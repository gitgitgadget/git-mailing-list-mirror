From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/5] tag: factor out sig detection for body edits
Date: Sat,  6 Nov 2010 12:04:08 +0100
Message-ID: <2d5bee89df29aeedefeadb73a26633ffe1af9a67.1289041051.git.git@drmicha.warpmail.net>
References: <4CAB90EC.1080302@drmicha.warpmail.net>
Cc: Stephan Hugel <urschrei@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:10:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEgfG-0004FV-KT
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab0KFLKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:10:10 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:45228 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755329Ab0KFLJ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Nov 2010 07:09:56 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EDD0E652;
	Sat,  6 Nov 2010 07:03:52 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sat, 06 Nov 2010 07:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=cR3BwLhwVIRHBXZdlLy15291Dbs=; b=fiSqXJ1HkU1KZTRX/GmfoaPSmcLT7PM2VcnLmPpkhLlLKmbWpno0J1QjAtE90c0jXo94SL/nGjtLWfQe2EtSdYDqEuMcpP1g06dqnt1FD+4UyT5YPIW+2vxSXV/8wy8ZWRNyp/HSSwoAPiwZP0nImZdL8QcNP5i4/LI4bra8tiY=
X-Sasl-enc: opkj5mgdAoDM27mBKzP4EawuLKVdWR1NZc+jPetnytrV 1289041432
Received: from localhost (p548596E8.dip0.t-ipconnect.de [84.133.150.232])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3FCB640244A;
	Sat,  6 Nov 2010 07:03:52 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
In-Reply-To: <4CAB90EC.1080302@drmicha.warpmail.net>
In-Reply-To: <cover.1289041051.git.git@drmicha.warpmail.net>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160839>

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
