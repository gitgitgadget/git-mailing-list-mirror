Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3712EB64DA
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 14:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjGSOx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 10:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGSOxK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 10:53:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF48171D
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 07:53:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D17831FD69;
        Wed, 19 Jul 2023 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689778384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wZQObvFiDDnj2PAeAX6NY7zkpBtLtZAfFbIIa582aM=;
        b=wETgX2AKyp8yc7aq3mup16k8BdEQf5Bn5xA+vujf5phu5lJ8c3lj+N2bo8y4HboiFTlC2T
        DgOTxwZnzHFUecJN6QETrkTCESBdvllaupES4qqiVsGQNKAjKfzUBg3cDlGVeIxH8eV0M7
        i+DEHY1ruGF00GkS62urV/LE1poydZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689778384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wZQObvFiDDnj2PAeAX6NY7zkpBtLtZAfFbIIa582aM=;
        b=vTVpVdzcyq+Mm49l45jBEsAkKW5B90HN2Tom8ggGS/CNXKv7a9fHQ9jwhiPd2Z1lxqYRLK
        IcbjAKnZXw2MesCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFB8A13460;
        Wed, 19 Jul 2023 14:53:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yCWYKdD4t2TBVQAAMHmgww
        (envelope-from <aherrmann@suse.de>); Wed, 19 Jul 2023 14:53:04 +0000
From:   Andreas Herrmann <aherrmann@suse.de>
To:     git@vger.kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] configure.ac: don't overwrite NO_CURL option
Date:   Wed, 19 Jul 2023 16:29:56 +0200
Message-ID: <20230719145211.17854-6-aherrmann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719145211.17854-2-aherrmann@suse.de>
References: <20230719145211.17854-2-aherrmann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if 'configure --with-curl=no' was run, curl support is used,
because library detection overwrites it. Avoid this overwrite.
Configure should obey what the user has specified.

Signed-off-by: Andreas Herrmann <aherrmann@suse.de>
---
 configure.ac | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure.ac b/configure.ac
index 62cc8197f8..e85e215f14 100644
--- a/configure.ac
+++ b/configure.ac
@@ -546,6 +546,8 @@ fi
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
 
+if test -z "$NO_CURL"; then
+
 GIT_STASH_FLAGS($CURLDIR)
 
 AC_CHECK_LIB([curl], [curl_global_init],
@@ -554,6 +556,8 @@ AC_CHECK_LIB([curl], [curl_global_init],
 
 GIT_UNSTASH_FLAGS($CURLDIR)
 
+fi
+
 GIT_CONF_SUBST([NO_CURL])
 
 if test -z "$NO_CURL"; then
-- 
2.41.0

