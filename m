From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Fix git-diff --cached to not error out if HEAD points to a nonexistant branch
Date: Sat, 24 Feb 2007 13:03:48 -0800
Message-ID: <7vvehrw9mz.fsf@assigned-by-dhcp.cox.net>
References: <20070224172037.GA31963@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 24 22:03:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HL43f-0000eS-1p
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 22:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933556AbXBXVDv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 16:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933560AbXBXVDv
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 16:03:51 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41890 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933556AbXBXVDu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 16:03:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070224210349.IURI233.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 24 Feb 2007 16:03:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TZ3o1W00N1kojtg0000000; Sat, 24 Feb 2007 16:03:49 -0500
In-Reply-To: <20070224172037.GA31963@xp.machine.xx> (Peter Baumann's message
	of "Sat, 24 Feb 2007 18:20:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40523>

Peter Baumann <waste.manager@gmx.de> writes:

> The documentation mentions "git-diff --cached" to see what is staged for
> the next commit. But this failes if you haven't done any commits yet.
> So lets fix it.
> ...
> ...  I am
> not sure if this is the right fix and/or if git-diff-index
> should also be fixed. I decided against it and let the core
> cmd git-diff-index stay as it is now.

I think you decision here is a correct one.  The plumbing level
command git-diff-index should error out if you do not give a
tree to compare against.

My preference for 'git-diff --cached' issue is to fix the
explanation.  Clearly document that --cached is to review the
difference between any commit (we could even be more precise to
say any tree, but I think we should say commit here, as the
description is at the end-user level) and what is staged for the
commit that will be created with your next 'git-commit'.  For
convenience it defaults to 'HEAD', the latest commit on your
current branch, because that is what people would do most often.

Until you have a commit at HEAD, there really is nothing to diff
against.  I think "foo is a new entry, no comparison available."
is one of the very few things that CVS got right.

The bug in the current code is that we do not check if that HEAD
is sensible when we add it as the default commit to compare
with.  The error message coming out of the low-level diff-index
code might be sensible if that 'HEAD' were what the user
actually gave us, but clearly not the right error message in
this case.

---

 builtin-diff.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index c387ebb..67f4932 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -261,6 +261,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				break;
 			else if (!strcmp(arg, "--cached")) {
 				add_head(&rev);
+				if (!rev.pending.nr)
+					die("No HEAD commit to compare with (yet)");
 				break;
 			}
 		}
