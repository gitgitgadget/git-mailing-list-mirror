Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA6B11F45A
	for <e@80x24.org>; Sun, 11 Aug 2019 17:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfHKRsL (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 13:48:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57444 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbfHKRsL (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Aug 2019 13:48:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e9dc:6bd6:18c8:c98f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 18F0B6047B;
        Sun, 11 Aug 2019 17:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565545686;
        bh=IcI18ZapiLuzp3MKGeCIXQ5bMNZ7nMMu/3Aokc8G//Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cnx5+XQif7KAsHEZ03IK4k2h63dCLVEri8yxdpTdjiMGo5p8b8H3ALdrBiTARyz36
         AC1Ubgpd8vJ1HVpRgB8kxlx10eXYvAnqIVONV7nIJYRokxkTGBzxgnoceeyNQvIX23
         IYD2v5vaq3Tx46Ro8TJdwAhxk/QFGufm3SAJ58YEZXxG/AwsxI92aiF3xsJUvO+pl8
         C9r5jpVZv7nyqOdRQs5EVuWHLmhfgML81kUaNE/QK5CXXl4uUMdaPsfFCx/VmdikUz
         NARQsV3nTltQ48mbWxYaGc4nZKJXYSF/WDi+wOZzZLcRm0sloI/hykOG7ZAbDHwoPD
         +S0REXP+YSJBWYj88pUubYStLE5kPah+csCl3kMw2Fe7lwTv1vmgwimvj75dfXP29L
         BKhLUegObGwvNyNUqqMDtKA57n6SL8W66C0UA/P0j+Jyppl7Gq2ckWMj0XMLFG6/DU
         eS/qxCXeqRWdF6fG/lct24YJXcQSX6jssWE3/AIrB0P5zPJVjDx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] Honor .gitattributes with rebase --am
Date:   Sun, 11 Aug 2019 17:47:46 +0000
Message-Id: <20190811174748.33552-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190809100217.427178-1-sandals@crustytoothpaste.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes rebase --am honor the .gitattributes file for
subsequent patches when a patch changes it.

Changes from v1:
* Add has_path_suffix in a separate commit.

brian m. carlson (2):
  path: add a function to check for path suffix
  apply: reload .gitattributes after patching it

 apply.c           |  7 +++++++
 convert.c         |  9 ++++++++-
 convert.h         |  6 ++++++
 path.c            | 39 ++++++++++++++++++++++++++++++---------
 path.h            |  3 +++
 t/t3400-rebase.sh | 23 +++++++++++++++++++++++
 6 files changed, 77 insertions(+), 10 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  e865872fc3 :rebase-gitattributes
-:  ---------- > 2:  125fda966c path: add a function to check for path suffix
1:  d7ea19aeef ! 3:  f54af7e595 apply: reload .gitattributes after patching it
    @@ apply.c: static int apply_patch(struct apply_state *state,
      			*listp = patch;
      			listp = &patch->next;
     +
    -+			if (!flush_attributes && patch->new_name) {
    -+				char *dummy = strip_path_suffix(patch->new_name, GITATTRIBUTES_FILE);
    -+				/* The patch applied to a .gitattributes file. */
    -+				if (dummy)
    -+					flush_attributes = 1;
    -+				free(dummy);
    -+			}
    ++			if (!flush_attributes && patch->new_name &&
    ++			    has_path_suffix(patch->new_name, GITATTRIBUTES_FILE))
    ++				flush_attributes = 1;
      		}
      		else {
      			if (state->apply_verbosity > verbosity_normal)
