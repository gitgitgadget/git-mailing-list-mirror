From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-quiltimport: better parser to  grok "enhanced" series files.
Date: Sat, 08 Mar 2008 19:27:09 +0100
Message-ID: <20080308182709.GA3109@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 19:28:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY3mI-0000y4-L4
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 19:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbYCHS1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 13:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbYCHS1M
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 13:27:12 -0500
Received: from pan.madism.org ([88.191.52.104]:44978 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbYCHS1M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 13:27:12 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 985042F94A;
	Sat,  8 Mar 2008 19:27:10 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id A726E636E; Sat,  8 Mar 2008 19:27:09 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76570>

The previous parser wasn't able to grok:
* empty lines;
* annotated patch levels (trailing -pNNN annotations);
* trailing comments.

Now it even uses the patch level hints as a git apply argument.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  I'd even argue that it's maint material btw :)

 git-quiltimport.sh |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 233e5ea..0d8a765 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -63,7 +63,22 @@ tmp_info="$tmp_dir/info"
 commit=$(git rev-parse HEAD)
 
 mkdir $tmp_dir || exit 2
-for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
+cat "$QUILT_PATCHES/series" | while read patch_name level garbage; do
+	case "$patch_name" in ''|'#'*) continue;; esac
+	case "$level" in
+		-p*);;
+		''|'#'*)
+			level=;;
+		*)
+			echo "unable to parse patch level, ignoring it."
+			level=;;
+	esac
+	case "$garbage" in
+		''|'#'*);;
+		*)
+			echo "trailing garbage found: $garbage, please fix your series file"
+			exit 1;;
+	esac
 	if ! [ -f "$QUILT_PATCHES/$patch_name" ] ; then
 		echo "$patch_name doesn't exist. Skipping."
 		continue
@@ -113,7 +128,7 @@ for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
 	fi
 
 	if [ -z "$dry_run" ] ; then
-		git apply --index -C1 "$tmp_patch" &&
+		git apply --index -C1 $level "$tmp_patch" &&
 		tree=$(git write-tree) &&
 		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tree $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
-- 
1.5.4.3.593.g07854.dirty

