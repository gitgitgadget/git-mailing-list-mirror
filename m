From: mhagger@alum.mit.edu
Subject: [PATCH 1/3] receive-pack: move more work into write_head_info()
Date: Fri,  6 Jan 2012 15:12:31 +0100
Message-ID: <1325859153-31016-2-git-send-email-mhagger@alum.mit.edu>
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
	id 1RjAXP-0004dd-R8
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 15:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758705Ab2AFOMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 09:12:46 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:55313 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758656Ab2AFOMo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 09:12:44 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RjANd-0007TD-TB; Fri, 06 Jan 2012 15:02:49 +0100
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1325859153-31016-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188025>

From: Michael Haggerty <mhagger@alum.mit.edu>

Move some more code from the calling site into write_head_info(), and
inline add_alternate_refs() there.  (Some more simplification is
coming, and it is easier if all this code is in the same place.)

Move some helper functions to avoid the need for forward declarations.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/receive-pack.c |   42 ++++++++++++++++++------------------------
 1 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d2dcb7e..08df17e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -144,12 +144,30 @@ static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, vo
 	return show_ref(path, sha1, flag, cb_data);
 }
 
+static void add_one_alternate_sha1(const unsigned char sha1[20], void *unused)
+{
+	add_extra_ref(".have", sha1, 0);
+}
+
+static void collect_one_alternate_ref(const struct ref *ref, void *data)
+{
+	struct sha1_array *sa = data;
+	sha1_array_append(sa, ref->old_sha1);
+}
+
 static void write_head_info(void)
 {
+	struct sha1_array sa = SHA1_ARRAY_INIT;
+	for_each_alternate_ref(collect_one_alternate_ref, &sa);
+	sha1_array_for_each_unique(&sa, add_one_alternate_sha1, NULL);
+	sha1_array_clear(&sa);
 	for_each_ref(show_ref_cb, NULL);
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1, 0, NULL);
+	clear_extra_refs();
 
+	/* EOF */
+	packet_flush(1);
 }
 
 struct command {
@@ -869,25 +887,6 @@ static int delete_only(struct command *commands)
 	return 1;
 }
 
-static void add_one_alternate_sha1(const unsigned char sha1[20], void *unused)
-{
-	add_extra_ref(".have", sha1, 0);
-}
-
-static void collect_one_alternate_ref(const struct ref *ref, void *data)
-{
-	struct sha1_array *sa = data;
-	sha1_array_append(sa, ref->old_sha1);
-}
-
-static void add_alternate_refs(void)
-{
-	struct sha1_array sa = SHA1_ARRAY_INIT;
-	for_each_alternate_ref(collect_one_alternate_ref, &sa);
-	sha1_array_for_each_unique(&sa, add_one_alternate_sha1, NULL);
-	sha1_array_clear(&sa);
-}
-
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
@@ -937,12 +936,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		unpack_limit = receive_unpack_limit;
 
 	if (advertise_refs || !stateless_rpc) {
-		add_alternate_refs();
 		write_head_info();
-		clear_extra_refs();
-
-		/* EOF */
-		packet_flush(1);
 	}
 	if (advertise_refs)
 		return 0;
-- 
1.7.8.2
