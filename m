From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 5/6] pull: add merge-ff-only option
Date: Tue, 29 Apr 2014 06:17:05 -0500
Message-ID: <1398770226-9686-6-git-send-email-felipe.contreras@gmail.com>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 13:28:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf6Cs-0004pG-OF
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 13:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933914AbaD2L2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 07:28:03 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:51855 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933909AbaD2L2B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 07:28:01 -0400
Received: by mail-yk0-f181.google.com with SMTP id q200so39536ykb.26
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 04:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UzvJsDepImRU5j1cLemplxMFirujSaiSth99CjsLSzk=;
        b=vPhCIqmm2kRm88xJnAD4y37aaLzujJXEJrcosBqzbIInuElys01QZerX8KN7BGWPtl
         2o9P/1J+acLlUEjLLnXhq28XWrDFl9AsjCvriNsck7x6hChUzXkRLCk2aBQjLHqDT63z
         nHo23mZoE16GpER1ujn4GioRk3+OYRxj4G8xrEvKJLaCe2B1X9CB0gZV/lD47rFo8eyR
         /skeIUCW8nK20BqDdQoVSgRALH20lsN6wWDySjMNy602lhd9iiOJWldMyGRFuWRuBqp7
         SotrL4uc1pjc23yP+CJTI7HgXYD5tLIBRaFVCR7qSl7dqfKVd2OXQrRx57pv9TdxP9kP
         a8aw==
X-Received: by 10.236.90.225 with SMTP id e61mr44912318yhf.15.1398770881255;
        Tue, 29 Apr 2014 04:28:01 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id m23sm36138466yho.15.2014.04.29.04.27.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 04:28:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247572>

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

Later on this mode can be enabled by default (e.g. in v2.0).

For the full discussion you can read:

http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=225305

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt |  7 +++++--
 git-pull.sh              | 15 ++++++++++++++-
 t/t5520-pull.sh          | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5978d35..4ebd3b5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1884,8 +1884,11 @@ pretty.<name>::
 pull.mode::
 	When "git pull" is run, this determines if it would either merge or
 	rebase the fetched branch. The possible values are 'merge',
-	'rebase', and 'rebase-preserve'. See "branch.<name>.pullmode" for doing
-	this in a non branch-specific manner.
+	'rebase', 'merge-ff-only,' and 'rebase-preserve'.
+	If 'merge-ff-only' is specified, the merge will only succeed if it's
+	fast-forward.
+	See "branch.<name>.pullmode" for doing this in a non branch-specific
+	manner.
 +
 	When 'rebase-preserve', also pass `--preserve-merges` along to
 	'git rebase' so that locally committed merge commits will not be
diff --git a/git-pull.sh b/git-pull.sh
index 26e4e55..946cbbe 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -57,7 +57,7 @@ then
 	mode=$(git config pull.mode)
 fi
 case "$mode" in
-merge|rebase|'')
+merge|rebase|merge-ff-only|'')
 	;;
 rebase-preserve)
 	mode="rebase"
@@ -83,6 +83,7 @@ then
 		warn "$(gettext "Please use pull.mode and branch.<name>.pullmode instead.")"
 	fi
 fi
+test -z "$mode" && mode=merge
 dry_run=
 while :
 do
@@ -318,6 +319,18 @@ case "$merge_head" in
 		die "$(gettext "Cannot rebase onto multiple branches")"
 	fi
 	;;
+*)
+	# check if a non-fast-foward merge would be needed
+	merge_head=${merge_head% }
+	if test "$mode" = merge-ff-only -a -z "$no_ff$ff_only${squash#--no-squash}" &&
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
index 01ad17a..2e2b476 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -365,4 +365,40 @@ test_expect_success 'git pull --rebase against local branch' '
 	test file = "$(cat file2)"
 '
 
+test_expect_success 'git pull fast-forward' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.mode merge-ff-only &&
+	git checkout -b other master &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull
+'
+
+test_expect_success 'git pull non-fast-forward' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.mode merge-ff-only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	test_must_fail git pull
+'
+
+test_expect_success 'git pull non-fast-forward (merge)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.mode merge-ff-only &&
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
1.9.2+fc1.3.gade8541
