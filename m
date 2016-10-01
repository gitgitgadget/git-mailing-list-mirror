Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A11207EC
	for <e@80x24.org>; Sat,  1 Oct 2016 00:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbcJAATq (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 20:19:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50396 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752423AbcJAATo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 20:19:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCB8D420E3;
        Fri, 30 Sep 2016 20:19:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=sxGN
        QRVEiwIQ+19EowJk10et/rE=; b=w5SsoH4/3TnO1Dlc87HuNQvBpY3adzU7rVkM
        F4tQA80OPGOZTHivsfWa0fEDInxBD2nYc98imm3vdkK6ftyzkJ0XRRwtyQrIFprg
        OVqtAshgwwTA68tyt/FE1ofjRvfNmtxgCBmhAuTK8XbkAgU0B3t/ayIzzlCYFuG7
        blNEOFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=SUmo4j
        B0cy3EW1Tn89ZIDiMcCe+B/IIMod9L3zsEsy++SBivb9Z1cA5xBHu2l9ScW+wd2o
        ftwB3Sv+DiZP/JjlGLBXBnwyXP17gTvQYijsxySQENkrqxa5zrQkOJfKoSWJcQnU
        ZxDYavvO+q2fj7ZoVCyBaWSbexFKhCN3FLdSc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFF6F420E2;
        Fri, 30 Sep 2016 20:19:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 535D1420E0;
        Fri, 30 Sep 2016 20:19:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] abbrev: add FALLBACK_DEFAULT_ABBREV to prepare for auto sizing
Date:   Fri, 30 Sep 2016 17:19:35 -0700
Message-Id: <20161001001937.10884-2-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-622-g05f606bbb0
In-Reply-To: <20161001001937.10884-1-gitster@pobox.com>
References: <20161001001937.10884-1-gitster@pobox.com>
X-Pobox-Relay-ID: BFAF42E0-876C-11E6-8645-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'll be introducing a new way to decide the default abbreviation
length by initialising DEFAULT_ABBREV to -1 to signal the first call
to "find unique abbreviation" codepath to compute a reasonable value
based on the number of objects we have to avoid collisions.

We have long relied on DEFAULT_ABBREV being a positive concrete
value that is used as the abbreviation length when no extra
configuration or command line option has overridden it.  Some
codepaths wants to use such a positive concrete default value
even before making their first request to actually trigger the
computation for the auto sized default.

Introduce FALLBACK_DEFAULT_ABBREV and use it to the code that
attempts to align the report from "git fetch".  For now, this
macro is also used to initialize the default_abbrev variable,
but the auto-sizing code will use -1 and then use the value of
FALLBACK_DEFAULT_ABBREV as the starting point of auto-sizing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c | 3 +++
 cache.h         | 3 +++
 environment.c   | 2 +-
 transport.h     | 3 +--
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 164623bb6f..a9f12cc5cf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -17,6 +17,9 @@
 #include "argv-array.h"
 #include "utf8.h"
 
+#define TRANSPORT_SUMMARY(x) \
+	(int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
+
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
 	N_("git fetch [<options>] <group>"),
diff --git a/cache.h b/cache.h
index f346c01708..5a651b8435 100644
--- a/cache.h
+++ b/cache.h
@@ -1183,6 +1183,9 @@ static inline int hex2chr(const char *s)
 #define MINIMUM_ABBREV minimum_abbrev
 #define DEFAULT_ABBREV default_abbrev
 
+/* used when the code does not know or care what the default abbrev is */
+#define FALLBACK_DEFAULT_ABBREV 7
+
 struct object_context {
 	unsigned char tree[20];
 	char path[PATH_MAX];
diff --git a/environment.c b/environment.c
index cd5aa57179..44fb107b8a 100644
--- a/environment.c
+++ b/environment.c
@@ -16,7 +16,7 @@ int trust_executable_bit = 1;
 int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
-int minimum_abbrev = 4, default_abbrev = 7;
+int minimum_abbrev = 4, default_abbrev = FALLBACK_DEFAULT_ABBREV;
 int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
diff --git a/transport.h b/transport.h
index 6fe3485325..e783377e40 100644
--- a/transport.h
+++ b/transport.h
@@ -142,8 +142,7 @@ struct transport {
 #define TRANSPORT_PUSH_ATOMIC 8192
 #define TRANSPORT_PUSH_OPTIONS 16384
 
-#define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
-#define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
+#define TRANSPORT_SUMMARY_WIDTH (2 * FALLBACK_DEFAULT_ABBREV + 3)
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
2.10.0-622-g05f606bbb0

