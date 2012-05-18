From: Jon Seymour <jon.seymour@gmail.com>
Subject: [RFC] submodule: fix handling of supermodules with relative origin URLs.
Date: Fri, 18 May 2012 22:13:40 +1000
Message-ID: <1337343220-26717-1-git-send-email-jon.seymour@gmail.com>
References: <AH3Anrr6mLVedBPcgfVwy=5KRjUgdp5W8P0DQ3qaX_UjH-npDw@mail.gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 14:13:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVM4E-0000bG-Gl
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 14:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759620Ab2ERMNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 08:13:53 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45398 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755367Ab2ERMNw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 08:13:52 -0400
Received: by pbbrp8 with SMTP id rp8so3874619pbb.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 05:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iGv5UM1FZ8WE0fbN/L37r103dv+o0SMvbgKZybWgWrY=;
        b=O+Xkht9SvvPiwURKz8Rm9qKY178tf21V9CdEmsML7OA0obcWtUDP4/Hs+z/xMXjQUc
         Nx31mMljluVv+8pfvQztGVfWWCSpfNCX+jYmABdATNWuC9oyDFKUU5jMgvt04HzW+QL6
         qCyQ3KNKnkZx0AEnfmapDAqDcKRNkmhT13SQRCErvEdkYEwn4eVbhx/V574fyQNXv48y
         AmTF4rgpa97WLO6Bji+fBmXXJxVxRaUqh+EfJJzD1twQousoleTRpWjc0x6EUjoYTQT7
         k3KGr4/4lZ+SkyLLz+QbTXoxdmFro7hvliHkTW99YGSKTIZrjMJDGdwdnlCXm6yB4U6K
         jTAw==
Received: by 10.68.218.72 with SMTP id pe8mr38283088pbc.45.1337343231760;
        Fri, 18 May 2012 05:13:51 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id qu6sm6082807pbc.36.2012.05.18.05.13.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 05:13:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.647.g63fe035.dirty
In-Reply-To: <AH3Anrr6mLVedBPcgfVwy=5KRjUgdp5W8P0DQ3qaX_UjH-npDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197949>

Prior to this change, operations such as git submodule sync produces
the wrong result when the origin URL of the super module
is itself a relative URL.

The issue arises because in this case, the origin URL of the supermodule
needs to be prepended with a prefix that navigates from the submodule to
the supermodule.

This change adds that prefix.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

If people are ok with the fix, I'll roll this as a patch together
with some tests.

diff --git a/git-submodule.sh b/git-submodule.sh
index 64a70d6..5008867 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -37,7 +37,8 @@ resolve_relative_url ()
 	remoteurl=$(git config "remote.$remote.url") ||
 		remoteurl=$(pwd) # the repository is its own authoritative upstream
 	url="$1"
-	remoteurl=${remoteurl%/}
+	up_path="$(echo "$2" | sed "s/[^/]*/../g")"
+	remoteurl=${remoteurl%/*}
 	sep=/
 	while test -n "$url"
 	do
@@ -45,6 +46,9 @@ resolve_relative_url ()
 		../*)
 			url="${url#../}"
 			case "$remoteurl" in
+			.*/*)
+				remoteurl="${up_path%/}/${remoteurl%/*}"
+				;;
 			*/*)
 				remoteurl="${remoteurl%/*}"
 				;;
@@ -235,11 +239,24 @@ cmd_add()
 		usage
 	fi
 
+	# normalize path:
+	# multiple //; leading ./; /./; /../; trailing /
+	sm_path=$(printf '%s/\n' "$sm_path" |
+		sed -e '
+			s|//*|/|g
+			s|^\(\./\)*||
+			s|/\./|/|g
+			:start
+			s|\([^/]*\)/\.\./||
+			tstart
+			s|/*$||
+		')
+
 	# assure repo is absolute or relative to parent
 	case "$repo" in
 	./*|../*)
 		# dereference source url relative to parent's url
-		realrepo=$(resolve_relative_url "$repo") || exit
+		realrepo=$(resolve_relative_url "$repo" "$sm_path") || exit
 		;;
 	*:*|/*)
 		# absolute url
@@ -250,18 +267,6 @@ cmd_add()
 	;;
 	esac
 
-	# normalize path:
-	# multiple //; leading ./; /./; /../; trailing /
-	sm_path=$(printf '%s/\n' "$sm_path" |
-		sed -e '
-			s|//*|/|g
-			s|^\(\./\)*||
-			s|/\./|/|g
-			:start
-			s|\([^/]*\)/\.\./||
-			tstart
-			s|/*$||
-		')
 	git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
 	die "$(eval_gettext "'\$sm_path' already exists in the index")"
 
@@ -401,13 +406,14 @@ cmd_init()
 		if test -z "$(git config "submodule.$name.url")"
 		then
 			url=$(git config -f .gitmodules submodule."$name".url)
+			sm_path=$(git config -f .gitmodules submodule."$name".path)
 			test -z "$url" &&
 			die "$(eval_gettext "No url found for submodule path '\$sm_path' in .gitmodules")"
 
 			# Possibly a url relative to parent
 			case "$url" in
 			./*|../*)
-				url=$(resolve_relative_url "$url") || exit
+				url=$(resolve_relative_url "$url" "$sm_path") || exit
 				;;
 			esac
 			git config submodule."$name".url "$url" ||
@@ -960,11 +966,12 @@ cmd_sync()
 	do
 		name=$(module_name "$sm_path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
+		sm_path=$(git config -f .gitmodules --get submodule."$name".path)
 
 		# Possibly a url relative to parent
 		case "$url" in
 		./*|../*)
-			url=$(resolve_relative_url "$url") || exit
+			url=$(resolve_relative_url "$url" "$sm_path") || exit
 			;;
 		esac
 
-- 
1.7.10.2.647.g63fe035.dirty
