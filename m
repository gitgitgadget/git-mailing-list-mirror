Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD14C433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 14:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD68320738
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 14:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Nj1z+p9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgHBOin (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:38:43 -0400
Received: from mout.web.de ([212.227.15.4]:44715 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgHBOin (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 10:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596379120;
        bh=En6MY+fOFcQvkgmQrSYVvy0mPlZYrFgeAjBrexRKuJs=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Nj1z+p9l9LD0K5aTv7BujSEgNQXYHUGbJwz9q/ewCvMIEfKRT1j8aUNcbt/IkBAsv
         nljlPuLHE+Mv9MjeGFA68ycShPNiTgAI+9Qkzx7Wktn0r3WxvHS1xx1BjFYWMbcFLF
         jX2unTYrGlLr1CWmp24hL7LpDe/Xjyvilb5Qrlj4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrHMi-1kl9e02Cz6-0138lM; Sun, 02
 Aug 2020 16:38:40 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] midx: use buffered I/O to talk to pack-objects
Message-ID: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
Date:   Sun, 2 Aug 2020 16:38:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:egOlXChcTtC5hW5JTS6v4BzcG0ykr1AFjYiqbEfdavx2LJ2uCG+
 EdHV+FjKdXtEUN8dFQrJwFwGpKMKytND7SG6i29wjKdqEDBNqIdNlkI+/sti6WDrZK7WFrA
 WKCkIwClKWv96vl+EqEV6cVM/e01sik5jTAC8Jnn37QEHG4xbxya9znwI1YvRHn0uDffk6L
 jelez6erJ+ocoOpvrQAjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AS//6xAQSEI=:wBk90piKe8Dkz8d1uvTVUU
 fl+Xs5s4HBQwCxgBYMMsxWtfoYce8+VmTUYKWvT+jEzBaqVjgro9edCDTJCZ/LbYYx5rbDjgK
 ziibro7Do2T/9ZgRjmyM+3XFZZyIMQMUMLR8SIgWBwQIa3tQhdGKCqFy3KDTU0f2zFxkgpaef
 4qOO4xyxUwUSh6T4T5ZJT4FvcMTEI8817d9ky1PL2ac5k3B8jzKeYSVm6y8uOl61naGL8JRaU
 Lf2dCFCpypGc4b7HSjoA40mf6aDzF4U2/OqfPCnxq0CTFuLKZkKJ8PdlaOs9qMOHIAz5lxeJb
 iB52Vu8L683qMt+83TjzRvKa6/uRyZvSfNGeWaja6XXafEzHF5Qm8QwAEEa5BojW1FuyWG1HM
 T1+c9/PqY4RhLQWmQ0Oiny/WZOYY2ReLvEKN7KLMdhxSi9fwZkGSBVlnKRWB1aqfygnmEdhXo
 YQ97qnzo8VPlv6c6/9VZ/JHhUxINsyp0rH/nQlbVI3fp/RhEkqTqQJCxdjVmxA/6nj4Lbf2E2
 yTn0MsBUfGorP2Xa59qxdaensOKtNb69tR/CgOGjarm2oRPj2ScNu1WDpBbBB+OmC6bqXS1r1
 uuTo/dtNYUuBvizIeQ88zW/8g/+1XA2FQNlbyq/Bm4HkqmE0CNyluP+erW6FIH+USI7wdG8BO
 WmO5k4jQUC+RdMpmltBJDXE3/IGLYWwL29btYHTJBJxaLq4MQSHsRL9mui3dXi+h1wIbOVUYl
 /tP7zpX2EtuYvfl8ovwgqk9rZ2KImGBkeCLhYpEWUdMxro3ofGKIdOEleKpBiUY4FWPxZShK2
 pxQCUtjYxPN8ljJmNi+1L9LWAYVLFZj6SiJVsjINh6rdLpsBvQ6nd1ey+JRebbTrL3QjD14x9
 6FtxN9+cJs5yb9h6yLifUiALCEfI7Rb2zIJui16equC5crmZ2puspC6eG3oLNgXho5QcDNT2A
 86puOij3ywFFqL6u3DnsMQHJUNB+aInMN/Wwa9NDiQqYG6okTDTCS1ahhSdP9EziqWbjypjN+
 6qtWaoPM0FoMydpmAdhZwhpY+lQ9fWuh/QMd7Lch1AXPfzQNFxtBwwdVHgsgqKX0F8B2aO0xm
 8PmSq2ESz3guN3tdi2PQf2HDDgSDs042cLIKu21LSYExh2f8+prsAvMR2bLEEO8hAq3FbNb0T
 f+nK13DPzsSxF732jWih9jiTyn6gAupA9yizVcHjxTbfZpNjaUEYBWboQMOPqt9RSVnEewzGj
 4xNK4098hHsmBimt2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like f0bca72dc77 (send-pack: use buffered I/O to talk to pack-objects,
2016-06-08), significantly reduce the number of system calls and
simplify the code for sending object IDs to pack-objects by using
stdio's buffering and handling errors after the loop.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 midx.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 6d1584ca51d..742638c3e51 100644
=2D-- a/midx.c
+++ b/midx.c
@@ -1383,6 +1383,7 @@ int midx_repack(struct repository *r, const char *ob=
ject_dir, size_t batch_size,
 	uint32_t i;
 	unsigned char *include_pack;
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	FILE *cmd_in;
 	struct strbuf base_name =3D STRBUF_INIT;
 	struct multi_pack_index *m =3D load_multi_pack_index(object_dir, 1);

@@ -1435,6 +1436,8 @@ int midx_repack(struct repository *r, const char *ob=
ject_dir, size_t batch_size,
 		goto cleanup;
 	}

+	cmd_in =3D xfdopen(cmd.in, "w");
+
 	for (i =3D 0; i < m->num_objects; i++) {
 		struct object_id oid;
 		uint32_t pack_int_id =3D nth_midxed_pack_int_id(m, i);
@@ -1443,10 +1446,15 @@ int midx_repack(struct repository *r, const char *=
object_dir, size_t batch_size,
 			continue;

 		nth_midxed_object_oid(&oid, m, i);
-		xwrite(cmd.in, oid_to_hex(&oid), the_hash_algo->hexsz);
-		xwrite(cmd.in, "\n", 1);
+		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
+	}
+
+	if (fclose(cmd_in)) {
+		error_errno(_("could not close stdin of pack-objects"));
+		result =3D 1;
+		finish_command(&cmd);
+		goto cleanup;
 	}
-	close(cmd.in);

 	if (finish_command(&cmd)) {
 		error(_("could not finish pack-objects"));
=2D-
2.28.0
