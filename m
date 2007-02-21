From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Wed, 21 Feb 2007 08:44:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702210836210.4043@woody.linux-foundation.org>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <20070217233203.GA6014@coredump.intra.peff.net>
 <Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
 <7vodnp68p8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
 <7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702210014140.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 17:44:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJuZk-0005XE-EP
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 17:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbXBUQoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 11:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbXBUQoN
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 11:44:13 -0500
Received: from smtp.osdl.org ([65.172.181.24]:32786 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422666AbXBUQoM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 11:44:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1LGi4hB027036
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Feb 2007 08:44:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1LGi38x019399;
	Wed, 21 Feb 2007 08:44:04 -0800
In-Reply-To: <Pine.LNX.4.64.0702210014140.6485@iabervon.org>
X-Spam-Status: No, hits=-2.462 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40301>



On Wed, 21 Feb 2007, Daniel Barkalow wrote:

> On Mon, 19 Feb 2007, Linus Torvalds wrote:
> > Imagine somebody sending you a patch to a set of files, and they didn't 
> > use git to generate that patch. What would it look right? Right, it might 
> > well look like
> > 
> > 	diff -u file.c.orig file.c
> > 	--- file.c.orig
> > 	+++ file.c
> > 	@@ -29,6 +29,7 @@
> > 	...
> > 
> > and it happens to be in some subdirectory. What would you do?
> > 
> > I'd use "git apply". And I would be really upset *if* git-apply actually 
> > applied the patch to some *other* subdirectory than the one I was in.
> 
> "git apply" should be able to notice the many clues that this patch 
> doesn't go at the root: (1) it's not -r; (2) it's not a rename, but the 
> filenames aren't the same; (3) there isn't an extra path element to 
> remove.

(4): it doesn't say "diff --git" with all the git-specific info.

We actually already *do* act differently for native git patches and for 
"traditional unified diffs", and yeah, we could certainly extend that to 
the whole "what to do about subdirectories" thing.

For traditional unified diffs, we already have extra rules about guessing 
the pathname, so this isn't even really a "new" rule, it's just an 
extension of the old ones. With traditional diffs, you *have* to guess at 
the pathnames, because the pathnames aren't well-defined (never mind 
renames, it's true for file create/delete events too, and it's true 
exactly because you often have two different filenames for the *same* 
file, like in my example).

> I think "git apply" should just know that if the filenames don't match, 
> and it's not a rename, and the --- filename isn't /dev/null, then add the 
> current directory and use -p0.

Well, "-p1" is still the saner default - even unified diff people tend to 
use that (and if there is no path at all, it's still safe - there's 
nothing to remove).

As to the traditional vs git patches: we already have totally separate 
functions for parsing what they are:

 - parse_git_header() parses git-only patches and understands all the 
   extended syntax, and has sanity checks

 - parse_traditional_patch() has this magic heuristic which knows about 
   the "/dev/null" special cases, and uses a magic "find_name()" function 
   that will choose whichever name makes more sense.

We could just make "parse_traditional_patch()" try to take the prefix 
information into account instead. That would be a better choice than doing 
it unconditionally even for native git patches.

Junio?

		Linus
