From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 4/4] remote: use remote_is_configured() for add and rename
Date: Mon, 15 Feb 2016 23:39:44 +0100
Message-ID: <1455575984-24348-5-git-send-email-t.gummerer@gmail.com>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 23:40:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVRoT-0002pi-TD
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 23:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbcBOWkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 17:40:05 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33098 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbcBOWje (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 17:39:34 -0500
Received: by mail-wm0-f66.google.com with SMTP id c200so17926277wme.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 14:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dqw4rGAGkeryYypoBV509s+vzrLqAICJis3rKV5HWRY=;
        b=nPVOAuWRntO9vr0SELwYpUZbgDz7RfdB2Jkl8MyIEhJuUPEpiC87ZL0nh6owK8jPdQ
         bwZdJhF7XigsJ5M51qW5g88RhGSvYADBNFtJp17D8QCyRoBQA1HmWq+S0WCEHy2oBpyd
         QoqMlxTXtvmaf0ZO1VQpstsFYZjQRz67RiChrOBRm9/A3Mn6HTiarf603nPwNtG4e+Q2
         qpBkv5NS8DmrrfsV5XTyj/sHggjDg7wfM4BAPvnA/8/Gp6P4P7MTV4mqngVnMpVj2/3b
         fA4/R4r6NzzjDUR3+Mu/LJ0SIazcK2m5UJ5PZNty4YysW9hTX+JKa0vk/nZOEaAXzutl
         Wr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dqw4rGAGkeryYypoBV509s+vzrLqAICJis3rKV5HWRY=;
        b=Lu+3igetMuRAJHunev/NdIXxfm5XmSPKD1vdUndORNrWTowcNNWYgt5jzv3u6hQx1B
         lZni5PnGYLcS27uXSfzvbShL514GnU9PWObEO4WB2/1h9X2O15uPRahTN2gmz/V5slRJ
         90EpjbdZ7YHAjSo6TXN4SHXo2D+1231p05a6pZrObhJQTaBNuteGCK77fboEh5h0vOkg
         CI90sighJRtrJsvy8gBXioMjYlmFTjyteIrt9SBvnw2ANepGV1TcPErbVpSCVLTQFTnJ
         PQQuPtgdOYfS7yNSCch5N7CTwDkAGBB98OVamfllwwuVE646+DMEdu/M5R6xNejLlqnw
         zqCQ==
X-Gm-Message-State: AG10YOREDH6I80zZCnClRD4OzSdiHNpBkNdCMgH7VGuG1vqnoj5ZoQ+tqeBe6iWf78tTbw==
X-Received: by 10.28.227.213 with SMTP id a204mr15954241wmh.2.1455575973681;
        Mon, 15 Feb 2016 14:39:33 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id l7sm27377666wjx.14.2016.02.15.14.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 14:39:32 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
In-Reply-To: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286280>

Both remote add and remote rename use a slightly different hand-rolled
check if the remote exits.  The hand-rolled check may have some subtle
cases in which it might fail to detect when a remote already exists.
One such case was fixed in fb86e32 ("git remote: allow adding remotes
agreeing with url.<...>.insteadOf").  Another case is when a remote is
configured as follows:

  [remote "foo"]
    vcs = bar

If we try to run `git remote add foo bar` with the above remote
configuration, git segfaults.  This change fixes it.

In addition, git remote rename $existing foo with the configuration for
foo as above silently succeeds, even though foo already exists,
modifying its configuration.  With this patch it fails with "remote foo
already exists".

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/remote.c  |  7 ++-----
 t/t5505-remote.sh | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 981c487..bd57f1b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -186,10 +186,7 @@ static int add(int argc, const char **argv)
 	url = argv[1];
 
 	remote = remote_get(name);
-	if (remote && (remote->url_nr > 1 ||
-			(strcmp(name, remote->url[0]) &&
-				strcmp(url, remote->url[0])) ||
-			remote->fetch_refspec_nr))
+	if (remote_is_configured(remote))
 		die(_("remote %s already exists."), name);
 
 	strbuf_addf(&buf2, "refs/heads/test:refs/remotes/%s/test", name);
@@ -641,7 +638,7 @@ static int mv(int argc, const char **argv)
 		return migrate_file(oldremote);
 
 	newremote = remote_get(rename.new);
-	if (newremote && (newremote->url_nr > 1 || newremote->fetch_refspec_nr))
+	if (remote_is_configured(newremote))
 		die(_("remote %s already exists."), rename.new);
 
 	strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index f1d073f..142ae62 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -157,6 +157,24 @@ test_expect_success 'rename errors out early when deleting non-existent branch'
 	)
 '
 
+test_expect_success 'add existing foreign_vcs remote' '
+	git config --add remote.foo.vcs "bar" &&
+	test_when_finished git remote rm foo &&
+	echo "fatal: remote foo already exists." >expect &&
+	test_must_fail git remote add foo bar 2>actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'add existing foreign_vcs remote' '
+	git config --add remote.foo.vcs "bar" &&
+	git config --add remote.bar.vcs "bar" &&
+	test_when_finished git remote rm foo &&
+	test_when_finished git remote rm bar &&
+	echo "fatal: remote bar already exists." >expect &&
+	test_must_fail git remote rename foo bar 2>actual &&
+	test_i18ncmp expect actual
+'
+
 cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
-- 
2.7.1.410.g6faf27b
