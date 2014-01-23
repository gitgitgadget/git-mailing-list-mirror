From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] tree-walk.c: ignore trailing slash on submodule in tree_entry_interesting()
Date: Thu, 23 Jan 2014 20:22:05 +0700
Message-ID: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
References: <2550653.GHkhBQDSTk@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pawel.sikora@agmk.net, Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 23 14:16:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6K9C-0005X2-NV
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 14:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbaAWNQi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jan 2014 08:16:38 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:62013 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbaAWNQg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 08:16:36 -0500
Received: by mail-pa0-f47.google.com with SMTP id kp14so1834918pab.34
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 05:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6jGkIGzWUvJuoDZ9scC+XrCABfj6rmCKJ3O98haD0VU=;
        b=DMFr44spKmVJv20WQIgA8HaZ92eb0jMa9wnhIjDhJf9dz0krF8bA2GywvK58zGvyya
         0x0+wRIP/O9VHvhynMWuUcOdI1vtBbvBsBQnr23T35WZCnsuCjwe+eDOXrysejKv3xtr
         y2C+Per3076D6AIUBO9nwocgM7wXTiK2MrKHKs+g94YGrYA3LIE41yTobv8aXgmMqf3+
         hSlFHYi7+joJPo0BFedwR2t4CoQ8OE+4VV9ZxqEHqCRlYHd0aX0gndVW7nZL/z17tVxX
         AHkrISrQVMyUjcUfy4BLMfA3ZZeXneWu5qoPRucCxsWjdhLdJ0nTuvxY9Ff44YrwcQ9w
         PDng==
X-Received: by 10.68.218.65 with SMTP id pe1mr7965088pbc.1.1390482995829;
        Thu, 23 Jan 2014 05:16:35 -0800 (PST)
Received: from lanh ([115.73.226.163])
        by mx.google.com with ESMTPSA id gw11sm36411850pbd.17.2014.01.23.05.16.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 05:16:34 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 23 Jan 2014 20:22:08 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <2550653.GHkhBQDSTk@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240911>

We do ignore trailing slash on a directory, so pathspec "abc/" matches
directory "abc". A submodule is also a directory. Apply the same logic
to it. This makes "git log submodule-path" and "git log submodule-path/=
"
produce the same output.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4010-diff-pathspec.sh | 17 +++++++++++++++++
 tree-walk.c              |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index af5134b..15a4912 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -110,4 +110,21 @@ test_expect_success 'diff-tree -r with wildcard' '
 	test_cmp expected result
 '
=20
+test_expect_success 'setup submodules' '
+	test_tick &&
+	git init submod &&
+	( cd submod && test_commit first; ) &&
+	git add submod &&
+	git commit -m first &&
+	( cd submod && test_commit second; ) &&
+	git add submod &&
+	git commit -m second
+'
+
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
