Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D561F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfHMMp5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:45:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57514 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728406AbfHMMp5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Aug 2019 08:45:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 88ABF60737;
        Tue, 13 Aug 2019 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565700354;
        bh=4BJmUlH4QpJycCuQyRLw9IQx+dnp07/Vxk6KkzrU+BI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=j+/v8TocahR7Wlwe0sEeO0BQdGWgoQwYYanai1h3Gd+lonn2QYT6kE9s4TN651/Ei
         CTfrt5gHt2Xx8gAQDX1X/JhNg3tixH/FP8cdgMYp0H/IW/sD+QMmwVf8aYTjA7NGWb
         QEVqEZw0sA55jWjK1CHNqs4jLT3WzO77O4bf5fywNzLlQGmAmmG95kcNsG+EpJh+He
         wIpsTiphS4Szrni3ypakyCHEuN85WapSKZ1AmdoZ5SbiZeepglVlb2xfJ3UmZdXUiv
         sAUv8UEylN/8KlNqIVmlyHKyx98VMcWFIhO99Qlx7hSTkM6TD592hCdnuG3CxLV32i
         RdUptrVL1kHsEIVS4x5JBD75HDbPRPbDFLNRpEhuaYeCV2bSMUlAzrYYKyGZJplXHr
         fo5QhbMkwJKxkkelZNcpjfcptr1XR4LbLjK5V9FbHIDsBXJ0PAFE+6cwEaersvTYyj
         u6Db6NZvV2KVURrtgqWse8Ski/2kjkpzIIKUnv/99/0lyNG1ewY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/2] Honor .gitattributes with rebase --am
Date:   Tue, 13 Aug 2019 02:43:05 +0000
Message-Id: <20190813024307.705016-1-sandals@crustytoothpaste.net>
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

Changes from v2:
* Rename has_path_suffix to ends_with_path_components.

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

Range-diff against v2:
1:  125fda966c ! 1:  14c853420b path: add a function to check for path suffix
    @@ Commit message
         have one to check for a path suffix. For a plain filename, we can use
         basename, but that requires an allocation, since POSIX allows it to
         modify its argument. Refactor strip_path_suffix into a helper function
    -    and a new function, has_path_suffix to meet this need.
    +    and a new function, ends_with_path_components, to meet this need.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ path.c: static inline int chomp_trailing_dir_sep(const char *path, int len)
     +}
     +
     +/*
    -+ * Returns true if the path ends with suffix, considering only complete path
    -+ * components and false otherwise.
    ++ * Returns true if the path ends with components, considering only complete path
    ++ * components, and false otherwise.
     + */
    -+int has_path_suffix(const char *path, const char *suffix)
    ++int ends_with_path_components(const char *path, const char *components)
     +{
    -+	return stripped_path_suffix_offset(path, suffix) != -1;
    ++	return stripped_path_suffix_offset(path, components) != -1;
     +}
     +
      /*
    @@ path.h: const char *git_path_merge_head(struct repository *r);
      const char *git_path_shallow(struct repository *r);
      
     +
    -+int has_path_suffix(const char *path, const char *suffix);
    ++int ends_with_path_components(const char *path, const char *components);
     +
      #endif /* PATH_H */
2:  f54af7e595 ! 2:  5f4402b38d apply: reload .gitattributes after patching it
    @@ apply.c: static int apply_patch(struct apply_state *state,
      			listp = &patch->next;
     +
     +			if (!flush_attributes && patch->new_name &&
    -+			    has_path_suffix(patch->new_name, GITATTRIBUTES_FILE))
    ++			    ends_with_path_components(patch->new_name, GITATTRIBUTES_FILE))
     +				flush_attributes = 1;
      		}
      		else {
