Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2427FEB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 20:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjFQUoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 16:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFQUoD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 16:44:03 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BC0B9
        for <git@vger.kernel.org>; Sat, 17 Jun 2023 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687034641; x=1687639441; i=l.s.r@web.de;
 bh=XI3uVOL6CN9DEQL1+XzLwgBEUz/1lBDeHMaZO7F+ZP0=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=UJiJHLtQEsMGUlPDLIyBQymvjF1GkNuWPybwWPasu5qMY4JwybuGglKyhgOLYNlbADg386F
 MmpgBJH9/6oj/h30JH1Sls5MaI8vOI41gq32cG+lQl3sguR/Y3XGQ9vCkSqNBp/JhzLnJQ8xe
 Hjqxh/x2eqcL4Ui3ddq01M96WS+ElBMvLNgGez8EPFceAKHO7an+eeq5U4d5jJlO+VajZkiZy
 h1bcRDwLahQyY4uUkSqiVy1/GLqSU2VovV3/NGqJ8eGJg6CeIvbHD2GKLVTEES05AxgLaeoYE
 AIYcvg8BsdY2sFa7vVMIWN6yWh8WbuTjJah0uUyWR1UxVH2zowHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.195]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRYd-1qS0w73hi7-00IEVH for
 <git@vger.kernel.org>; Sat, 17 Jun 2023 22:44:00 +0200
Message-ID: <ded69969-158d-b05f-fdd4-91b26e9b502b@web.de>
Date:   Sat, 17 Jun 2023 22:44:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: [PATCH 5/5] strbuf: simplify strbuf_expand_literal_cb()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
In-Reply-To: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aadY49ByRNsuV5jeXeia79uETt268RowoI+I4SbLhmAAQcTRmdS
 Bp/w1/EuKTxVK8VbhxCuJyNcfuwiz+WiIRHANAyGpfCuKMwk9jtUsjKMhkmZVbuSKhkNkDb
 8EzY5uBVXq+v8sx+JjD7O3g0j+1qWh9j2kP+Ql+Bx6TOOPp+zcnLQGZKO2p0N+uNVBmn0s5
 lcamA0xkCvzMdnj1Amo7g==
UI-OutboundReport: notjunk:1;M01:P0:tK+oNHxrH5c=;CEUGPIeVzo1qCTVAovZcplHlBYF
 IZchgcZbY5Eti4dAdBDho/UEfy8Q55RyP20CEa5Nest7mR3ea/I9Zx2GonBupPmBh82aZIW+R
 w5YV/QGuFKwSpRPnv/t1iJt3X5bYoPa0x1F5VKfn2e5NuWnn3Ob8vzG7JUGeqFuC5GgbejWgw
 au7gZWX483/XbxBebE30ZX9df/AnDWu8wdaHqAp8aQs0UK8YuixsxEfYP8tt9bs+34K4GZmhw
 qHiig6NZqPajjY1Y8qyD5qRD9m5HF1RSG2IgcaZ/felRFIKoz9a4atgvRVYN8LmRsB+ztWqgK
 +50ydMFEixrWh6kL+ozyGrAiN7JQpbbh7ic4y8XVxuWnlTwcC6y2OX0dXErFEqHAEpGdv24+Q
 WX1duSXKJxqCONO2WpLyxkRrGyC4hdXhsG5+yGBOkwTimPTtYKyHFAcI9yZKwZ/108G6zXjQd
 R9uYppzQOj+eXdh/VPIX5fvhJHsAWksNzzqhOWaL0npfQps5JNUDaIWojaMIGaNnMwQcHZZM2
 kLi9OLS0luitXYSPKK6Uc6m7vLJbmycplepUKClnDquEU/tDmFSVHW0RvXwh7Lb98Npf7u5RO
 MhuKJgiKc2viqfKC6iBXLlndN7ic4Wr0tzhu+C8dWCPNF3yyBdh4DhX9FHZRip2AAyEQqIjzX
 lZPpo6dtkSi4PwcNRYv46giyJuxd/pHu7o4WuudIvxG4Qqd1SyOaNsGIHg+ZR89ojWAoMNg4A
 LCbY+AD8pKTSCgf/m39yDN0yaExS1prohl1kma4wU9iOILcM2TkVD9okgq1hec9dhriALRwwi
 /AL91gqO5OQFIVvIB3Ve28I+iPqxPJLDH7lRejMcPa2kLRgDM7oNbPuK5iTDqucCxXPJkj+3a
 k7hpL6A0xY7biMZxK/QlI/ic9ymQv/1F1OmiktmzQPNT8xoeiIoS+MumXvUR6FQ8E0fJcznvg
 KBx601UB/eMV/4c9idreTiX4Dk4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that strbuf_expand_literal_cb() is no longer used as a callback,
drop its "_cb" name suffix and unused context parameter.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/ls-files.c | 2 +-
 builtin/ls-tree.c  | 2 +-
 pretty.c           | 4 ++--
 strbuf.c           | 4 +---
 strbuf.h           | 6 ++----
 5 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 03bf5771b4..0b00bd5d0f 100644
=2D-- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -274,7 +274,7 @@ static void show_ce_fmt(struct repository *repo, const=
 struct cache_entry *ce,

 		if (skip_prefix(format, "%", &format))
 			strbuf_addch(&sb, '%');
-		else if ((len =3D strbuf_expand_literal_cb(&sb, format, NULL)))
+		else if ((len =3D strbuf_expand_literal(&sb, format)))
 			format +=3D len;
 		else if (*format !=3D '(')
 			die(_("bad ls-files format: element '%s' "
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 8460d20257..a90f3c81a0 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -108,7 +108,7 @@ static int show_tree_fmt(const struct object_id *oid, =
struct strbuf *base,

 		if (skip_prefix(format, "%", &format))
 			strbuf_addch(&sb, '%');
-		else if ((len =3D strbuf_expand_literal_cb(&sb, format, NULL)))
+		else if ((len =3D strbuf_expand_literal(&sb, format)))
 			format +=3D len;
 		else if (*format !=3D '(')
 			die(_("bad ls-tree format: element '%s' "
diff --git a/pretty.c b/pretty.c
index cffbf32987..4c08f9856b 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -1262,7 +1262,7 @@ static struct strbuf *expand_separator(struct strbuf=
 *sb,

 		if (skip_prefix(format, "%", &format))
 			strbuf_addch(sb, '%');
-		else if ((len =3D strbuf_expand_literal_cb(sb, format, NULL)))
+		else if ((len =3D strbuf_expand_literal(sb, format)))
 			format +=3D len;
 		else
 			strbuf_addch(sb, '%');
@@ -1395,7 +1395,7 @@ static size_t format_commit_one(struct strbuf *sb, /=
* in UTF-8 */
 	char **slot;

 	/* these are independent of the commit */
-	res =3D strbuf_expand_literal_cb(sb, placeholder, NULL);
+	res =3D strbuf_expand_literal(sb, placeholder);
 	if (res)
 		return res;

diff --git a/strbuf.c b/strbuf.c
index c3d1cee616..55a3cfa5cf 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -427,9 +427,7 @@ int strbuf_expand_step(struct strbuf *sb, const char *=
*formatp)
 	return 1;
 }

-size_t strbuf_expand_literal_cb(struct strbuf *sb,
-				const char *placeholder,
-				void *context UNUSED)
+size_t strbuf_expand_literal(struct strbuf *sb, const char *placeholder)
 {
 	int ch;

diff --git a/strbuf.h b/strbuf.h
index 95e50e243e..b1eab015f0 100644
=2D-- a/strbuf.h
+++ b/strbuf.h
@@ -320,11 +320,9 @@ const char *strbuf_join_argv(struct strbuf *buf, int =
argc,
 /**
  * Used with `strbuf_expand_step` to expand the literals %n and %x
  * followed by two hexadecimal digits. Returns the number of recognized
- * characters. The context argument is ignored.
+ * characters.
  */
-size_t strbuf_expand_literal_cb(struct strbuf *sb,
-				const char *placeholder,
-				void *context);
+size_t strbuf_expand_literal(struct strbuf *sb, const char *placeholder);

 /**
  * If the string pointed to by `formatp` contains a percent sign ("%"),
=2D-
2.41.0
