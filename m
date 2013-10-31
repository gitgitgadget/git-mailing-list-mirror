From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 00/10] transport-helper: updates
Date: Thu, 31 Oct 2013 03:36:28 -0600
Message-ID: <1383212197-14259-2-git-send-email-felipe.contreras@gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:43:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbomt-0003nt-I3
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789Ab3JaJnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:43:24 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:58918 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab3JaJnV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:43:21 -0400
Received: by mail-ob0-f176.google.com with SMTP id uy5so2763015obc.35
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x7LLkLcbGKIHmgkBn4OEsqNhEHI4ZJDEDnGEXHbSVXY=;
        b=qS6qas5a/08Z9q4sCSdxUOlmLbKON15jtbPxhA6noiF4UYjqtBcg7ht8Fd+YITBwkU
         0jmICMbfM0ytJklLjTPV3lqXvoChQC2Iq/75ocZ+G8L9A6Y9ftsfW3JsYzWEtNXGZND6
         8f4XSeXSDUxqZBcFyGLE6xlJ7Job+6gYkkUpT5U1dxqN4C4nVSqqIjEHwSkPM/TNy5Tu
         gm25pr6YPciaUMpWHR7Z/BmJWGIuxhSJibtt1l1q1fGhMbO+7+dAa5pfFsTVhfAu5xHp
         pXX3Id7neiJvbpI5XWnfUBW/243Mv/Un66utIS89KYJfAfYaN9yhSxS1TaatvUzlt91H
         hGhA==
X-Received: by 10.182.113.195 with SMTP id ja3mr1931265obb.46.1383212600961;
        Thu, 31 Oct 2013 02:43:20 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm4494234obg.13.2013.10.31.02.43.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:43:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237105>

Hi,

Here are the patches that allow transport helpers to be completely transparent;
renaming branches, deleting them, custom refspecs, --force, --dry-run,
reporting forced update, everything works.

Some of these were were sent before and rejected without a reason, but here
they are again in case anybody is interested.

Diff from v3:

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index f1f4ca9..e75699c 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -437,6 +437,10 @@ set by Git if the remote helper has the 'option' capability.
 'option check-connectivity' \{'true'|'false'\}::
 	Request the helper to check connectivity of a clone.
 
+'option force' \{'true'|'false'\}::
+	Request the helper to perform a force update.  Defaults to
+	'false'.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index 6d2f282..716aa4c 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -39,6 +39,7 @@ do
 		fi
 		test -n "$GIT_REMOTE_TESTGIT_SIGNED_TAGS" && echo "signed-tags"
 		test -n "$GIT_REMOTE_TESTGIT_NO_PRIVATE_UPDATE" && echo "no-private-update"
+		echo 'option'
 		echo
 		;;
 	list)
@@ -93,6 +94,7 @@ do
 		before=$(git for-each-ref --format=' %(refname) %(objectname) ')
 
 		git fast-import \
+			${force:+--force} \
 			${testgitmarks:+"--import-marks=$testgitmarks"} \
 			${testgitmarks:+"--export-marks=$testgitmarks"} \
 			--quiet
@@ -115,6 +117,20 @@ do
 
 		echo
 		;;
+	option\ *)
+		read cmd opt val <<-EOF
+		$line
+		EOF
+		case $opt in
+		force)
+			test $val = "true" && force="true" || force=
+			echo "ok"
+			;;
+		*)
+			echo "unsupported"
+			;;
+		esac
+		;;
 	'')
 		exit
 		;;
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index be543c0..c667965 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -102,6 +102,19 @@ test_expect_success 'push delete branch' '
 	 rev-parse --verify refs/heads/new-name
 '
 
+test_expect_success 'forced push' '
+	(cd local &&
+	git checkout -b force-test &&
+	echo content >> file &&
+	git commit -a -m eight &&
+	git push origin force-test &&
+	echo content >> file &&
+	git commit -a --amend -m eight-modified &&
+	git push --force origin force-test
+	) &&
+	compare_refs local refs/heads/force-test server refs/heads/force-test
+'
+
 test_expect_success 'cloning without refspec' '
 	GIT_REMOTE_TESTGIT_REFSPEC="" \
 	git clone "testgit::${PWD}/server" local2 2>error &&

Felipe Contreras (10):
  transport-helper: fix extra lines
  transport-helper: don't update refs in dry-run
  transport-helper: add 'force' to 'export' helpers
  transport-helper: check for 'forced update' message
  fast-export: improve argument parsing
  fast-export: add new --refspec option
  transport-helper: add support for old:new refspec
  fast-import: add support to delete refs
  fast-export: add support to delete refs
  transport-helper: add support to delete branches

 Documentation/git-fast-export.txt   |  4 ++++
 Documentation/git-fast-import.txt   |  3 +++
 Documentation/gitremote-helpers.txt |  4 ++++
 builtin/fast-export.c               | 47 ++++++++++++++++++++++++++++++++++++-
 fast-import.c                       | 13 +++++++---
 git-remote-testgit.sh               | 16 +++++++++++++
 t/t5801-remote-helpers.sh           | 23 +++++++++++++++++-
 t/t9300-fast-import.sh              | 18 ++++++++++++++
 t/t9350-fast-export.sh              | 18 ++++++++++++++
 transport-helper.c                  | 47 +++++++++++++++++++++++++------------
 10 files changed, 173 insertions(+), 20 deletions(-)

-- 
1.8.4.2+fc1
