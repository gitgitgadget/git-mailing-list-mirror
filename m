From: Yves Blusseau <blusseau@zetam.org>
Subject: [PATCH] completion: resolve svn remote upstream refs
Date: Thu, 02 Aug 2012 10:20:02 +0200
Message-ID: <501A3832.5040905@zetam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 10:28:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwqlV-00069x-LN
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 10:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab2HBI2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 04:28:10 -0400
Received: from smtpout01s1.x-echo.com ([193.252.149.37]:60638 "EHLO
	smtpout01s1.x-echo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab2HBI2D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 04:28:03 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Aug 2012 04:28:03 EDT
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.3
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:6.0) Gecko/20110812 Thunderbird/6.0
X-AV-Checked: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202745>

This fix is used to return the svn reference of the remote svn upstream
branch when the git repository is a clone of a svn repository that was
created with the --stdlayout and --prefix options of git svn command.

* completion/git-prompt.sh: add function to resolve svn branches
   into git remote refs using paths declared in svn-remote.*.branches
   configurations

Signed-off-by: Yves Blusseau <blusseau@zetam.org>
---
  contrib/completion/git-prompt.sh | 48 
+++++++++++++++++++++++++++++++++++++++-
  1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh 
b/contrib/completion/git-prompt.sh
index 29b1ec9..dafcecc 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -73,17 +73,57 @@ __gitdir ()
  	fi
  }
  +# resolve svn refs
+# The function accepts 2 arguments:
+# 1: An array containing the translation ref(s) (ie 
branches/*:refs/remotes/svn/*)
+# 2: the ref to be translated (ie. branches/prod)
+# returns the remote refs or original ref if it could not be translated
+__git_resolve_svn_refs ()
+{
+	local idx ref_globs left_part_ref_glob right_part_ref_glob left right 
value
+
+	local all_ref_globs=("${!1}")
+	local ref="$2"
+
+	for (( idx=0 ; idx < ${#all_ref_globs[@]}; idx++ ));do
+		ref_globs="${all_ref_globs[$idx]}"
+		# get the left part ref glob (before the :refs/)
+		left_part_ref_glob="${ref_globs%%:refs/*}"
+		case $ref in
+			# check if the ref match the glob
+			$left_part_ref_glob)
+				# extract the value that match the pattern
+				left=${left_part_ref_glob%%\**}
+				right=${left_part_ref_glob##*\*}
+				value=${ref#$left}
+				value=${value%$right}
+				# get the right part ref glob (after the :)
+				right_part_ref_glob="${ref_globs/${left_part_ref_glob}:/}"
+				# replace the pattern with the value found above
+				left=${right_part_ref_glob%%\**}
+				right=${right_part_ref_glob##*\*}
+				ref=${left}${value}${right}
+				# remove leading refs/remotes/
+				ref=${ref/refs\/remotes\//}
+				break
+				;;
+		esac
+	done
+	echo "$ref"
+}
+
  # stores the divergence from upstream in $p
  # used by GIT_PS1_SHOWUPSTREAM
  __git_ps1_show_upstream ()
  {
  	local key value
  	local svn_remote svn_url_pattern count n
+	local branches_refs_globs=()
  	local upstream=git legacy="" verbose=""
   	svn_remote=()
  	# get some config options from git-config
-	local output="$(git config -z --get-regexp 
'^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
+	local output="$(git config -z --get-regexp 
'^(svn-remote\..*\.(branches|url)|bash\.showupstream)$' 2>/dev/null | tr 
'\0\n' '\n ')"
  	while read -r key value; do
  		case "$key" in
  		bash.showupstream)
@@ -93,6 +133,9 @@ __git_ps1_show_upstream ()
  				return
  			fi
  			;;
+		svn-remote.*.branches)
+			branches_refs_globs[${#branches_refs_globs[*]}]="$value"
+			;;
  		svn-remote.*.url)
  			svn_remote[ $((${#svn_remote[@]} + 1)) ]="$value"
  			svn_url_pattern+="\\|$value"
@@ -132,6 +175,9 @@ __git_ps1_show_upstream ()
  			else
  				upstream=${svn_upstream#/}
  			fi
+			if [[ ${#branches_refs_globs[@]} -gt 0 ]]; then
+				upstream=$(__git_resolve_svn_refs branches_refs_globs[@] "$upstream")
+			fi
  		elif [[ "svn+git" = "$upstream" ]]; then
  			upstream="@{upstream}"
  		fi
-- 
1.7.12.rc1
