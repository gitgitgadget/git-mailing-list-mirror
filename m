From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH 2/4] upload-pack: strip refs before calling ref_is_hidden()
Date: Sun,  1 Nov 2015 20:34:21 +0100
Message-ID: <1446406463-22527-3-git-send-email-lfleischer@lfos.de>
References: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 20:34:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsyOl-0000LI-Ni
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 20:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbbKATeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 14:34:36 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:8371 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbbKATee (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 14:34:34 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id aba88d9c;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Sun, 1 Nov 2015 20:34:30 +0100 (CET)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280657>

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
