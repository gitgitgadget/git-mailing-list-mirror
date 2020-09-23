Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE30BC4363D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 21:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D255212CC
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 21:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b="Ke1n+TfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIWV7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 17:59:34 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:59901 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIWV7e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 17:59:34 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 7DF6E2008537
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 21:59:31 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b="Ke1n+TfV"
Date:   Wed, 23 Sep 2020 21:59:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rtzoeller.com;
        s=protonmail; t=1600898366;
        bh=4CDivIZW807yEMA65v1BQdBxQg5Y/YMZCG7Bp6zjVXE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Ke1n+TfVxIbq2rWfmO/IZ4igev/X7tJBhZY7a5TSd4Ln1SPiuAWo4Oot01OBGCwd9
         KhxYUT1GQYEOfUiqKyo/Uk+uE9oE88JjR9e4VnWW9j2J+gfEnGFnZXE4vHoiWTEg3H
         DRPmirrQ/XU13VUG9iJiptFi7bVZxQNq4FszQH9I=
To:     git@vger.kernel.org
From:   Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     Ryan Zoeller <rtzoeller@rtzoeller.com>
Reply-To: Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: [RFC 1/1] xdiff: use leading whitespace in function heuristic
Message-ID: <20200923215859.102981-2-rtzoeller@rtzoeller.com>
In-Reply-To: <20200923215859.102981-1-rtzoeller@rtzoeller.com>
References: <20200923215859.102981-1-rtzoeller@rtzoeller.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The regular expressions specified in userdiff.c, as well as user-defined
expressions, allow git to detect which lines of code which declare function=
s
(as well as other notable lines, such as class declarations).

Although useful, these regular expressions can't identify which function
a line of code belongs to, only the closest function to it.
Languages which allow for nested functions -- or functions inside of
classes -- can trip this mechanism up.

Since many languages use indentation to associate lines of code with a
function (either semantically or cosmetically), we can use indentation
as an additional heuristic for identifying the owning function.

Specifically, this assumes code belongs to a function which is less
indented than it.

Signed-off-by: Ryan Zoeller <rtzoeller@rtzoeller.com>
---
 grep.c            |  2 +-
 line-range.c      |  2 +-
 xdiff-interface.c | 14 +++++++++++++-
 xdiff/xdiff.h     |  2 +-
 xdiff/xemit.c     | 23 +++++++++++++++++------
 5 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/grep.c b/grep.c
index 54af9f813e..3281f19977 100644
--- a/grep.c
+++ b/grep.c
@@ -1555,7 +1555,7 @@ static int match_funcname(struct grep_opt *opt, struc=
t grep_source *gs, char *bo
=20
 =09if (xecfg) {
 =09=09char buf[1];
-=09=09return xecfg->find_func(bol, eol - bol, buf, 1,
+=09=09return xecfg->find_func(bol, eol - bol, buf, 1, -1,
 =09=09=09=09=09xecfg->find_func_priv) >=3D 0;
 =09}
=20
diff --git a/line-range.c b/line-range.c
index 9b50583dc0..eb9540bc76 100644
--- a/line-range.c
+++ b/line-range.c
@@ -119,7 +119,7 @@ static int match_funcname(xdemitconf_t *xecfg, const ch=
ar *bol, const char *eol)
 {
 =09if (xecfg) {
 =09=09char buf[1];
-=09=09return xecfg->find_func(bol, eol - bol, buf, 1,
+=09=09return xecfg->find_func(bol, eol - bol, buf, 1, -1,
 =09=09=09=09=09xecfg->find_func_priv) >=3D 0;
 =09}
=20
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 4d20069302..d93cb5c72e 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -201,7 +201,7 @@ struct ff_regs {
 };
=20
 static long ff_regexp(const char *line, long len,
-=09=09char *buffer, long buffer_size, void *priv)
+=09=09char *buffer, long buffer_size, long max_leading_spaces, void *priv)
 {
 =09struct ff_regs *regs =3D priv;
 =09regmatch_t pmatch[2];
@@ -216,6 +216,18 @@ static long ff_regexp(const char *line, long len,
 =09=09=09len--;
 =09}
=20
+=09// TODO: Is it faster to check whitespace only after matching the regex=
?
+=09if (max_leading_spaces >=3D 0) {
+=09=09long leading_spaces;
+=09=09for (leading_spaces =3D 0; leading_spaces < len
+=09=09=09=09&& leading_spaces <=3D max_leading_spaces
+=09=09=09=09&& isspace(line[leading_spaces]); leading_spaces++)
+=09=09=09;
+
+=09=09if (leading_spaces > max_leading_spaces)
+=09=09=09return -1;
+=09}
+
 =09for (i =3D 0; i < regs->nr; i++) {
 =09=09struct ff_reg *reg =3D regs->array + i;
 =09=09if (!regexec_buf(&reg->re, line, len, 2, pmatch, 0)) {
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 032e3a9f41..f78c30c527 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -93,7 +93,7 @@ typedef struct s_xdemitcb {
 =09int (*out_line)(void *, mmbuffer_t *, int);
 } xdemitcb_t;
=20
-typedef long (*find_func_t)(const char *line, long line_len, char *buffer,=
 long buffer_size, void *priv);
+typedef long (*find_func_t)(const char *line, long line_len, char *buffer,=
 long buffer_size, long max_leading_spaces, void *priv);
=20
 typedef int (*xdl_emit_hunk_consume_func_t)(long start_a, long count_a,
 =09=09=09=09=09    long start_b, long count_b,
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 9d7d6c5087..1de68008f9 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -95,7 +95,7 @@ xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t =
const *xecfg)
 }
=20
=20
-static long def_ff(const char *rec, long len, char *buf, long sz, void *pr=
iv)
+static long def_ff(const char *rec, long len, char *buf, long sz, long max=
_leading_spaces, void *priv)
 {
 =09if (len > 0 &&
 =09=09=09(isalpha((unsigned char)*rec) || /* identifier? */
@@ -112,19 +112,19 @@ static long def_ff(const char *rec, long len, char *b=
uf, long sz, void *priv)
 }
=20
 static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long =
ri,
-=09=09=09   char *buf, long sz)
+=09=09=09   char *buf, long sz, long max_leading_spaces)
 {
 =09const char *rec;
 =09long len =3D xdl_get_rec(xdf, ri, &rec);
 =09if (!xecfg->find_func)
-=09=09return def_ff(rec, len, buf, sz, xecfg->find_func_priv);
-=09return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
+=09=09return def_ff(rec, len, buf, sz, max_leading_spaces, xecfg->find_fun=
c_priv);
+=09return xecfg->find_func(rec, len, buf, sz, max_leading_spaces, xecfg->f=
ind_func_priv);
 }
=20
 static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
 {
 =09char dummy[1];
-=09return match_func_rec(xdf, xecfg, ri, dummy, sizeof(dummy)) >=3D 0;
+=09return match_func_rec(xdf, xecfg, ri, dummy, -1, sizeof(dummy)) >=3D 0;
 }
=20
 struct func_line {
@@ -137,12 +137,23 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t =
const *xecfg,
 {
 =09long l, size, step =3D (start > limit) ? -1 : 1;
 =09char *buf, dummy[1];
+=09long leading_spaces;
+
+=09if (start - step >=3D 0 && start - step < xe->xdf1.nrec) {
+=09=09xrecord_t *first_line =3D xe->xdf1.recs[start - step];
+
+=09=09for (leading_spaces =3D 0; first_line->ptr[leading_spaces]
+=09=09=09=09&& isspace(first_line->ptr[leading_spaces]); leading_spaces++)
+=09=09=09;
+=09} else {
+=09=09leading_spaces =3D 0;
+=09}
=20
 =09buf =3D func_line ? func_line->buf : dummy;
 =09size =3D func_line ? sizeof(func_line->buf) : sizeof(dummy);
=20
 =09for (l =3D start; l !=3D limit && 0 <=3D l && l < xe->xdf1.nrec; l +=3D=
 step) {
-=09=09long len =3D match_func_rec(&xe->xdf1, xecfg, l, buf, size);
+=09=09long len =3D match_func_rec(&xe->xdf1, xecfg, l, buf, size, leading_=
spaces - 1);
 =09=09if (len >=3D 0) {
 =09=09=09if (func_line)
 =09=09=09=09func_line->len =3D len;
--=20
2.28.0.586.g47c91ef7fe


