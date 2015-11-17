From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 2/2] completion: add support for completing email aliases
Date: Tue, 17 Nov 2015 03:45:50 -0800
Message-ID: <1447760750-21287-2-git-send-email-jacob.e.keller@intel.com>
References: <1447760750-21287-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 12:47:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zyej0-0005el-Ox
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 12:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbbKQLq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 06:46:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:57964 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501AbbKQLpy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 06:45:54 -0500
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 17 Nov 2015 03:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,307,1444719600"; 
   d="scan'208";a="852657509"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by orsmga002.jf.intel.com with ESMTP; 17 Nov 2015 03:45:52 -0800
X-Mailer: git-send-email 2.6.3.491.g3e3f6ce
In-Reply-To: <1447760750-21287-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281401>

From: Jacob Keller <jacob.keller@gmail.com>

Using the new --dump-aliases option from git-send-email, add completion
for --to, --cc, --bcc, and --from with the available configured aliases.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

Notes:
    - v2
    * Use git-send-email for parsing instead of re-implementing it in awk
    
    - v3
    * update for change to git-send-email
    * add support for "--from"
    
    - v2
    * reuse parsing from git-send-email via --list-aliases

 contrib/completion/git-completion.bash | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 482ca84b451b..111b05302bc7 100644
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
@@ -1711,6 +1712,15 @@ __git_send_email_suppresscc_options="author self cc bodycc sob cccmd body all"
 
 _git_send_email ()
 {
+	case "$prev" in
+	--to|--cc|--bcc|--from)
+		__gitcomp "
+		$(git --git-dir="$(__gitdir)" send-email --dump-aliases 2>/dev/null)
+		" "" ""
+		return
+		;;
+	esac
+
 	case "$cur" in
 	--confirm=*)
 		__gitcomp "
@@ -1735,6 +1745,12 @@ _git_send_email ()
 			" "" "${cur##--thread=}"
 		return
 		;;
+	--to=*|--cc=*|--bcc=*|--from=*)
+		__gitcomp "
+		$(git --git-dir="$(__gitdir)" send-email --dump-aliases 2>/dev/null)
+		" "" "${cur#--*=}"
+		return
+		;;
 	--*)
 		__gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
 			--compose --confirm= --dry-run --envelope-sender
-- 
2.6.3.491.g3e3f6ce
