From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Tue, 17 Jul 2007 12:15:27 +0200
Message-ID: <20070717101527.GB7774@cip.informatik.uni-erlangen.de>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <7vtzs3a0xg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 12:15:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAk5c-0000Cj-Tt
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 12:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbXGQKP3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 06:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbXGQKP2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 06:15:28 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:48257 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754402AbXGQKP2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 06:15:28 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 1D85B3F442; Tue, 17 Jul 2007 12:15:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzs3a0xg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52753>

Hello Junio,

> This is wrong.  If the filesystem has a symlink and we would want a
> directory there, we should unlink().  So at least the stat there needs
> to be lstat().

I see.

> I wonder if anybody involved in the discussion has actually
> tested this patch (or the other one, that has the same problem)?

I tested it. But I did not test it with symlinks.

> Does the following replacement work for you?  It adds far more lines
> than your version, but they are mostly comments to make it clear why
> we do things this way.

Yes, it does. Excuse the delay but my build machine is not the fastest.

	(faui04a) [/var/tmp] git clone ~/work/repositories/public/easix.git test-10
	Initialized empty Git repository in /var/tmp/test-10/.git/
	remote: Generating pack...
	remote: Done counting 317 objects.
	remote: Deltifying 317 objects...
	remote: te: % (317/317) done: ) done
	Indexing 317 objects...
	remote: Total 317 (delta 182), reused 278 (delta 157)
	100% (317/317) done
	Resolving 182 deltas...
	100% (182/182) done
	(faui04a) [/var/tmp] cd test-10
	./test-10
	(faui04a) [/var/tmp/test-10] git status
	# On branch master
	nothing to commit (working directory clean)

I rebased your patch on top of current HEAD (as I can access it on
git.kernel.org) and removed trailing whitspace from one line (git-apply
complained)

	Thomas

>From 3b60b807007507ce5e1f8490f1469dac5bb95917 Mon Sep 17 00:00:00 2001
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Date: Tue, 17 Jul 2007 11:31:07 +0200
Subject: [PATCH] Do _not_ call unlink on a directory

Calling unlink on a directory on a Solaris UFS filesystem as root makes it
inconsistent. Thanks to Junio for the not so obvious fix.
---
 entry.c |   37 ++++++++++++++++++++++++++++++-------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/entry.c b/entry.c
index c540ae1..0625112 100644
--- a/entry.c
+++ b/entry.c
@@ -8,17 +8,40 @@ static void create_directories(const char *path, const struct checkout *state)
 	const char *slash = path;
 
 	while ((slash = strchr(slash+1, '/')) != NULL) {
+		struct stat st;
+		int stat_status;
+
 		len = slash - path;
 		memcpy(buf, path, len);
 		buf[len] = 0;
+
+		if (len <= state->base_dir_len)
+			/*
+			 * checkout-index --prefix=<dir>; <dir> is
+			 * allowed to be a symlink to an existing
+			 * directory.
+			 */
+			stat_status = stat(buf, &st);
+		else
+			/*
+			 * if there currently is a symlink, we would
+			 * want to replace it with a real directory.
+			 */
+			stat_status = lstat(buf, &st);
+
+		if (!stat_status && S_ISDIR(st.st_mode))
+			continue; /* ok, it is already a directory. */
+
+		/*
+		 * We know stat_status == 0 means something exists
+		 * there and this mkdir would fail, but that is an
+		 * error codepath; we do not care, as we unlink and
+		 * mkdir again in such a case.
+		 */
 		if (mkdir(buf, 0777)) {
-			if (errno == EEXIST) {
-				struct stat st;
-				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
-					continue;
-				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
-					continue; /* ok */
-			}
+			if (errno == EEXIST && state->force &&
+			    !unlink(buf) && !mkdir(buf, 0777))
+				continue;
 			die("cannot create directory at %s", buf);
 		}
 	}
-- 
1.5.2.1
