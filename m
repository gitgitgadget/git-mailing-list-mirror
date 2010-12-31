From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 3/3] filter-branch: support --submodule-filter
Date: Fri, 31 Dec 2010 16:29:24 +0100
Message-ID: <44e6104ba28c80a6befe0f39fa4e2d6eeec56aa9.1293809100.git.trast@student.ethz.ch>
References: <cover.1293809100.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: <jeffrey.freeman@syncleus.com>
X-From: git-owner@vger.kernel.org Fri Dec 31 16:29:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYgv9-0005F6-Ng
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 16:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab0LaP3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 10:29:33 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:51957 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020Ab0LaP32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 10:29:28 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 31 Dec
 2010 16:28:54 +0100
Received: from localhost.localdomain (217.162.250.31) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 31 Dec
 2010 16:29:25 +0100
X-Mailer: git-send-email 1.7.4.rc0.240.g44e61
In-Reply-To: <cover.1293809100.git.trast@student.ethz.ch>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164387>

This new filter gets each submodule's current sha1 and path on stdin,
separated by a tab.  It can then emit a new submodule sha1 and/or
path, and filter-branch will:

* if the path differs, remove the submodule at the old path;

* add/replace the new sha1 at the new path.

Additionally, returning an empty new sha1 deletes the submodule.

You can tie this together with the last two commits to filter the
super-project after a subproject filtering as follows:

  ( cd sub1 && git filter-branch --dump-map map <filters|args> )
  ( cd sub2 && git filter-branch --dump-map map <filters|args> )
  cat sub1/map sub2/map > map
  git filter-branch --load-map map \
  	--submodule-filter "map $(cut -f1)" \
	<args>

Other use-cases should also be covered since we also pass through the
path.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-filter-branch.sh |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 9feeb26..4a321c4 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -122,6 +122,7 @@ filter_msg=cat
 filter_commit=
 filter_tag_name=
 filter_subdir=
+filter_submodule=
 orig_namespace=refs/original/
 force=
 prune_empty=
@@ -193,6 +194,9 @@ do
 		filter_subdir="$OPTARG"
 		remap_to_ancestor=t
 		;;
+	--submodule-filter)
+		filter_submodule="$OPTARG"
+		;;
 	--original)
 		orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
 		;;
@@ -379,6 +383,26 @@ while read commit parents; do
 	eval "$filter_index" < /dev/null ||
 		die "index filter failed: $filter_index"
 
+	if [ "$filter_submodule" ]; then
+		git ls-files -s |
+		grep '^160000' |
+		while read mode sha1 stage path; do
+			printf "$sha1\t$path\n" |
+			{ eval "$filter_submodule" ||
+				die "submodule filter failed: $filter_submodule"; } |
+			read newsha1 newpath
+			if [ -z "$newsha1" ] || [ "$path" != "$newpath" ]; then
+				git update-index --remove "$path" ||
+					die "failed to remove submodule $path"
+			fi
+			if [ -n "$newsha1" ] && [ "$sha1" != "$newsha1" ]; then
+				git update-index --add --replace --cacheinfo \
+					160000 "$newsha1" "$newpath" ||
+					die "failed to add submodule $newpath"
+			fi
+		done
+	fi
+
 	parentstr=
 	for parent in $parents; do
 		for reparent in $(map "$parent"); do
-- 
1.7.4.rc0.240.g44e61
