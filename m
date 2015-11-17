From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 2/2] completion: add support for completing email aliases
Date: Mon, 16 Nov 2015 16:29:26 -0800
Message-ID: <1447720166-9941-2-git-send-email-jacob.e.keller@intel.com>
References: <1447720166-9941-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 01:29:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyU9X-0002Kd-60
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 01:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbbKQA3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 19:29:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:20202 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbbKQA32 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 19:29:28 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 16 Nov 2015 16:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,305,1444719600"; 
   d="scan'208";a="840117989"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2015 16:29:27 -0800
X-Mailer: git-send-email 2.6.3.491.g3e3f6ce
In-Reply-To: <1447720166-9941-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281374>

From: Jacob Keller <jacob.keller@gmail.com>

Using the new --dump-alias-names option from git-send-email, add completion
for --to, --cc, and --bcc with the available configured aliases.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

Notes:
    - v2
    * Use git-send-email for parsing instead of re-implementing it in awk
    
    - v3
    * update for change to git-send-email
    * add support for "--from"

 contrib/completion/git-completion.bash | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 482ca84b451b..1de8c0e6fc96 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -10,6 +10,7 @@
 #    *) local and remote tag names
 #    *) .git/remotes file names
 #    *) git 'subcommands'
+#    *) git email aliases for git-send-email
 #    *) tree paths within 'ref:path/to/file' expressions
 #    *) file paths within current working directory and index
 #    *) common --long-options
@@ -1709,8 +1710,25 @@ _git_reflog ()
 __git_send_email_confirm_options="always never auto cc compose"
 __git_send_email_suppresscc_options="author self cc bodycc sob cccmd body all"
 
+__git_get_email_aliases ()
+{
+	git --git-dir="$(__gitdir)" send-email --dump-aliases 2>/dev/null | while read alias expansion
+	do
+		echo $alias
+	done
+}
+
 _git_send_email ()
 {
+	case "$prev" in
+	--to|--cc|--bcc|--from)
+		__gitcomp "
+		$(__git_get_email_aliases)
+		" "" ""
+		return
+		;;
+	esac
+
 	case "$cur" in
 	--confirm=*)
 		__gitcomp "
@@ -1735,6 +1753,12 @@ _git_send_email ()
 			" "" "${cur##--thread=}"
 		return
 		;;
+	--to=*|--cc=*|--bcc=*|--from=*)
+		__gitcomp "
+		$(__git_get_email_aliases)
+		" "" "${cur#--*=}"
+		return
+		;;
 	--*)
 		__gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
 			--compose --confirm= --dry-run --envelope-sender
-- 
2.6.3.491.g3e3f6ce
