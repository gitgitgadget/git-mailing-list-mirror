From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 6/7] warn on "git pull" without a given branch.<name>.remote value
Date: Mon, 28 Apr 2008 11:32:17 -0400
Message-ID: <22f5914b1ffff814fa2387ff5cb762e0099aaa6b.1209391615.git.bonzini@gnu.org>
References: <4812DA50.3000702@gnu.org>
 <cover.1209391614.git.bonzini@gnu.org>
 <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org>
 <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org>
 <65b938da49b447129297d4dbf20191be52d16670.1209391614.git.bonzini@gnu.org>
 <d941a7a16cb7d5529b22a47f1dc7b986ba66ee56.1209391615.git.bonzini@gnu.org>
 <b5b9b866e5f942d024831d528ae599e3e6ce31da.1209391615.git.bonzini@gnu.org>
Cc: spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 17:35:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqVMh-0004Kp-GY
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 17:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934826AbYD1Pck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 11:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935673AbYD1Pci
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 11:32:38 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60627 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935625AbYD1Pcf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 11:32:35 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JqVL0-0004fF-Rg; Mon, 28 Apr 2008 11:32:18 -0400
X-Mailer: git-send-email 1.5.5.1.89.g36c79d
In-Reply-To: <b5b9b866e5f942d024831d528ae599e3e6ce31da.1209391615.git.bonzini@gnu.org>
In-Reply-To: <cover.1209391614.git.bonzini@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80546>

This patch deprecates the behavior of "git pull" without a
branch.<name>.remote value in the configuration.  The value
"origin" will be used, but a warning will be printed too.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/git-pull.txt |    9 +++++----
 git-parse-remote.sh        |    8 ++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

	In this case, I think we can warn because branch.*.remote
	lines are created by checkouts made with 1.5 or later.

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 3405ca0..18898f6 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -58,10 +58,11 @@ DEFAULT BEHAVIOUR
 -----------------
 
 Often people use `git pull` without giving any parameter.
-Traditionally, this has been equivalent to saying `git pull
-origin`.  However, when configuration `branch.<name>.remote` is
-present while on branch `<name>`, that value is used instead of
-`origin`.
+While on branch `<name>`, this will use the value of configuration
+`branch.<name>.remote` as the branch to pull from.  If the
+value is not present, it will be implicitly considered to be
+`origin`; however, this is deprecated and you consider
+writing the value explicitly in the configuration file.
 
 In order to determine what URL to use to fetch from, the value
 of the configuration `remote.<origin>.url` is consulted
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 695a409..eddb593 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -54,9 +54,17 @@ get_remote_url () {
 	esac
 }
 
+warned_about_default_remote=no
 get_default_remote () {
 	curr_branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
 	origin=$(git config --get "branch.$curr_branch.remote")
+	if test -z "$origin" && test "$warned_about_default_remote" = no; then
+	        echo "warning: you asked me to pull without telling me which repository"
+	        echo "warning: you want to pull from, and 'branch.${curr_branch}.remote'"
+	        echo "warning: in your configuration file does not tell me either."
+	        echo "warning: proceeding with 'origin'."
+		warned_about_default_remote=yes
+	fi
 	echo ${origin:-origin}
 }
 
-- 
1.5.5
