Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67F8C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885CA20786
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b="cWKMJQI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHSRvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:51:12 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:12745 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHSRvM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:51:12 -0400
Date:   Wed, 19 Aug 2020 17:51:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rtzoeller.com;
        s=protonmail; t=1597859470;
        bh=7jBLOozP0Py58OyEYnfnTnvKffXWRu8cge9wuOwqgZo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=cWKMJQI1nWC7KyrxN03FYdABQdCsPgZ3pDbWvmw/akWJ4U2OBOaoraXvJ0U/dtPQI
         u1vwYYt/DCJ2uqvTk7Pfh6Ix+UMXIJpKQEoQtFltlOXbnNCwHAEbAmd2xUl3ZiHomq
         I97D0KIEnBUBZLqc8LY+N/zJi3hmFvs0w6GnfKAo=
To:     git@vger.kernel.org
From:   Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     Ryan Zoeller <rtzoeller@rtzoeller.com>
Reply-To: Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: [RFC PATCH 1/2] parse-options: add --git-completion-helper-all
Message-ID: <20200819175047.692962-2-rtzoeller@rtzoeller.com>
In-Reply-To: <20200819175047.692962-1-rtzoeller@rtzoeller.com>
References: <20200819175047.692962-1-rtzoeller@rtzoeller.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--git-completion-helper excludes hidden options, such as --allow-empty
for git commit. This is typically helpful, but occasionally we want
auto-completion for obscure flags. --git-completion-helper-all returns
all options, even if they are marked as hidden or nocomplete.

Signed-off-by: Ryan Zoeller <rtzoeller@rtzoeller.com>
---
 parse-options.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index c57618d537..cc7239e1c6 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -535,8 +535,9 @@ static void show_negated_gitcomp(const struct option *o=
pts, int nr_noopts)
=20
 =09=09if (!opts->long_name)
 =09=09=09continue;
-=09=09if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
-=09=09=09continue;
+=09=09/* Don't check PARSE_OPT_HIDDEN or PARSE_OPT_NOCOMPLETE,
+=09=09 * we expect the caller to handle these appropriately.
+=09=09 */
 =09=09if (opts->flags & PARSE_OPT_NONEG)
 =09=09=09continue;
=20
@@ -572,7 +573,7 @@ static void show_negated_gitcomp(const struct option *o=
pts, int nr_noopts)
 =09}
 }
=20
-static int show_gitcomp(const struct option *opts)
+static int show_gitcomp(const struct option *opts, int show_all)
 {
 =09const struct option *original_opts =3D opts;
 =09int nr_noopts =3D 0;
@@ -582,7 +583,8 @@ static int show_gitcomp(const struct option *opts)
=20
 =09=09if (!opts->long_name)
 =09=09=09continue;
-=09=09if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
+=09=09if (!show_all &&
+=09=09=09(opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE)))
 =09=09=09continue;
=20
 =09=09switch (opts->type) {
@@ -723,9 +725,13 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 =09=09if (internal_help && ctx->total =3D=3D 1 && !strcmp(arg + 1, "h"))
 =09=09=09goto show_usage;
=20
-=09=09/* lone --git-completion-helper is asked by git-completion.bash */
+=09=09/* lone --git-completion-helper and --git-completion-helper-all
+=09=09 * are asked by git-completion.bash
+=09=09 */
 =09=09if (ctx->total =3D=3D 1 && !strcmp(arg + 1, "-git-completion-helper"=
))
-=09=09=09return show_gitcomp(options);
+=09=09=09return show_gitcomp(options, 0);
+=09=09if (ctx->total =3D=3D 1 && !strcmp(arg + 1, "-git-completion-helper-=
all"))
+=09=09=09return show_gitcomp(options, 1);
=20
 =09=09if (arg[1] !=3D '-') {
 =09=09=09ctx->opt =3D arg + 1;
--=20
2.28.0.260.g5fadab5a9c


