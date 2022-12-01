Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B038FC3A5A7
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 22:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiLAWuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 17:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiLAWuH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 17:50:07 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D3A80BA
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 14:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669934951; bh=XcVr80Rsrak1rZf/eMZq5cWtksFz2VBJcB9yYzLIqvs=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=Eozb21aluwZi8p6g5oiLoKB9kJFSLjC7NX46xr7JnoouSXtLh3Rpf9ZXmiHViTZgq
         ied55VhCBp0srcL9En4ZOeXBVCJqDYuXqfiahDA7buXdYfAjCchRdZQtwJWB/JBTUd
         QtWvCEPiJmAn6vR+HHXE/+SsbqGXtueWYq5KEugF3Vfka8BZguQcrXKguD/gtqUCnZ
         ZUvum+vYP92aKJSOqRZXgX/BQyvoJvDr2qSxu5uJ2A6NCp6AWlEnEDcGTSRaBd2oWi
         OnN/lFPJb0n27yCdQqVvMNeN1xmsvkPy5NMuxMZBmzdNoyvGdYqS92f//8b/XijaX2
         5mLsJiB7+98hA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpCmT-1oe9nM0gjn-00qZVC; Thu, 01
 Dec 2022 23:49:11 +0100
Message-ID: <31f0e4ed-4a31-2423-65f0-2f9f1f6c7df3@web.de>
Date:   Thu, 1 Dec 2022 23:49:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: [PATCH v3 1/3] diff: factor out add_diff_options()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
 <19325420-5630-87bb-0c2c-362151214b36@web.de>
In-Reply-To: <19325420-5630-87bb-0c2c-362151214b36@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cEujPDKxwYP4nW/W3SXe1aY1iUuBJHtzCyqMqY0muStW7jLBx4F
 /2Y//dtWJcfafL1RZ2x6CyqR6hCYDc/sU6F3YBBD0w4LrnpshM8+SksPbXdFjZpVf140k/+
 et23g1v3KyPdjnt6j82dIqc2e+KFP3lMd6s+pb5zsTVio7ovIPeC635n6SOWji3h3CgjnS2
 7/gRZ6NJXw+FCNrTzNrWQ==
UI-OutboundReport: notjunk:1;M01:P0:v1O9FIb9Ds4=;EWzFu/lmIj3XMmisIGJG5Vsalcv
 qhkqkxuGBT596LCceW2S2aoE6yGx1Q5msMh2x8fqGrTpRBIZC/MgF2sJ4AhbswQbKRXAJBuYN
 +7qcXufFMxkPYMTr0L5e+RoubDPoZ3/UKQtBCQtom+TP//mq22cxas36nkEDU1sGJmVLDObDQ
 7TvA9H35kWzKw6OEm5tmuc3xTTpaUomcJAkeA7imaSgefBt3thc+YNOhW7BILcvR5hqmLhFjV
 5CPe4bybU3v6hqg6nOk1cG6m29EVupVyxmEwb46VV9r7dJDWVkF+39LZ76XiDlTUYY2vPPhJF
 d2GiTmne527b92bXcxBkETlaaH4OOQJlVqLnK8097FiCl81mAnPQG2sd1fruY8IzWyb8/zlal
 NuolDdS9wPKU257740SGSkOg/EVxhtbS7Elpa8tkn8FXDyEQz6e6xVCs5hh2tSJzGO4cRpNqp
 dBUXG3JjPVXsdt93X6BsWl1I7pmT6yUayKJ9fUCagOY91FpfuyJ8zK9MWMCC2z6c95N1keqTv
 3TYveGbob3MYKoN2/t21980kBUREdyUtpM8V+IXJ4u8Q3iva/vW2bZcYUB58B6dOK6bEKZxbh
 mVAahEkBqw42QLrwhmVuN+tQsljUSYG32pWU+AqJOmjpyF/ik3BACKXQiaBG1A45KzOti2riQ
 ZpZDa6cEC+VqhWSxjQSn/k3fkdyZ251CxfT9nTmO0UDwzlrMnPjk6vcRe7RMAr1PDJXwIqCDX
 Bgk6w5YXX4+TGV64qkYoM8RyICS90vRt+dIUe/XwSs0RnJ3GfA8iUDPxFWEtlxIjTOkzoHNfb
 Ln2q+Q6oDOlNUholf7W/DEqzXY2+XMNh7OcjKs4obudYXG0000gW5JOOdqv0omoG8iAOO8l8i
 1N4NFd2OhPF704MptEKjYQ1uuHbz8J2PKZsX7yXvoEhFQrqICkUEfMjqj0oyf1ALUDDSkx1uS
 tTZDXQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function for appending the parseopts member of struct diff_options
to a struct option array.  Use it in two sites instead of accessing the
parseopts member directly.  Decoupling callers from diff internals like
that allows us to change the latter.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/range-diff.c | 2 +-
 diff-no-index.c      | 3 +--
 diff.c               | 6 ++++++
 diff.h               | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index e2a74efb42..aecfae12d3 100644
=2D-- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -47,7 +47,7 @@ int cmd_range_diff(int argc, const char **argv, const ch=
ar *prefix)

 	repo_diff_setup(the_repository, &diffopt);

-	options =3D parse_options_concat(range_diff_options, diffopt.parseopts);
+	options =3D add_diff_options(range_diff_options, &diffopt);
 	argc =3D parse_options(argc, argv, prefix, options,
 			     builtin_range_diff_usage, PARSE_OPT_KEEP_DASHDASH);

diff --git a/diff-no-index.c b/diff-no-index.c
index 18edbdf4b5..05fafd0019 100644
=2D-- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -255,8 +255,7 @@ int diff_no_index(struct rev_info *revs,
 	};
 	struct option *options;

-	options =3D parse_options_concat(no_index_options,
-				       revs->diffopt.parseopts);
+	options =3D add_diff_options(no_index_options, &revs->diffopt);
 	argc =3D parse_options(argc, argv, revs->prefix, options,
 			     diff_no_index_usage, 0);
 	if (argc !=3D 2) {
diff --git a/diff.c b/diff.c
index 1054a4b732..f1cf13e8e7 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -5419,6 +5419,12 @@ static int diff_opt_rotate_to(const struct option *=
opt, const char *arg, int uns
 	return 0;
 }

+struct option *add_diff_options(const struct option *opts,
+				struct diff_options *options)
+{
+	return parse_options_concat(opts, options->parseopts);
+}
+
 static void prep_parse_options(struct diff_options *options)
 {
 	struct option parseopts[] =3D {
diff --git a/diff.h b/diff.h
index fd33caeb25..c20a1ad76d 100644
=2D-- a/diff.h
+++ b/diff.h
@@ -539,6 +539,7 @@ int git_diff_ui_config(const char *var, const char *va=
lue, void *cb);
 #define diff_setup(diffopts) repo_diff_setup(the_repository, diffopts)
 #endif
 void repo_diff_setup(struct repository *, struct diff_options *);
+struct option *add_diff_options(const struct option *, struct diff_option=
s *);
 int diff_opt_parse(struct diff_options *, const char **, int, const char =
*);
 void diff_setup_done(struct diff_options *);
 int git_config_rename(const char *var, const char *value);
=2D-
2.30.2
