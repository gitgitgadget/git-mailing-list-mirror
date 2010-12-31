From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 1/3] filter-branch: optionally dump all mappings at the end
Date: Fri, 31 Dec 2010 16:29:22 +0100
Message-ID: <57609f1df897f19becc77d5c43c3c3608725160b.1293809100.git.trast@student.ethz.ch>
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
	id 1PYgv8-0005F6-4R
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 16:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab0LaP33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 10:29:29 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:51957 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089Ab0LaP31 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 10:29:27 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 31 Dec
 2010 16:28:54 +0100
Received: from localhost.localdomain (217.162.250.31) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 31 Dec
 2010 16:29:24 +0100
X-Mailer: git-send-email 1.7.4.rc0.240.g44e61
In-Reply-To: <cover.1293809100.git.trast@student.ethz.ch>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164385>

In some cases, like the sub/super-project filtering attempted in this
series, it may be necessary to carry over the mappings from one or
more filter-branch run to another.

As the first part to this, make a --dump-map option that dumps a flat
text file with lines of the form

  $sha1 $(map $sha1)

after it has established all mappings.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-filter-branch.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 962a93b..020b076 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -126,6 +126,7 @@ orig_namespace=refs/original/
 force=
 prune_empty=
 remap_to_ancestor=
+dump_map=
 while :
 do
 	case "$1" in
@@ -194,6 +195,16 @@ do
 	--original)
 		orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
 		;;
+	--dump-map)
+		case "$OPTARG" in
+		/*)
+			dump_map="$OPTARG"
+			;;
+		*)
+			dump_map="$(pwd)/$OPTARG"
+			;;
+		esac
+		;;
 	*)
 		usage
 		;;
@@ -385,6 +396,16 @@ then
 	done < "$tempdir"/heads
 fi
 
+# At this point the mappings are stable so we can dump them if
+# requested
+
+if test -n "$dump_map"; then
+	( cd "$workdir"/../map/; ls ) |
+	while read sha1; do
+		echo $sha1 $(map $sha1)
+	done > "$dump_map"
+fi
+
 # Finally update the refs
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-- 
1.7.4.rc0.240.g44e61
