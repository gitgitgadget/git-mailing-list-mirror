Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6662BC3524D
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3937621741
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="LCDVB679"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBDVXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:23:33 -0500
Received: from mout.web.de ([212.227.15.3]:34363 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgBDVXd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580851410;
        bh=ISlDNV6/USXUyAwE8XS3v+S1ixiS0mw7BGPxS8KsPh0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=LCDVB679ZRJIE/ZYWhWl5G7HZpPSITG2wakpguAdzzx1k7hfmvc3vo35x9aU+QCjS
         Qf1hYLfDgN+Teo4qcixljMgiAZcOwr0DoBSS2AQ0k5Kqu4iKTZxSLy9ebjR5zivqxu
         HLV85n8UTXvU33EbBepIPzF0PQl9irnJEpb2i6VA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZleQ-1jG5M40ECk-00LSvy; Tue, 04
 Feb 2020 22:23:30 +0100
Subject: [PATCH 07/10] name-rev: factor out get_parent_name()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Message-ID: <1d7f3936-20e0-2452-15bc-2b58c71c57ed@web.de>
Date:   Tue, 4 Feb 2020 22:23:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FB1sTi6rQ2M6M3k7dlZbB33CvjKAbtrKo7BGz/btGmOZHmmJubO
 zIvLrocN4m4pmI+Piqm+oLw+4kENioX4ZEQuSyt7nJyod8E+7BL9+v3I/Wfyt1XHwca3jm0
 4H2tP5nSYCI6HzSOwrI3LFhOFxIlP1mJIM/r4dZA7zptta5dyxzPL4Cj7jY31hr5Q2a/Sp/
 hcRVKgue3t5vI0UGqDLvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QB1X+Mex878=:TsdPyJ35MbD0lfW2mFl9N7
 PJAN5Kg2EspxjiU9kIk/wMhnDt2xBDbsBv6YSJmUOUYFqFZIFPQPYnqki4N84qg4Fy4uCimgz
 9GZ8kokYsDGQfEy/M+nhGVW4LvRgAnCgVl8T+1n/VjOWo05r7WtSoNapUqx6gw4V3v6XbBu5j
 XiS29sek7Nlb62+NHqPQR1m9K31gLPgtwo8Sui/sKUhWXMno7GOUOBDNAvkt1EoiV2qW+32S8
 PNVrBpCQOXsLoKthN62Vuq0fVEkzYXUM6W7gc3SaQX3Tgpv/Ym4Dzht4SgcPlTZ5rSxxZzVhu
 w6l9DhNtEhGcvDC26bfikK7kBk6ABf6tctR2DsB0053Mv4A5OicjzGY2gHZ1nUEfHG+x5ZCmt
 P00T18ZAc4tOaXcZjcNhWya22tvC2CFxzK0sNRFj+acnvmHG5Pn3UstLFAfcLWyDeBhDuB1nK
 EF/n++TTA44qiNYsfVhHiO1I4TlkrYHOn3NCw0ZokAxiG7d8pUcahWYNfdmLAOn0vyoh2xLyi
 xPqbSmDbc26CNB+9Ony70RDHFBPyKV2qRFlp+DIRmceGordPTmM1QepS4r7pgNQ5rR5TWHQcC
 vI/BZLRfa7xrjhvT7dmXB3aQ0YA03kfaT0F1zY9LSGThsyr43umDPF2ac1hgyIpMnlT4GDH0I
 CD0eWMReEyvH/MTRtfxuAy1cAx3rziN16vsBu5EkErcT3Bsloeuqi+L1HN/5YkU9oB+h/aWim
 XxZ8mWd6hNB8iwIwfafcusS5m0D0nhUVHBc14l/sx+U8y60NciIMp5naRLhfui1rI8xZmB/Ww
 mdzwl4Ybz5gByqVnNdkHiuSsDar2dcuaT6lOyCyO93cMPYyTaVA/jZWJir+HlcYK0oOIqXNVE
 b+zh153m2HjcC7+EF1wqtZZC3rt4ge50AgvJFblbjallBkrIeRY2H785k5HR6RXUaipWb6Y5O
 O9FIfWt4N8a9Y5FHJfKgovcVKPQuyhEoaBRCafcOqqEm5EP0XhczM4dpYHj7NCwhwZlXVFMMD
 ohj8KvIac6A7buxWxPzPMig2dRpKmIOCHb7zKUhp24flgwujpDcG6V2xPd6mtENyFTqcIb3Ff
 qZ91Zf17qWVpb5oybIok5iUl6o7AEmXRFavC1T+FTfOFfR2oyErLQ4+ws+d9KShrtdD3K9Uz6
 xyvCrZ+wptXIi9gW7RBkjdROG03YFihw/BrQqxUfDm1jw6fsED+zbTMSDiCl9qoEf1tLvNmbk
 YFkhq8a2fhn6tl7+y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce nesting by moving code to come up with a name for the parent into
its own function.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 14381a3c64..6701fb1569 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -101,6 +101,19 @@ static struct rev_name *create_or_update_name(struct =
commit *commit,
 	return name;
 }

+static char *get_parent_name(const struct rev_name *name, int parent_numb=
er)
+{
+	size_t len;
+
+	strip_suffix(name->tip_name, "^0", &len);
+	if (name->generation > 0)
+		return xstrfmt("%.*s~%d^%d", (int)len, name->tip_name,
+			       name->generation, parent_number);
+	else
+		return xstrfmt("%.*s^%d", (int)len, name->tip_name,
+			       parent_number);
+}
+
 static void name_rev(struct commit *start_commit,
 		const char *tip_name, timestamp_t taggerdate,
 		int from_tag, int deref)
@@ -148,19 +161,7 @@ static void name_rev(struct commit *start_commit,
 				continue;

 			if (parent_number > 1) {
-				size_t len;
-
-				strip_suffix(name->tip_name, "^0", &len);
-				if (name->generation > 0)
-					new_name =3D xstrfmt("%.*s~%d^%d",
-							   (int)len,
-							   name->tip_name,
-							   name->generation,
-							   parent_number);
-				else
-					new_name =3D xstrfmt("%.*s^%d", (int)len,
-							   name->tip_name,
-							   parent_number);
+				new_name =3D get_parent_name(name, parent_number);
 				generation =3D 0;
 				distance =3D name->distance + MERGE_TRAVERSAL_WEIGHT;
 			} else {
=2D-
2.25.0
