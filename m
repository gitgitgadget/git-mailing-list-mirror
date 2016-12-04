Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842061FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 14:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750955AbcLDOD2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 09:03:28 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:34074 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750804AbcLDOD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 09:03:27 -0500
Received: by mail-wj0-f194.google.com with SMTP id xy5so35809451wjc.1
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 06:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ze/vC7KYJ5hxRIG6Th4kkaTP5LMsNjj71bhkIjakpM4=;
        b=HNtuy8YpLf/6U/0uSBYuqCD0VX6rc0n95XkzgkDS5K2z7R9o+ADGr+PSiEvnO5rpJ1
         ZRqfSVwy/obXf3X7X7O2toiln9SRNHhsSQESCtY7fVocYEQPPOYxpJgJP80tnsvur/KD
         Z6rEWpNzvAnykthg+1g7GVZ+iqKiafYc4iu6mEotlpAodOyYrp/FraOJBSH2axIUZVqg
         heJKkFa8mApiHqrrV2fI3ZtiwjcnWKneiu3BsI7LNykx+6rL4VEaxaahc9KXXs+zIAEl
         LfP5DOGbt6WcaVB+vk3IgMHEfPM3cO+QPaN9SxaGOZhX0yvrtisckyNHXKU044hybhPo
         NEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ze/vC7KYJ5hxRIG6Th4kkaTP5LMsNjj71bhkIjakpM4=;
        b=E+j/ZZ25UZGkXH/3XC2cjozM9AoN2HF9Vrg8d+OLolJHLs8Y5Z4ZdWPTDUMok8ohno
         e7kFpAxOFyxE+HnpflQLEBWK3aYjR4eviYD+2UPk1ZLRQvX+SkV2HYNwk7AaV18W1d7v
         dURX0tvFYlIv7GZY8n9uQSmyYtolDX1XMEeZiQ9esTLl/g6ZLKZ7OxkK5VWq6HNeR2xl
         NM+V3ZpKpt519Qq6bBfmFO36CWj+qJRlnA2yAEWycZAgKNizTZCqN6FNIiYpWMmSiDkV
         rEW0Orh+d80gBLNXzON0bnF7gqtb9o5+jB5fyXygMSiUwzom4+7uQbFJWpgBO5hFzLvF
         hi8g==
X-Gm-Message-State: AKaTC00n5wmqGXpldsPUcyk8vHF9soojq0iz9FfVZmYavBjdOvpBO2rJ5VpZvgVrevCMnw==
X-Received: by 10.194.134.66 with SMTP id pi2mr26766151wjb.61.1480860188116;
        Sun, 04 Dec 2016 06:03:08 -0800 (PST)
Received: from slxBook4.fritz.box.fritz.box (p508BA0CE.dip0.t-ipconnect.de. [80.139.160.206])
        by smtp.gmail.com with ESMTPSA id ct7sm15578023wjc.2.2016.12.04.06.03.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 04 Dec 2016 06:03:07 -0800 (PST)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     luke@diamand.org, orirawlings@gmail.com,
        Lars Schneider <lars.schneider@autodesk.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] git-p4: add config to retry p4 commands; retry 3 times by default
Date:   Sun,  4 Dec 2016 15:03:11 +0100
Message-Id: <20161204140311.26269-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <lars.schneider@autodesk.com>

P4 commands can fail due to random network issues. P4 users can counter
these issues by using a retry flag supported by all p4 commands [1].

Add an integer Git config value `git-p4.retries` to define the number of
retries for all p4 invocations. If the config is not defined then set
the default retry count to 3.

[1] https://www.perforce.com/perforce/doc.current/manuals/cmdref/global.options.html

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Commit: 454cb6b (v2.11.0)
    Diff on Web: https://github.com/git/git/compare/454cb6b...larsxschneider:654c727
    Checkout:    git fetch https://github.com/larsxschneider/git git-p4/retries-v1 && git checkout 654c727

 Documentation/git-p4.txt | 4 ++++
 git-p4.py                | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index c83aaf39c3..656587248c 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -467,6 +467,10 @@ git-p4.client::
 	Client specified as an option to all p4 commands, with
 	'-c <client>', including the client spec.
 
+git-p4.retries::
+	Specifies the number of times to retry a p4 command (notably,
+	'p4 sync') if the network times out. The default value is 3.
+
 Clone and sync variables
 ~~~~~~~~~~~~~~~~~~~~~~~~
 git-p4.syncFromOrigin::
diff --git a/git-p4.py b/git-p4.py
index fd5ca52462..2422178210 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -78,6 +78,11 @@ def p4_build_cmd(cmd):
     if len(client) > 0:
         real_cmd += ["-c", client]
 
+    retries = gitConfigInt("git-p4.retries")
+    if retries is None:
+        # Perform 3 retries by default
+        retries = 3
+    real_cmd += ["-r", str(retries)]
 
     if isinstance(cmd,basestring):
         real_cmd = ' '.join(real_cmd) + ' ' + cmd
-- 
2.11.0

