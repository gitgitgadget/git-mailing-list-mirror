From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 2/2] completion: add support for completing email aliases
Date: Thu, 19 Nov 2015 14:52:12 -0800
Message-ID: <1447973532-21666-2-git-send-email-jacob.e.keller@intel.com>
References: <1447973532-21666-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 23:52:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzY41-0003dw-Vj
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 23:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbbKSWwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 17:52:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:58582 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030192AbbKSWwV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 17:52:21 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 19 Nov 2015 14:52:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,319,1444719600"; 
   d="scan'208";a="824518589"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by orsmga001.jf.intel.com with ESMTP; 19 Nov 2015 14:52:20 -0800
X-Mailer: git-send-email 2.6.3.491.g3e3f6ce
In-Reply-To: <1447973532-21666-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281494>

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
