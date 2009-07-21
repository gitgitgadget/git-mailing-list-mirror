From: Junio C Hamano <gitster@pobox.com>
Subject: Re: three-way diff performance problem
Date: Tue, 21 Jul 2009 12:21:07 -0700
Message-ID: <7v7hy1g7vg.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0907211038120.19335@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:22:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTKuj-0002lX-4S
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 21:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808AbZGUTV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 15:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754342AbZGUTV0
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 15:21:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906AbZGUTVP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 15:21:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 03D2FC2ED;
	Tue, 21 Jul 2009 15:21:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 80106C2EB; Tue, 21 Jul 2009
 15:21:09 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907211038120.19335@localhost.localdomain>
 (Linus Torvalds's message of "Tue\, 21 Jul 2009 11\:10\:01 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A7E00140-762B-11DE-9367-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123684>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> In fact, on the instruction-level profile, it looks like it's all spent on 
> four instructions:
>
>     3.51 :        45aec0:       4c 85 72 10             test   %r14,0x10(%rdx)
>    86.27 :        45aec4:       48 0f 45 ca             cmovne %rdx,%rcx
>          :              if (sline->lost_head) {
>          :                      struct lline *last_one = NULL;
>          :                      /* We cannot squash it with earlier one */
>          :                      for (lline = sline->lost_head;
>          :                           lline;
>          :                           lline = lline->next)
>     6.69 :        45aec8:       48 8b 12                mov    (%rdx),%rdx
>          :
>          :              /* Check to see if we can squash things */
>          :              if (sline->lost_head) {
>          :                      struct lline *last_one = NULL;
>          :                      /* We cannot squash it with earlier one */
>          :                      for (lline = sline->lost_head;
>     3.51 :        45aecb:       48 85 d2                test   %rdx,%rdx
>     0.01 :        45aece:       75 f0                   jne    45aec0 <consume_line+0xc0>
>
> (ok, five, I included the 0.01% of the branch instruction that finishes 
> the loop - the way Nehalem works, it will merge those test+jne 
> instructions into one macro-instruction internally, which is why the 
> branch that is obviously part of the loop doesn't get a lot of hits)
>
> Just FYI, those four instructions come from inlining 'append_lost()'. It's 
> compiled that first for-loop into some very good assembly language, but 
> the problem is that this all looks very much quadratic in number of 
> lost_lines. The quality of the compiler thus sadly in no way helps make up 
> for a really really expensive algorithm.
>
> Any ideas?

What's that cmovne?

The function append_lost() is the meat of combining.  When you have seen
a hunk like this:

    @@ -l,k +m,n @@
    -lost line
    -another lost line
     common line
    +added line

We queue the lost lines in front of a surviving line (that is sline that
points at "common line").  "lost line" and "another lost line" are stored
in lline (lost line) and they are queued to sline->lost_head.

When another diff that corresponds to this section looks like this:

    @@ -l,k +m1,n1 @@
    -lost line
     common line
    +added line

the function looks at "lost line", tries to find the identical one in the
list of llines.  We find one, and mark the fact that the lline element is
shared among the two parents.

That allows the output routine to say

    @@@ -l,k +m,n +m1,n1 @@@
    --lost line
    - another lost line
      common line
    ++added line

If that cmovne that eats 86.27% of the run time has something to do with
the memcmp() that is repeatedly done, and if the length of lost_head list
is very large, I think a possible optimization is to add a line hash value
in struct lline.

After feeding the first diff (forget the one with +m1,n1 example above),
if the second diff looks like this:

    @@ -l,k +m2,n2 @@
    -another lost line
    -lost line
     common line
    +added line

we match "-another lost line" with the second element in lost_head list,
and when processing the next line "-lost line", we try to avoid matching
it with the first one in the list, by stupidly scanning from the front of
the list.  I think we should add a member to struct sline to remember the
last element in lost_head list for the current parent to skip that scan.
Perhaps that scan is the one that is costing, not memcmp()?
