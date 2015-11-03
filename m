From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH v2 2/4] upload-pack: strip refs before calling ref_is_hidden()
Date: Tue,  3 Nov 2015 08:58:15 +0100
Message-ID: <1446537497-13921-3-git-send-email-lfleischer@lfos.de>
References: <1446537497-13921-1-git-send-email-lfleischer@lfos.de>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 09:13:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWj0-000157-GN
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 09:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbbKCH61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:58:27 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:31080 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbbKCH60 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 02:58:26 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 19df3984;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Tue, 3 Nov 2015 08:58:19 +0100 (CET)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446537497-13921-1-git-send-email-lfleischer@lfos.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280780>

Make hideRefs handling in upload-pack consistent with the behavior
described in the documentation by stripping refs before comparing them
with prefixes in hideRefs.

Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
 upload-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index d0bc3ca..4ca960e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -692,7 +692,7 @@ static int mark_our_ref(const char *refname, const struct object_id *oid)
 {
 	struct object *o = lookup_unknown_object(oid->hash);
 
-	if (ref_is_hidden(refname)) {
+	if (refname && ref_is_hidden(refname)) {
 		o->flags |= HIDDEN_REF;
 		return 1;
 	}
@@ -703,7 +703,7 @@ static int mark_our_ref(const char *refname, const struct object_id *oid)
 static int check_ref(const char *refname, const struct object_id *oid,
 		     int flag, void *cb_data)
 {
-	mark_our_ref(refname, oid);
+	mark_our_ref(strip_namespace(refname), oid);
 	return 0;
 }
 
@@ -726,7 +726,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	const char *refname_nons = strip_namespace(refname);
 	struct object_id peeled;
 
-	if (mark_our_ref(refname, oid))
+	if (mark_our_ref(refname_nons, oid))
 		return 0;
 
 	if (capabilities) {
-- 
2.6.2
