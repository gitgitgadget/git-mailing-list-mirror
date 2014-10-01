From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 09/38] lock_file(): always initialize and register lock_file object
Date: Wed,  1 Oct 2014 12:28:13 +0200
Message-ID: <1412159322-2622-10-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:31:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHBY-0003Kl-FR
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbaJAKbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:31:00 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52435 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751428AbaJAK3G (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:06 -0400
X-AuditID: 1207440d-f797f6d000000a4a-a6-542bd7714e9b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id E9.A3.02634.177DB245; Wed,  1 Oct 2014 06:29:05 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk68026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:04 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1C28rh1icH+blEXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3Bldh16zFuwUrfh2ailTA+MywS5G
	Tg4JAROJT4enskPYYhIX7q1n62Lk4hASuMwo0T73EjOEc5xJ4uaEc8wgVWwCuhKLepqZQGwR
	ATWJiW2HWECKmAUWM0lMOLSJDSQhLBAmsebFf1YQm0VAVeLVzy6wFbwCLhIT9q1khlgnJ7Fh
	939GEJsTKL78cjMLiC0k4Cyx485XpgmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp
	5WaW6KWmlG5ihIQj7w7G/+tkDjEKcDAq8fAqJGiHCLEmlhVX5h5ilORgUhLlXXQJKMSXlJ9S
	mZFYnBFfVJqTWnyIUYKDWUmEN/sAUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1
	CCYrw8GhJMHLcA2oUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UHfHFwPgASfEA
	7XUGaectLkjMBYpCtJ5i1OVY1/mtn0mIJS8/L1VKnDf0KlCRAEhRRmke3ApY8nnFKA70sTCv
	NMgoHmDigpv0CmgJE9CS5DVgS0oSEVJSDYxKUV5at00+MqmYxURnnNup/Mh4kkx4uaSN1uY5
	Zee5+CTnrGwqqD3WZlY3VcGF73qjUcT/x/xeHvN+LBb5M6lVQqV+3akAgxPfP+/o 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257735>

The purpose of this patch is to make the state diagram for lock_file
objects simpler and deterministic.

If locking fails, lock_file() sometimes leaves the lock_file object
partly initialized, but sometimes not. It sometimes registers the
object in lock_file_list, but sometimes not. This makes the state
diagram for lock_file objects effectively indeterministic and hard to
reason about. A future patch will also change the filename field into
a strbuf, which needs more involved initialization, so it will become
even more important that the state of a lock_file object is
well-defined after a failed attempt to lock.

The ambiguity doesn't currently have any ill effects, because
lock_file objects cannot be removed from the lock_file_list anyway.
But to make it easier to document and reason about the code, make this
behavior inconsistent: *always* initialize the lock_file object and
*always* register it in lock_file_list the first time it is used,
regardless of whether an error occurs.

While we're at it, make sure that all of the lock_file fields are
initialized to values appropriate for an unlocked object; the caller
is only responsible for making sure that on_list is set to zero before
the first time it is used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index f4ce79b..81143e5 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -129,6 +129,22 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	 */
 	static const size_t max_path_len = sizeof(lk->filename) - 5;
 
+	if (!lock_file_list) {
+		/* One-time initialization */
+		sigchain_push_common(remove_lock_file_on_signal);
+		atexit(remove_lock_file);
+	}
+
+	if (!lk->on_list) {
+		/* Initialize *lk and add it to lock_file_list: */
+		lk->fd = -1;
+		lk->owner = 0;
+		lk->filename[0] = 0;
+		lk->next = lock_file_list;
+		lock_file_list = lk;
+		lk->on_list = 1;
+	}
+
 	if (strlen(path) >= max_path_len) {
 		errno = ENAMETOOLONG;
 		return -1;
@@ -139,16 +155,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	strcat(lk->filename, ".lock");
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
-		if (!lock_file_list) {
-			sigchain_push_common(remove_lock_file_on_signal);
-			atexit(remove_lock_file);
-		}
 		lk->owner = getpid();
-		if (!lk->on_list) {
-			lk->next = lock_file_list;
-			lock_file_list = lk;
-			lk->on_list = 1;
-		}
 		if (adjust_shared_perm(lk->filename)) {
 			int save_errno = errno;
 			error("cannot fix permission bits on %s",
-- 
2.1.0
