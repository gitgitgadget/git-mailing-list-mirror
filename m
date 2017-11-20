Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A54F202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 18:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbdKTSYw (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 13:24:52 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34230 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbdKTSYt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 13:24:49 -0500
Received: by mail-wm0-f66.google.com with SMTP id y82so7333624wmg.1
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 10:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3tOwFUWBoF06O3fouSa8wVn4ukJlo3uMroeMTIzKwYM=;
        b=re2Rf221+bJIQCLm0aYkX2Zc7l/U4uvQofaYAEjFQdkiQXmHONzBk36Xb42FdL/qyE
         eN8hRt5WONRBcDR8mH28vuwwTluySGmMZSuv+lhtB8tPb82IjsbdQiJcUeBgD7uEmsUy
         T7iV8G85mft8lHWvuikXdtoctWPGZOcSEMly0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3tOwFUWBoF06O3fouSa8wVn4ukJlo3uMroeMTIzKwYM=;
        b=pi9TnBVDq3bma1vsJm9UHYss4l7JH4KLrwCeo18ACGqYBOiapCCRzHAkjTkUgNnnrE
         pGhn4AXiNVx1DemurqI/uiwlUUNUj/iox4WMJQrk/qXXU6DOHwQrcO/dHmKrRa6qTWwW
         xqd66EcTKG3Pobi9tx6lhB8GctZ01DBkDM+Llj/isll/SJ8goiTxtYOL/a3saVkmPwNs
         k/HHeDInCSIs3BD09TpXIyz+zLBiBzEq8yIhGhFvzkC1UfOKOr7/J5O7y7ImxNRFrIEr
         MmX6NGUskx2U3101O/AgSWOCNF7qb0jBQZ1E8rh/FaGyucD9zAMR3eLfVFb9rGfvM5uu
         tsJQ==
X-Gm-Message-State: AJaThX5NSTfsyxUW1AHCoWpboliVEwBN4BCzaw2NojGO91Beyf09A7wX
        tHY59BN6e/IxRLx6R0yYRP8okLYmkvw=
X-Google-Smtp-Source: AGs4zMYl5VUQO6MLJmvaLMP9JocxSwEEdet6joPDLxqnZwJ15WvYyVH2846vvmjn6YY1b7sDgGOD0g==
X-Received: by 10.28.183.132 with SMTP id h126mr11139970wmf.17.1511202288315;
        Mon, 20 Nov 2017 10:24:48 -0800 (PST)
Received: from PC5175.ad.datcon.co.uk ([2620:104:4001:73:a407:552d:75e4:4516])
        by smtp.gmail.com with ESMTPSA id 138sm13691999wmf.21.2017.11.20.10.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 10:24:47 -0800 (PST)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [RFC PATCH v2 1/2] bisect: split out replay file parsing
Date:   Mon, 20 Nov 2017 18:24:38 +0000
Message-Id: <e3bfd0ab1f7b17eb43cf50c91e17f498db56cdee.1511200589.git.adam@dinwoodie.org>
X-Mailer: git-send-email 2.15.0.281.g87c0a7615
In-Reply-To: <cover.1511200589.git.adam@dinwoodie.org>
References: <cover.1511200589.git.adam@dinwoodie.org>
In-Reply-To: <cover.1511200589.git.adam@dinwoodie.org>
References: <20171108135931.166880-1-adam@dinwoodie.org> <cover.1511200589.git.adam@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to allow a git bisect log file to be replayed without using all
the surrounding code to do things like clean the repository state, split
out the file-parsing part of bisect_replay into a separate function.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 git-bisect.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 54cbfecc5..895d7976a 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -422,6 +422,14 @@ bisect_replay () {
 	test "$#" -eq 1 || die "$(gettext "No logfile given")"
 	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
 	bisect_reset
+	bisect_replay_file "$file"
+	bisect_auto_next
+}
+
+bisect_replay_file() {
+	file="$1"
+	test "$#" -eq 1 || die "$(gettext "No logfile given")"
+	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
 	while read git bisect command rev
 	do
 		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
@@ -444,7 +452,6 @@ bisect_replay () {
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
 	done <"$file"
-	bisect_auto_next
 }
 
 bisect_run () {
-- 
2.15.0.281.g87c0a7615

