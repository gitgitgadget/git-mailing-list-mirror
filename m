From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Added --mirror-all to git-fetch.
Date: Tue, 19 Sep 2006 19:28:51 -0400
Message-ID: <20060919232851.GA12195@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 20 01:29:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPp1O-0002Aj-FL
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 01:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWISX2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 19:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWISX2z
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 19:28:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47312 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750802AbWISX2z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 19:28:55 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GPp19-0004z8-DI
	for git@vger.kernel.org; Tue, 19 Sep 2006 19:28:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 666CD20E48E; Tue, 19 Sep 2006 19:28:51 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27314>

The --mirror-all option to git-fetch can be used to obtain a copy of
every available remote ref into the current repository.  This can be
a rather destructive update as the local repository will have its
HEAD ref overwritten, as well as any ref which it shares in common
with the remote repository.  On the other hand it can be useful if
all you want to do is have this repository track another repository,
such as if you are providing Git repository hosting and mirroring
source repositories on other systems.

Currently local refs are not deleted even if they do not exist in the
remote repository.  This may be taken as either a feature or a bug.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 pasky was asking about this on #git.  So here it is.

 Documentation/fetch-options.txt |    7 ++++++
 git-fetch.sh                    |   43 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 13f34d3..5ed9b4f 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -30,6 +30,13 @@
 	flag lets all tags and their associated objects be
 	downloaded.
 
+\--mirror-all::
+	All refs and tags on the remote side are downloaded to
+	the local side.  This option is not intendend for user
+	repositories as it will overwrite every local ref,
+	including HEAD.  You probably don't mean to use this
+	option.
+
 -k, \--keep::
 	Keep downloaded pack.
 
diff --git a/git-fetch.sh b/git-fetch.sh
index 09a5d6c..d22c560 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -14,6 +14,7 @@ IFS="$LF"
 rloga=fetch
 no_tags=
 tags=
+mirror_all=
 append=
 force=
 verbose=
@@ -36,6 +37,9 @@ do
 	-f|--f|--fo|--for|--forc|--force)
 		force=t
 		;;
+	--mirror-all)
+		mirror_all=t
+		;;
 	-t|--t|--ta|--tag|--tags)
 		tags=t
 		;;
@@ -216,12 +220,45 @@ case "$update_head_ok" in
 	;;
 esac
 
-# If --tags (and later --heads or --all) is specified, then we are
-# not talking about defaults stored in Pull: line of remotes or
+# If --tags or -mirror_all (and later --heads) is specified, then we
+# are not talking about defaults stored in Pull: line of remotes or
 # branches file, and just fetch those and refspecs explicitly given.
 # Otherwise we do what we always did.
 
-reflist=$(get_remote_refs_for_fetch "$@")
+if test "$mirror_all"
+then
+	tags=0;  # tags are implied in all 
+	reflist=`IFS="	" &&
+		  (
+			git-ls-remote $upload_pack "$remote" ||
+			echo fail ouch
+		  ) |
+	          while read sha1 name
+		  do
+			case "$sha1" in
+			fail)
+				exit 1
+			esac
+			case "$name" in
+			*^*) continue ;;
+			esac
+		  	if git-check-ref-format "$name"
+			then
+			    echo ".+${name}:${name}"
+			else
+				if test "x$name" = xHEAD
+				then
+					echo ".+${name}:${name}"
+				else
+					echo >&2 "warning: malformed ref ${name} ignored"
+				fi
+			fi
+		  done` || exit
+else
+	# Not using all; do what we always have done.
+	reflist=$(get_remote_refs_for_fetch "$@")
+fi
+
 if test "$tags"
 then
 	taglist=`IFS="	" &&
-- 
1.4.2.1.g832e
