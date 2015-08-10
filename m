From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/16] create_bundle(): duplicate file descriptor to avoid closing it twice
Date: Mon, 10 Aug 2015 11:47:37 +0200
Message-ID: <82dbb49a0212672ed74c928f2b97fa29b7a7c280.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjgm-0001vA-EA
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbbHJJsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:13 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49330 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754699AbbHJJsG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:06 -0400
X-AuditID: 1207440d-f79136d00000402c-a7-55c8734eaec8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CA.F5.16428.E4378C55; Mon, 10 Aug 2015 05:47:59 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lswq021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:47:58 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqOtffCLU4PVdJouuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGf0X9Qp+
	S1T07L7A1sD4SriLkZNDQsBE4viSt4wQtpjEhXvr2UBsIYHLjBJPbpt2MXIB2SeYJI78mcIE
	kmAT0JVY1NMMZosIqElMbDvEAmIzC6RLnFjQDmYLC8RJzNrfDjaIRUBVovfCPrAFvAJREt+u
	7gKq4QBaJiex4EI6SJhTwEJie+MGVoi95hKP551nn8DIu4CRYRWjXGJOaa5ubmJmTnFqsm5x
	cmJeXmqRrpFebmaJXmpK6SZGSOjw7mD8v07mEKMAB6MSD++MzcdDhVgTy4orcw8xSnIwKYny
	WuSfCBXiS8pPqcxILM6ILyrNSS0+xCjBwawkwhufAZTjTUmsrEotyodJSXOwKInzqi1R9xMS
	SE8sSc1OTS1ILYLJanBwCMw4N3c6kxRLXn5eqpIEr3wR0BDBotT01Iq0zJwShFImDk6QRVxS
	IsWpeSmpRYmlJRnxoGiJLwbGC0iKB+iGI4UgNxQXJOYCRSFaTzEqSonz/gFJCIAkMkrz4MbC
	EsUrRnGgj4V594BU8QCTDFz3K6DBTECD7QLBBpckIqSkGhhjuiL0l1RYygq1/L4WdkWXba3d
	g1tB6cqPM6+lVzG7Sh7NSPSSXtQeKrts04bg8/wfGcuLHSd8XSfhfY5TrV7U/ZJX3LRr783Y
	G3dEWc1WM9wk43cj4xHnjw8cG+z6ZinOvCkUcNjr3EGdtRH/VeZ7OTDW2zNW/rrM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275590>

write_pack_data() passes bundle_fd to start_command() to be used as
the stdout of pack-objects. But start_command() closes its stdout if
it is > 1. This is a problem if bundle_fd is the fd of a lock_file,
because commit_lock_file() will also try to close the fd.

So the old code suppressed commit_lock_file()'s usual behavior of
closing the file descriptor by setting the lock_file object's fd field
to -1.

But this is not really kosher. Code here shouldn't be mutating fields
within the lock_file object.

Instead, duplicate the file descriptor before passing it to
write_pack_data(). Then that function can close its copy without
closing the copy held in the lock_file object.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This is new since v1. I like that it is better decoupled than the old
code, but let me know if you think otherwise.

Actually, it seems to me that start_command()'s special case of not
closing fd==0 is weird. I suppose that is because fd==0 is used to
mean "no redirections" whereas 0 also happens to be the fd for stdin.
But I don't want to dig into that now.

 bundle.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/bundle.c b/bundle.c
index f732c92..b9dacc0 100644
--- a/bundle.c
+++ b/bundle.c
@@ -235,7 +235,9 @@ out:
 	return result;
 }
 
-static int write_pack_data(int bundle_fd, struct lock_file *lock, struct rev_info *revs)
+
+/* Write the pack data to bundle_fd, then close it if it is > 1. */
+static int write_pack_data(int bundle_fd, struct rev_info *revs)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
 	int i;
@@ -250,13 +252,6 @@ static int write_pack_data(int bundle_fd, struct lock_file *lock, struct rev_inf
 	if (start_command(&pack_objects))
 		return error(_("Could not spawn pack-objects"));
 
-	/*
-	 * start_command closed bundle_fd if it was > 1
-	 * so set the lock fd to -1 so commit_lock_file()
-	 * won't fail trying to close it.
-	 */
-	lock->fd = -1;
-
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object *object = revs->pending.objects[i].item;
 		if (object->flags & UNINTERESTING)
@@ -416,10 +411,21 @@ int create_bundle(struct bundle_header *header, const char *path,
 	bundle_to_stdout = !strcmp(path, "-");
 	if (bundle_to_stdout)
 		bundle_fd = 1;
-	else
+	else {
 		bundle_fd = hold_lock_file_for_update(&lock, path,
 						      LOCK_DIE_ON_ERROR);
 
+		/*
+		 * write_pack_data() will close the fd passed to it,
+		 * but commit_lock_file() will also try to close the
+		 * lockfile's fd. So make a copy of the file
+		 * descriptor to avoid trying to close it twice.
+		 */
+		bundle_fd = dup(bundle_fd);
+		if (bundle_fd < 0)
+			die_errno("unable to dup file descriptor");
+	}
+
 	/* write signature */
 	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
 
@@ -445,7 +451,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 		return -1;
 
 	/* write pack */
-	if (write_pack_data(bundle_fd, &lock, &revs))
+	if (write_pack_data(bundle_fd, &revs))
 		return -1;
 
 	if (!bundle_to_stdout) {
-- 
2.5.0
