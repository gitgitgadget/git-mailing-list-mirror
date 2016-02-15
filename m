From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/4] remote: actually check if remote exits
Date: Mon, 15 Feb 2016 18:42:29 +0100
Message-ID: <1455558150-30267-4-git-send-email-t.gummerer@gmail.com>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 18:43:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNBm-0001ZW-4V
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 18:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbcBORnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 12:43:49 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35103 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbcBORnq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 12:43:46 -0500
Received: by mail-wm0-f65.google.com with SMTP id g62so16841130wme.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 09:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=965j7znh9lG56qORoP7K0yTdCdgB4aW49qovIAXjyBg=;
        b=wmTB42E0+w+6Cls1wGTjg4E5mZQ8UAfA36Caqn46+HyGZ8JX/txKNhRwVcUJjRWVWU
         wntVlH2eTUQ678GpBNEBKuHKcFDiEvf6G9KGe+cHgc4cvysgCkRNuLJopeM9FT93HK2s
         Br22MNiIxOHJdOqtuIIdI+gn5clTSj/rzWPmN1wJDYC6HzLywoSO/DW2Xc88Ka6kdJhd
         k2GukWU9UyKCEZGD27rGHdxFFv1Nd0iDspEo9BLZwVzA9Dp6Xjuenjf9KVJIraJh6KFf
         mUe8wbNjt2Fe6b6nlR/5naK7hHUMbbrJQN6oKTXKhe6jmRY3e2ZPDpQ84oo6Z5wBs79q
         7b8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=965j7znh9lG56qORoP7K0yTdCdgB4aW49qovIAXjyBg=;
        b=C/fTbKXr/AeWCIUgYl1yLSsH5fhO2GdkCpziuvCyb7JpanZEVw9VYaXPXYkfTmbHOp
         UZhtxqQVUN5s41DrUNX/g927BN30LnConnj20Y8I/A1MytSXXCm4HcdbIztsbPEcrsWW
         V5v4n3HRaTnlUUk0mxptankZc08Qhmmz4DsZjtk0abn5+Sjmh9h9raJOHM+mtPygD6tI
         aq/zWP+VKOHCYTaQobgf3reE2AKrJSBBpL1fJ9D1EotwBsF5udCZAGkLclphol7W9+ZA
         iaCLd7FRUF4VVid7ohZw0CfBGigEAEiSh5RSMMA7sXReG9MorHIAkHmRTgsvV6HHRfzr
         jcIw==
X-Gm-Message-State: AG10YORGcgW5zjn3mfBzpJJliVdyo7bFi/66M89DrOebuG0GFpTCiHGTes+A3kB5qyD4vA==
X-Received: by 10.28.189.67 with SMTP id n64mr14723778wmf.24.1455558224639;
        Mon, 15 Feb 2016 09:43:44 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id a128sm16688377wmh.6.2016.02.15.09.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 09:43:43 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
In-Reply-To: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286217>

When converting the git remote command to a builtin in 211c89 ("Make
git-remote a builtin"), a few calls to check if a remote exists were
converted from:
       if (!exists $remote->{$name}) {
       	  [...]
to:
       remote = remote_get(argv[1]);
       if (!remote)
          [...]

The new check is not quite correct, because remote_get() never returns
NULL if a name is given.  This leaves us with the somewhat cryptic error
message "error: Could not remove config section 'remote.test'", if we
are trying to remove a remote that does not exist, or a similar error if
we try to rename a remote.

Use the remote_is_configured() function to check whether the remote
actually exists, and die with a more sensible error message ("No such
remote: $remotename") instead if it doesn't.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/remote.c  |  4 ++--
 t/t5505-remote.sh | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d966262..981c487 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -634,7 +634,7 @@ static int mv(int argc, const char **argv)
 	rename.remote_branches = &remote_branches;
 
 	oldremote = remote_get(rename.old);
-	if (!oldremote)
+	if (!remote_is_configured(oldremote))
 		die(_("No such remote: %s"), rename.old);
 
 	if (!strcmp(rename.old, rename.new) && oldremote->origin != REMOTE_CONFIG)
@@ -773,7 +773,7 @@ static int rm(int argc, const char **argv)
 		usage_with_options(builtin_remote_rm_usage, options);
 
 	remote = remote_get(argv[1]);
-	if (!remote)
+	if (!remote_is_configured(remote))
 		die(_("No such remote: %s"), argv[1]);
 
 	known_remotes.to_delete = remote;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 1a8e3b8..f1d073f 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -139,6 +139,24 @@ test_expect_success 'remove remote protects local branches' '
 	)
 '
 
+test_expect_success 'remove errors out early when deleting non-existent branch' '
+	(
+		cd test &&
+		echo "fatal: No such remote: foo" >expect &&
+		test_must_fail git remote rm foo 2>actual &&
+		test_i18ncmp expect actual
+	)
+'
+
+test_expect_success 'rename errors out early when deleting non-existent branch' '
+	(
+		cd test &&
+		echo "fatal: No such remote: foo" >expect &&
+		test_must_fail git remote rename foo bar 2>actual &&
+		test_i18ncmp expect actual
+	)
+'
+
 cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
-- 
2.7.1.410.g6faf27b
