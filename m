From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 3/4] remote: actually check if remote exits
Date: Mon, 15 Feb 2016 23:39:43 +0100
Message-ID: <1455575984-24348-4-git-send-email-t.gummerer@gmail.com>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 23:40:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVRp2-0003DH-0c
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 23:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbcBOWkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 17:40:05 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34447 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbcBOWjc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 17:39:32 -0500
Received: by mail-wm0-f67.google.com with SMTP id b205so10534879wmb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 14:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=965j7znh9lG56qORoP7K0yTdCdgB4aW49qovIAXjyBg=;
        b=OkZxPUdAGmc3SDAswcx5P/BRnNr6MHk7CYFzwObUGnIyqNzcv09dqxeKN6e1fP1vKv
         duwPRtKTiDHKyHclBSs61XdnVLacy+fsCmLFnNyVrgsjWz8lAzpD13jxBSVQjoRFzgGc
         e6rtX+p1LLrsUrx+KZuF5riKvcQDmun/C6DZK9r5AM4OKmrGE2T8eN9z8tHmWgmEQ/tU
         BfjaZADc6CCyBpCEtdv8yeRdlffICA93UBEEaLAoQ7AUs7XLKZSpvSVzh5N5Uodj7ODt
         CNPSSQcFegYz4sFzA8ZTAQPcKaCTmX1uc1dUeJ/7K5rThOyHMvPsTdYVpoAwjmXJpIEX
         BKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=965j7znh9lG56qORoP7K0yTdCdgB4aW49qovIAXjyBg=;
        b=AxhnWKGFyW6syHj1QmJ42TgphycvMo0l1+gkzy/PJDZhoIdVTpQzY5Kj5T2+NH9Dtq
         juFkAxiRW2HVwk2JZTOXo3v6P9eHCLWAXWI5WTjSDKw3CNllrF2/YSGQWoyzgl/TqXB/
         4QSmbahfw7kRVd8N7Gh++3bWTHAv07U0sDrR6E0PSubVl8P9Qrl6LIkEpbrKNoe8kB3U
         ZwOhaGUhclGUnKgDW5VBZZPcrzr/kmreMfYK0LQahqz0Xvv3BPQVXWRSl29pn3Ut8unW
         8nsuUPcLSDzvGyeUDojiJOvTJg+1WCmUkPID1cwImNlEQYaWf8XZ5WoJMGQproAvrA0W
         wigw==
X-Gm-Message-State: AG10YOSEcZfGA/VOn4eSQQkq/emJjGiA7vBiRdnZN82Ws6DZ5sVIkqtIcEwAF3aaqpqKNw==
X-Received: by 10.28.63.200 with SMTP id m191mr14486578wma.21.1455575971650;
        Mon, 15 Feb 2016 14:39:31 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id 198sm17738366wml.22.2016.02.15.14.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 14:39:30 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
In-Reply-To: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286282>

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
