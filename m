Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADB3C4332F
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 10:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiKLKo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 05:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiKLKo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 05:44:56 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F6A16593
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 02:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668249890; bh=vgtPAVm3hcY2+aWMpG5fgjk652kn/2m6tRnBrZn7eEs=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=EqHVKWgB6FLi+7/ukIgBzl6JMf7aJmuIgCOwLCzzZwzMkwoXcNZrbQsQK6t9PhYom
         YuDWraV/BlG9TBy0HjkfUzDO1/L8ki4YemKrtn/pOWcX9RwFSwgMSwUXvDslxhhdNV
         xQvH771026dsuFQxW0moaVKrPPKvNKonApOoo/eMY+IfYA2YvdV3BEq8d6wtNqUMLv
         Io0kK1SS/qmBIADnL3rANxN4lnDHhRTCc1AFV8ymgqz/aSzlOQimtofuOdROHdrWY7
         u881/fXinsyiOrr2l9Rt+f2bYhjjGM6WC3JiCnvsT4MJo2ElNmYtVXv8vMt+jfGH9Q
         CMe4gayXBPiog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.27.139]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MW9rM-1oUvl22meQ-00Y3hr; Sat, 12
 Nov 2022 11:44:50 +0100
Message-ID: <59abb8d2-e8e6-7423-ead8-49382293aaa6@web.de>
Date:   Sat, 12 Nov 2022 11:44:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: [PATCH 2/3] pack-object: simplify --filter handling
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
In-Reply-To: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7ruvVsjFpM9YSwV1HCoygNaeKz72cORvQkhLoCTYInqgsGx4sY4
 YoUfBrjuJ0uf0imbE8/uh2IhyDfvw7GkUgAoZCh4ew+bYN27RMCx4jShK1wn4L6lgCzFOxx
 Hbxch/KDxtAFaTWxnnNrTISnVJ8+RjZSHLO1WlzJ5qOUyn09k4+AA7WQWqHN5gS9H3/ZlmA
 sfzYGUBZXLGYUw+bI0wsw==
UI-OutboundReport: notjunk:1;M01:P0:lzm4q+gvjZI=;RF84KHgzBKAiMNaKnYlwidEwCAn
 qKX1S9E5NIQXJPzR/9rolgdqriacVagaYpe1FGpG92mr2zaFQFXYmAdGeP9SbeV10FSjBCSJZ
 mxqZOplDeHzFPgC8+0fA0/PB0ExrjJ0wkDo10Lzd4NyPfVL8cjccOYkzKoqJw20VqxYW0+qeC
 tL7fJjZod8GCYGkmjvetiiYm3eUzrWHBiWHigYzwCfLtNVYnLDCDdkXmiguRDVCVxi3NTMVNi
 PxtVXdXnzYnQ5cdlOMhjgOBo7rw+dVVFwYmX/nbaNnsDXp2eOu4TVu4sVhOwn/bSrR9mY/5Ty
 WEcmxy6BmExpAyIGZZg/Qde94KfU97JDRwJb4JfG4uarxNpJqX9AmX68L0zk95Sx8LqmqsxOM
 8xaZ3fhHfgLF1AP9KU1YbrmLnrPbueXh8F5o78AFNVPzIYo3tImrCYgbdCPJlcgyC5k7v6l0z
 vjK0G1w/iZi63uk+ZFESSQbtAx0Yw5y5+byU6Rc2vaV/LE3y6rDqAhg3jiRPh0C0jXS1Kr5C4
 v4ouSXy/6EtNgi7o9B8vE0x/GruhNmXhRhkGxU8U8aDZUWEiyk1c+lxhzdG278sFhwRDHvlfg
 Ico3ZUR4UiX7xAn362ZQwMsQ1X8xsrFH/j/zAptsmwKb4l9tR0jmFa4QWTYtOlzSi6r6FCExF
 N82rOEOyH3U8A247j7R/2uMo2VDoLpQ1wO8z5hWPuOFPmhF4Ezlx6L+92JBv85yEvJPYF1+gA
 lPSOUcDg0fLvuBDBWyAGN63gH4Mx1bnEc5wiZQn/uCulta7/716Xbg5VQLG0b/b5z7SzSDZ7o
 fkeyJeVDUuf+At7ddEw3pnL71iC+AUcW3lYTFjjSeyxwPijUugxTmzGQxoDBg5xOdvXe+ys4H
 rCa7QAF5fFGrfmwH/PfROXFMNieBOjnKy+PuX2weAjDhi0hJDqJjINAzLQUGQ138KayQvh0fJ
 nVvt0MoZygTV7WsFH7p8JxSEaFo=
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

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/pack-objects.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c702c09dd4..30023bcebb 100644
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
@@ -4473,16 +4458,15 @@ int cmd_pack_objects(int argc, const char **argv, =
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
+	list_objects_filter_release(&filter_options);
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
 		for_each_tag_ref(add_ref_tag, NULL);
=2D-
2.38.1
