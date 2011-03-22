From: Nicolas Morey-Chaisemartin <nmorey@kalray.eu>
Subject: [PATCH 1/2] git-submodule.sh: Handle submodules with merge conflicts
Date: Tue, 22 Mar 2011 09:56:16 +0100
Message-ID: <4D886430.3080300@kalray.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 10:01:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1xTM-0000JN-Iq
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 10:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757Ab1CVJBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 05:01:49 -0400
Received: from mailhost.kalray.eu ([217.108.237.233]:60569 "EHLO EKA.kalray.eu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751726Ab1CVJBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 05:01:46 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Mar 2011 05:01:44 EDT
Received: from sat.lin.mbt.kalray.eu (192.168.37.91) by EKA.kalray.eu
 (192.168.38.100) with Microsoft SMTP Server id 8.3.83.0; Tue, 22 Mar 2011
 09:55:26 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169712>

During a merge with conflict on a submodule, the submodule appears 3 times in git ls-files (stage 1,2,3) which caused the submodule to be used 3 times in git submodule init, sync, update and status command.
This patch filters the results of git ls-files to generate a single entry for conflicting submodules with a 0 SHA1 and 'U' as stage.
After this patch:
- init and sync behave as previously but only once per submodule
- update skips submodule with merge conflicts
- status now display a null SHA1 prefixed by 'U' for submodule with merge conflicts

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 git-submodule.sh |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3a13397..7f6b3cf 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -72,7 +72,24 @@ resolve_relative_url ()
 #
 module_list()
 {
-	git ls-files --error-unmatch --stage -- "$@" | sane_grep '^160000 '
+	git ls-files --error-unmatch --stage -- "$@" |
+	perl -e '
+	my %unmerged = ();
+	my ($null_sha1) = ("0" x 40);
+	while (<STDIN>) {
+		chomp;
+		my ($mode, $sha1, $stage, $path) =
+			/^([0-7]+) ([0-9a-f]{40}) ([0-3])\t(.*)$/;
+		next unless $mode eq "160000";
+		if ($stage ne "0") {
+			if (!$unmerged{$path}++) {
+				print "$mode $null_sha1 U\t$path\n";
+			}
+			next;
+		}
+		print "$_\n";
+	}
+	'
 }
 
 #
@@ -427,6 +444,11 @@ cmd_update()
 	module_list "$@" |
 	while read mode sha1 stage path
 	do
+		if test "$stage" = U
+		then
+			echo >&2 "Skipping unmerged submodule $path"
+			continue
+		fi
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
 		update_module=$(git config submodule."$name".update)
@@ -770,6 +792,11 @@ cmd_status()
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
 		displaypath="$prefix$path"
+		if test "$stage" = U
+		then
+			say "U$sha1 $displaypath"
+			continue
+		fi
 		if test -z "$url" || ! test -d "$path"/.git -o -f "$path"/.git
 		then
 			say "-$sha1 $displaypath"
-- 
1.7.4
