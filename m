Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4691CC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B97A60EE7
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhIKUnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 16:43:41 -0400
Received: from mout.web.de ([212.227.15.3]:57737 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233608AbhIKUnk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 16:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631392941;
        bh=xJZnghI+6gjHEugvJNlOxXX5Xoz8chOUFnGa2sT0nRI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=iMArmhsKikIgAcAI04FJAx4f8FuVzKU89SQhGomo8ItjRqwxA/Wg4A1byy4aHWZye
         fq5GZIRjDnpWqKqTw09nakLl2bM1lqfUvWfTonjqw7CCVd/mwfl4pQk8j6TsFQndyc
         Dp7eTabltBNpCqVF5fGbv+vwocYN9t/SSXQ+ouSE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1N4vRY-1n6I5B2Cyy-010niP; Sat, 11 Sep 2021 22:42:21 +0200
Subject: [PATCH v2 4/5] packfile: convert has_packed_and_bad() to object_id
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Message-ID: <dcf75a98-8659-2df0-9d6d-4015aec81c6c@web.de>
Date:   Sat, 11 Sep 2021 22:42:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MmIye8tj4DCf0A33sYPf+aUdCQZ/tZXhZUuDnZgtDcCX30qwBqb
 OS3bVkgtA66hakPDOO/vSEpvsipg7pIEGRJS/3ZQYT79xUwYs11QdHKW69JZyy8EG04Q1aq
 q9tpoKx32Cf4E13S5Xv8rJ6npsCHlyaibGaRV5Ujzfor6g6sILUcMmRhwbdCJWyBxtOGrx+
 QEORu+nVTRyx3lVSw/iTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J9Fbrqh3iNU=:bKpMCs47JA1SjiTKmNReWl
 bYXU46J63D+zw0YH3Zg4ifPUpTzdOqNtuAFy9wLpfuV6KQhmqa+uLqjridFlHVcfY2Zcaa6LL
 lAxR0oR1BUdx/d+ioB86cZIaEWkkYG1bMcgE5KVErMDEPsEEShX4YwZmpTOAtNKaKIUx1Pg1+
 vju7ew7VR++oZRYFOQdZXERia5pBjL01IXGrSL077Q0fsDwMc0Uv24/0m4wCwV6zwDzcWigqm
 lEo14NFnpzYMpVOi2Ic8vmYczxb4Jqq+EK4Xf/1WZ2gMEj9Vb/64SRFhXB9KmNUcdR6tVMIYa
 Q3jqbbwrjwWaqO4vuzztqQwJgYqzf2c7UpqMuZGReFu9UOj8sJyB2/obzsKqkUQ8T6T3UGyd2
 bQTHWGWCHwsw4oU3sBPUU9XIoVd0qjFTQRBuNFyUlkIPiD/SY61EK1YHlqTaONPLfL5+i+Nk5
 1OUIEMa1htBmyaltsRtqwTxkOS+9BGh7RwZ0HCKRqfZP2JR96x82VgG+J+Yf74MlTNtA2oZKs
 ZAV4t3JJQOoBSEKqXT1R2wep8zBY3ZhsvVSQtnwSJMcaMqzT0ZM0Nf5jdbd2GHKQQJozEk5bv
 R57f3NsuXMngx5DfhLuEm/qPJNtwmdIUZKWDV88vfB1bpJZEmnMtXuhinwqMhLHQQqJCsaS7U
 dhA6qIdUbeSt3RIFgSbyhq1EEcBze7YHjVNBIJqfMqv4sY69S9GHYLk1XLZXy/dnbrYS65vw3
 iOfc6OBYuLwZKP3aDHgtsCRLhJR1iiP7k9JwVtH5eKfznerECmooxmp56uRRyyh5x/kBGcbXW
 LtSpTkG4vYYFbggA3gS06ROwm1LV/b6wUFGF0g6DPELcJeeq8s+xLuJmgPeuekH7lOVw/SQc8
 SWPKm59rMp05gFQmftoBrWLkkk7Il/SWSaFIsmHJwHeUDRRXWNAP9GjWRRGGhRm4cogRSHOQi
 XqcqmjB2TiJtDESioxZvRIkKr8PVPHktlJENVRxoV1UxUoYmcRnsxCZrfLjs+QxzQDTZu5qFs
 jBVUCaYN+a8eVrZsNCgAav9ogqlNZEyU8cRdZuavviLXGAVgsfDaCtCdQxLy/N85WKzc3SPTC
 OJNRJMviYQetjs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The single caller has a full object ID, so pass it on instead of just
its hash member.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 object-file.c | 2 +-
 packfile.c    | 4 ++--
 packfile.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index fb5a385a06..01e7058b4e 100644
=2D-- a/object-file.c
+++ b/object-file.c
@@ -1725,7 +1725,7 @@ void *read_object_file_extended(struct repository *r=
,
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), path);

-	if ((p =3D has_packed_and_bad(r, repl->hash)) !=3D NULL)
+	if ((p =3D has_packed_and_bad(r, repl)) !=3D NULL)
 		die(_("packed object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), p->pack_name);
 	obj_read_unlock();
diff --git a/packfile.c b/packfile.c
index fb15fc5b49..04080a558b 100644
=2D-- a/packfile.c
+++ b/packfile.c
@@ -1176,14 +1176,14 @@ void mark_bad_packed_object(struct packed_git *p, =
const struct object_id *oid)
 }

 const struct packed_git *has_packed_and_bad(struct repository *r,
-					    const unsigned char *sha1)
+					    const struct object_id *oid)
 {
 	struct packed_git *p;
 	unsigned i;

 	for (p =3D r->objects->packed_git; p; p =3D p->next)
 		for (i =3D 0; i < p->num_bad_objects; i++)
-			if (hasheq(sha1,
+			if (hasheq(oid->hash,
 				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
 				return p;
 	return NULL;
diff --git a/packfile.h b/packfile.h
index a982ed9994..186146779d 100644
=2D-- a/packfile.h
+++ b/packfile.h
@@ -160,7 +160,7 @@ int packed_object_info(struct repository *r,
 		       off_t offset, struct object_info *);

 void mark_bad_packed_object(struct packed_git *, const struct object_id *=
);
-const struct packed_git *has_packed_and_bad(struct repository *r, const u=
nsigned char *sha1);
+const struct packed_git *has_packed_and_bad(struct repository *, const st=
ruct object_id *);

 #define ON_DISK_KEEP_PACKS 1
 #define IN_CORE_KEEP_PACKS 2
=2D-
2.33.0
