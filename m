From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/4] Tweak diff output further to make it a bit less
 distracting.
Date: Mon, 16 May 2005 16:28:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
References: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net> <20050516220559.GC8609@pasky.ji.cz>
 <7vsm0mn5s1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 01:27:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXoyd-0004H4-R8
	for gcvg-git@gmane.org; Tue, 17 May 2005 01:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVEPX0p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 19:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVEPX0p
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 19:26:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:490 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261635AbVEPX0f (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2005 19:26:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4GNQSU3029689
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 May 2005 16:26:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4GNQRxF002782;
	Mon, 16 May 2005 16:26:27 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsm0mn5s1.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.39__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 16 May 2005, Junio C Hamano wrote:

>     # mode: 100644 100755 nitfol
>     --- a/nitfol
>     +++ b/nitfol

>     @. 100644 100755 nitfol
>     --- a/nitfol
>     +++ b/nitfol

I have to say, I muct prefer the first over the second.

I don't know why people think "line noise" means "computer readable".  To
me, "@." look slike line noise, and worse, it's clearly _less_
disambiguous than spelling out "mode". The fact that it (on purpose, I
assume) looks somewhat like the "@@" beginning of a patch hunk for the
_previous_ file makes it even worse.

Terseness is filne, and thus maybe it could be just

	# 100644 100755 nitfol

but on the other hand that doesn't really have any advantages either. 
Except being better than the inexplicable "@."

Me, I'd prefer making it clear whether the file is "new", "removed" or
"changed". That's really what matters, and at least the "new" case does
need the mode (while the "removed" case does not). So instead of talking
about "mode", which is largely irrelevant (the important thing is to
indicate whether it's new or old), we should talk about how the file has
changed.

There's another issue I noticed with the current default 'diff' output: I 
often (almost always) want to have a way to go to "next file", which in 
traditional diffs I just do with "/^diff" when paging with 'less'. The 
current one doesn't have a way to do that - searching for '^--- ' comes 
closest, but is ambiguous, since it might be a part of a _patch_ that 
contains a line that got removed and that started with "-- ".

So I'd actually prefer some output format that fixed that thing too, by 
having a header for each file.

Making the header be "diff a/file b/file" would make the thing look the 
same as a regular diff, and that also makes it disambiguous (and thus easy 
for machines to parse) to have a _second_ or third line for things like 
mode change information.

So my preferred format would actually be

	diff -git a/filename b/filename
	<optional extended header lines>
	--- a/filename
	+++ b/filename
	@@ -xx ....

where the "optional extended header lines" would be very plain, like

	old mode 100644
	new mode 100755

or

	new file mode 100644

or

	deleted file mode 100644

or something like that.

In fact anything _except_ for something that starts with "-" "+" " " or
"@"  which have special meanings inside diffs (whether you want the "mode"
for the deleted file case or not is up to you - it could be an added
sanity check that the diff actually matches, but on the other hand there's
really nothing you could do anyway except warn if the mode didn't match,
so..)

This makes it very easy to parse mechanically: look for a line that starts
with "diff -git " (which cannot be part of the "meat" of the patch), and
then you know that you've found the start of an extended patch.

Why the "-git"? A normal patch header already looks something like the 
following (head of the pre-git 2.6.12-rc1 patch):

	diff -Nru a/CREDITS b/CREDITS
	--- a/CREDITS   2005-03-17 17:35:10 -08:00
	+++ b/CREDITS   2005-03-17 17:35:10 -08:00
	@@ -34,8 +34,9 @@
	 E: airlied@linux.ie
	 W: http://www.csn.ul.ie/~airlied
	 D: NFS over TCP patches
	-S: University of Limerick
	-S: Ireland
	+D: in-kernel DRM Maintainer

so the "-git" thing there is equivalent to the "-Nru" part, telling how
the diff was generated, and being an added hint that we may have extended
headers before the actual patch (which wouldn't be sensible in a non-git
patch).

One final note: I actually think that "rename patches" make a ton of 
sense, even if git itself doesn't track renames. If we ever have a "smart 
diff" thing that can generate inter-file diffs, I'd like to eventually see

	diff -git a/kernel/sched.c b/kernel/sched.c.old
	rename kernel/sched.c kernel/sched.c.old
	old mode 100644
	new mode 100755
	--- a/kernel/sched.c
	+++ b/kernel/sched.c.old
	@@ -1,5 +1,5 @@
	 /*
	- *  kernel/sched.c
	+ *  kernel/sched.c.old
	  *
	  *  Kernel scheduler and related syscalls
	  *

Notice? We could have a mode change, a rename _and_ a content change, all
at the same time under the same header. That's obviously a totally idiotic
example, but the point is that if we have a nice "extended diff header"
setup, the format is very easily able to accomodate things like this.

And it's both human-readable _and_ automatically parseable. And my old 
"/^diff " thing would still work, and still find each new entry, so I'd 
not have to teach my old fingers new tricks.

(This is, btw, the reason for the format of "git-diff-tree -v --stdin", in 
case anybody wondered. Take a look, and notice how piping the output to 
"less" and then doing "/^diff-tree " gives the expected results. Same 
deal. Human-readable _and_ machine-parseable at the same time!).

		Linus
