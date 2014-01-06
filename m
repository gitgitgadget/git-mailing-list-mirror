From: Francesco Pretto <ceztko@gmail.com>
Subject: [PATCH] git-submodule.sh: Support 'checkout' as a valid update command
Date: Mon,  6 Jan 2014 19:58:46 +0100
Message-ID: <1389034726-8744-1-git-send-email-ceztko@gmail.com>
Cc: Francesco Pretto <ceztko@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 06 19:59:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0FOn-0007n3-Li
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 19:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794AbaAFS7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 13:59:34 -0500
Received: from mail-ea0-f182.google.com ([209.85.215.182]:42451 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755629AbaAFS70 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 13:59:26 -0500
Received: by mail-ea0-f182.google.com with SMTP id a15so8039115eae.41
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 10:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SgRQ5OfTac/s8uLPGPAtf3Miu7ZhT02nR+jF5SfE46g=;
        b=0nCoI50maQUSKYXMsb72BDRso6YToIayybxwXoAk9RiVVwwSNx3uOu7pt3zmy5jVP5
         lMMLF/BzLJ5fCNvJzJs+7rOzl3EyO71QnoCrWmgfJtMJ8XK9XSjPnRk6BAcAbVlLfbNM
         3YwGMNDM3edj24VyXtWI6ORPPBAlcJZBkPpzHov32L3kA20EQN1ffn12iVL3WRGd7m29
         X/FG0SFCs1QifKy1P/FLTmByXyibstLmWQX0sjKrclQF4CbLyw6KMQtaIgkPPT7vCae3
         9UitPYsryEdCEAG3fXzh91U1jO9EWj7Xrx5pcEImkIR1OeOLvzLGy9OIc+GxE6aiv9ox
         vX6g==
X-Received: by 10.14.251.132 with SMTP id b4mr17734748ees.78.1389034764875;
        Mon, 06 Jan 2014 10:59:24 -0800 (PST)
Received: from localhost.localdomain (host195-121-static.106-82-b.business.telecomitalia.it. [82.106.121.195])
        by mx.google.com with ESMTPSA id 1sm173309393eeg.4.2014.01.06.10.59.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 Jan 2014 10:59:23 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.230.g72d9864
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240049>

According to "Documentation/gitmodules.txt", 'checkout' is a valid
'submodule.<name>.update' command. Also "git-submodule.sh" refers to
it and processes it correctly. Reflecting commit 'ac1fbb' to support
this syntax and also validate property values during 'update' command,
issuing an error if the value found is unknown.

Signed-off-by: Francesco Pretto <ceztko@gmail.com>
---
 git-submodule.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2677f2e..4a30087 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -622,7 +622,7 @@ cmd_init()
 		   test -z "$(git config submodule."$name".update)"
 		then
 			case "$upd" in
-			rebase | merge | none)
+			checkout | rebase | merge | none)
 				;; # known modes of updating
 			*)
 				echo >&2 "warning: unknown update mode '$upd' suggested for submodule '$name'"
@@ -805,6 +805,17 @@ cmd_update()
 			update_module=$update
 		else
 			update_module=$(git config submodule."$name".update)
+			case "$update_module" in
+			'')
+				;; # Unset update mode
+			checkout | rebase | merge | none)
+				;; # Known update modes
+			!*)
+				;; # Custom update command
+			*)
+				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
+				;;
+			esac
 		fi
 
 		displaypath=$(relative_path "$prefix$sm_path")
-- 
1.8.5.2.229.g4448466.dirty
