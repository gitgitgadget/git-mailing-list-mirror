From: Salikh Zakirov <salikh@gmail.com>
Subject: [PATCH] combine-diff: use diff_opts->a_prefix
Date: Tue, 25 Dec 2007 22:46:13 +0900
Message-ID: <477109A5.9040000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 25 14:47:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7A7q-0008UI-5G
	for gcvg-git-2@gmane.org; Tue, 25 Dec 2007 14:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbXLYNqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2007 08:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbXLYNqT
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Dec 2007 08:46:19 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:43059 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbXLYNqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2007 08:46:18 -0500
Received: by an-out-0708.google.com with SMTP id d31so366020and.103
        for <git@vger.kernel.org>; Tue, 25 Dec 2007 05:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=tSMKjK4ZKt57QGAJDhdWkBNuZvDbImwBdVQ866YmExo=;
        b=AcYsphZmLerAYApZC1OBY2bFwEFNI7bo+/+cezBCDaV/zmmxxRzVrqUelS3GvceGUyz3huokwuXESM4CMD92K1SxVJGTjbXfC2LyfbMb9Oivp8C2hGibrPJbTEWF+44GxPoR5fYZXsqNetl+0shCaOLGKG0pTdbsjYN9Yv179og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=haKwwL6F40sJUITyENa6mp32KheEVpcATBGycy/lc459itECYbYcyLR8Jh4xuH47aF3+jrr3qDZ6A9sYYqiNtIRMreKhdd0pDsL6CD8A92k1ggLe8wxFhlnqkyr3gAM+65phP47JYaQhX7gIzKpMQRR0nzW8x+l2uJm0DSx4fE0=
Received: by 10.100.247.14 with SMTP id u14mr9902406anh.79.1198590377531;
        Tue, 25 Dec 2007 05:46:17 -0800 (PST)
Received: from ?221.115.75.108? ( [221.115.75.108])
        by mx.google.com with ESMTPS id p33sm9022671elf.2.2007.12.25.05.46.15
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Dec 2007 05:46:16 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071205)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69234>


The introduction of configurable dir prefix for diff headers in commit
eab9a40b 'Teach diff machinery to display other prefixes than "a/" and "b/"'
missed combined diff generation.

Signed-off-by: Salikh Zakirov <salikh@gmail.com>
---

I realize that this fix is ugly, so I am all ears for a suggestion
of a better fix.

 combine-diff.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index e22db89..5c3b42d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -646,10 +646,11 @@ static void reuse_combine_diff(struct sline *sline, unsigned long cnt,
 	sline->p_lno[i] = sline->p_lno[j];
 }
 
-static void dump_quoted_path(const char *prefix, const char *path,
-			     const char *c_meta, const char *c_reset)
+static void dump_quoted_path(const char *prefix, const char *prefix2,
+                             const char *path, const char *c_meta,
+			     const char *c_reset)
 {
-	printf("%s%s", c_meta, prefix);
+	printf("%s%s%s", c_meta, prefix, prefix2);
 	quote_c_style(path, NULL, stdout, 0);
 	printf("%s\n", c_reset);
 }
@@ -792,7 +793,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 		if (rev->loginfo && !rev->no_commit_id)
 			show_log(rev, opt->msg_sep);
-		dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
+		dump_quoted_path(dense ? "diff --cc " : "diff --combined ", "",
 				 elem->path, c_meta, c_reset);
 		printf("%sindex ", c_meta);
 		for (i = 0; i < num_parent; i++) {
@@ -829,13 +830,15 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			printf("%s\n", c_reset);
 		}
 		if (added)
-			dump_quoted_path("--- /dev/", "null", c_meta, c_reset);
+			dump_quoted_path("--- /dev/", "", "null", c_meta, c_reset);
 		else
-			dump_quoted_path("--- a/", elem->path, c_meta, c_reset);
+			dump_quoted_path("--- ", opt->a_prefix, elem->path,
+			                 c_meta, c_reset);
 		if (deleted)
-			dump_quoted_path("+++ /dev/", "null", c_meta, c_reset);
+			dump_quoted_path("+++ /dev/", "", "null", c_meta, c_reset);
 		else
-			dump_quoted_path("+++ b/", elem->path, c_meta, c_reset);
+			dump_quoted_path("+++ ", opt->b_prefix, elem->path,
+			                 c_meta, c_reset);
 		dump_sline(sline, cnt, num_parent, DIFF_OPT_TST(opt, COLOR_DIFF));
 	}
 	free(result);
-- 
1.5.3.7.1315.g1b8e7
