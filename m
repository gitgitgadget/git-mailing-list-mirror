From: Yves Blusseau <blusseau@zetam.org>
Subject: [PATCH] completion: resolve svn remote upstream refs
Date: Fri, 03 Aug 2012 11:54:25 +0200
Message-ID: <501B9FD1.8090204@zetam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 11:56:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxEc6-00026J-6d
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 11:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab2HCJ4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 05:56:05 -0400
Received: from [193.252.149.37] ([193.252.149.37]:36924 "EHLO
	smtpout01s1.x-echo.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751793Ab2HCJ4D (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 05:56:03 -0400
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.3
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:6.0) Gecko/20110812 Thunderbird/6.0
X-AV-Checked: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202826>

Updated version of my previous patch

This fix is used to return the svn reference of the remote svn upstream
branch when the git repository is a clone of a svn repository that was
created with the --stdlayout and --prefix options of git svn command.

* completion/git-prompt.sh: add function to resolve svn branches into
   git remote refs using paths declared in svn-remote.*.fetch and
   svn-remote.*.branches configurations

Signed-off-by: Yves Blusseau <blusseau@zetam.org>
---
  contrib/completion/git-prompt.sh | 56 
+++++++++++++++++++++++++++++++++++++++-
  1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh 
b/contrib/completion/git-prompt.sh
index 29b1ec9..f9a3421 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -73,17 +73,65 @@ __gitdir ()
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
+
+		# If the ref match the left part we can resolve the ref directly
+		if [[ "$ref" == "$left_part_ref_glob" ]];then
+			# resolve the ref into the right part (after the :)
+			ref="${ref_globs/${left_part_ref_glob}:/}"
+			break
+		else
+			case $ref in
+				# check if the ref match the glob
+				$left_part_ref_glob)
+					# extract the value that match the pattern
+					left=${left_part_ref_glob%%\**}
+					right=${left_part_ref_glob##*\*}
+					value=${ref#$left}
+					value=${value%$right}
+					# get the right part ref glob (after the :)
+					right_part_ref_glob="${ref_globs/${left_part_ref_glob}:/}"
+					# replace the pattern with the value found above
+					left=${right_part_ref_glob%%\**}
+					right=${right_part_ref_glob##*\*}
+					ref=${left}${value}${right}
+					break
+					;;
+			esac
+		fi
+	done
+	# remove leading refs/remotes/
+	ref=${ref/refs\/remotes\//}
+	echo "$ref"
+}
+
  # stores the divergence from upstream in $p
  # used by GIT_PS1_SHOWUPSTREAM
  __git_ps1_show_upstream ()
  {
  	local key value
  	local svn_remote svn_url_pattern count n
+	local svn_refs_globs=()
  	local upstream=git legacy="" verbose=""
   	svn_remote=()
  	# get some config options from git-config
-	local output="$(git config -z --get-regexp 
'^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
+	local output="$(git config -z --get-regexp 
'^(svn-remote\..*\.(fetch|branches|url)|bash\.showupstream)$' 
2>/dev/null | tr '\0\n' '\n ')"
  	while read -r key value; do
  		case "$key" in
  		bash.showupstream)
@@ -93,6 +141,9 @@ __git_ps1_show_upstream ()
  				return
  			fi
  			;;
+		svn-remote.*.fetch|svn-remote.*.branches)
+			svn_refs_globs[${#svn_refs_globs[*]}]="$value"
+			;;
  		svn-remote.*.url)
  			svn_remote[ $((${#svn_remote[@]} + 1)) ]="$value"
  			svn_url_pattern+="\\|$value"
@@ -132,6 +183,9 @@ __git_ps1_show_upstream ()
  			else
  				upstream=${svn_upstream#/}
  			fi
+			if [[ ${#svn_refs_globs[@]} -gt 0 ]]; then
+				upstream=$(__git_resolve_svn_refs svn_refs_globs[@] "$upstream")
+			fi
  		elif [[ "svn+git" = "$upstream" ]]; then
  			upstream="@{upstream}"
  		fi
-- 
1.7.12.rc1.17.g6cf3663
