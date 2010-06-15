From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: [PATCHv4] bash completion: Support "divergence from upstream" messages
 in __git_ps1
Date: Tue, 15 Jun 2010 22:50:43 +0100
Message-ID: <4C17F5B3.4070907@pileofstuff.org>
References: <20100612000002.GA30196@neumann> <cover.1276336602.git.trast@student.ethz.ch> <4C13F32B.7060106@pileofstuff.org> <201006140942.43099.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 15 23:51:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOe2j-0005LU-OQ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 23:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746Ab0FOVuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 17:50:55 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:49179 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754353Ab0FOVuy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 17:50:54 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100615215047.SRBZ3192.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Tue, 15 Jun 2010 22:50:47 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100615215046.SZIG1593.aamtaout04-winn.ispmail.ntl.com@[192.168.1.5]>;
          Tue, 15 Jun 2010 22:50:46 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <201006140942.43099.trast@student.ethz.ch>
X-Cloudmark-Analysis: v=1.1 cv=ZtHxNT4mZm3rCuM0SmWmgWxeBwJsziC8EqOrwwVkrhA= c=1 sm=0 a=7F5Lw3tw7loA:10 a=1CvaPgNKC-EA:10 a=8nJEP1OIZ-IA:10 a=Z2kc0SbD0OWn5tVQmvkA:9 a=nLDSVni_70hGDdUAYkUA:7 a=yaECA6FOYJN2fAruzgpiH8PoBpYA:4 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149229>

Add a notification in the command prompt specifying whether (and optionally how
far) your branch has diverged from its upstream.  This is especially helpful in
small teams that very frequently (forget to) push to each other.

Support git-svn upstream detection as a special case, as migrators from
centralised version control systems are especially likely to forget to push.

Support for other types of upstream than SVN should be easy to add if anyone is
so inclined.
---

This version removes ref= and cmd=/eval entirely, adds documentation
and reaches once again into the forbidden bash bag to fix Thomas'
issues.

I've used process substitution <(git config) instead of a simple pipe
because it's the only way I know to maintain the value of a local
variable.  To demonstrate, this prints a blank line:

foo() {
	local FOO
	echo foo | while read ; do FOO=$REPLY ; done
	echo $FOO
}
foo

Whereas this prints 'foo':

foo() {
	local FOO
	while read ; do FOO=$REPLY ; done < <( echo foo )
	echo $FOO
}
foo

While working on this patch, I found the following bug in 1.7.0.4:

$ git config --get-regexp '^(bash\.showUpstream)$'
bash.showupstream legacy verbose
$ git config --get-regexp '^(bash\.showUpstream|x)$'
bash.showupstream legacy verbose
$ git config --get-regexp '^(bash\.showupstream|\.)$'
bash.showupstream legacy verbose
$ git config --get-regexp '^(bash\.showUpstream|\.)$'

The last line should print the same value as all the others.  This
seems to be some weird issue with handling uppercase characters, but
I've not yet had time to create a minimal test case or check it on
master - I'll try to make some time tomorrow if it isn't a known
issue.

 contrib/completion/git-completion.bash |  142 +++++++++++++++++++++++++++++++-
 1 files changed, 141 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 57245a8..dabcdaa 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -42,6 +42,23 @@
 #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're
 #       untracked files, then a '%' will be shown next to the branch name.
 #
+#       If you would like to see the difference between HEAD and its
+#       upstream, set GIT_PS1_SHOWUPSTREAM to a nonempty value.  A "<"
+#       indicates you are behind, ">" indicates you are ahead, and
+#       "<>" indicates you have diverged.  You can further control
+#       behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated
+#       list of values:
+#           git           compare HEAD to @{upstream}
+#           svn           compare HEAD to your SVN upstream
+#           verbose       show number of commits ahead/behind (+/-) upstream
+#           legacy        don't use the '--count' option available in recent
+#                         versions of git-rev-list
+#       By default, __git_ps1 will compare HEAD to your SVN upstream
+#       if it can find one, or @{upstream} otherwise.  You can
+#       override the value of GIT_PS1_SHOWUPSTREAM on a per-repository
+#       basis by setting the bash.showUpstream config variable.
+#
+#
 # To submit patches:
 #
 #    *) Read Documentation/SubmittingPatches
@@ -78,6 +95,124 @@ __gitdir ()
 	fi
 }
 
+# stores the divergence from upstream in $p
+# used by GIT_PS1_SHOWUPSTREAM
+__git_ps1_show_upstream ()
+{
+	local key value
+	local svn_remote=() svn_url_pattern count n
+	local upstream=git legacy verbose
+
+	# get some config options from git-config
+	while read key value; do
+		case "$key" in
+			bash.showupstream)
+				GIT_PS1_SHOWUPSTREAM="$value"
+				if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
+					p=""
+					return
+				fi
+				;;
+			svn-remote.*.url)
+				svn_remote[ $((${#svn_remote[@]} + 1)) ]="$value"
+				svn_url_pattern+="\\|$value"
+				upstream=svn # default upstream is SVN if available
+				;;
+		esac
+	done < <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')
+
+	# parse configuration values
+	for option in ${GIT_PS1_SHOWUPSTREAM}; do
+		case "$option" in
+			git|svn) upstream="$option" ;;
+			verbose) verbose=1 ;;
+			legacy)  legacy=1  ;;
+		esac
+	done
+
+	# Find our upstream
+	case "$upstream" in
+		git)    upstream="@{upstream}" ;;
+		svn)
+			# get the upstream from the "git-svn-id: ..." in a commit message
+			# (git-svn uses essentially the same procedure internally)
+			upstream=($(git log --first-parent -1 \
+					--grep="^git-svn-id: \(${svn_url_pattern:2}\)"))
+			if [[ -n "$upstream" ]]; then
+				upstream=${upstream[ ${#upstream[@]} - 2 ]}
+				upstream=${upstream%@*}
+				for ((n=1; "$n" <= "${#svn_remote[@]}"; ++n)); do
+					upstream=${upstream#${svn_remote[$n]}}
+				done
+
+				if [[ -z "$upstream" ]]; then
+					# default branch name for checkouts with no layout:
+					upstream=${GIT_SVN_ID:-git-svn}
+				else
+					upstream=${upstream#/}
+				fi
+
+			fi
+			;;
+	esac
+
+	# Find how many commits we are ahead/behind our upstream
+	if [[ -z "$legacy" ]]; then
+		count="$(git rev-list --count --left-right \
+				"$upstream"...HEAD 2>/dev/null)"
+	else
+		# produce equivalent output to --count for older versions of git
+		local commits
+		if commits="$(git rev-list --left-right "$upstream"...HEAD 2>/dev/null)"
+		then
+			local commit behind=0 ahead=0
+			for commit in $commits
+			do
+				case "$commit" in
+					"<"*) let ++behind
+						;;
+					*)    let ++ahead
+						;;
+				esac
+			done
+			count="$behind	$ahead"
+		else
+			count=""
+		fi
+	fi
+
+	# calculate the result
+	if [[ -z "$verbose" ]]; then
+		case "$count" in
+			"") # no upstream
+				p="" ;;
+			"0	0") # equal to upstream
+				p="=" ;;
+			"0	"*) # ahead of upstream
+				p=">" ;;
+			*"	0") # behind upstream
+				p="<" ;;
+			*)	    # diverged from upstream
+				p="<>" ;;
+		esac
+	else
+		case "$count" in
+			"") # no upstream
+				p="" ;;
+			"0	0") # equal to upstream
+				p=" u=" ;;
+			"0	"*) # ahead of upstream
+				p=" u+${count#0	}" ;;
+			*"	0") # behind upstream
+				p=" u-${count%	0}" ;;
+			*)	    # diverged from upstream
+				p=" u+${count#*	}-${count%	*}" ;;
+		esac
+	fi
+
+}
+
+
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
 # returns text to add to bash PS1 prompt (includes branch name)
 __git_ps1 ()
@@ -132,6 +267,7 @@ __git_ps1 ()
 		local s
 		local u
 		local c
+		local p
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
 			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
@@ -159,10 +295,14 @@ __git_ps1 ()
 			      u="%"
 			   fi
 			fi
+
+			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+				__git_ps1_show_upstream
+			fi
 		fi
 
 		local f="$w$i$s$u"
-		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r"
+		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
 	fi
 }
 
-- 
1.7.0.4
