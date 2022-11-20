Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6247C4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 10:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKTKEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 05:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKTKEB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 05:04:01 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F2C5B5BA
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 02:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668938616; bh=EcKmQ5veCg4m3iZn01IVc1Ay2wWY7PfxpGy0MQMckEo=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=oGx8JCXhpfngqWHj4tdRsuG0iORA82ZvaC0URRv26j8jR8atSvqNwhl3o+2KK0FUX
         PsXZyCGQeP8PxIoy99tYB5t19l+0zVkWvn4M0+lBbT9lE8iiYl8Snvq3v+XOSRcR84
         wqowv7fqkV5S+blSnva+WqS6VUv3p0B13qsf74jIWNgrfTDUCwHvTRP1nDmNgmp0yk
         5+audS9vNxN4/VBG3/lYyyPBBCqtmmaNe0no8tBcHQ1Sps/YdCOvFROzoNcOgpFYyP
         ExdQQBc40Qwr3wCcQSlPReGmZizVD8bRRYk2Bqo1Ryt7uFjKkhaPXcXhFay4FQ97gy
         iiLIYXnmE474Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxHUC-1p7Skq0Bi4-00xbEv; Sun, 20
 Nov 2022 11:03:36 +0100
Message-ID: <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
Date:   Sun, 20 Nov 2022 11:03:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v2 0/3] pack-objects: fix and simplify --filter handling
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
Content-Language: en-US
In-Reply-To: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iUr2044uBkWn4eiDljBG3PkCZ4W/FbmZQqwTEYUW1suGDXYnmTh
 q+3F6B17gKtj7IRNoN94WkQLyWnCilTClbzWntme0SS0KDXN3RLd5i6KHv/jdkaCHqtFfpp
 yb7L7yA8BfQjXRx+HyZW1kuvaBbxrpvxQQ/JZsuIAMYpicZSaHrJW01lqgYohXAxrESFTgM
 SObUUds1z0khqBBjdBiDQ==
UI-OutboundReport: notjunk:1;M01:P0:JKWWVpvWe0w=;GwKKiOXVUJNMCdS1ieuxFFKt+52
 W6cw93g1TS9tH7/hU1m3Pl/u4HwD8MbNHTPv1Ihzzn0xdCBbICXh6X15NJv98T48OtEYRoqYK
 lZwwA+2JtD9FebUB4pZwCt7nk4340Du4mni1iqbAeHDPI2mkpE8fIHg6N1r8sBL3r13hgOHlm
 BCtHLJQhm9tbhrL9PEyml0Qu7RWLN544vYW5ybWzE/Ia29y5t1NUpey1AfLtbBZ9bEO37q1bY
 T3HdIxV49apHel1YPAhU4OFSYRONaBNc6m908cKe7bRLcZM7m/FyDqsuJNTfzAMSAdkcOxNpw
 xLlATT6Y0OmryueYrBMak3WIBs/myb2wsPkB0IPN3utXE/0wIrc2epKh/gW8VkSCJKxj3M0vE
 yKyFUsJ6GzLvPWS4R0ThNBGjb0n6K2kJ/cGUZTKtGx7cCRjFlGs/IjHGF4/ZmmkhcbNmm/bjt
 0rwFVH1xoy/IZdniJzM5wqcbJmc+sn08PLxWJO+duPdVKEEE0RbIc/o4GI/xc1o5iHQE5rmzB
 CCLkyZF1uX7cPcZb5Zq31856vgT+28SuQ445/nzXUCN2NUDczgEgayP9XJNWnbnZckbJr2twV
 bI9sgjf/gwH2RSiJxWm/amtmxcPQpMO4kksqPh6WU+hFvv4dLzmZgsE1NXjQtof3jtmg1LfeJ
 4DzXWTgMIOQa1ImWSAFRYDxPw25YUsT47wy4DUQjJPs1SkkDffErfrIxjU8ssJMS18vUFvm5K
 Q5sUIbg+lInn4BDmEu7p6w1q8yZ6XLZiFGLvlrOR2htXPOSNarZCNHJ3Wv+nHXgdKulSIPgnQ
 TZftpTGNvPMdem37s9BRtLVS3d1FFDtUIufqsZKXP5e6RqAhZwH1C3DiaPU3f9Jgt3x4m/uBi
 1tSZnkol9Q15hz20/m/4q5c+Ifv5pVVd3Ws4MPnZg5PAxzEeRY8iB43EbwzrSypvPdfCLVXQO
 a6tyig==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression that prevents using multiple --filter options, simplify
the option parsing code and avoid relying on undefined behavior in it.

Patch 3 conflicts with cc/filtered-repack in seen, but not semantically.

Changes since v1:
- Added patch 1 to fix an issue with existing tests.
- Separate patch 2 for new tests.
- Test using blob size filters, only, which is a bit simpler.
- Test both combinations to also catch not just the current
  last-one-wins regression, but also a possible future first-one-wins
  issue.
- Actually revert 5cb28270a1 (pack-objects: lazily set up
  "struct rev_info", don't leak, 2022-03-28) instead of having a
  minimal fix and then adding some kind of middle ground by using a
  separate struct list_objects_filter_options.

  t5317: stop losing return codes of git ls-files
  t5317: demonstrate failure to handle multiple --filter options
  Revert "pack-objects: lazily set up "struct rev_info", don't leak"

 builtin/pack-objects.c                 | 31 ++-------
 list-objects-filter-options.c          |  4 --
 list-objects-filter-options.h          | 24 +------
 t/t5317-pack-objects-filter-objects.sh | 90 +++++++++++++++++++-------
 4 files changed, 75 insertions(+), 74 deletions(-)

Range-Diff gegen v1:
1:  2df1185b5f < -:  ---------- pack-objects: fix handling of multiple --f=
ilter options
2:  b8e951fb4f < -:  ---------- pack-object: simplify --filter handling
3:  1e4ae7d9f1 < -:  ---------- list-objects-filter: remove OPT_PARSE_LIST=
_OBJECTS_FILTER_INIT()
-:  ---------- > 1:  43af432f5c t5317: stop losing return codes of git ls-=
files
-:  ---------- > 2:  a77b85e71d t5317: demonstrate failure to handle multi=
ple --filter options
-:  ---------- > 3:  63ccb81357 Revert "pack-objects: lazily set up "struc=
t rev_info", don't leak"
=2D-
2.38.1
