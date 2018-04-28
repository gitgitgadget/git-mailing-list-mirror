Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3E91F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeD1Wom (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:44:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:60051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752111AbeD1Wol (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:44:41 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lqhaw-1ei9lx1X8c-00eLJI; Sun, 29 Apr 2018 00:44:35 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v7 05/12] replace: prepare create_graft() for converting graft files wholesale
Date:   Sun, 29 Apr 2018 00:44:32 +0200
Message-Id: <d3d9b0888ba3123dedf7fabfe93f53a539dbecd4.1524955439.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
MIME-Version: 1.0
In-Reply-To: <cover.1524955439.git.johannes.schindelin@gmx.de>
References: <cover.1524865158.git.johannes.schindelin@gmx.de> <cover.1524955439.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:TecsIS6E1K0slWt7l+IqmduAnhfF5Dj+HfK0q+vTkpshOV+pcIZ
 mlxHTSq+GJn+/tQBAjOpso5n72GUn7vdALhJNU5TQPtfy9W7GPRQ0QWEV2ppZ3VYMWHDNng
 TaB78+psB8uid7rsYMXT6slvz0d0xr04f53IIOue+CzcfASZ54fRjEImivwMkyVnN3YT990
 c0LOWS27OEFnthQLuIrDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P2SII4pPxlA=:qTfchX8h0HDqgAgUwMsYfH
 VURAlr/EN7abeK/89ZAVtiniu3rLGiir4nDEqZ+lg6ZD2KAZ0Zpu0BH19ttxrOTWbKed1bTEz
 q1M3VrNH+wpTxSE8xcilBodTA22g/j3mfZ/gH/Io4a3CM5dfXsyVd6D+H809u+4ncFvwxteFe
 XxDH4RW7F/Kr8JL4s75Q51YguU+0VY/cZ6KMHL1fX9FiUiOuoNzDoBdfUZyU/Ma5UjS+bxodz
 0TsmZ48Nx8tOvU6FKBgP6xGcf6jMfIoH9i+0SbMX/l46vbFiUQaUwE5BP1wafUnCxWiwDK6zh
 NirhM9UkWZ9XiNg0TAjYkmYS0VgEygXH8PdqVVutq4/AYq6757JWOQnQ0SYkWaKd++5BWUCbB
 WSbD1RAb9M/t8gmDedekeieWDnDZmlJUmLNQ3JGdxyx5HFAhcZkkGTNyumSQZnuPlfDlu+PrA
 A+G8UwWh6nh/vfmZ4JA5FKlf97O7tiDykQA95tcQ/D9VnxfvSjXZuogHjYTYd45NDPPE+I/K1
 q4sEA5CnDvvwHYj8T5ixmCDCTFhyAhuarX3busMGIIutMKDgHzeJ068/KPTXx6nHB/WvgukK0
 JBgqj/SArekUtJNLSzvlxL+V3v4Bg2uBuoUyjYNzSSMsoQSDcg+O3bKTzXOtuKnytOXKmTdgK
 kNA2YmlNHrPBrMWXPWIJnsYaD5NuYSEppMtuZg/PpRejLew3etXBPtddzziTsaHhGuYGaS5JQ
 ba2kxcUPSC4dArmA2GiWBU/S83el2IE/fOxvxDokaP3R4DeeBEtgilwOq2z1i0jjBTROneeEL
 m2rxnFs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When converting all grafts in a graft file to replace refs, and one of
them happens to leave the original commit's parents unchanged, we do not
want to error out. Instead, we would like to issue a warning.

Prepare the create_graft() function for such a use case by adding a
`gentle` parameter. If set, we do not return an error when the replace ref
is unchanged, but a mere warning.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/replace.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index e57d3d187ed..64f58112701 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -428,7 +428,7 @@ static int check_mergetags(struct commit *commit, int argc, const char **argv)
 	return for_each_mergetag(check_one_mergetag, commit, &mergetag_data);
 }
 
-static int create_graft(int argc, const char **argv, int force)
+static int create_graft(int argc, const char **argv, int force, int gentle)
 {
 	struct object_id old_oid, new_oid;
 	const char *old_ref = argv[0];
@@ -470,8 +470,13 @@ static int create_graft(int argc, const char **argv, int force)
 
 	strbuf_release(&buf);
 
-	if (!oidcmp(&old_oid, &new_oid))
+	if (!oidcmp(&old_oid, &new_oid)) {
+		if (gentle) {
+			warning("graft for '%s' unnecessary", oid_to_hex(&old_oid));
+			return 0;
+		}
 		return error("new commit is the same as the old one: '%s'", oid_to_hex(&old_oid));
+	}
 
 	return replace_object_oid(old_ref, &old_oid, "replacement", &new_oid, force);
 }
@@ -547,7 +552,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		if (argc < 1)
 			usage_msg_opt("-g needs at least one argument",
 				      git_replace_usage, options);
-		return create_graft(argc, argv, force);
+		return create_graft(argc, argv, force, 0);
 
 	case MODE_LIST:
 		if (argc > 1)
-- 
2.17.0.windows.1.36.gdf4ca5fb72a


