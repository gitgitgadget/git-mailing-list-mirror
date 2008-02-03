From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 5/7] Teach git-submodule to use top-level remote when updating subprojects
Date: Sun,  3 Feb 2008 12:31:05 -0500
Message-ID: <1202059867-1184-6-git-send-email-mlevedahl@gmail.com>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-2-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-3-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-4-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-5-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 03 18:32:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLihk-0000tY-Au
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 18:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758246AbYBCRba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 12:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758005AbYBCRba
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 12:31:30 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:37993 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757540AbYBCRb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 12:31:29 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1719736fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 09:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=y+Ja7A2s3sAhbe3dLyWsJwzxKpZuwk8Yu29dGOjy8II=;
        b=Ov/S8DyFxuz5Vy55mAfMubNkEh/Aa3SLApxtHMsG9jwMXICJuAWqAIgL8r/wKqgZwrAMgfNnObREehs/igtxFVpflOcD+6lkooUIipPhvpmci8qx5DBQPttjAitzaB5mqSiUkSmsQCbj1Wo0JN9re33WjaNh2loF0ZkRQF7Nn/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PgZ7EnB8OdCVoxzB5VDVoOER+o3J6aEn05xDiV9oRuvcm6H7iXpIZUoo2E4VeX9Tewl0WAypUYojh5q2hSZDarXXLosHwxYWbW7iAqQcEgQjtsC0nokxmbnogOnRNOGr9cVgvT3nbVlnp4yEYy/9CwaE4rV8VPVuPiPK3fNIjSA=
Received: by 10.86.84.5 with SMTP id h5mr5654279fgb.53.1202059888526;
        Sun, 03 Feb 2008 09:31:28 -0800 (PST)
Received: from localhost.localdomain ( [71.191.242.88])
        by mx.google.com with ESMTPS id l19sm8463628fgb.0.2008.02.03.09.31.25
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 09:31:27 -0800 (PST)
X-Mailer: git-send-email 1.5.4.18.g43c18
In-Reply-To: <1202059867-1184-5-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72380>

Modules that are defined using relative urls to the master project are
assumed to be completely owned by the project. When running
"submodule update" from the top level, it is reasonable that the entire
project exists at the remote given by top-level branch.<name>.remote.
Using the remote machinery, this remote can be different for each
branch and can be different than the current defaults in each submodule.

This teaches submodule to:

1) Possibly define the current master's remote in each submodule, using
the same relative url used by submodule init.
2) Fetch each submodule's updates from the master's remote.

Submodules defined using absolute urls (not relative to the parent) are
not touched by this logic. Such modules are assumed to be independent
of the master project so submodule can do no better than to fetch from
their currently defined default remotes as already done.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-submodule.sh |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bb0d265..8f31ebe 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -255,6 +255,8 @@ cmd_init()
 
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
+# For owned submodules (defined using relative url), we use master project's remote
+# and define that in each submodule if not already there
 #
 # $@ = requested paths (default to all)
 #
@@ -281,6 +283,7 @@ cmd_update()
 		shift
 	done
 
+	master_remote=$(get_default_remote)
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
@@ -306,9 +309,24 @@ cmd_update()
 			die "Unable to find current revision in submodule path '$path'"
 		fi
 
+		baseurl="$(GIT_CONFIG=.gitmodules git config submodule."$name".url)"
+		case "$baseurl" in
+		./*|../*)
+			fetch_remote=$master_remote
+			(unset GIT_DIR ; cd "$path" && git config remote."$fetch_remote".url > nul) ||
+			(
+				absurl="$(resolve_relative_url $baseurl)"
+				unset GIT_DIR; cd "$path" && git remote add "$master_remote" "$absurl"
+			) || die "Unable to define remote '$fetch_remote' in submodule path '$path'"
+			;;
+		*)
+			fetch_remote=
+			;;
+		esac
+
 		if test "$subsha1" != "$sha1"
 		then
-			(unset GIT_DIR; cd "$path" && git-fetch &&
+			(unset GIT_DIR; cd "$path" && git-fetch $fetch_remote &&
 				git-checkout -q "$sha1") ||
 			die "Unable to checkout '$sha1' in submodule path '$path'"
 
-- 
1.5.4.18.g43c18
