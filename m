Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645B81F6DC
	for <e@80x24.org>; Tue, 31 Jan 2017 09:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbdAaJJn (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 04:09:43 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:59146 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbdAaJJg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 04:09:36 -0500
Received: from localhost (unknown [10.10.10.227])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 55E0716C880;
        Tue, 31 Jan 2017 10:01:49 +0100 (CET)
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 0/5] urlmatch: allow wildcard-based matches
Date:   Tue, 31 Jan 2017 10:01:42 +0100
Message-Id: <cover.1485853153.git.ps@pks.im>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170123130635.29577-1-patrick.steinhardt@elego.de>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this is version 5 of my patch series. The previous version can
be found at [1]. The use case is to be able to configure an HTTP
proxy for all subdomains of a domain where there are hundreds of
subdomains.

This includes only a single change, interdiff is included below.
The previous version had an embarassing bug because a variable
was not properly initialized in all cases, leading to undefined
behavior. I also verified that the patches work on top of
4e59582ff (Seventh batch for 2.12, 2017-01-23), where Junio
reported the test failures.

Regards
Patrick

Patrick Steinhardt (5):
  mailmap: add Patrick Steinhardt's work address
  urlmatch: enable normalization of URLs with globs
  urlmatch: split host and port fields in `struct url_info`
  urlmatch: include host in urlmatch ranking
  urlmatch: allow globbing for the URL host part

 .mailmap                 |   1 +
 Documentation/config.txt |   5 +-
 t/t1300-repo-config.sh   | 105 ++++++++++++++++++++++++++++++++++++
 urlmatch.c               | 138 +++++++++++++++++++++++++++++++++++------------
 urlmatch.h               |  12 +++--
 5 files changed, 220 insertions(+), 41 deletions(-)

-- 
2.11.0

diff --git a/urlmatch.c b/urlmatch.c
index bb5267732..6c12f1a48 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -552,7 +552,7 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 {
 	struct string_list_item *item;
 	struct urlmatch_config *collect = cb;
-	struct urlmatch_item matched;
+	struct urlmatch_item matched = {0};
 	struct url_info *url = &collect->url;
 	const char *key, *dot;
 	struct strbuf synthkey = STRBUF_INIT;
