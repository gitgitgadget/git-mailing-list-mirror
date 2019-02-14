Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34DF71F453
	for <e@80x24.org>; Thu, 14 Feb 2019 06:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393146AbfBNGfS (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 01:35:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50650 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfBNGfR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 01:35:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76282145EC4;
        Thu, 14 Feb 2019 01:35:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=DsrN8njTPZeGn5ODrPzWSb7k+Yc=; b=Pm/TULU9eApDQmlWbaUc
        zuBSlKyGTH4kF77MqPrhbVkDSbqvoVJnfgXM8AXw2+VfIxxT5pTUe1wxXUAvvIBU
        oDnVufdagOV2NNlvpkQKzNjplOu47MYiKfMu/ZLYU1V53rIVO/NMoNd+K8t95j3k
        E3F0DR1GKlGBj5Cv/xRZWAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         q=dns; s=sasl; b=RZzWt1TfdF8zXEHlVReBfFuoQQ8L1UAKUCEvKrZPq1jcXs
        oZjyFNKijF++8dsm2F1Zf55iSXzSwsLFm+WCV93kcaqQuO73T59rgxCGK4VSbmxl
        rUkMQReT2xl7Yt63BrFosYn6l9txx9Z9HqlYRCsTpTtPl+GrtPzP8pwyuKwLk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D0C1145EC3;
        Thu, 14 Feb 2019 01:35:15 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BABBE145EC2;
        Thu, 14 Feb 2019 01:35:14 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH] t/lib-httpd: pass GIT_TEST_SIDEBAND_ALL through Apache
Date:   Thu, 14 Feb 2019 01:35:13 -0500
Message-Id: <20190214063513.32041-1-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0.rc1
MIME-Version: 1.0
X-Pobox-Relay-ID: AFE52490-3022-11E9-8DD0-F733E42159A7-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

07c3c2aa16 ("tests: define GIT_TEST_SIDEBAND_ALL", 2019-01-16) added
GIT_TEST_SIDEBAND_ALL to the apache.conf PassEnv list.  Avoid warnings
from Apache when the variable is unset, as we do for GIT_VALGRIND* and
GIT_TRACE, from f628825481 ("t/lib-httpd: handle running under
--valgrind", 2012-07-24) and 89c57ab3f0 ("t: pass GIT_TRACE through
Apache", 2015-03-13), respectively.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
I missed this with rc0, but poking through build logs I noticed a number
of 'AH01506: PassEnv variable GIT_TEST_SIDEBAND_ALL was undefined'
warnings.

I think exporting this in lib-httpd.sh like we do for GIT_VALGRIND* and
GIT_TRACE is the way to go, as opposed to in test-lib.sh, as we do for
things like GNUPGHOME.  But I could easily be wrong about that.

 t/lib-httpd.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 216281eabc..0dfb48c2f6 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -91,6 +91,7 @@ HTTPD_DOCUMENT_ROOT_PATH=3D$HTTPD_ROOT_PATH/www
 # hack to suppress apache PassEnv warnings
 GIT_VALGRIND=3D$GIT_VALGRIND; export GIT_VALGRIND
 GIT_VALGRIND_OPTIONS=3D$GIT_VALGRIND_OPTIONS; export GIT_VALGRIND_OPTION=
S
+GIT_TEST_SIDEBAND_ALL=3D$GIT_TEST_SIDEBAND_ALL; export GIT_TEST_SIDEBAND=
_ALL
 GIT_TRACE=3D$GIT_TRACE; export GIT_TRACE
=20
 if ! test -x "$LIB_HTTPD_PATH"
--=20
2.21.0.rc1

