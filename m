From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 2/5] fast-import: don't fail on omitted committer name
Date: Thu, 11 Aug 2011 16:21:07 +0600
Message-ID: <1313058070-4774-3-git-send-email-divanorama@gmail.com>
References: <1313058070-4774-1-git-send-email-divanorama@gmail.com>
Cc: SASAKI Suguru <sss.sonik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 12:21:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrSO3-0004S2-Fi
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 12:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab1HKKVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 06:21:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42211 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188Ab1HKKVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 06:21:00 -0400
Received: by bke11 with SMTP id 11so867264bke.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 03:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YxHWhMVUpPZIzEtjMBJRgMX+XcsmYUU8NPFtN7cYsMw=;
        b=cdA84K7yjhQ8QG+EFhrNN4aJwEGgshJWXP3Ldx1doBnthyOlqLcO0lkeS9U0g1XOza
         MvANT7b/fVedNZ4LM0SS37BNELIrqklK/FCZdrw6eU3fnqCXwvRL/bX28ZiKL5zj8Wu+
         1sZqRxXW63aEau8wapT/+ozbZZi28izz1flho=
Received: by 10.205.83.136 with SMTP id ag8mr2765748bkc.80.1313058059588;
        Thu, 11 Aug 2011 03:20:59 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id p15sm476918bkd.62.2011.08.11.03.20.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 03:20:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313058070-4774-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179103>

fast-import format declares 'committer_name SP' to be optional in
'committer_name SP LT email GT'. But for a (commit) object SP is
obligatory while zero length committer_name is ok. git-fsck checks
that SP is present, so fast-import must prepend it if the name SP
part is omitted. It doesn't do so and thus for "LT email GT" ident
it writes a bad object.

Name cannot contain LT or GT, ident always comes after SP in fast-import.
So if ident starts with LT reuse the SP as if a valid 'SP LT email GT'
ident was passed.

This fixes a ident parsing bug for a well-formed fast-import input.
Though the parsing is still loose and can accept a ill-formed input.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |    4 ++++
 t/t9300-fast-import.sh |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7cc2262..ed1f7c9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1973,6 +1973,10 @@ static char *parse_ident(const char *buf)
 	size_t name_len;
 	char *ident;
 
+	/* ensure there is a space delimiter even if there is no name */
+	if (*buf == '<')
+		--buf;
+
 	gt = strrchr(buf, '>');
 	if (!gt)
 		die("Missing > in ident string: %s", buf);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 0844e9d..8f3938c 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -352,7 +352,7 @@ data <<COMMIT
 empty commit
 COMMIT
 INPUT_END
-test_expect_failure 'B: accept and fixup committer with no name' '
+test_expect_success 'B: accept and fixup committer with no name' '
 	git fast-import <input &&
 	out=$(git fsck) &&
 	echo "$out" &&
-- 
1.7.3.4
