Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC01EB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 21:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjGRVqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 17:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGRVqD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 17:46:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5EB198C
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 14:46:03 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D5BE18B0A0;
        Tue, 18 Jul 2023 17:46:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L449DDvAFjDFhcH5iKO6wRjBXGTftjmIMM2hBx
        nVtoQ=; b=vETkABbBpNX3saXX2DSkvGiz+ngVFnAuVLHDJhbRfz/DZf71NSkltR
        iGZsQdUc5jRaXqAGBZrjLYWz2hzcr6+2p5CfhdAurm92vpflUG3vuZMTGDuE2er0
        EdOZxMi0ACx7PNeY034jVHux7R5+QKHkw4C5mbdXzE5mv0PecwsHo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34E2118B09E;
        Tue, 18 Jul 2023 17:46:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3A4C118B099;
        Tue, 18 Jul 2023 17:46:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] fetch: reject --no-ipv[46]
References: <xmqqjzuwgaza.fsf@gitster.g>
Date:   Tue, 18 Jul 2023 14:45:59 -0700
In-Reply-To: <xmqqjzuwgaza.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        18 Jul 2023 14:34:33 -0700")
Message-ID: <xmqqedl4gag8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CCC284C-25B4-11EE-96BB-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now we have introduced OPT_IPVERSION(), tweak its implementation so
that "git clone", "git fetch", and "git push" reject the negated
form of "Use only IP version N" options.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.h       |  8 ++++----
 t/t5516-fetch-push.sh | 11 +++++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git c/parse-options.h w/parse-options.h
index e35710733d..57a7fe9d91 100644
--- c/parse-options.h
+++ w/parse-options.h
@@ -582,9 +582,9 @@ int parse_opt_tracking_mode(const struct option *, const char *, int);
 #define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically stash/stash pop before and after"))
 
 #define OPT_IPVERSION(v) \
-	OPT_SET_INT('4', "ipv4", (v), N_("use IPv4 addresses only"), \
-		TRANSPORT_FAMILY_IPV4), \
-	OPT_SET_INT('6', "ipv6", (v), N_("use IPv6 addresses only"), \
-		TRANSPORT_FAMILY_IPV6)
+	OPT_SET_INT_F('4', "ipv4", (v), N_("use IPv4 addresses only"), \
+		TRANSPORT_FAMILY_IPV4, PARSE_OPT_NONEG), \
+	OPT_SET_INT_F('6', "ipv6", (v), N_("use IPv6 addresses only"), \
+		TRANSPORT_FAMILY_IPV6, PARSE_OPT_NONEG)
 
 #endif
diff --git c/t/t5516-fetch-push.sh w/t/t5516-fetch-push.sh
index 19ebefa5ac..87163d7745 100755
--- c/t/t5516-fetch-push.sh
+++ w/t/t5516-fetch-push.sh
@@ -120,6 +120,17 @@ test_expect_success setup '
 
 '
 
+for cmd in push fetch
+do
+	for opt in ipv4 ipv6
+	do
+		test_expect_success "reject 'git $cmd --no-$opt'" '
+			test_must_fail git $cmd --no-$opt 2>err &&
+			grep "unknown option .no-$opt" err
+		'
+	done
+done
+
 test_expect_success 'fetch without wildcard' '
 	mk_empty testrepo &&
 	(

