From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] Teach git-submodule to use master's remote when updating subprojects
Date: Sun, 13 Jan 2008 11:27:11 -0500
Message-ID: <1200241631-3300-5-git-send-email-mlevedahl@gmail.com>
References: <478A3284.1000102@gmail.com>
 <1200241631-3300-1-git-send-email-mlevedahl@gmail.com>
 <1200241631-3300-2-git-send-email-mlevedahl@gmail.com>
 <1200241631-3300-3-git-send-email-mlevedahl@gmail.com>
 <1200241631-3300-4-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Sun Jan 13 17:28:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE5h5-0001G5-NH
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 17:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbYAMQ12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 11:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753010AbYAMQ11
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 11:27:27 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:2842 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbYAMQ1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 11:27:22 -0500
Received: by wx-out-0506.google.com with SMTP id h31so976652wxd.4
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 08:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DKPlZS4fCfGTKcGhvbGYNkIWbv8u0AvKs4ADwvhK3fs=;
        b=AF2YnUdyUWWAUr4B7BmMb4z8zMJdxoRXg+TIi5Qe3Q8Lu/FtkiJg2OOLw4T85ka+NQhVfT9cReN7x7aNSL27aYSh7R66kOC7+FD5W2JTfZGORBFhdwjUI4U+D9l9XHgI9mcvPHGqK/rYt53mNjcFBOQEHu5q/tJGOzf2n+TozQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vCWEbDjBdsbdxRSOsGwj97kuxf9hoxujsAazq6lBPdmcfKig35LkGm5MFswmJIZZBVu6PJnkSlYTOUisgTOPQvZTokDCYscCoHEae0rBxvZkc/d4d5cFEgE5FbtfPVe4OylJRVo8EmEQhrU6XzEuVB7ycipAFrYJNnnjayNnE3M=
Received: by 10.70.18.11 with SMTP id 11mr3757913wxr.21.1200241642514;
        Sun, 13 Jan 2008 08:27:22 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id i18sm8324960wxd.0.2008.01.13.08.27.21
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 08:27:21 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc3.14.gc50f
In-Reply-To: <1200241631-3300-4-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70394>

Modules that are defined using relative urls to the master project are
assumed to be completely owned by the project. When running
"submodule update" from the top level, it is reasonable that the entire
project exists at the current master's remote. Using the
branch.$name.remote machinery, this remote can be different for each
branch and can be different than the current defaults in each submodule.

This teaches submodule to:

1) Possibly define the current master's remote in each submodule, using
the same relative url used by submodule init.
2) Fetch each submodule's updates from the master's remote.

Submodules defined using absolute urls (not relative to the parent) are
not touched by this logic. These modules are assumed to be independent
of the master project so submodule can do no better than to fetch from
their currently defined default remotes as already done.


Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-submodule.sh |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 42be4b9..5b4b16f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -209,11 +209,14 @@ modules_init()
 
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
+# For owned submodules (defined using relative url), we use master project's remote
+# and define that in each submodule if not already there
 #
 # $@ = requested paths (default to all)
 #
 modules_update()
 {
+	master_remote=$(get_default_remote)
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
@@ -240,9 +243,24 @@ modules_update()
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
+			(unset GIT_DIR; cd "$path" && git-fetch "$fetch_remote" &&
 				git-checkout -q "$sha1") ||
 			die "Unable to checkout '$sha1' in submodule path '$path'"
 
-- 
1.5.4.rc3.14.gc50f
