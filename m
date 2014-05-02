From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 5/7] pull: add merge-ff-only option
Date: Thu,  1 May 2014 19:00:06 -0500
Message-ID: <1398988808-29678-6-git-send-email-felipe.contreras@gmail.com>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	"W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 02:11:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg14b-00015g-K5
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 02:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbaEBALQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 20:11:16 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:38521 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbaEBALP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 20:11:15 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so1121530obc.18
        for <git@vger.kernel.org>; Thu, 01 May 2014 17:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lnWKXvKa6aZXLN9PBmIXIpEuFVqZOfDh0/NeYYpWf14=;
        b=Ed70JWdTixsFrN+huiHYbKTAIP7faZMkLQD8eEAwWPdZGji3DeerWtpo9HLU6+9l8v
         17SkldeI0UE9K+8iuamS3s6pWWFPa4tGys7+Og0SeBlCLflgWaNtoHTJ7Xbjc5xzm4eJ
         2DvSyw1ktAPGLFEtfOZvbWWxNB3Btn4UIrZG9Qjm5Y3VqWQ+FiAPWHdBgJCZM4nPx8H1
         ZLoV2Ljreceq05oHFtskcu3VdGsOHjMc9a/8OcAPeEV4IJ6HwH2GM/ev+oejLkZY+cg0
         ZHWCAx+VuSNIJ4Weav2E0FTqgK/akRrTLLn91RfCvtdluOT7xKHLcBmphjm+3F2M/Nj/
         FoEQ==
X-Received: by 10.182.128.36 with SMTP id nl4mr4470062obb.63.1398989475197;
        Thu, 01 May 2014 17:11:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id wy2sm62726512obc.21.2014.05.01.17.11.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 17:11:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.19.g85b6256
In-Reply-To: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247905>

It is very typical for Git newcomers to inadvertently create merges and
worst; inadvertently pushing them. This is one of the reasons many
experienced users prefer to avoid 'git pull', and recommend newcomers to
avoid it as well.

To avoid these problems and keep 'git pull' useful, it has been
suggested that 'git pull' barfs by default if the merge is
non-fast-forward, which unfortunately would break backwards
compatibility.

This patch leaves everything in place to enable this new mode, but it
only gets enabled if the user specifically configures it; pull.mode =
merge-ff-only.

Later on this mode can be enabled by default.

For the full discussion you can read:

http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=225305

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt |  7 +++++--
 git-pull.sh              | 15 ++++++++++++++-
 t/t5520-pull.sh          | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c028aeb..b391ec1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1886,8 +1886,11 @@ pretty.<name>::
 pull.mode::
 	When "git pull" is run, this determines if it would either merge or
 	rebase the fetched branch. The possible values are 'merge',
-	'rebase', and 'rebase-preserve'. See "branch.<name>.pullmode" for doing
-	this in a non branch-specific manner.
+	'rebase', 'ff-only,' and 'rebase-preserve'.
+	If 'ff-only' is specified, the merge will only succeed if it's
+	fast-forward.
+	See "branch.<name>.pullmode" for doing this in a non branch-specific
+	manner.
 +
 	When 'rebase-preserve', also pass `--preserve-merges` along to
 	'git rebase' so that locally committed merge commits will not be
diff --git a/git-pull.sh b/git-pull.sh
index e7e52ec..2446417 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -57,7 +57,7 @@ then
 	mode=$(git config pull.mode)
 fi
 case "$mode" in
-merge|rebase|'')
+merge|rebase|ff-only|'')
 	;;
 rebase-preserve)
 	mode="rebase"
@@ -78,6 +78,7 @@ then
 		rebase=$(bool_or_string_config pull.rebase)
 	fi
 fi
+test -z "$mode" && mode=merge
 dry_run=
 while :
 do
@@ -313,6 +314,18 @@ case "$merge_head" in
 		die "$(gettext "Cannot rebase onto multiple branches")"
 	fi
 	;;
+*)
+	# check if a non-fast-foward merge would be needed
+	merge_head=${merge_head% }
+	if test "$mode" = 'ff-only' && test -z "$no_ff$ff_only${squash#--no-squash}" &&
+		test -n "$orig_head" &&
+		! git merge-base --is-ancestor "$orig_head" "$merge_head" &&
+		! git merge-base --is-ancestor "$merge_head" "$orig_head"
+	then
+		die "$(gettext "The pull was not fast-forward, please either merge or rebase.
+If unsure, run 'git pull --merge'.")"
+	fi
+	;;
 esac
 
 # Pulling into unborn branch: a shorthand for branching off
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 01ad17a..a548c1b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -365,4 +365,40 @@ test_expect_success 'git pull --rebase against local branch' '
 	test file = "$(cat file2)"
 '
 
+test_expect_success 'git pull fast-forward (ff-only)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.mode ff-only &&
+	git checkout -b other master &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull
+'
+
+test_expect_success 'git pull non-fast-forward (ff-only)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.mode ff-only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	test_must_fail git pull
+'
+
+test_expect_success 'git pull non-fast-forward with merge (ff-only)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.mode ff-only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull --merge
+'
+
 test_done
-- 
1.9.2+fc1.19.g85b6256
