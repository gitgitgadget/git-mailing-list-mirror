From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 9/9] tree-walk.c: ignore trailing slash on submodule in tree_entry_interesting()
Date: Fri, 24 Jan 2014 20:40:36 +0700
Message-ID: <1390570836-20394-10-git-send-email-pclouds@gmail.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
 <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, pawel.sikora@agmk.net,
	Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 14:36:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6gvb-0005Of-RQ
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 14:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbaAXNgF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 08:36:05 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:52218 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbaAXNgD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 08:36:03 -0500
Received: by mail-pd0-f179.google.com with SMTP id q10so3126704pdj.24
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 05:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mebZCqf3K+shALlf2TDh8WEva7hdIKVr17aMCPgr8l0=;
        b=AxZl5nB87D8EX5/w3w5AVHbVZmZJNe1vNGlCJcXwYqNLzRWxKdD3aAC54vt6RH/LHw
         B5TYTaWIaa8ps1IAByXpM/dcV/814Y+KXIiXL2J0z/0WvHQe6ymVVDyvcOeL2te7GNtx
         oO9TRwmHiZNLWOUuV5MXH46St6uxHl9MxJFAvUKZTpeMcgCtLI0stdlcAowSdc7uIqwq
         GtJsr8SpOYlw+51LlvUL6SmMqZtQJ94B0kEpXQqPc+YMnTcEkaVRjHKGyergh31+9IVn
         bLe37UNzP142jDqK/OAIbmTX7kt8/2BoA8GqDdFWg4M4JleM31Mc3EyZwTWLB297gcKN
         oDiA==
X-Received: by 10.66.156.137 with SMTP id we9mr14556810pab.30.1390570562289;
        Fri, 24 Jan 2014 05:36:02 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id xs1sm7741609pac.7.2014.01.24.05.35.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 05:36:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 24 Jan 2014 20:41:36 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241008>

We do ignore trailing slash on a directory, so pathspec "abc/" matches
directory "abc". A submodule is also a directory. Apply the same logic
to it. This makes "git log submodule-path" and "git log submodule-path/=
"
produce the same output.

Reported-by: Pawe=C5=82 Sikora <pawel.sikora@agmk.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4010-diff-pathspec.sh | 6 ++++++
 tree-walk.c              | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 167af53..2424af0 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -127,4 +127,10 @@ test_expect_success 'diff-cache ignores trailing s=
lash on submodule path' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'diff-tree ignores trailing slash on submodule pat=
h' '
+	git diff --name-only HEAD^ HEAD submod >expect &&
+	git diff --name-only HEAD^ HEAD submod/ >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/tree-walk.c b/tree-walk.c
index 680afda..c29b6a3 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -543,7 +543,7 @@ static int match_entry(const struct pathspec_item *=
item,
 	if (matchlen > pathlen) {
 		if (match[pathlen] !=3D '/')
 			return 0;
-		if (!S_ISDIR(entry->mode))
+		if (!S_ISDIR(entry->mode) && !S_ISGITLINK(entry->mode))
 			return 0;
 	}
=20
--=20
1.8.5.2.240.g8478abd
