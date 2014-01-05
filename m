From: Francesco Pretto <ceztko@gmail.com>
Subject: [PATCH 1/2] git-submodule.sh: Support 'checkout' as a valid update command
Date: Sun,  5 Jan 2014 03:50:48 +0100
Message-ID: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
Cc: Francesco Pretto <ceztko@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 05 03:52:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzdpJ-00036Z-FW
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 03:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbaAECwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jan 2014 21:52:08 -0500
Received: from mail-ea0-f181.google.com ([209.85.215.181]:37156 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaAECwH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jan 2014 21:52:07 -0500
Received: by mail-ea0-f181.google.com with SMTP id m10so7332283eaj.40
        for <git@vger.kernel.org>; Sat, 04 Jan 2014 18:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JRJLXjTWkE+GIH0jy5HhSlFPLBiMEDdep38lywsa/rs=;
        b=BD2/W7OBxf3OxGgyvC6uLWV4ZrVJoTwV0xNgvL4WPtt1HpOAxsNKmyW42sIFfo64fW
         kOx3snEdub0arXRpk6CxY7N1z3EgcBa+iY8TgMjYSeCXF2zNHVfDn6aRHrwTZxaOlNhn
         39Q80y9Q9yYwy44g5Vwce74iXsSA/B0lcH1z/tjaQyr3a6cITyqcFOMAzaQvJEE8TPy/
         smk3Vbzf7KUSJTo70ADO+aIHmy8YN/me8zEptUesQ5Znd5Uo0NlF/dqBPypU5FEP/hs9
         SQWCcMdWFpM5LqazaHodmdLL3BiUKmUQ7LWj0lnFqNyvTC9+OqFDgUFi6lSxXUMmwB6o
         nCMQ==
X-Received: by 10.14.88.134 with SMTP id a6mr80831745eef.5.1388890324770;
        Sat, 04 Jan 2014 18:52:04 -0800 (PST)
Received: from localhost.localdomain (host195-121-static.106-82-b.business.telecomitalia.it. [82.106.121.195])
        by mx.google.com with ESMTPSA id e43sm158387291eep.7.2014.01.04.18.52.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 04 Jan 2014 18:52:03 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.230.g032cd47.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239955>

According to "Documentation/gitmodules.txt", 'checkout' is a valid
'submodule.<name>.update' command. Also "git-submodule.sh" refers to
it and processes it correctly. Reflect commit 'ac1fbb' to support this
syntax and also validates property values during 'update' command,
issuing a warning if the value found is unknwon.
---
 git-submodule.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2677f2e..1d041a7 100755
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
@@ -805,6 +805,18 @@ cmd_update()
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
+				update_module=
+				echo >&2 "warning: invalid update mode for submodule '$name'"
+				;;
+			esac
 		fi
 
 		displaypath=$(relative_path "$prefix$sm_path")
-- 
1.8.5.2.230.g032cd47.dirty
