From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: bisect / history preserving on rename + update
Date: Sat, 25 Aug 2007 08:38:32 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708250819360.25853@woody.linux-foundation.org>
References: <1187080681.12828.174.camel@chaos>
 <alpine.LFD.0.999.0708140853500.30176@woody.linux-foundation.org>
 <7vmywgb45c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 17:39:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOxjl-00015N-Cg
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 17:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbXHYPjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 11:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbXHYPji
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 11:39:38 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37278 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462AbXHYPjh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2007 11:39:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7PFcXK9005159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Aug 2007 08:38:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7PFcWfS019584;
	Sat, 25 Aug 2007 08:38:32 -0700
In-Reply-To: <7vmywgb45c.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.75 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56642>



On Fri, 24 Aug 2007, Junio C Hamano wrote:
> 
> I finally had a bit of time to follow this through.  After
> running your set-up using revision.c and Makefile to emulate the
> situation, you can try running:
> 
> 	$ git diff-tree -B -C --numstat --summary HEAD
> 
> or
> 
> 	$ git diff-tree -B -M --numstat --summary HEAD
> 
> which would say:
> 
>         90028d007986de4db8c3af30a2d5e5c00e5a2c8b
>         0       0       revision.c => old-revision.c
>         1117    1579    revision.c
>          rename revision.c => old-revision.c (100%)
>          rewrite revision.c (98%)

Yeah, in that format, git behaviour actually looks really nice.

> The code is working as intended (it is a different discussion if
> "as intended" is actually the desired behaviour).

I think it may be at times.

> We take the preimage tree as a whole, and express postimage in
> terms of series of patches, _however_ we do not interpret the
> series of patches as _incremental_.

IIRC, that's not strictly true. We do have logic to make sure that the 
difference between "copy" and "rename" is that the rename happens only 
once, ie I just tested this sequence:

	mkdir test-rename
	cd test-rename/
	cp /home/torvalds/git/revision.c .
	git init
	git add .
	git commit -m "add revision.c"
	cp revision.c rev1.c
	cp revision.c rev2.c
	rm revision.c
	em rev1.c
	em rev2.c
	git add .
	git commit -a -m "rename revision.c twice"

(the two "em" calls are just me in an editor, adding a line to the top 
of the file saying "This is rev[12].c")

After that, doing a "git show -C" shows:

	diff --git a/revision.c b/rev1.c
	similarity index 99%
	copy from revision.c
	copy to rev1.c
	...
	diff --git a/revision.c b/rev2.c
	similarity index 99%
	rename from revision.c
	rename to rev2.c
	...

so we do have a notion of "incremental" in that the first is a copy, the 
second is a rename, and that the rename is expected to remove the file.

(Doing a "--stat" doesn't show the difference between copy and rename, so 
we'll just see it as

	 revision.c => rev1.c |    1 +
	 revision.c => rev2.c |    1 +

which looks pretty).

> IOW, when we talk about the effect of the second patch that describes 
> the postimage of revision.c, we pretend as if nothing happened with the 
> first patch (which renamed away revision.c).  So "rewrite revision.c" is 
> what we say, not "create revision.c anew, because the first one renamed 
> it away".

If that was consistent, then we'd have used "rename" in both cases above..

> It was corrected into the current behaviour, following the guiding 
> principle described in this message:
> 
> 	http://thread.gmane.org/gmane.comp.version-control.git/3807

Ahh, you're a wily one. Using my own words against me.

But that earlier Linus was obviously a fake impostor, since he was wrong 
(and could thus by definition not _possibly_ be the true Linus!). So your 
judo mindtrick fails.

That said, I actually think that the earlier Linus might actually be me, 
and he's right in the case he mentions: we should *not* break the 
association if it results in a good diff!

Ie, the true "guiding principle" should be the principle of minizing the 
final diff - that's how diff is supposed to act within a single file, and 
I think it's how the rename/copy detection is supposed to act too.

So:

>     I think it's perfectly valid to say
> 
>             :100644 100644 <sha_A> <sha_A'> M	fileA	fileA
>             :100644 100644 <sha_A> <sha_B> C89	fileA	fileB
> 
>     which says "fileA" was modified from orig-A to new-A, and "fileB" is a 
>     copy based on orig-A.

This is 100% consistent with "how do I minimally show the differences 
between the original and the result": we decide that we can show it as a 
"copy" and a "modification" of the original file.

But it makes sense to "copy and modify the original", but it does *not* 
make sense to "rename and modify the original". That is, after all, the 
*only* difference between copying and renaming. A copy will leave the 
original around (so that it can be modified), while a rename will not.

So, by the very definition of "rename", doing a "rename and modify the 
original" would appear to be somewhat senseless, no?

			Linus
