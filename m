From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bisect / history preserving on rename + update
Date: Fri, 24 Aug 2007 21:59:43 -0700
Message-ID: <7vmywgb45c.fsf@gitster.siamese.dyndns.org>
References: <1187080681.12828.174.camel@chaos>
	<alpine.LFD.0.999.0708140853500.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 25 07:00:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOnkg-0001kJ-Vx
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 07:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbXHYE7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 00:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbXHYE7u
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 00:59:50 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbXHYE7u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 00:59:50 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 17C44126887;
	Sat, 25 Aug 2007 01:00:06 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708140853500.30176@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 14 Aug 2007 09:14:30 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56619>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> [ However, there does seem to be a bug in the "-B" logic, so it doesn't 
>   actually work as well as it should! See below ]

I finally had a bit of time to follow this through.  After
running your set-up using revision.c and Makefile to emulate the
situation, you can try running:

	$ git diff-tree -B -C --numstat --summary HEAD

or

	$ git diff-tree -B -M --numstat --summary HEAD

which would say:

        90028d007986de4db8c3af30a2d5e5c00e5a2c8b
        0       0       revision.c => old-revision.c
        1117    1579    revision.c
         rename revision.c => old-revision.c (100%)
         rewrite revision.c (98%)

The code is working as intended (it is a different discussion if
"as intended" is actually the desired behaviour).

We take the preimage tree as a whole, and express postimage in
terms of series of patches, _however_ we do not interpret the
series of patches as _incremental_.  IOW, when we talk about the
effect of the second patch that describes the postimage of
revision.c, we pretend as if nothing happened with the first
patch (which renamed away revision.c).  So "rewrite revision.c"
is what we say, not "create revision.c anew, because the first
one renamed it away".

This behaviour actually was a bit counterintuitive to me.  I did
not implement the very original rename/copy the way we currently
operate.  It was corrected into the current behaviour, following
the guiding principle described in this message:

	http://thread.gmane.org/gmane.comp.version-control.git/3807

which is reproduced below.

From: Linus Torvalds <torvalds@osdl.org>
Date: Mon, 23 May 2005 07:49:01 -0700 (PDT)
Subject: Re: [PATCH] Make sure diff-helper can tell rename/copy in the new
 diff-raw format.
Message-ID: <Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org>

    On Mon, 23 May 2005, Junio C Hamano wrote:
    >
    > This adds tests to make sure that diff-helper can tell renames
    > from copies using the same "everything but the last one are
    > copies and the last one is either rename or stay" logic.

    Btw, I still disagree...
    ...
    For example, let's say that you have modified "fileA" _and_ you have 
    created a "fileB" that is a copy of the original "fileA" with some _other_ 
    slight modifications. We'll call the SHA1's involved "sha_A", "sha_A'" and 
    "sha_B"

    I think it's perfectly valid to say

            :100644 100644 <sha_A> <sha_A'> M	fileA	fileA
            :100644 100644 <sha_A> <sha_B> C89	fileA	fileB

    which says "fileA" was modified from orig-A to new-A, and "fileB" is a 
    copy based on orig-A.

    Now, when the above is turned into a "diff", that diff is no longer
    something you can apply "incrementally" - you have to apply it as if
    you're applying all differences to the "original tree". But the thing is,
    that's actually what I _want_, because I was planning on writing a tool
    that applies patches that applies them all-or-nothing.

    Also, it turns out that this kind of "non-incremental" diff is the kind
    that I personally want to see as a _human_, because quite frankly, my
    brain-capacity is that of a demented ocelot, and I can't _remember_ what
    happened in other parts of the diff. I much prefer the stateless "oh, this
    file X is in that relation Y to the previous version of file Z".

    I do that partly because I actually routinely edit patches. If you have 
    the incremental format, that's practically impossible, while the stateless 
    version is fine.

    See?

    So I think all the clever "don't re-use files we have modified" etc is 
    actually wrong. If you want to make a traditional diff that can be applied 
    with normal "patch", you just don't use the -M or -C flags.

                    Linus
