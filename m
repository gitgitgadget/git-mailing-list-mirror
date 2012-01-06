From: mhagger@alum.mit.edu
Subject: [PATCH 3/3] write_head_info(): handle "extra refs" locally
Date: Fri,  6 Jan 2012 15:12:33 +0100
Message-ID: <1325859153-31016-4-git-send-email-mhagger@alum.mit.edu>
References: <1325859153-31016-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 15:13:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjAXQ-0004dd-VS
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 15:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933119Ab2AFOMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 09:12:51 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:55330 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758674Ab2AFOMt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 09:12:49 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RjANj-0007TD-H4; Fri, 06 Jan 2012 15:02:55 +0100
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1325859153-31016-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188026>

From: Michael Haggerty <mhagger@alum.mit.edu>

The old code basically did:

     generate array of SHA1s for alternate refs
     for each unique SHA1 in array:
         add_extra_ref(".have", sha1)
     for each ref (including real refs and extra refs):
         show_ref(refname, sha1)

But there is no need to stuff the alternate refs in extra_refs; we can
call show_ref() directly when iterating over the array, then handle
real refs separately.  So change the code to:

     generate array of SHA1s for alternate refs
     for each unique SHA1 in array:
         show_ref(".have", sha1)
     for each ref (this now only includes real refs):
         show_ref(refname, sha1)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/receive-pack.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 65d129c..8c9e91e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -144,9 +144,9 @@ static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
-static void add_one_alternate_sha1(const unsigned char sha1[20], void *unused)
+static void show_one_alternate_sha1(const unsigned char sha1[20], void *unused)
 {
-	add_extra_ref(".have", sha1, 0);
+	show_ref(".have", sha1);
 }
 
 static void collect_one_alternate_ref(const struct ref *ref, void *data)
@@ -159,12 +159,11 @@ static void write_head_info(void)
 {
 	struct sha1_array sa = SHA1_ARRAY_INIT;
 	for_each_alternate_ref(collect_one_alternate_ref, &sa);
-	sha1_array_for_each_unique(&sa, add_one_alternate_sha1, NULL);
+	sha1_array_for_each_unique(&sa, show_one_alternate_sha1, NULL);
 	sha1_array_clear(&sa);
 	for_each_ref(show_ref_cb, NULL);
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1);
-	clear_extra_refs();
 
 	/* EOF */
 	packet_flush(1);
-- 
1.7.8.2
