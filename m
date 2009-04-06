From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 05/14] difftool: remove the backup file feature
Date: Mon,  6 Apr 2009 01:31:20 -0700
Message-ID: <1239006689-14695-6-git-send-email-davvid@gmail.com>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com>
 <1239006689-14695-2-git-send-email-davvid@gmail.com>
 <1239006689-14695-3-git-send-email-davvid@gmail.com>
 <1239006689-14695-4-git-send-email-davvid@gmail.com>
 <1239006689-14695-5-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 10:35:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkIG-0002l9-7R
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbZDFIcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbZDFIb7
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:31:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:12597 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbZDFIby (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:31:54 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1642070wah.21
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=c6+IdhF/Y4fR2uTkochDFsoehO9bM4pzRfL7HLvV1k4=;
        b=vzhuoWtmQXsbfsh55glrLBmvi4PnbfUUD/X+xBphlhmdDvJuthYafMSzyR9UfVdWyW
         r5ToR60YduMhYAjSQV0XTLtoQEbWTF6g8MLQZi98GRlcOg2oEHRNwwDjNO/3C2xcKTHu
         +Hbcs0jgfdCiEfCdGjqOhnhYULt40NH4npRLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nzrejoKDYpm1P/1dph6B2sJ9klGMOylgmqrMxuIcJBWuURRQfLL/loypS9aGnz1Ndc
         1fx27pjaE0LiQKPtEdT9ZS1fI+GzqDN5BMnLnHj7lEvlAMKWpQXyJTv/1onZLgO0FlAI
         wMd8RjTYeiEwvKL1k0BDU+nBmSg9OU5jNkvZE=
Received: by 10.114.179.1 with SMTP id b1mr2155420waf.70.1239006713407;
        Mon, 06 Apr 2009 01:31:53 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id d20sm5203945waa.45.2009.04.06.01.31.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 01:31:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239006689-14695-5-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115784>

Most users find the backup file feature annoying and there's no
need for it since diff is supposed to be a read-only operation.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/difftool/git-difftool-helper |   34 +---------------------------------
 1 files changed, 1 insertions(+), 33 deletions(-)

diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
index ef684b6..e74a274 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/contrib/difftool/git-difftool-helper
@@ -9,31 +9,7 @@
 
 # Set GIT_DIFFTOOL_NO_PROMPT to bypass the per-file prompt.
 should_prompt () {
-	! test -n "$GIT_DIFFTOOL_NO_PROMPT"
-}
-
-# Should we keep the backup .orig file?
-keep_backup_mode="$(git config --bool merge.keepBackup || echo true)"
-keep_backup () {
-	test "$keep_backup_mode" = "true"
-}
-
-# This function manages the backup .orig file.
-# A backup $MERGED.orig file is created if changes are detected.
-cleanup_temp_files () {
-	if test -n "$MERGED"; then
-		if keep_backup && test "$MERGED" -nt "$BACKUP"; then
-			test -f "$BACKUP" && mv -- "$BACKUP" "$MERGED.orig"
-		else
-			rm -f -- "$BACKUP"
-		fi
-	fi
-}
-
-# This is called when users Ctrl-C out of git-difftool-helper
-sigint_handler () {
-	cleanup_temp_files
-	exit 1
+	test -z "$GIT_DIFFTOOL_NO_PROMPT"
 }
 
 # This function prepares temporary files and launches the appropriate
@@ -47,12 +23,6 @@ launch_merge_tool () {
 	LOCAL="$2"
 	REMOTE="$3"
 	BASE="$1"
-	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
-	BACKUP="$MERGED.BACKUP.$ext"
-
-	# Create and ensure that we clean up $BACKUP
-	test -f "$MERGED" && cp -- "$MERGED" "$BACKUP"
-	trap sigint_handler INT
 
 	# $LOCAL and $REMOTE are temporary files so prompt
 	# the user with the real $MERGED name before launching $merge_tool.
@@ -120,8 +90,6 @@ launch_merge_tool () {
 		fi
 		;;
 	esac
-
-	cleanup_temp_files
 }
 
 # Verifies that (difftool|mergetool).<tool>.cmd exists
-- 
1.6.2.2.414.g81aa9
