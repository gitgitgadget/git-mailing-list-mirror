Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB2CC4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiK3SDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiK3SDl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:03:41 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A7B6C72B
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669831407; bh=BELVZTOFweG4MXi49FK/7BMX053QNdU9nRvU/1a5hFQ=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=hBBVmPY2xpwB7D4PjlwCTjzGNyI7uYkhMmLZe0xQlml+w4ZQfnlBptfjwFfwTeSNe
         DaAWOCrdChJioArHWwX2/8KE+6zLhscHftTRcqme66/7TYIf8HhD/C4e6JZckxEz4Y
         XXaEw5o0lDPj3hVSRny4RXV5S9a8g703ztjzZFzc0CJ/oBfxpHi0z+Jp5vF8KM91L1
         OuU6xx1vovdum4jvMYHJOPgVsTfWEu2hvPWmr61Bw3DbCr2jK274qc5u2LxJ3Z9vEz
         Ks86hKIUToX5bLLW7gDsC7NGefgP3WMWEtL1pFSYz8ctqRBJeYFH3RHl99wJ1OhJjV
         usIye55cPCpGw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO9K-1oR6bu3zqC-00ZDYc; Wed, 30
 Nov 2022 19:03:27 +0100
Message-ID: <19be5afa-63e8-5f11-c5f4-6f391677e4c4@web.de>
Date:   Wed, 30 Nov 2022 19:03:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH 1/3] diff: factor out add_diff_options()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
In-Reply-To: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y8KWpQuWplgU49aQyMsMma9s0Je+btx8sjDGHgNLhEJh8sYlw2l
 ATRJoeyqlyeR/O1f74qohceyWlIQhqoiCPChUJ+XUW5nwYtclUJdbGkHisHNfQLPMkwFnFP
 hC7hXfokVfft1pmyWpjr+fLc00TUPDcAFr2WTP8x0Siw/2Zqoekat/IvOYRPEsEEnDPV26V
 vJhWG9xVZVihZvOaoP9cw==
UI-OutboundReport: notjunk:1;M01:P0:SFSeQPPuCT8=;HSroOq6+YigHRN35Pa1fOKT9AZ0
 xB5SfH8rPmiNtnuJuM6v3Lo0Qa2LTLGYgLryUN+9wZvAqSo7FPzvnBoWhBlt4iVRCmBLABDqz
 rFdWJjcesnmdADL5RFkOH3KDDwFyCYA3a8+qfDlJZ6sc9vvYeDP5DFyOEzPuZWsd0MeCvIJUi
 sk1twOXioD2gm6iCe2sNmfjjEm8oTCO6fqB9GDp3lqrOrNznTpfs+F+GNjz80M6R0h7McBZ2R
 3vo7OIojQJCVhPD11UYILEHzn/nJPC0c5t1RMpxVRcztTS7YqVL1s3vZ4IFDJFqezTKep9YaA
 aUfemcK6FJXMQSdM7Zq8J45Gg8qcMky6pp0GkGnbay0sU0r4pbyrBvZ8BJMRB7+4Zvrgd5fLl
 d8lOHXEL5sZnkzcDA1TVKA9ikjlv0l5jz2a4n3JsfkAUlOccqUTWka5XuuiJuhDco3HxsA1mo
 MOAvNLp80IVyz5QXmj/ZbxSLEQxmKNQVfoC8ZghCB4uMpy4WSFpcHZBaHJQDLBwdQrAdZpzzK
 ZZqiUbNT/sFLCIMzuHzCB/BgHNkbL+OVanLsOQ8oVJYvWKOKcR54ZHPhyJINto5a4b/yZgOJz
 aZ9GPAw2h2CKUqk7+CIuj8tuEJtroLevgaT2Wdy2STVXboJCXkcprWAlGpoWuK63bf5apq5dl
 UF04q+ANFskVhCGIhvy0s60INSFd5LhUtcf5vBvAT04uY5Vl0CO9NkqxgV8RlTmYgKqrR5yof
 +F9Gmr+Au0/hA12iTo1Z/zuSlEW7xzE3GysqWxIPZLwaakHC/39oKsAbcHn/XDm3WRbWcEGjK
 P0hskMs5uEzbwtIngCiAmAXEML/d2G8UJQRWQ42VuvFpqUQ1iJbPAlCzfcMEbuHajsN8nEGq6
 qMO1DBMPgiQSdsb6dNxjIhkJPT0TnjX7t4tUFTsCsq30WgEpHle4LvO67Kc568k+9llAqJva/
 oilL5zoJ9TBMo5iyRpeCqpVxp2E=
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
