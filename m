Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9282720437
	for <e@80x24.org>; Tue, 31 Oct 2017 13:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbdJaNTT (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 09:19:19 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45102 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbdJaNTS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 09:19:18 -0400
Received: by mail-wr0-f195.google.com with SMTP id y9so15911970wrb.2
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZAN1BH0Se8C8c6GH5IDBDsdVCVV6WQ0jmXLgvQ5Kh9A=;
        b=Wl156ipe+F68tdZ7mlXx5jH3/kkwqfo21KT43Kxi2DIht0LxAB1ScnF6a0T2seQBqx
         V3VtT1yPwlUdxUm42KtWqZSh+Q8K/jT9EI6tjd32xovVWqKuM5lsHcoNqpPvXw8TLN5A
         t6PhP5nqLcPWK3D0k05A7AuSmv1EqsHINGAHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZAN1BH0Se8C8c6GH5IDBDsdVCVV6WQ0jmXLgvQ5Kh9A=;
        b=eeCQsa/8gtO8STsaw6gPgyMMmK5P/SIPA8wxtY1rr9aiqLIvBRDz90f+FHcDOaR1mP
         f0M5W7eIG/UjfrUlueZtQ6abhHjqdx9AIl0oENNcJuoejOESs5AXJ1ckvOowMEvFicFm
         ulQGVz2DzPFXwMIHOXpvjB64f2vw/dzTy675tlx4qz1QKNeReACF7iM/bkMTk+ZBlFP2
         4Uoivu3xy7di6MKyRdL3x8uz1mQLtJS2RwpKyiZXRI7nblI7q4oX4OrJ7p5ei32A0yuK
         AhHdKsfESNfXIjy3TwbS52zFxtnhqQzPqqR0AtaKwxEGPgJbMQWjakrLKCoQco4t90qw
         rdCw==
X-Gm-Message-State: AMCzsaWaOGRCXh6feZR+EIEWs/wC98vUV9DqpmnvTuD461ruC1xDJ1UL
        w+are2G+inK479UUwru9ofenXSxsAiI=
X-Google-Smtp-Source: ABhQp+TJ6z3j51mqIyLcnU0vJKg/4sieAY5YNuInwiVM0Cwa4v9jXoJOqVNTIl5BmKL6dKCCDRQsKw==
X-Received: by 10.223.136.51 with SMTP id d48mr1782523wrd.150.1509455956632;
        Tue, 31 Oct 2017 06:19:16 -0700 (PDT)
Received: from PC5175.ad.datcon.co.uk ([2620:104:4001:73:6477:c46c:a3e:668a])
        by smtp.gmail.com with ESMTPSA id j2sm1311725wrj.82.2017.10.31.06.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Oct 2017 06:19:15 -0700 (PDT)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t5580: add Cygwin support
Date:   Tue, 31 Oct 2017 13:19:03 +0000
Message-Id: <20171031131903.10496-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t5580 tests that specifying Windows UNC paths works with Git.  Cygwin
supports UNC paths, albeit only using forward slashes, not backslashes,
so run the compatible tests on Cygwin as well as MinGW.

The only complication is Cygwin's `pwd`, which returns a *nix-style
path, and that's not suitable for calculating the UNC path to the
current directory.  Instead use Cygwin's `cygpath` utility to get the
Windows-style path.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 t/t5580-clone-push-unc.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
index b322c2f72..47a9a7cda 100755
--- a/t/t5580-clone-push-unc.sh
+++ b/t/t5580-clone-push-unc.sh
@@ -3,12 +3,16 @@
 test_description='various Windows-only path tests'
 . ./test-lib.sh
 
-if ! test_have_prereq MINGW; then
+if test_have_prereq CYGWIN; then
+	alias winpwd='cygpath -aw .'
+elif test_have_prereq MINGW; then
+	alias winpwd=pwd
+else
 	skip_all='skipping Windows-only path tests'
 	test_done
 fi
 
-UNCPATH="$(pwd)"
+UNCPATH="$(winpwd)"
 case "$UNCPATH" in
 [A-Z]:*)
 	# Use administrative share e.g. \\localhost\C$\git-sdk-64\usr\src\git
@@ -45,8 +49,8 @@ test_expect_success push '
 	test "$rev" = "$(git rev-parse --verify refs/heads/to-push)"
 '
 
-test_expect_success 'remote nick cannot contain backslashes' '
-	BACKSLASHED="$(pwd | tr / \\\\)" &&
+test_expect_success MINGW 'remote nick cannot contain backslashes' '
+	BACKSLASHED="$(winpwd | tr / \\\\)" &&
 	git ls-remote "$BACKSLASHED" >out 2>err &&
 	test_i18ngrep ! "unable to access" err
 '
-- 
2.14.3

