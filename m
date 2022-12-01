Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D559C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 13:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiLANmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 08:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiLANmS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 08:42:18 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8175AD9AC
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 05:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669902126; bh=BELVZTOFweG4MXi49FK/7BMX053QNdU9nRvU/1a5hFQ=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=gpzF0gor86cLtbmhwdNVwWxfoNDbM4IPnNYnT9lVBuQR4uQmim5SIvBUR6JHbgzH9
         nIT03taEWmDxpEm+bIQKQu8JqcUsZjNdDGzyNCf/qCivpmNQ2xOC+6pXGoC2Mw0k0m
         +GnZ5jVt4JP8K27CD2JBzyRAiW738Qer67m1Iiy1B2cjkf/ViguSPs94IVXZvLV/5u
         m/LqrpaJjyukyRKCXwEakQvT0pHvAZj66esqyk4w+HkBBH02LeECX3TuHZsrICM437
         L+OoIbxapeLBEK0cx3MMVXJydGc5RZvm200gh3l5rus8/DnOteIbhTh1GiDvhqLidK
         vCB1E4XxyyjEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrbz-1pSXZT0FsL-00S2QH; Thu, 01
 Dec 2022 14:42:06 +0100
Message-ID: <ed84a688-e1fd-945d-7dfc-10d051652c77@web.de>
Date:   Thu, 1 Dec 2022 14:42:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v2 1/3] diff: factor out add_diff_options()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
 <ea838ae7-b635-d4d2-d9df-e96b3d8980af@web.de>
In-Reply-To: <ea838ae7-b635-d4d2-d9df-e96b3d8980af@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:StHTwUNfgQb9WKOmS09lektYiTBLV8lBx8AyVd+Bc8vURFC2bMX
 9C3Gunij+cnvpR8/yINWy1ay+0FuN44NMGOzCJJM0fatptKzvbM2OWq2nhfLHH6Kj8mi+wx
 Gf3M2vXc85O9HFE6lk1gX2Oa8iE10xyIbSPbe+1hvXPAHlRJ+D1EEIPdiDhcV9E0EUq3c2X
 kWIv9xsnJWMl3YeNmkMoQ==
UI-OutboundReport: notjunk:1;M01:P0:P/Xh+S+R49w=;c/9f/fWYFLQXXlAk0AyVALqSPyh
 nvEs9qFsTGJcfF7WMT9WcrCHpWwHcx8TVJO2XeIRNW6dVHiIRXAldvn4Xb0g4vcyOCtAe2Nqi
 6JiV2P55h9/10EALMFNs2rzfZTPKrW+lEJDizv+8wjXeegQrf1gOKOjwCgYhH3XDIj0poeUP4
 RYKK+K5kUhDlpiUJqWnBWBs4Iw+Vtdv9qZa0agvoHZ+oLzZFcfY+4DNKYtBvs/+s7nz2aul1Q
 QavpuBeEppSMXdv2PdtVVkZuhXbKg0alJHXhSPc7m0Z69FmHusXxXWPQMpiFuDQtr9FyqBOi1
 hlyOza58lLDNbusnfyVxUM7LFR1O3pxpRm5njdaGinGGMWSdEh0F8BFnqf17tB/3W2N1qCEwT
 +FctusGbGeC8ZJGkT9JDb0N/tMeKCGZInI9iRo7Pd0KGu/zhaPYsHNEDE0My/90wT3GSOGOC2
 XkNmWwHoHvaSTGUOZRSENBaJfrIBacCpIFhruHt6xDHNpL6uaVcp7vBsse+ZE1Py+MQvQAWDP
 RPUIUUjmhL15LWZr/MzwTo6N/rxyDwT0NNTQX5lrfyLTEmSbTNFRAXA5mOA5J/IQU7sC35EhR
 9e+6bQJpkGEQ7Ub/+kR1diVFCnGfXspQEBYC2zuTTgBD3JU1JaYpjvr+wJxvOKRVjzbHJFwDu
 6jq+E+t5z6dgcTWK/Mi6BajHGlqWjuRyO2KTAJhz5jM2NFHJqVp7jRKyTiIVIzNHPiT9LDET+
 JGFpDun24hD3ZOYuikcdD6UZmoUUJ4PDtdDCELZ/uiLRCcYrG80PIJnBh4NAnd00YQ0L6s2Cs
 /CUpqNdyfVA4Tfhcw1ICIttt6adQ0OeLxMTiEGvyev/TMd9s3O52iVSVey4XV4SJcyC4MK1V3
 80mB/H0EfnB7wfNF6Xesofy/w0Ie0drSZkh107Fimha1R1/wOcf0YfJaVyXE45nQXAQSBYpHO
 ctzS6A==
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
index 1054a4b732..e01129f0ea 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -5693,6 +5693,12 @@ static void prep_parse_options(struct diff_options =
*options)
 	memcpy(options->parseopts, parseopts, sizeof(parseopts));
 }

+struct option *add_diff_options(const struct option *parseopts,
+				struct diff_options *options)
+{
+	return parse_options_concat(parseopts, options->parseopts);
+}
+
 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
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
2.38.1
