Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAEAC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 12:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiK2MZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiK2MZR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 07:25:17 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBF048426
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669724705; bh=Gxe7hS/HUUyId9efRCahqvW3Z+HQHwcA2P72W6inP14=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=OUiXHgTk1Dqwelt33bx+Pyxmsa9PQItCiYUF+i/kw1H5CZnMibPpg7Lo9zgys1Ncx
         m1sDdyko1aktLf+wjIn7DuUcItDCc4iOAn3rgfKNHfPxJbIYcouLEFpM3o5bQ10yxV
         g0CL0jVj8eHpxQUzDoIFI208vN0Xkgm+pPQRM/zcOGGaPD7wWzjq+FLZfkDxyIHq6d
         6Xgla3KcVR6SV5CeNw6g5D5I6omoCwctBR2jk001FN5M4z8ZrjnnrEpuiylx4h7soU
         Jk/RD6ZRkrMh7r2Zt1lUZ94ruJjuqWzPMFTECO+E18Ikq5jwqObz/YTISk+KlXyN9O
         g4DHWZcpu+o4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuOW-1oTwiD3OU8-00exeX; Tue, 29
 Nov 2022 13:25:05 +0100
Message-ID: <d7a86408-da5c-10ca-90e8-01bc7e268d3e@web.de>
Date:   Tue, 29 Nov 2022 13:25:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v3 4/5] pack-objects: simplify --filter handling
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <c2d3e7a3-599f-dae5-8dde-dc969df39f02@web.de>
In-Reply-To: <c2d3e7a3-599f-dae5-8dde-dc969df39f02@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KoFuizDamAoCh2k3tJ/54Plwo4jt1V0Do89HkzDhwStAkzKv60O
 KCSHYG+cxVYOxKFy1rodYctu7loLaGMoqSAApZ0L1Z2hvKlUw949ui9RvR6720daZ3zhGKj
 IZgMZR8F4xwCVd+b1b10Bmn7g2fonHzzEfilYnS/65SrOukZqxMjAggHwbjIG04Ju+muts0
 hQfzld1EQd8UuMuRXJ/Fw==
UI-OutboundReport: notjunk:1;M01:P0:8HjOXloebBg=;YZ3Hm9PZGWT6Y05i3vpTJYYJxTP
 Z6NnyyVpWOZIE4AgbdEB46K396sKQkEwB8F0NqtPkxSrTaPQxRqhcF/8N6/2MbVOX3IhAonEi
 8zqxmageJNX5PerUH17SPooOl/LLHEmqBRxsrdh6qF7ZjtyeVHYTpoQEIFU0OxRFDl3OLdIac
 aFOKbpbSM08Q4QtDDzp08EmLwDGCZpdPx01LHQ1AUMClnrQleInSINAJlywvtxIwfGUM9GLc+
 fAQ1WTPgRaSJUa9kij+3h3Kl0Ck3swKfvJzHnM+rxNwbc43DBKkxnGoo8ZNwK824UyZeCK3Uu
 5PXf8Beruk3KvX4eCMe8sR/jZOL83QVryIFSnjGR2l+wKwTKA6XerOIOE4fS7MuGJh7XAIQoT
 hW6unqBjHb5BvDjZVWCdaG9TSH/969CTGKmu5xzb8ajaAzQCNzLIHEwwzuH2Y4hr1yBk3KB+d
 6cJfx2iIV/yN0z+IscznAa/6p6sFg/3MIP7oj6dGuMpM+VazAMWTEskDVJ2d53sZhkqURg8S8
 szkBArJnM1pI4am7iZG5MDZYcFY0KEl8GxC0zuP916ApInlWZMJm899nAYW+472aKOJSYWqDk
 9zdoASY66txzal410UylU2GxZ4todB7C+oPcDBV+K9eujJ5t9KGNiMJr6lUUaKumpfWJoxWm5
 QDX3xHCviyOPcZkwcLpjikmpms2Lr6XYejz7NMV585jg0iL602ezBEy8in8264khIpCacuJYe
 25eQX5K8VkSTtSjNkby6qlQHwJ45lL83gIo3x4YCc98YXvOTz2aComdnHcS7c3DExYgQ6ZChF
 /R7bXjDsqunj0HCg4ZcpjhCEUppV8suheCv81t0KjOjmnkZEZZkqinVVRb/DgOSjOVVA+0LSo
 r7mMrteflcNmB22Hb2ylML6kOGECoSJtAttuFtRYC6+UDXXvDcqZZXV5gG/YbSOUJKBsUnPj0
 xAXLqg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pack-objects uses OPT_PARSE_LIST_OBJECTS_FILTER_INIT() to initialize the
a rev_info struct lazily before populating its filter member using the
=2D-filter option values.  It tracks whether the initialization is needed
using the .have_revs member of the callback data.

There is a better way: Use a stand-alone list_objects_filter_options
struct and build a rev_info struct with its .filter member after option
parsing.  This allows using the simpler OPT_PARSE_LIST_OBJECTS_FILTER()
and getting rid of the extra callback mechanism.

Even simpler would be using a struct rev_info as before 5cb28270a1
(pack-objects: lazily set up "struct rev_info", don't leak, 2022-03-28),
but that would expose a memory leak caused by repo_init_revisions()
followed by release_revisions() without a setup_revisions() call in
between.

Using list_objects_filter_options also allows pushing the rev_info
struct into get_object_list(), where it arguably belongs. Either way,
this is all left for later.

Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/pack-objects.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c702c09dd4..2193f80b89 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4149,22 +4149,6 @@ static int option_parse_cruft_expiration(const stru=
ct option *opt,
 	return 0;
 }

-struct po_filter_data {
-	unsigned have_revs:1;
-	struct rev_info revs;
-};
-
-static struct list_objects_filter_options *po_filter_revs_init(void *valu=
e)
-{
-	struct po_filter_data *data =3D value;
-
-	if (!data->have_revs)
-		repo_init_revisions(the_repository, &data->revs, NULL);
-	data->have_revs =3D 1;
-
-	return &data->revs.filter;
-}
-
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list =3D 0;
@@ -4175,7 +4159,8 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
 	int rev_list_index =3D 0;
 	int stdin_packs =3D 0;
 	struct string_list keep_pack_list =3D STRING_LIST_INIT_NODUP;
-	struct po_filter_data pfd =3D { .have_revs =3D 0 };
+	struct list_objects_filter_options filter_options =3D
+		LIST_OBJECTS_FILTER_INIT;

 	struct option pack_objects_options[] =3D {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -4266,7 +4251,7 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
 			      &write_bitmap_index,
 			      N_("write a bitmap index if possible"),
 			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
-		OPT_PARSE_LIST_OBJECTS_FILTER_INIT(&pfd, po_filter_revs_init),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
 		  option_parse_missing_action),
@@ -4386,7 +4371,7 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration =3D 0;

-	if (pfd.have_revs && pfd.revs.filter.choice) {
+	if (filter_options.choice) {
 		if (!pack_to_stdout)
 			die(_("cannot use --filter without --stdout"));
 		if (stdin_packs)
@@ -4473,13 +4458,11 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
 		read_cruft_objects();
 	} else if (!use_internal_rev_list) {
 		read_object_list_from_stdin();
-	} else if (pfd.have_revs) {
-		get_object_list(&pfd.revs, rp.nr, rp.v);
-		release_revisions(&pfd.revs);
 	} else {
 		struct rev_info revs;

 		repo_init_revisions(the_repository, &revs, NULL);
+		list_objects_filter_copy(&revs.filter, &filter_options);
 		get_object_list(&revs, rp.nr, rp.v);
 		release_revisions(&revs);
 	}
@@ -4514,6 +4497,7 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
 			   reuse_packfile_objects);

 cleanup:
+	list_objects_filter_release(&filter_options);
 	strvec_clear(&rp);

 	return 0;
=2D-
2.38.1
