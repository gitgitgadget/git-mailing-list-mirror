From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] make git-filter-branch use parse-options.
Date: Thu, 30 Oct 2008 17:18:57 +0100
Message-ID: <1225383538-23666-2-git-send-email-madcoder@debian.org>
References: <20081030132623.GC24098@artemis.corp>
 <1225383538-23666-1-git-send-email-madcoder@debian.org>
Cc: pasky@suse.cz, srabbelier@gmail.com,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 17:20:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvaG8-0005xS-Gg
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 17:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757076AbYJ3QTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 12:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756814AbYJ3QTJ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 12:19:09 -0400
Received: from pan.madism.org ([88.191.52.104]:39189 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755321AbYJ3QTC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 12:19:02 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 0411E3B411;
	Thu, 30 Oct 2008 17:18:59 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6BA6E5EE23C; Thu, 30 Oct 2008 17:18:58 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.758.gc29b0
In-Reply-To: <1225383538-23666-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99492>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-filter-branch.sh |   93 +++++++++++++++++++++-----------------------------
 1 files changed, 39 insertions(+), 54 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 81392ad..8af3126 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -87,14 +87,26 @@ set_ident () {
 	echo "case \"\$GIT_${uid}_NAME\" in \"\") GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\" && export GIT_${uid}_NAME;; esac"
 }
 
-USAGE="[--env-filter <command>] [--tree-filter <command>] \
-[--index-filter <command>] [--parent-filter <command>] \
-[--msg-filter <command>] [--commit-filter <command>] \
-[--tag-name-filter <command>] [--subdirectory-filter <directory>] \
-[--original <namespace>] [-d <directory>] [-f | --force] \
-[<rev-list options>...]"
-
-OPTIONS_SPEC=
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git filter-branch [options] [<rev-list options>...]
+--
+d=                      temporary path to use for rewriting
+f,force                 force filter-branch to run
+subdirectory-filter=    only look at the history touching that specific subdirectory
+original=               namespace where the original commits will be stored (default: refs/original)
+
+ Filters that you can run:
+
+env-filter=             environment filter to run
+tree-filter=            tree rewriting filter to run
+index-filter=           index rewriting filter to run
+parent-filter=          parent rewriting filter to run
+msg-filter=             commit message rewriting filter to run
+commit-filter=          commit rewriting filter to run
+tag-name-filter=        tag name rewriting filter to run
+"
+
 . git-sh-setup
 
 if [ "$(is_bare_repository)" = false ]; then
@@ -117,63 +129,36 @@ force=
 while :
 do
 	case "$1" in
-	--)
-		shift
-		break
-		;;
 	--force|-f)
-		shift
-		force=t
-		continue
-		;;
-	-*)
-		;;
-	*)
-		break;
-	esac
-
-	# all switches take one argument
-	ARG="$1"
-	case "$#" in 1) usage ;; esac
-	shift
-	OPTARG="$1"
-	shift
-
-	case "$ARG" in
+		force=t;;
 	-d)
-		tempdir="$OPTARG"
-		;;
+		tempdir="$2"; shift;;
+	--subdirectory-filter)
+		filter_subdir="$2"; shift;;
+	--original)
+		orig_namespace=$(expr "$2/" : '\(.*[^/]\)/*$')/
+		shift;;
+
 	--env-filter)
-		filter_env="$OPTARG"
-		;;
+		filter_env="$2"; shift;;
 	--tree-filter)
-		filter_tree="$OPTARG"
-		;;
+		filter_tree="$2"; shift;;
 	--index-filter)
-		filter_index="$OPTARG"
-		;;
+		filter_index="$2"; shift;;
 	--parent-filter)
-		filter_parent="$OPTARG"
-		;;
+		filter_parent="$2"; shift;;
 	--msg-filter)
-		filter_msg="$OPTARG"
-		;;
+		filter_msg="$2"; shift;;
 	--commit-filter)
-		filter_commit="$functions; $OPTARG"
-		;;
+		filter_commit="$functions; $2"; shift;;
 	--tag-name-filter)
-		filter_tag_name="$OPTARG"
-		;;
-	--subdirectory-filter)
-		filter_subdir="$OPTARG"
-		;;
-	--original)
-		orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
-		;;
+		filter_tag_name="$2"; shift;;
+	--)
+		shift; break;;
 	*)
-		usage
-		;;
+		usage;;
 	esac
+	shift
 done
 
 case "$force" in
-- 
1.6.0.3.758.gc29b0
