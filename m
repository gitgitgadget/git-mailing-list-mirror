From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 3/4] remote: actually check if remote exits
Date: Tue, 16 Feb 2016 10:47:51 +0100
Message-ID: <1455616072-20838-4-git-send-email-t.gummerer@gmail.com>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
 <1455616072-20838-1-git-send-email-t.gummerer@gmail.com>
Cc: sunshine@sunshineco.com, peff@peff.net, Johannes.Schindelin@gmx.de,
	gitster@pobox.com
To: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 10:47:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVcEa-0005m3-GJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 10:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbcBPJrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 04:47:46 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33529 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbcBPJri (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 04:47:38 -0500
Received: by mail-wm0-f52.google.com with SMTP id g62so182972031wme.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 01:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=965j7znh9lG56qORoP7K0yTdCdgB4aW49qovIAXjyBg=;
        b=rjb61OZMXcMZIxhzIMYYT/TZgJwmR2gt5K+GJzJf7My3SB+MJN8Fcr4IlmD9z5oDYn
         SNRNTBxBQAcqQlbzjx8IXZAHFJwj4cXxvZ1s1uyCHQ57UGRll5PzoE9OciaxPD0Ebkw8
         1I2heIHRk4xD5EAVjwNwD77ds7FdKbcJAT4YVM8AVmgTnLkA3nHyhdn1Zs97wG91zj+J
         7xRAI/QQo+K4r3VJ71GynV34r3GDzcxgQtRqdJYTyAq9OSayIxA6CbOM2KgNSHqWDUs6
         JwCuoNXnQhbqecRkOkrIYE+ZOYQDHd/Nth5vM28rMq4ypWe9xti5Op0Xoi5iamu901Cn
         K76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=965j7znh9lG56qORoP7K0yTdCdgB4aW49qovIAXjyBg=;
        b=O9knp6WXfnDLHjKV0Ffmt7PZCIfZ7/QYrVS11cOrlu9u7uP8ZfQda+fbwfRsd5xP95
         P8KEsHAAqpEfTafzzbQWVwufQapXfnjIuMoLRMA/zsy97DuS68RC8JpMyt2h/UJVscsw
         Duj8Y7dsFX4AoczvcQAWWtKg0HfMkVbtlHVLMGixrPAgZ6AjeU0yPuqSUKo/yu0jo+PT
         4DPf0PPG7an5g2p+2yDEPym6bJiGhkAA8XxlS2A80wd8foqVz3CWS80VWIpzzeYmW+R8
         eI8iNnlx27adk6ArTdKr/sBLVHOJXqVryMoU57BvkkHVfvXyOQIpa306lc7kxXMF4GYT
         gJOw==
X-Gm-Message-State: AG10YOTAwVu+V9JLKInIRY8iNrm3PwdcElW/4dZqfTGAkefI+PCUOLtMsgaw09PsoMjKLA==
X-Received: by 10.194.60.44 with SMTP id e12mr20909053wjr.137.1455616057207;
        Tue, 16 Feb 2016 01:47:37 -0800 (PST)
Received: from localhost (host161-107-dynamic.2-87-r.retail.telecomitalia.it. [87.2.107.161])
        by smtp.gmail.com with ESMTPSA id w17sm19662727wmw.5.2016.02.16.01.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 01:47:35 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
In-Reply-To: <1455616072-20838-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286334>

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
