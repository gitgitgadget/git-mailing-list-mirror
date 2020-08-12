Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245FEC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E68662076C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="E70pAN74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgHLQw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:52:57 -0400
Received: from mout.web.de ([212.227.17.12]:41623 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgHLQwy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 12:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597251169;
        bh=wlLBmV3r0sqMzhPJRttgsQsVDMOBg5eXiMNGstcVS70=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=E70pAN74Jl5hVXK7KoniMsMCUOmZR6++9FmhldHVIhcMzcJ9pROIp9SYmmaDTpORL
         /GmLSKG/LKU0QuhSTJVfNF4hohFQAha0s2bHKyDL0Mz9Cfl7yklR+l3SAghz+tCDGs
         cI9obzL8fREgULxoxuAwh6EpZBAPN5gRidyIlF8o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MREzO-1kI3412x64-00NdVb; Wed, 12
 Aug 2020 18:52:49 +0200
Subject: [PATCH v2] connected: use buffered I/O to talk to rev-list
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <2e2907ac-3be9-c0ed-830a-f8aa28b471aa@web.de>
Message-ID: <2e3ac6f7-77c2-4792-d6df-891ede6318ce@web.de>
Date:   Wed, 12 Aug 2020 18:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2e2907ac-3be9-c0ed-830a-f8aa28b471aa@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+Hm0nNMcWr8bVA72mohXK2nXZ5yi+Hl6QK1qnRD1PK7YxpHRhrm
 sZr1sKoEuIHADOOqskL/FW1wBRcYutj77KBeC7mJXCJoXvhcu+hrSB6sLZYZ56dRFsnUwaS
 7xHUSRqrbuwZYiGUoNaYEVRdMVHRRMHU/6xbIX7Kc/RCUyCcbFSO40U1yaUlHvcCANo7VYF
 PENdGIQoVGgz2CeeX8lWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ITbUrC9iFA=:51YE9om8ICrEil6hilkiRg
 cqLc+O1QRo0LlKUHWMosDSrCtRPutKr4+z0wZfswK3QftyQu5+XEDVW8lMyb4yuXA7lvSHPPF
 9+fUR/h9c7nFrhH7tpiu8hlDQr63q7EHHOFE97/avNez3pi1Tcw/gMoxXsu9VR55SGcZJHafs
 zmQZBpg3IOHBD98ymulyM32r3bJE+xRqG22jvH++QDrQqP+qUgb3BSNGFaipfnqQmQb2L+RTN
 XPYJ2mgmyTyAxp3YyjictCkigJwruooV3YQwVPnIorBZlUH4TAUXBk4mfpH7b9sKSfZElmqty
 ElE9Q3EWNKtsLsxYq4yU8RiI+glrhI0Bc7qSMu4VcdzCBKIRpGJW7K1ttvaTGOP0G3R0szXSc
 e4AAq/qtnAbCi4wZVf1nvZnfqeHIpJb2R78L2kOECsLZYoIurLzcfB/U5e/l07HE3IPaA5E4c
 cuEhX3ps0Mf62mpibBmf2eLkLVO22Sv66w5ekvlZk9Vv24scFwp43cZUBl4iUsY74+2sSTHnG
 vfbtIeCqdqf8b+jd+iwH5SYb5WpRMn3yxjzLgjpcVYDOV3rDnj+s/UgAw/ZGklzyHNwxCYVvI
 hUIUhJWDgRnyrN3Zw3352J9IkUST048A/4oOoRrQkdJD/NWeknlkh0AkNnwDKsG5dXtCr7mOA
 0zhoZ5nbgty+MXUDM36Oo9VVwQcIR0z1UJHPDbbpGj95TfeIvwksXRIS4A1aZeemoeXace27o
 NuCQz/3oxuR3Ir+bexU/VgKnXQB8oh2kCHmrTGsz97uykcQQM/IPurgTRgHSENGR/rpqCWKVY
 ubvpuw0GCHHblMW8Xleot+Ktvnq80Gfcs8TeuHkjIxYjbKj33HcP+TvG/APZM1pyVnrppTwiM
 hNSWrIyTa3Ez/4eSApiGK/qKONswvjR++oK2M68ybMrHME6sEEfxlo9GLT2FDQq/Lkt5UAYMv
 RKZP7MbcsCgF6aeGMIvIvVrrV3q4tEH2pZ+WdxAjX7mUpL7f14HK3qNSKRreST3Wt3QDiZ5IB
 JG8ehd08jhUM6K0dtzFm7lcQ2GmfGhwfGIt/Bt0ewXMePNyUXX4d9fXeHTKo+KX5gvPAMqFh5
 0c7PnR6w4+suzxrQxXtaPGNYso3qP0NiP0IJYwxW1viGJ0z6Yv6dDjoBlE38wriYi/+wPY/AV
 jUyp2bxaJPd7jrHfvhfE2K1aUdPRakd0t6fKNfcLBz2mRszPQAlFYClXgMXPffVXiTtieWGK7
 ESgxYnhKPnlIw16Ib
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like f0bca72dc77 (send-pack: use buffered I/O to talk to pack-objects,
2016-06-08), significantly reduce the number of system calls and
simplify the code for sending object IDs to rev-list by using stdio's
buffering.

Take care to handle errors immediately to get the correct error code,
and to flush the buffer explicitly before closing the stream in order to
catch any write errors for these last bytes.

Helped-by: Chris Torek <chris.torek@gmail.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
=2D--
Changes since v1:
- Handle fprintf() errors immediately.
- Call ferror() and fflush() explicitly before calling fclose().
- Report write errors other than EPIPE and EINVAL, like the original
  code does.

 connected.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/connected.c b/connected.c
index 21c1ebe9fbf..b18299fdf0e 100644
=2D-- a/connected.c
+++ b/connected.c
@@ -22,14 +22,13 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		    struct check_connected_options *opt)
 {
 	struct child_process rev_list =3D CHILD_PROCESS_INIT;
+	FILE *rev_list_in;
 	struct check_connected_options defaults =3D CHECK_CONNECTED_INIT;
-	char commit[GIT_MAX_HEXSZ + 1];
 	struct object_id oid;
 	int err =3D 0;
 	struct packed_git *new_pack =3D NULL;
 	struct transport *transport;
 	size_t base_len;
-	const unsigned hexsz =3D the_hash_algo->hexsz;

 	if (!opt)
 		opt =3D &defaults;
@@ -122,7 +121,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,

 	sigchain_push(SIGPIPE, SIG_IGN);

-	commit[hexsz] =3D '\n';
+	rev_list_in =3D xfdopen(rev_list.in, "w");
+
 	do {
 		/*
 		 * If index-pack already checked that:
@@ -135,16 +135,17 @@ int check_connected(oid_iterate_fn fn, void *cb_data=
,
 		if (new_pack && find_pack_entry_one(oid.hash, new_pack))
 			continue;

-		memcpy(commit, oid_to_hex(&oid), hexsz);
-		if (write_in_full(rev_list.in, commit, hexsz + 1) < 0) {
-			if (errno !=3D EPIPE && errno !=3D EINVAL)
-				error_errno(_("failed write to rev-list"));
-			err =3D -1;
+		if (fprintf(rev_list_in, "%s\n", oid_to_hex(&oid)) < 0)
 			break;
-		}
 	} while (!fn(cb_data, &oid));

-	if (close(rev_list.in))
+	if (ferror(rev_list_in) || fflush(rev_list_in)) {
+		if (errno !=3D EPIPE && errno !=3D EINVAL)
+			error_errno(_("failed write to rev-list"));
+		err =3D -1;
+	}
+
+	if (fclose(rev_list_in))
 		err =3D error_errno(_("failed to close rev-list's stdin"));

 	sigchain_pop(SIGPIPE);
=2D-
2.28.0
