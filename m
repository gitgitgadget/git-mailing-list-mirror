From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH] Allow hideRefs to match refs outside the namespace
Date: Wed, 28 Oct 2015 16:42:00 +0100
Message-ID: <1446046920-15646-1-git-send-email-lfleischer@lfos.de>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 16:42:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrSrl-0002nv-JR
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 16:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966042AbbJ1PmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 11:42:15 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:25596 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965998AbbJ1PmG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 11:42:06 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 678151d4;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Wed, 28 Oct 2015 16:42:01 +0100 (CET)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280372>

Right now, refs with a path outside the current namespace are replaced
by ".have" before passing them to show_ref() which in turn checks
whether the ref matches the hideRefs pattern. Move the check before the
path substitution in show_ref_cb() such that the hideRefs feature can be
used to hide specific refs outside the current namespace.

Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
The other show_ref() call sites are in show_one_alternate_sha1() and in
write_head_info(). The call site in show_one_alternate_sha1() is for
alternates and passes ".have". The other one is

    show_ref("capabilities^{}", null_sha1);

and is not relevant to the hideRefs feature. Note that this kind of
breaks backwards compatibility since the "magic" hideRefs patterns
".have" and "capabilities^{}" no longer work, as explained in the
discussion.

 builtin/receive-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bcb624b..4a5d0ae 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -195,9 +195,6 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 
 static void show_ref(const char *path, const unsigned char *sha1)
 {
-	if (ref_is_hidden(path))
-		return;
-
 	if (sent_capabilities) {
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
 	} else {
@@ -221,6 +218,9 @@ static void show_ref(const char *path, const unsigned char *sha1)
 
 static int show_ref_cb(const char *path, const struct object_id *oid, int flag, void *unused)
 {
+	if (ref_is_hidden(path))
+		return 0;
+
 	path = strip_namespace(path);
 	/*
 	 * Advertise refs outside our current namespace as ".have"
-- 
2.6.2
