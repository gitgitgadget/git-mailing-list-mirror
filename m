From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] fast-import: add special '-' blob reference to use the previous one.
Date: Sun, 21 Dec 2008 04:11:42 +0200
Message-ID: <1229825502-963-2-git-send-email-felipe.contreras@gmail.com>
References: <1229825502-963-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 03:13:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEDov-00074a-TF
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 03:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbYLUCLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 21:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbYLUCLt
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 21:11:49 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:56797 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbYLUCLs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 21:11:48 -0500
Received: by bwz14 with SMTP id 14so6034745bwz.13
        for <git@vger.kernel.org>; Sat, 20 Dec 2008 18:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=un6BSAjpfH7+VrBACf3dm1zW7BWUiH+b90kQ37xL8BA=;
        b=mipukBfM+5erbhfc8C3Y/j8uQg5VUopEuGKSsBES1XYuiBDjH5aCehPvtMj2g3xhEp
         cTSIxUqHEfXk9GKeNZBzMGhND+NMO9avDVVynsRpVpU6y594sKyNoEDqFUpdYmhsTp0E
         N50ADJs+CQXvspX7NS15NK8ebbe5WbQIFBZV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Jf4BIruQjGZLUWFcFUYFNQXEVJhzj6pWaUArCACVSYdvbagt/DvCkD5x6h91KeHYTk
         1PfhMfWEDBKxjZMXAjsLYFCHt4yiZJxb9rJ5DDEB/k6k4r7evwkTb9cNxGaL5de9S2HH
         4+8iLPdlxumbE4EcAPAhMpl2j4LKozVo66mzg=
Received: by 10.181.148.3 with SMTP id a3mr1711901bko.74.1229825506187;
        Sat, 20 Dec 2008 18:11:46 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id d13sm9459119fka.35.2008.12.20.18.11.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Dec 2008 18:11:45 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6.3.g7ccbd
In-Reply-To: <1229825502-963-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103681>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fast-import.txt |    6 +++---
 fast-import.c                     |   13 ++++++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 9d4231e..6fce41f 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -457,9 +457,9 @@ External data format::
 	'M' SP <mode> SP <dataref> SP <path> LF
 ....
 +
-Here `<dataref>` can be either a mark reference (`:<idnum>`)
-set by a prior `blob` command, or a full 40-byte SHA-1 of an
-existing Git blob object.
+Here `<dataref>` can be either a mark reference (`:<idnum>`) set by a prior
+`blob` command, a special `-` reference to use the one of the ancestor, or
+a full 40-byte SHA-1 of an existing Git blob object.
 
 Inline data format::
 	The data content for the file has not been supplied yet.
diff --git a/fast-import.c b/fast-import.c
index a00d3fe..228c474 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1385,7 +1385,8 @@ static int tree_content_set(
 				if (mode == S_IFREG)
 					mode = e->versions[0].mode;
 				e->versions[1].mode = (mode == S_IFREG) ? (S_IFREG | 0644) : mode;
-				hashcpy(e->versions[1].sha1, sha1);
+				hashcpy(e->versions[1].sha1,
+					is_null_sha1(sha1) ? e->versions[0].sha1 : sha1);
 				if (e->tree)
 					release_tree_content_recursive(e->tree);
 				e->tree = subtree;
@@ -1420,7 +1421,8 @@ static int tree_content_set(
 	} else {
 		e->tree = subtree;
 		e->versions[1].mode = (mode == S_IFREG) ? (S_IFREG | 0644) : mode;
-		hashcpy(e->versions[1].sha1, sha1);
+		hashcpy(e->versions[1].sha1,
+			is_null_sha1(sha1) ? e->versions[0].sha1 : sha1);
 	}
 	hashclr(root->versions[1].sha1);
 	return 1;
@@ -1862,7 +1864,7 @@ static void file_change_m(struct branch *b)
 	const char *endp;
 	struct object_entry *oe = oe;
 	unsigned char sha1[20];
-	uint16_t mode, inline_data = 0;
+	uint16_t mode, inline_data = 0, empty_blob = 0;
 
 	if (!prefixcmp(p, "- ")) {
 		mode = 0;
@@ -1893,6 +1895,10 @@ static void file_change_m(struct branch *b)
 	} else if (!prefixcmp(p, "inline")) {
 		inline_data = 1;
 		p += 6;
+	} else if (!prefixcmp(p, "- ")) {
+		hashclr(sha1);
+		empty_blob = 1;
+		p += 1;
 	} else {
 		if (get_sha1_hex(p, sha1))
 			die("Invalid SHA1: %s", command_buf.buf);
@@ -1936,6 +1942,7 @@ static void file_change_m(struct branch *b)
 		if (oe->type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
 				typename(oe->type), command_buf.buf);
+	} else if (empty_blob) {
 	} else {
 		enum object_type type = sha1_object_info(sha1, NULL);
 		if (type < 0)
-- 
1.6.0.6.3.g7ccbd
