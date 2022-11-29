Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130FCC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 12:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiK2MYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiK2MYK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 07:24:10 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB804666A
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669724634; bh=wQ9dT1YL3b+Y9bak8T+zeTQfONMXSU77JnQAOu/sN4o=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=MvN1wg8Zd5LfC/9psD1TpRuhBQAEbAMeZ9BT1JLUL5Gdv2a1wqBtrLIKCRydxa7PY
         w1tipIdjE0uXXWNcCPejJ+ygyhrOYyL73x0Cb59iuMkaDYReLwn/2FghXc7uYwrWYR
         aUMHaIZ+t70AyEIKm2Bv7Eo6SvteopYSqsKN+x/LnJwGoYrGMfebQ3w9HvAQD9DZTZ
         ljYHh7+SO0LLdu3ToXgBA/AZ7a8+P9y/LkhgmqQeEwiq5KtSjilI++gcNxAhBCoMSr
         i9s7/KqehxDc8FvRh4sr8wGDa3Px2yj5OyeuDO431lYwgxe/QSoAEPIO4AlLQ5Ii4H
         X2o+rDw7uG6Zg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8n46-1oun8u1IqU-015taZ; Tue, 29
 Nov 2022 13:23:54 +0100
Message-ID: <6c7ef5fb-59b5-df16-036d-9a9a3d987cb0@web.de>
Date:   Tue, 29 Nov 2022 13:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v3 3/5] pack-objects: fix handling of multiple --filter
 options
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
X-Provags-ID: V03:K1:cCUR3x/pZ8IJzOPFS7ZJLtmVjor6E73KXhU0tb1sWDv4PhzBsdy
 NaezjAhlJBXJO2MSAdnNG1wtFqAdQ4nREs6fT1anUc3ZXAw0CWuDW1Ok72iqObVmN2zro9d
 uPxAb/ZhE69d+6gAit3FNRPRqi5JjHyQq4lwQsupBnBdMevuVYOGaASGMvvBcv6b6a/yvSG
 mU3saaYESJBmNRws04+XA==
UI-OutboundReport: notjunk:1;M01:P0:4Etc4mtMTS0=;8EMjzz2gITaIZCIK7p3EA5xK8RM
 Gl4FFrPxwo6lfnNHKcymTJKcevckE3+LrT+nYOT1h6SH0QmUsLSBr7MRPceplI8qlGJDXLR+V
 o6bL23tjjkki6PchJpZJCtdq4iSfVWs30qW92uDIuXwgIxiqOW7iMjsLKFBtMJGRZQOGJgSQk
 awElhK8dvgAKJbvnVB85o9zxMiiqM3LvdMA+Cjyvc3BabDxcLw/S8YNWv5D1JP+cdz5BuvMkZ
 QoRbWCzF/UDWfleVhAmM7bKpJ94lq5ZR/rGIuyCoWrz6AevfupBKQIJHMXVAmNkqP/XZuwCws
 WtaP0xBeeU9X/TLi0acKCVLphusHH6WLEgZFbcG4dVnILEXGRa/Yw29PFjvIwdkaoMw/jTVVC
 Je9J/kWQBC2dH9TYZiN0HqeAYKvTnPuP5/S5waiSgGYh3/Jt0t+0+SDmemdPXHI2hnAH4KDPh
 c3/cjL0JBx/Y96vlY+yvSKOL4p0wiwbPMU2ZxYbjFuFUwjI5XrFVPSHseYWPtolFOq6TOmcyy
 7niui0ZEfhWeG7Sv2TQq6Zz0RAazKCRZPo0gLiOplXC5jlOVkxIXwk9wni4VYaFtPhdujLgr3
 ywJPD0WZLJUOYxxmiLUf+wQx49LSeAW/pTgRaOFMlmhRn5qOI79kRMsKg0dl+RpnGKH5fEhYd
 QR8Si+jFMf9pdzRrWnuxyPnpVdFUsw1XUIihzwjIyTo/TxDxeXR6bwXBH7KcIB8Z6lfu1t4EV
 L9iBHnvRIRCg559fkO3CPyLuSg/CQnsIwEt00HmsONV2ug7OWb9K5oIFAzf0HHAR0/C3fk5iA
 G7Yn8F8bV/4MlFSkO8cqkSYqIjSaE+xcZfiqzrLsl33xEhIPmUONiWJ3DMrmUUW3XtEb5raDo
 lEPYdDMZbsGRZGZeJm4UvtjFH7xCVy0XmhJWUy8Q5aqwrXQMw4CKyryenqf0pS35ZcdSj+wmo
 sEEJjpytgHhqr8HVU74DtHKr4Uk=
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
 builtin/pack-objects.c                 | 3 ++-
 t/t5317-pack-objects-filter-objects.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

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
index 25faebaada..5b707d911b 100755
=2D-- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -265,7 +265,7 @@ test_expect_success 'verify normal and blob:limit pack=
files have same commits/tr
 	test_cmp expected observed
 '

-test_expect_failure 'verify small limit and big limit results in small li=
mit' '
+test_expect_success 'verify small limit and big limit results in small li=
mit' '
 	git -C r2 ls-files -s large.1000 >ls_files_result &&
 	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&
=2D-
2.38.1
