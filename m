Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E2471FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 16:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbdFMQRl (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 12:17:41 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:36930
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752781AbdFMQRk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Jun 2017 12:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1497370658;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=R3gwSP8HLAEleZxLHaGr498RF2uUUYzM1GS+K4ydVIY=;
        b=Wrd1eqWTYEOFxxgmrIKH52NbSFINrH4fW+YCUuil4lXhg1WFunbZhIWqhG8ANksS
        Z9IBJeBSQ7E/SWxay5zR9Fuuhub2sv5uYl+Q7Kbn1f7S7R7xvoYBfkdFpgJzf/yIVE3
        77DJAQzYKQeuXLLKESWkiDTXc9IL4yMM/mKKv61E=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015c79fcbda0-2779b4ff-54ad-46f4-bef0-14eeb58338d4-000000@eu-west-1.amazonses.com>
References: <0102015c79fcbda0-2779b4ff-54ad-46f4-bef0-14eeb58338d4-000000@eu-west-1.amazonses.com>
Subject: [PATCH 1/3] config: create a function to format section headers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 13 Jun 2017 16:17:38 +0000
X-SES-Outgoing: 2017.06.13-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the logic which creates section headers in the config file,
e.g. the 'branch.foo' key will be turned into '[branch "foo"]'.

This introduces no function changes, but is needed for a later change
which adds support for copying branch sections in the config file.

Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 config.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 146cb3452adab..d5bb69e925dac 100644
--- a/config.c
+++ b/config.c
@@ -2169,10 +2169,10 @@ static int write_error(const char *filename)
 =09return 4;
 }
=20
-static int store_write_section(int fd, const char *key)
+struct strbuf store_create_section(const char *key)
 {
 =09const char *dot;
-=09int i, success;
+=09int i;
 =09struct strbuf sb =3D STRBUF_INIT;
=20
 =09dot =3D memchr(key, '.', store.baselen);
@@ -2188,6 +2188,15 @@ static int store_write_section(int fd, const char *k=
ey)
 =09=09strbuf_addf(&sb, "[%.*s]\n", store.baselen, key);
 =09}
=20
+=09return sb;
+}
+
+static int store_write_section(int fd, const char *key)
+{
+=09int success;
+
+=09struct strbuf sb =3D store_create_section(key);
+
 =09success =3D write_in_full(fd, sb.buf, sb.len) =3D=3D sb.len;
 =09strbuf_release(&sb);
=20

--
https://github.com/git/git/pull/363
