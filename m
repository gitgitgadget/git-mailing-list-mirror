Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01EE41FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757015AbcLCAa6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:30:58 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36304 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755561AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pg0-f48.google.com with SMTP id f188so112440335pgc.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y2/yGIyh/M/fph/FuyYw+PX15azAZElHvbKMzDjkvpE=;
        b=U4s00wQjqHb/EEqUTe4E4eaeX3jMDUQC71tEc0psw1ZikI2Unxo+ZkSSioRryyUJjW
         ygZqUUI5Idn5i0DZ5lTjS2QPexnry2wRzebCTW9VoCkc002La0fu6Bda1C73C2V4Jtj3
         YAZh/xeWaMyq8eIn7dZYDbyEn+N0GskmgK+FnRH8tEd5SXbrWyBNrvRe2Pz5DFnx5LC6
         CrWaI1nwloQn08lU2kNJNN5/4oCdKHGPLm0jKaCf5HW4o9UWsiMNTEo62xbWaZIH0wyU
         5fU6/UJIzYZXyZEA6rsByVDMI3Q2ofQItDIx0l1B7wUVR9FAjKOl+ScFgMsTkYBDIyUc
         TUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y2/yGIyh/M/fph/FuyYw+PX15azAZElHvbKMzDjkvpE=;
        b=b0VFbUxMu6cR1GxEFVBRAWmuyiyivvAvF2WsUHpzCF57Nd+l7B9iBp7EwihW5jlmJA
         QJMA4I4YFf6eSToY4Q0Trwun43BWF8s1HIi6OPUPdWTeyuE5fpXFM0n+nSB0LusA2J9h
         vbydbZWPUpirE59+eC5UMeea3wJLNd55n+0ueMHqiLFhxrFS1oOPHCywcPF6TUC7xfl7
         Sw8RZso3PoCJZ+W0LK32k/TsXEs05V4XeQh5w+fgUAdXuI2gKOXTK0W6N8/JoPS44uHA
         Apl9Hf5jEWPDGapGJKvzB+zcaf6vIIFAUY8cduea9WP5XV/eXR0LwG1nuUTRcj63KXT3
         Fycw==
X-Gm-Message-State: AKaTC01y8ZPo5eND3UeqrrIFxhpxpeh7UMGIBPSJsXalXtUlDCWsRAdZrT++6id0gzY4nNLk
X-Received: by 10.99.115.82 with SMTP id d18mr82171029pgn.56.1480725047559;
        Fri, 02 Dec 2016 16:30:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id c22sm10308637pgn.12.2016.12.02.16.30.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 12/17] unpack-trees: remove submodule contents if interesting
Date:   Fri,  2 Dec 2016 16:30:17 -0800
Message-Id: <20161203003022.29797-13-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when a unlink_entry() is called on a submodule, this fails
as remove_or_warn detects it needs to delete a directory via rmdir.
However rmdir only works on empty directories, such that the
"_or_warn" part kicks in, and we get a warning message.

In case the submodule is of no interest we're not going to delete the
submodule, so a warning like that is useful.

If the submodule is interesting then we need to depopulate it properly,
there is no need to react on its return code the depopulation method
handles proper warnings nor do we need to schedule the directory for
removal later, such that we can return early.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 22e32eca96..db03293347 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -214,7 +214,12 @@ static void unlink_entry(const struct cache_entry *ce)
 {
 	if (!check_leading_path(ce->name, ce_namelen(ce)))
 		return;
-	if (remove_or_warn(ce->ce_mode, ce->name))
+
+	if (S_ISGITLINK(ce->ce_mode) &&
+	    submodule_is_interesting(ce->name)) {
+		depopulate_submodule(ce->name);
+		return;
+	} else if (remove_or_warn(ce->ce_mode, ce->name))
 		return;
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
-- 
2.11.0.rc2.28.g2673dad

