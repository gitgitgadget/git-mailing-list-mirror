From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 5/5] refs.c: rollback the lockfile before we die() in repack_without_refs
Date: Wed, 30 Jul 2014 14:52:48 -0700
Message-ID: <1406757168-3729-6-git-send-email-sahlberg@google.com>
References: <1406757168-3729-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 23:53:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCbnx-0005eJ-Ij
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 23:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbaG3Vw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 17:52:58 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:38004 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbaG3Vw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 17:52:57 -0400
Received: by mail-vc0-f201.google.com with SMTP id le20so251206vcb.2
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6tOdDulQ2lilcQyAITXNBBjlcGN53R+Q9cDcF67DqtU=;
        b=dcMeBP8dvStiw1qXnTCSKr9k5VemzPxGmuRoMIaX1v/Fiz33ifyOJ0kj/TLXZxjvpy
         6wRx8VB7PTUeQTRpe5BLpj4QetpSweJvYSWLo8UIrbAvwUV7hwOarj0f9nxMJ/RYiC92
         DSoZ6lZbjPIF89I7QqIs2XQ4dHuilO6bZaAkFiRdelX/eEOf9363uXmbC24gsgrdCWbP
         aSNnlz8ZW3Ku0v+B60UzqklJX4XerpEvFMcy0JHslJppb0m8xgmp3oBbb0SalXh5XKQS
         KV3j1Uj+odzbPGKVxcerIYIFj51q+yN6asvgN1i3jEI2nvsCanNtCqT/eTWfINMkLvcv
         37qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6tOdDulQ2lilcQyAITXNBBjlcGN53R+Q9cDcF67DqtU=;
        b=W/y7aoaIzrnXiTzVDd2iOguuWofwZMGlADKd1fLBqpEV+CM8EmfnqMiP3OUjfx4HCl
         mdbwHLhMyI+g2bhVXl/jk4xVGhFJcXtO+7ItiRStItQ6YbQSdAd2jvIIDqLeFEHYObD4
         mpbjR2V3utOiCtEWetCX88cKnwtArDl42PqAyuCw1435Q/nfiMVS7OyaBzVxHNRoo8v8
         R0BOreIif/Bjm0EQt+atdLFgmVVf7rWHmCmcE0OUqNUrwTxHP+USby3vN3kxXrHaYL8X
         kXSqE5Yb5NAImwzxSQ9LXVoa7T2GkfH7tj8JmjMb3o9RnSWJNRvIhhwhr35Ri7sdgCgM
         UX7Q==
X-Gm-Message-State: ALoCoQnHWz24XjBH4u/RxCO/Q2Ggy+EvS2VeKpg/omnRv141cC+NFIv7Cr/HBk/RsqONb9c1ZtRt
X-Received: by 10.236.43.20 with SMTP id k20mr2459440yhb.54.1406757175133;
        Wed, 30 Jul 2014 14:52:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si226062yhb.3.2014.07.30.14.52.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jul 2014 14:52:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 53DC831C541;
	Wed, 30 Jul 2014 14:52:54 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E3C34E0639; Wed, 30 Jul 2014 14:52:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g0041e8a
In-Reply-To: <1406757168-3729-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254519>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 9c813f9..3e98ca1 100644
--- a/refs.c
+++ b/refs.c
@@ -2574,8 +2574,10 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	/* Remove any other accumulated cruft */
 	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
-		if (remove_entry(packed, ref_to_delete->string) == -1)
+		if (remove_entry(packed, ref_to_delete->string) == -1) {
+			rollback_packed_refs();
 			die("internal error");
+		}
 	}
 
 	/* Write what remains */
-- 
2.0.1.523.g0041e8a
