From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 - RFH/WIP] xdiff-merge: optionally show conflicts in
 "diff3 -m" style
Date: Fri, 29 Aug 2008 02:01:32 -0700
Message-ID: <7vej485h5f.fsf@gitster.siamese.dyndns.org>
References: <7vzlmwbs1u.fsf@gitster.siamese.dyndns.org>
 <7vsksobrn9.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808281727490.3300@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 11:02:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYzsT-0005NZ-C6
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 11:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbYH2JBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 05:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753202AbYH2JBk
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 05:01:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbYH2JBk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 05:01:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 73D8456B37;
	Fri, 29 Aug 2008 05:01:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 76C1756B36; Fri, 29 Aug 2008 05:01:34 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808281727490.3300@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Thu, 28 Aug 2008 17:34:36 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 16DF0B4C-75A9-11DD-AF9D-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 28 Aug 2008, Junio C Hamano wrote:
>> 
>> Some poeple find it easier to be able to understand what is going on when
>> they can view the common ancestor's version, which is used by "diff3 -m",
>> which shows:
>> 
>>  <<<<<<<
>>  postimage from one side;
>>  |||||||
>>  shared preimage;
>>  =======
>>  postimage of the other side; and
>>  >>>>>>>
> ...
> Wouldn't it be much nicer to make this a bitflag, than an enumeration of 
> different models?
>
> In particular, why would it be wrong to want to be ZEALOUS (possibly 
> _ALNUM) and still want DIFF3 output?
>
> IOW, I don't think these are at all disjoint sets. In fact, I think DIFF3 
> sounds not at all like a "level" to me, but like an output format thing, 
> so it's in a totally different "address space".
>
> Hmm?

I've thought about this a bit more, and I think "diff3 -m" style output
would not make sense for anything more aggressive than XDL_MERGE_EAGER,
because of the way how the merge reduction works.

Suppose a common ancestor (shared preimage) is modified to postimage #1
and #2 (each letter represents one line):

                     #####
    postimage#1: 1234ABCDE789
                    |    /
                    |   /
    preimage:    123456789
                    |   \
    postimage#2: 1234AXYE789
                     ####

XDL_MERGE_MINIMAL and XDL_MERGE_EAGER would:

 (1) find the s/56/ABCDE/ done on one side and s/56/AXYE/ done on the
     other side,

 (2) notice that they touch an overlapping area, and

 (3) mark it as a conflict, "ABCDE vs AXYE".

The difference between the two algorithm is that EAGER drops the hunk if
the postimages match (i.e. both sides modified the same way), while
MINIMAL keeps it.  There is no other operation performed to the hunk.  As
the result, lines marked with "#" in the above picure will be in the RCS
merge style output.  We can sanely say that the part from the preimage
that corresponds to these conflicting changes is "567", which is what
"diff3 -m" style output adds to it.

Now, XDL_MERGE_ZEALOUS postprocesses output XDL_MERGE_EAGER would have
produced, by looking at the differences between the changes two postimages
made.  It notices that both sides start their new contents with "A", and
excludes it from the output (it also excludes "E" for the same reason).
The conflict that used to be "ABCDE vs AXYE" is now "BCD vs XY".

There could even be matching part between two postimages in the middle.
Instead of one side rewriting the shared "56" to "ABCDE" and the other
side to "AXYE", imagine the case where the postimages are "ABCDE" and
"AXCYE", in which case instead of having one conflicted hunk "BCD vs XY",
you would have two conflicting hunks "B vs X" and "D vs Y".

In either case, once you reduce "ABCDE vs AXYE" to "BCD vs XY" (or "ABCDE
vs AXCYE" to "B vs X" and "D vs Y"), there is no part from the preimage
that corresponds to the conflicting change made in both postimages
anymore.  In other words, conflict reduced by ZEALOUS algorithm cannot be
expressed in "diff3 -m" style.

You can still have "diff3 -m" style with MINIMAL or EAGER, but I think MINIMAL
is pointless and using "diff3 -m" style with it is even more so.
