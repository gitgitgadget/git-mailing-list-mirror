From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] builtin-commit.c: Not add duplicate S-o-b when commit
Date: Thu, 26 Jul 2012 14:01:19 +0800
Message-ID: <ee08efceaa3f015732a19d49eb96bdeeaaf3d609.1343282283.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 08:02:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuH9J-0002Ot-5e
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 08:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab2GZGBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 02:01:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62322 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab2GZGBo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 02:01:44 -0400
Received: by pbbrp8 with SMTP id rp8so2680759pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 23:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9+uO/iITpD+JF+9pViSFzS1U8Hblx39Fz8ByHWntWyw=;
        b=DemCuR3kMeyvPfCafQi13CPMGSbuJbpVMA6a2QIHnw2MJuDw1iRiVIZAp3KFFI+hzr
         YL5pImXDBB1DeKh7CLRmB5XuNaIh+4161k40qoFEs7euG6mcFU5sI9SY80FwUzUc2jgs
         2ZG/v1pYe+Z3qHZ+BEfou1jJ7B+XDneqaE0ecvjh3HwD4UsDAL6FzRmF+QMiLK7l98gu
         8S6OtJj3AuboyxXBuOU6KraJ1C9Ap6lyBtkVWFwzOZqf2X2+js/WkxgpvfZOkLQSdFcS
         dAGQlDOt2Ge5hDGj8w5GFqgARheQ+0MtE3Vh3qSRJllGh5vnq9gXSi+rkj3dbxFCDglM
         sb/Q==
Received: by 10.68.226.73 with SMTP id rq9mr2005087pbc.145.1343282503412;
        Wed, 25 Jul 2012 23:01:43 -0700 (PDT)
Received: from localhost.foo.bar ([123.115.149.64])
        by mx.google.com with ESMTPS id qr3sm15855718pbc.69.2012.07.25.23.01.37
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 23:01:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.28.g8ecd8a5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202224>

Scan the whole rfc2822 footer for duplicate S-o-b, not just the last
line of the commit message.

A commit may have multiple S-o-bs, or other tags, such as:

    some commit log...

    Signed-off-by: C O Mitter <committer@example.com>
    Reported-by: R E Porter <reporter@example.com>

Because the S-o-b is not located at the last line in the above commit,
when the above commit is amended by the original committer, a
duplicated S-o-b may appended by accident. New commit log may looks
like:

    some commit log...

    Signed-off-by: C O Mitter <committer@example.com>
    Reported-by: R E Porter <reporter@example.com>
    Signed-off-by: C O Mitter <committer@example.com>

This hack scans the whole rfc2822 footer for duplicate S-o-b, and only
append a S-o-b when necessary. Also add testcases in 't/t7502-commit.sh'
for this.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/commit.c  | 28 ++++++++++++++++++++++++----
 t/t7502-commit.sh | 19 +++++++++++++++++++
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 20cef..1a3da 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -704,15 +704,35 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (signoff) {
 		struct strbuf sob = STRBUF_INIT;
 		int i;
+		int hit_footer = 0;
+		int hit_sob = 0;
 
 		strbuf_addstr(&sob, sign_off_header);
 		strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
 					     getenv("GIT_COMMITTER_EMAIL")));
 		strbuf_addch(&sob, '\n');
-		for (i = sb.len - 1; i > 0 && sb.buf[i - 1] != '\n'; i--)
-			; /* do nothing */
-		if (prefixcmp(sb.buf + i, sob.buf)) {
-			if (!i || !ends_rfc2822_footer(&sb))
+		for (i = sb.len - 1; i > 0; i--) {
+			if (hit_footer && sb.buf[i] == '\n') {
+				hit_footer = 2;
+				i += 2;
+				break;
+			}
+			hit_footer = (sb.buf[i] == '\n');
+		}
+		hit_footer = (2 == hit_footer);
+		if (hit_footer) {
+			while (i < sb.len)
+			{
+				if (!prefixcmp(sb.buf + i, sob.buf)) {
+					hit_sob = 1;
+					break;
+				}
+				while (i < sb.len && sb.buf[i++] != '\n')
+					; /* do nothing */
+			}
+		}
+		if (!hit_sob) {
+			if (!hit_footer || !ends_rfc2822_footer(&sb))
 				strbuf_addch(&sb, '\n');
 			strbuf_addbuf(&sb, &sob);
 		}
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 18145..8198f 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -336,7 +336,26 @@ test_expect_success 'A single-liner subject with a token plus colon is not a foo
 	git commit -s -m "hello: kitty" --allow-empty &&
 	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
 	test_line_count = 3 actual
+'
+
+cat > expect << EOF
+Footer-like: commit log
+
+Signed-off-by: C O Mitter <committer@example.com>
+EOF
+
+test_expect_success 'S-o-b after footer-like commit message' '
+	head -1 expect | git commit -s --allow-empty -F - &&
+	git cat-file commit HEAD | sed "1,/^\$/d" > output &&
+	test_cmp expect output
+'
+
+echo "Reported-by: R E Porter <reporter@example.com>" >> expect
 
+test_expect_success 'no duplicate S-o-b when signoff' '
+	cat expect | git commit -s --allow-empty -F - &&
+	git cat-file commit HEAD | sed "1,/^\$/d" > output &&
+	test_cmp expect output
 '
 
 cat >.git/FAKE_EDITOR <<EOF
-- 
1.7.12.rc0.28.g8ecd8a5.dirty
