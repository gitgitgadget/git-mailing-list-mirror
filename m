Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F93C4332F
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 10:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiKLKoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 05:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKLKoI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 05:44:08 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E076715704
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 02:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668249841; bh=sLrMbdMbyE6TeYtx2P7MCpJsx891+F0QAC69/P35mKc=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=mQS5Jit+gBsVIOI3quSGAWHyqL1B/5i6i0eoByA+6QZagnNPoFmx+PW0JPK8WN5tG
         RQF0pg6Wd06qYpBw5SsNctzfumO0UuRkmqHI1DXYSR7991VbHpIcb1Lh8Dm3akH9OB
         UTeT6i/I40/aSWM/zyPEQYoMnYdbAImMazWk/35WyWhbVms/8bir9C1aut+h5pAQgR
         Bd8EwEr+lqfPEI1egw1PwIyFw5hUdfkGOALOXQ+vNOl8Kx8LwhgODUGcacbKS5XikX
         WR0ivhkW9R/L1ZYCUwjF8uEdI/8QY0LEpBxWXB9fOgt3ee+nREhy9ashIaI1tjnfAY
         oqLu5svR/H2xw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.27.139]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwA1O-1pANPB0SYO-00rzOd; Sat, 12
 Nov 2022 11:44:01 +0100
Message-ID: <53bffbf4-8308-0dd7-bca5-7c85b8334e05@web.de>
Date:   Sat, 12 Nov 2022 11:44:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: [PATCH 1/3] pack-objects: fix handling of multiple --filter options
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
X-Provags-ID: V03:K1:n8dK94eNxxmwtzrZpWXpWYQmWR6rMNrPdqsL/RrIdjUpsB+Q7NH
 AatixomiWNNqq3+uyGZ7pVRwpS7Um1RTnz/PGk5Pg3es0t8ScS3TfZi5rdvF9oG6Ms6T0XI
 JepxfkhzQ7O8tTV2KlYq8yQ7PwpEVZ1EIsIExjyKPa7UDr+dUaVAtnfFW/ArhQkRC2BCC6q
 RJfa+LhSdjEsnb7+OQGDQ==
UI-OutboundReport: notjunk:1;M01:P0:gODc8CB4KdM=;ueHqc8VD3AuL71tIMsTmEdCmlPR
 qVJFmC+CMG/bWaf3D+2pvJAxC23dxDqCnlUjsOYfoydUPwzAkoU6p3LLj5x/Mx4jEUn/5W7vZ
 fjzMFClCBom+R3XzPCPl+7tUjtZgWumMue6dAuFNmQjyCmCYM/NJsjifoXoFN3I3YIX7tBJO5
 zKohRnN8iVepwtGYgaxiK4av3XGfj3M1fvaeXzA6EAz4jPg7BPgGakxdakltmmYLurOyzKy2O
 JP51mJ6NSun+25Yg0Ves5GuimBDQzsxK/iiAl9tnFllwuDAqdE1BosetQvIJTdrbJNElW2YtA
 q10P+ukkZBmfxC42cDTdHO5QN0pWUDsu409fNPs4UoylWFIgY4bsgw2xJImPpQa8sYiUFgvXP
 pr6G6c5JlaPoOoTmhxKWp+MEVpDYrEFkI5mREAdeXxaTpzE5vtTWXUITU4OsSo2UfLgKAkuX4
 LvgSPzCLQ+Ti5tzc5z+oPYQ7xBwETXK3bASJY9BUtGA3FEDivE5rJ31obROTcTymnK0ep4m7/
 qfgW/4ep3+go7ylyhX/S/1AqzNVwALob+6o5vsc23Frtu4fn1AeAA3nHwhCUNkzrw73KnGojL
 wiFMBRrzMg63O9WRLx03kk94G2DHDMCMqMjV6wya1Rgn0fYrCX+diIl9cIl2HUOiZcadvAfYr
 gb1mi721+Miqls54Ds7xgVfPo2lgn0xaxIS3bUxpLX3JBS1YqRPFyjo8Tm6+gK6n5xSeNp78a
 C4fcKdNF2OfO4s7h5MyaMUa5b1WEkv3vgoVLhRPtcmn/PsLdO57dDokntcpXl9RpqJz/1QPCo
 aNdPMWNZJzx3HmM9bc91CGQBTWtraxLE4EdQ33xDklCeVz7MgJJiQunuiFEW/cv/aFz4Nhn6K
 bRfHoh1viPZGTpu4Pf59sKq24O8gG7pQDDo969fav5dYtrC/JbeBZDK8aar2n7ozRJmfNEuaI
 dp6Ytg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't
leak, 2022-03-28) --filter options given to git pack-objects overrule
earlier ones, letting only the leftmost win and leaking the memory
allocated for earlier ones.  Fix that by only initializing the rev_info
struct once.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/pack-objects.c                 |  3 ++-
 t/t5317-pack-objects-filter-objects.sh | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 573d0b20b7..c702c09dd4 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4158,7 +4158,8 @@ static struct list_objects_filter_options *po_filter=
_revs_init(void *value)
 {
 	struct po_filter_data *data =3D value;

-	repo_init_revisions(the_repository, &data->revs, NULL);
+	if (!data->have_revs)
+		repo_init_revisions(the_repository, &data->revs, NULL);
 	data->have_revs =3D 1;

 	return &data->revs.filter;
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects=
-filter-objects.sh
index bb633c9b09..bd8983bb56 100755
=2D-- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -178,6 +178,25 @@ test_expect_success 'verify blob:limit=3D1001' '
 	test_cmp expected observed
 '

+test_expect_success 'verify blob:limit=3D1001+object:type=3Dblob' '
+	git -C r2 ls-files -s large.1000 |
+	test_parse_ls_files_stage_oids |
+	sort >expected &&
+
+	git -C r2 pack-objects --revs --stdout --filter=3Dblob:limit=3D1001 \
+		--filter=3Dobject:type=3Dblob >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r2 index-pack ../filter.pack &&
+
+	git -C r2 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
+	parse_verify_pack_blob_oid |
+	sort >observed &&
+
+	test_cmp expected observed
+'
+
 test_expect_success 'verify blob:limit=3D10001' '
 	git -C r2 ls-files -s large.1000 large.10000 |
 	test_parse_ls_files_stage_oids |
=2D-
2.38.1
