From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 3/5] tag: factor out sig detection for body edits
Date: Wed, 10 Nov 2010 12:17:28 +0100
Message-ID: <a463b5b983213c630b800b961fc7bc10c3b4bc5e.1289387142.git.git@drmicha.warpmail.net>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 12:19:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG8iV-00055t-R6
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 12:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562Ab0KJLTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 06:19:30 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59396 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755410Ab0KJLT1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 06:19:27 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5D86F964;
	Wed, 10 Nov 2010 06:19:27 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 10 Nov 2010 06:19:27 -0500
X-Sasl-enc: pzx5ZjVH81LpFz8wieyBnHQHA6mwx4NtQw2JC/9PaXac 1289387966
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D61335E4F42;
	Wed, 10 Nov 2010 06:19:26 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
In-Reply-To: <cover.1289041051.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1289387142.git.git@drmicha.warpmail.net>
References: <cover.1289387142.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161145>

Use the factored out code for sig detection when editing existing
tag bodies (tag -a -f without -m).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/tag.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index d311491..66feeb0 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -29,8 +29,6 @@ struct tag_filter {
 	struct commit_list *with_commit;
 };
 
-#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
-
 static int show_reference(const char *refname, const unsigned char *sha1,
 			  int flag, void *cb_data)
 {
@@ -242,8 +240,7 @@ static void write_tag_body(int fd, const unsigned char *sha1)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf, *sp, *eob;
-	size_t len;
+	char *buf, *sp;
 
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
@@ -256,12 +253,7 @@ static void write_tag_body(int fd, const unsigned char *sha1)
 		return;
 	}
 	sp += 2; /* skip the 2 LFs */
-	eob = strstr(sp, "\n" PGP_SIGNATURE "\n");
-	if (eob)
-		len = eob - sp;
-	else
-		len = buf + size - sp;
-	write_or_die(fd, sp, len);
+	write_or_die(fd, sp, parse_signature(sp, buf + size - sp));
 
 	free(buf);
 }
-- 
1.7.3.2.193.g78bbb
