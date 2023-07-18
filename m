Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCC4EB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 21:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjGRVek (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 17:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGRVej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 17:34:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB50198C
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 14:34:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8787528580;
        Tue, 18 Jul 2023 17:34:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=w
        Xxhca6MxRU991jzByiVNfPD1PLtd7I7YTKaHXirtyE=; b=anD5tNY4gZ31HuhXP
        NxNsyX0KZXgNBgmd3QhQYyBz4nnmNkYavcP/wIriFlgExWCTwk9qePHv0z7Sculo
        3UhGJ9sUlP1E7HDTyUKz6wKH1Aj7Kcpt+Pp7cyHGeBBmwKLrZ6JCSq9NiAoJWr7H
        zoIRoiTYA3k2N4BoRS/o1gyrR0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8000A2857F;
        Tue, 18 Jul 2023 17:34:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 068E82857E;
        Tue, 18 Jul 2023 17:34:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] parse-options: introduce OPT_IPVERSION()
Date:   Tue, 18 Jul 2023 14:34:33 -0700
Message-ID: <xmqqjzuwgaza.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3BF2600-25B2-11EE-B142-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command line option parsing for "git clone", "git fetch", and
"git push" have duplicated implementations of parsing "--ipv4" and
"--ipv6" options, by having two OPT_SET_INT() for "ipv4" and "ipv6".

Introduce a new OPT_IPVERSION() macro and use it in these three
commands.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * No changes in behaviour (yet).  Notably, they still accept
   "--no-ipv4" and do nonsensical things.

 builtin/clone.c | 5 +----
 builtin/fetch.c | 5 +----
 builtin/push.c  | 5 +----
 parse-options.h | 6 ++++++
 4 files changed, 9 insertions(+), 12 deletions(-)

diff --git c/builtin/clone.c w/builtin/clone.c
index 15f9912b4c..6c9ad9b621 100644
--- c/builtin/clone.c
+++ w/builtin/clone.c
@@ -161,10 +161,7 @@ static struct option builtin_clone_options[] = {
 			N_("set config inside the new repository")),
 	OPT_STRING_LIST(0, "server-option", &server_options,
 			N_("server-specific"), N_("option to transmit")),
-	OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
-			TRANSPORT_FAMILY_IPV4),
-	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
-			TRANSPORT_FAMILY_IPV6),
+	OPT_IPVERSION(&family),
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 	OPT_BOOL(0, "also-filter-submodules", &option_filter_submodules,
 		    N_("apply partial clone filters to submodules")),
diff --git c/builtin/fetch.c w/builtin/fetch.c
index 849a9be421..0b5cadc12a 100644
--- c/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -2193,10 +2193,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "refmap", NULL, N_("refmap"),
 			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
 		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
-		OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
-				TRANSPORT_FAMILY_IPV4),
-		OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
-				TRANSPORT_FAMILY_IPV6),
+		OPT_IPVERSION(&family),
 		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
 				N_("report that we have only objects reachable from this object")),
 		OPT_BOOL(0, "negotiate-only", &negotiate_only,
diff --git c/builtin/push.c w/builtin/push.c
index dbdf609daf..aa28fdba0e 100644
--- c/builtin/push.c
+++ w/builtin/push.c
@@ -627,10 +627,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 				PARSE_OPT_OPTARG, option_parse_push_signed),
 		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"), TRANSPORT_PUSH_ATOMIC),
 		OPT_STRING_LIST('o', "push-option", &push_options_cmdline, N_("server-specific"), N_("option to transmit")),
-		OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
-				TRANSPORT_FAMILY_IPV4),
-		OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
-				TRANSPORT_FAMILY_IPV6),
+		OPT_IPVERSION(&family),
 		OPT_END()
 	};
 
diff --git c/parse-options.h w/parse-options.h
index 8e48efe524..e35710733d 100644
--- c/parse-options.h
+++ w/parse-options.h
@@ -581,4 +581,10 @@ int parse_opt_tracking_mode(const struct option *, const char *, int);
 #define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
 #define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically stash/stash pop before and after"))
 
+#define OPT_IPVERSION(v) \
+	OPT_SET_INT('4', "ipv4", (v), N_("use IPv4 addresses only"), \
+		TRANSPORT_FAMILY_IPV4), \
+	OPT_SET_INT('6', "ipv6", (v), N_("use IPv6 addresses only"), \
+		TRANSPORT_FAMILY_IPV6)
+
 #endif

