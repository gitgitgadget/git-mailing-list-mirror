From: Ryan Cumming <etaoins@gmail.com>
Subject: [PATCH] Teach git-completion about git p4
Date: Fri, 21 Sep 2012 14:51:11 -0700
Message-ID: <1348264271-99395-1-git-send-email-rcumming@ea.com>
Cc: Ryan Cumming <etaoins@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 21 23:51:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFB8c-0006f0-Kb
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 23:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab2IUVvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 17:51:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36458 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab2IUVvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 17:51:44 -0400
Received: by pbbrr4 with SMTP id rr4so3485123pbb.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 14:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ShmWAS5xAgzVaClgwBcfo7x+vQRUEExYGzHUAxttie8=;
        b=w48suO4/Iqned4Psc1vW4wmDtkz9x6xV7W9iKDn2dtZeReV7vsBdrhlJWosJcQoPr9
         xdrMD9sufrf69XUmDAcZ7CG7S7eLTBIEPTog3r4pRioU2ees8Jk172LNjsh5qQXr+B96
         RAqNVh86c7pgkZnlzF2UKuXRF2uK6Fl7Z+hJim6JoJeoc5L2PWHP8L6TN9xcaB9Tw4fi
         WzXN42idVenlne5kW8p4Vkk2rBOBx0l+7zE/+TCvPaRcDu7syWE4uHgBiRF2SzchM69L
         iRKJrHcfwWHDAwJlo3vrGx5TH9OLFXnN7PkC7sLzGpnYTqZY49gPPO/yb+7yOo70QOMv
         mUOw==
Received: by 10.66.75.104 with SMTP id b8mr16291985paw.21.1348264303826;
        Fri, 21 Sep 2012 14:51:43 -0700 (PDT)
Received: from Ready. ([74.198.151.54])
        by mx.google.com with ESMTPS id wn1sm5665269pbc.57.2012.09.21.14.51.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Sep 2012 14:51:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206172>

From: Ryan Cumming <etaoins@gmail.com>

git p4 was moved out of contrib in 1.7.11 but it git-completion didn't
know about it. Add git p4 completion based on the existing SVN
completion. It covers all known subcommands and options except for the
-/ option for clone which doesn't use the standard -- prefix.

Signed-off-by: Ryan Cumming <etaoins@gmail.com>
---
 contrib/completion/git-completion.bash | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c48cd19..c6140be 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1459,6 +1459,50 @@ _git_notes ()
 	esac
 }
 
+_git_p4 ()
+{
+	local subcommands="
+		clone sync rebase submit
+		"
+	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
+	else
+		local common_opts="--git-dir= --verbose"
+		local sync_opts="
+			--branch= --detect-branches --changes-file=
+			--silent --detect-labels --import-labels
+			--import-local --max-changes= --keep-path
+			--use-client-spec $common_opts
+			"
+		local clone_opts="
+			--destination= --bare $sync_opts
+			"
+		local submit_opts="
+			--origin= -M --preserve-user --export-labels
+			$common_opts
+			"
+
+		case "$subcommand,$cur" in
+		clone,--*)
+			__gitcomp "$clone_opts"
+			;;
+		sync,--*)
+			__gitcomp "$sync_opts"
+			;;
+		rebase,--*)
+			__gitcomp "$common_opts --import-labels"
+			;;
+		submit,--*)
+			__gitcomp "$submit_opts"
+			;;
+		submit,*)
+			__gitcomp "$(__git_refs)"
+			;;
+		esac
+	fi
+}
+
 _git_pull ()
 {
 	__git_complete_strategy && return
-- 
1.7.12.1
