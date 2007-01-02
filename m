From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix infinite loop when deleting multiple packed refs.
Date: Tue, 02 Jan 2007 11:19:05 -0800
Message-ID: <7vy7oluthy.fsf@assigned-by-dhcp.cox.net>
References: <20070102081709.GA28779@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicholas Miell <nmiell@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 02 20:19:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1pAE-0005HC-Ne
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 20:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbXABTTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 14:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932910AbXABTTI
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 14:19:08 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:55183 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932907AbXABTTG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 14:19:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102191905.VCOS7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 14:19:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6KJJ1W00R1kojtg0000000; Tue, 02 Jan 2007 14:18:18 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35799>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Nicholas Miell reported that `git branch -D A B` failed if both refs
> A and B were packed into .git/packed-refs.  This happens because the
> same pack_lock instance was being enqueued into the lock list twice,

I do not like this, actually.

It was stupid to link the same element twice to lock_file_list
and end up in a loop, so we certainly need a fix.

But it is not like we are taking a lock on multiple files in
this case.  It is just that we leave the linked list element on
the list even after commit_lock_file() successfully removes the
cruft.

We obviously cannot remove the list element commit_lock_file();
if we are interrupted in the middle of list manipulation, the
call to remove_lock_file_on_signal will happen with a broken
lock_file_list, which would cause the cruft to remain, so not
unlinking is the right thing to do.  Instead we should be
reusing the element already on the list.

I notice that there is already a code for that in lock_file()
function in lockfile.c.  Notice that lk->next is checked and the
element is linked only when it is not already on the list?  I
think the check is wrong for the last element on the list which
has NULL in next but is on the list, but if you read the check
as "is this element already on the list?" it actually makes
sense.  We do not want to link it on the list again, nor we
would want to set up signal/atexit over and over.

In other words, I am suspecting this might be a cleaner fix.

-- >8 --

diff --git a/cache.h b/cache.h
index a5fc232..4dbf658 100644
--- a/cache.h
+++ b/cache.h
@@ -179,6 +179,7 @@ extern int refresh_cache(unsigned int flags);
 
 struct lock_file {
 	struct lock_file *next;
+	char on_list;
 	char filename[PATH_MAX];
 };
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
diff --git a/lockfile.c b/lockfile.c
index 261baff..731bbf3 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -27,9 +27,12 @@ static int lock_file(struct lock_file *lk, const char *path)
 	sprintf(lk->filename, "%s.lock", path);
 	fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= fd) {
-		if (!lk->next) {
+		if (!lk->on_list) {
 			lk->next = lock_file_list;
 			lock_file_list = lk;
+			lk->on_list = 1;
+		}
+		if (lock_file_list) {
 			signal(SIGINT, remove_lock_file_on_signal);
 			atexit(remove_lock_file);
 		}
@@ -37,6 +40,8 @@ static int lock_file(struct lock_file *lk, const char *path)
 			return error("cannot fix permission bits on %s",
 				     lk->filename);
 	}
+	else
+		lk->filename[0] = 0;
 	return fd;
 }
 
diff --git a/refs.c b/refs.c
index 121774c..5205745 100644
--- a/refs.c
+++ b/refs.c
@@ -726,7 +726,6 @@ static int repack_without_ref(const char *refname)
 	}
 	if (!found)
 		return 0;
-	memset(&packlock, 0, sizeof(packlock));
 	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
 	if (fd < 0)
 		return error("cannot delete '%s' from packed refs", refname);
