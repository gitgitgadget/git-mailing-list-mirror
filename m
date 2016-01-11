From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/3] t7810: correct --no-index test
Date: Mon, 11 Jan 2016 18:00:46 +0100
Message-ID: <1452531648-16575-2-git-send-email-t.gummerer@gmail.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
 <1452531648-16575-1-git-send-email-t.gummerer@gmail.com>
Cc: pclouds@gmail.com, sunshine@sunshineco.com, gitster@pobox.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 18:00:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIfpm-0001OJ-DZ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933137AbcAKRAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:00:41 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36327 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbcAKRAk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:00:40 -0500
Received: by mail-wm0-f66.google.com with SMTP id l65so27142506wmf.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 09:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YxRNg2J22MNoOdb2D1jUa860d0qwZbUZdovHnKcqz4I=;
        b=OAZDhe1m9zlKdAxGEDB1hvUhC/b7LgxXeCiDg5bXkBcyeuNLYUwj7lRMvM5Mb5nopc
         oLbNVIppFNyOF0CDyn0+GcJG+R/aF8F/ydJAXzX4BUTuL8Hyf6ezKOej2AZ9ZPOz+CE5
         SbTKn4uwxG4Z3aFW8Ln6LEvL/V23yIXFtRZoJ/0NWXy6m8oHCnSI9L7hMLAj/CnOxvP7
         vWn2MYamQQ89syilpZiVQ/fqBoO5CY+dohJ00ejy2KpV1+XhGi/jFCr4fs1JtJlloLY/
         MUnRN8DA6641lgqx7J6v5xkIrUv/+nHT9UqxPTSYwS8W6sjRdI/j3M3eJUTHkvnFJon3
         ANGQ==
X-Received: by 10.194.117.5 with SMTP id ka5mr119792776wjb.20.1452531638127;
        Mon, 11 Jan 2016 09:00:38 -0800 (PST)
Received: from localhost (host143-106-dynamic.248-95-r.retail.telecomitalia.it. [95.248.106.143])
        by smtp.gmail.com with ESMTPSA id i196sm13603054wmf.23.2016.01.11.09.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 09:00:36 -0800 (PST)
X-Mailer: git-send-email 2.6.0.rc0.160.g9ddbed8
In-Reply-To: <1452531648-16575-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283671>

GIT_CEILING_DIRECTORIES doesn't prevent chdir up into another directory
while looking for a repository directory if it is equal to the current
directory.  Because of this, the test which claims to test the git grep
--no-index command outside of a repository actually tests it inside of a
repository.  The test_must_fail assertions still pass because the git
grep only looks at untracked files and therefore no file matches, but
not because it's run outside of a repository as it was originally
intended.

Set the GIT_CEILING_DIRECTORIES environment variable to the parent
directory of the directory in which the git grep command is executed, to
make sure it is actually run outside of a git repository.

In addition the && chain was broken in a couple of places, fix that.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t7810-grep.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 028ffe4..cc4b97d 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -791,12 +791,12 @@ test_expect_success 'outside of git repository' '
 	} >non/expect.full &&
 	echo file2:world >non/expect.sub &&
 	(
-		GIT_CEILING_DIRECTORIES="$(pwd)/non/git" &&
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
 		test_must_fail git grep o &&
 		git grep --no-index o >../actual.full &&
-		test_cmp ../expect.full ../actual.full
+		test_cmp ../expect.full ../actual.full &&
 		cd sub &&
 		test_must_fail git grep o &&
 		git grep --no-index o >../../actual.sub &&
@@ -805,7 +805,7 @@ test_expect_success 'outside of git repository' '
 
 	echo ".*o*" >non/git/.gitignore &&
 	(
-		GIT_CEILING_DIRECTORIES="$(pwd)/non/git" &&
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
 		test_must_fail git grep o &&
@@ -813,7 +813,7 @@ test_expect_success 'outside of git repository' '
 		test_cmp ../expect.full ../actual.full &&
 
 		{
-			echo ".gitignore:.*o*"
+			echo ".gitignore:.*o*" &&
 			cat ../expect.full
 		} >../expect.with.ignored &&
 		git grep --no-index --no-exclude o >../actual.full &&
-- 
2.7.0.3.g214d8d0.dirty
