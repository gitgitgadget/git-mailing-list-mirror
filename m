From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 2/3] filter-branch: optionally load existing mappings prior to filtering
Date: Fri, 31 Dec 2010 16:29:23 +0100
Message-ID: <f89203efcf1b2f49fb33097b3e7fc27e070626fb.1293809100.git.trast@student.ethz.ch>
References: <cover.1293809100.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: <jeffrey.freeman@syncleus.com>
X-From: git-owner@vger.kernel.org Fri Dec 31 16:29:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYgv9-0005F6-6S
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 16:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab0LaP3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 10:29:32 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:4268 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035Ab0LaP32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 10:29:28 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 31 Dec
 2010 16:29:14 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164388>

In the previous commit filter-branch learned to dump its mappings.
Introduce a --load-map option that lets it load map files in the same
format.

This option does not accumulate; only the last one counts.  Letting it
accumulate would require two argument-parsing passes since we need to
know the $tempdir before we can establish any maps.

Also, the maps add to all filtered maps.  This is a bit of a tradeoff.
As it stands, it could be useful to remap refs in another repository
using the map file from elsewere.  On the other hand, it does mean
that it may rewrite more refs than the user intended.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-filter-branch.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 020b076..9feeb26 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -127,6 +127,7 @@ force=
 prune_empty=
 remap_to_ancestor=
 dump_map=
+load_map=
 while :
 do
 	case "$1" in
@@ -205,6 +206,16 @@ do
 			;;
 		esac
 		;;
+	--load-map)
+		case "$OPTARG" in
+		/*)
+			load_map="$OPTARG"
+			;;
+		*)
+			load_map="$(pwd)/$OPTARG"
+			;;
+		esac
+		;;
 	*)
 		usage
 		;;
@@ -275,6 +286,14 @@ export GIT_INDEX_FILE
 # map old->new commit ids for rewriting parents
 mkdir ../map || die "Could not create map/ directory"
 
+if test -n "$load_map"
+then
+	while read pre post
+	do
+		echo $post > ../map/$pre
+	done < "$load_map"
+fi
+
 # we need "--" only if there are no path arguments in $@
 nonrevs=$(git rev-parse --no-revs "$@") || exit
 if test -z "$nonrevs"
-- 
1.7.4.rc0.240.g44e61
