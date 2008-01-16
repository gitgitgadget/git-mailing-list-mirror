From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] close_lock_file(): new function in the lockfile API
Date: Wed, 16 Jan 2008 13:57:50 -0800
Message-ID: <7v7ii9o2ld.fsf@gitster.siamese.dyndns.org>
References: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.44.0801152006260.944-100000@demand>
	<7vejchr3pf.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801161207220.2806@woody.linux-foundation.org>
	<7vodblo6c9.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0801161443340.31161@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jan 16 22:58:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFGHH-0008A1-A6
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 22:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbYAPV6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 16:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbYAPV6B
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 16:58:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbYAPV6A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 16:58:00 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 701BC23AD;
	Wed, 16 Jan 2008 16:57:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 35A2423AC;
	Wed, 16 Jan 2008 16:57:52 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0801161443340.31161@torch.nrlssc.navy.mil>
	(Brandon Casey's message of "Wed, 16 Jan 2008 14:46:23 -0600 (CST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70752>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> My patch does this, though I understand it may take some time to review.

This is what I have right now, squashed your change into [2/2] 
I sent earlier, along with a couple of further fixups.

Improvement since my v1 are:

 - close_lock_file() returns int, which is the return value from
   close(2);

 - remove_lock_file() avoids calling close(2) if
   close_lock_file() was called earlier on the lockfile;

 - commit_lock_file() does the same, and notices failure
   returned from close_lock_file().  In addition, it unlinks the
   lockfile and clears lk->filename upon failure;

 - commit_locked_index() does the same, and notices failure
   returned from close_lock_file() in alternate_index_output
   codepath.  It unlinks the lockfile and clears lk->filename
   upon failure;

 - The codepath in commit_locked_index() for writing to
   alternate_index_output clears the alternate_index_output
   variable when it is done.

Most of the above are thanks to the changes to lockfile.c in your
version and Linus's suggestion.

I am planning to take your patch (only the parts that fix the
callers, because the changes to lockfile.c are all included
here) on top of this one.

-- >8 --
close_lock_file(): new function in the lockfile API

The lockfile API is a handy way to obtain a file that is cleaned
up if you die().  But sometimes you would need this sequence to
work:

 1. hold_lock_file_for_update() to get a file descriptor for
    writing;

 2. write the contents out, without being able to decide if the
    results should be committed or rolled back;

 3. do something else that makes the decision --- and this
    "something else" needs the lockfile not to have an open file
    descriptor for writing (e.g. Windows do not want a open file
    to be renamed);

 4. call commit_lock_file() or rollback_lock_file() as
    appropriately.

This adds close_lock_file() you can call between step 2 and 3 in
the above sequence.

[jc: updated with Brandon's stricter error checking on return values
 from close() and a suggestion by Linus.]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-lockfile.txt |   15 +++++++++++--
 cache.h                                  |    2 +-
 lockfile.c                               |   32 ++++++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index 5b1553e..dd89404 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -37,7 +37,8 @@ commit_lock_file::
 	Take a pointer to the `struct lock_file` initialized
 	with an earlier call to `hold_lock_file_for_update()`,
 	close the file descriptor and rename the lockfile to its
-	final destination.
+	final destination.  Returns 0 upon success, a negative
+	value on failure to close(2) or rename(2).
 
 rollback_lock_file::
 
@@ -45,6 +46,12 @@ rollback_lock_file::
 	with an earlier call to `hold_lock_file_for_update()`,
 	close the file descriptor and remove the lockfile.
 
+close_lock_file::
+	Take a pointer to the `struct lock_file` initialized
+	with an earlier call to `hold_lock_file_for_update()`,
+	and close the file descriptor.  Returns 0 upon success,
+	a negative value on failure to close(2).
+
 Because the structure is used in an `atexit(3)` handler, its
 storage has to stay throughout the life of the program.  It
 cannot be an auto variable allocated on the stack.
@@ -54,8 +61,10 @@ done writing to the file descriptor.  If you do not call either
 and simply `exit(3)` from the program, an `atexit(3)` handler
 will close and remove the lockfile.
 
-You should not close the file descriptor you obtained from
-`hold_lock_file_for_update` function yourself.  The `struct
+If you need to close the file descriptor you obtained from
+`hold_lock_file_for_update` function yourself, do so by calling
+`close_lock_file()`.  You should never call `close(2)` yourself!
+Otherwise the `struct
 lock_file` structure still remembers that the file descriptor
 needs to be closed, and a later call to `commit_lock_file()` or
 `rollback_lock_file()` will result in duplicate calls to
diff --git a/cache.h b/cache.h
index 39331c2..24735bd 100644
--- a/cache.h
+++ b/cache.h
@@ -308,7 +308,7 @@ extern int commit_lock_file(struct lock_file *);
 extern int hold_locked_index(struct lock_file *, int);
 extern int commit_locked_index(struct lock_file *);
 extern void set_alternate_index_output(const char *);
-
+extern int close_lock_file(struct lock_file *);
 extern void rollback_lock_file(struct lock_file *);
 extern int delete_ref(const char *, const unsigned char *sha1);
 
diff --git a/lockfile.c b/lockfile.c
index f45d3ed..fcf9285 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -13,7 +13,8 @@ static void remove_lock_file(void)
 	while (lock_file_list) {
 		if (lock_file_list->owner == me &&
 		    lock_file_list->filename[0]) {
-			close(lock_file_list->fd);
+			if (lock_file_list->fd >= 0)
+				close(lock_file_list->fd);
 			unlink(lock_file_list->filename);
 		}
 		lock_file_list = lock_file_list->next;
@@ -159,11 +160,23 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int die_on
 	return fd;
 }
 
+int close_lock_file(struct lock_file *lk)
+{
+	int fd = lk->fd;
+	lk->fd = -1;
+	return close(fd);
+}
+
 int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
 	int i;
-	close(lk->fd);
+
+	if (lk->fd >= 0 && close_lock_file(lk)) {
+		unlink(lk->filename);
+		lk->filename[0] = 0;
+		return -1;
+	}
 	strcpy(result_file, lk->filename);
 	i = strlen(result_file) - 5; /* .lock */
 	result_file[i] = 0;
@@ -185,9 +198,15 @@ void set_alternate_index_output(const char *name)
 int commit_locked_index(struct lock_file *lk)
 {
 	if (alternate_index_output) {
-		int result = rename(lk->filename, alternate_index_output);
-		lk->filename[0] = 0;
-		return result;
+		const char *newname = alternate_index_output;
+		alternate_index_output = NULL;
+
+		if (lk->fd >= 0 && close_lock_file(lk)) {
+			unlink(lk->filename);
+			lk->filename[0] = 0;
+			return -1;
+		}
+		return rename(lk->filename, newname);
 	}
 	else
 		return commit_lock_file(lk);
@@ -196,7 +215,8 @@ int commit_locked_index(struct lock_file *lk)
 void rollback_lock_file(struct lock_file *lk)
 {
 	if (lk->filename[0]) {
-		close(lk->fd);
+		if (lk->fd >= 0)
+			close(lk->fd);
 		unlink(lk->filename);
 	}
 	lk->filename[0] = 0;
-- 
1.5.4.rc3.14.g44397
