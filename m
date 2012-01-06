From: mhagger@alum.mit.edu
Subject: [PATCH 2/3] show_ref(): remove unused "flag" and "cb_data" arguments
Date: Fri,  6 Jan 2012 15:12:32 +0100
Message-ID: <1325859153-31016-3-git-send-email-mhagger@alum.mit.edu>
References: <1325859153-31016-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 15:13:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjAXQ-0004dd-Cd
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 15:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758707Ab2AFOMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 09:12:47 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:55319 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758674Ab2AFOMq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 09:12:46 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RjANg-0007TD-On; Fri, 06 Jan 2012 15:02:52 +0100
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1325859153-31016-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188024>

From: Michael Haggerty <mhagger@alum.mit.edu>

The function is not used as a callback, so it doesn't need these
arguments.  Also change its return type to void.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

I suppose, though I didn't verify, that the old function signature was
a vestige of its earlier having been used as a callback function.  But
it doesn't really matter; the point is that the extra arguments are
currently not needed.

 builtin/receive-pack.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 08df17e..65d129c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -115,7 +115,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static void show_ref(const char *path, const unsigned char *sha1)
 {
 	if (sent_capabilities)
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
@@ -125,10 +125,9 @@ static int show_ref(const char *path, const unsigned char *sha1, int flag, void
 			     " report-status delete-refs side-band-64k",
 			     prefer_ofs_delta ? " ofs-delta" : "");
 	sent_capabilities = 1;
-	return 0;
 }
 
-static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, void *unused)
 {
 	path = strip_namespace(path);
 	/*
@@ -141,7 +140,8 @@ static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, vo
 	 */
 	if (!path)
 		path = ".have";
-	return show_ref(path, sha1, flag, cb_data);
+	show_ref(path, sha1);
+	return 0;
 }
 
 static void add_one_alternate_sha1(const unsigned char sha1[20], void *unused)
@@ -163,7 +163,7 @@ static void write_head_info(void)
 	sha1_array_clear(&sa);
 	for_each_ref(show_ref_cb, NULL);
 	if (!sent_capabilities)
-		show_ref("capabilities^{}", null_sha1, 0, NULL);
+		show_ref("capabilities^{}", null_sha1);
 	clear_extra_refs();
 
 	/* EOF */
-- 
1.7.8.2
