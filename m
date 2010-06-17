From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: [PATCHv5 1/2] bash completion: Support "divergence from upstream"
 messages in __git_ps1
Date: Thu, 17 Jun 2010 22:32:02 +0100
Message-ID: <4C1A9452.1090900@pileofstuff.org>
References: <20100612000002.GA30196@neumann> <cover.1276336602.git.trast@student.ethz.ch> <4C13F32B.7060106@pileofstuff.org> <201006140942.43099.trast@student.ethz.ch> <4C17F5B3.4070907@pileofstuff.org> <7v7hlyg5nh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 23:32:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPMh7-0006LU-2Q
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 23:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760033Ab0FQVcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 17:32:11 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:42150 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757670Ab0FQVcK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 17:32:10 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100617213204.CWMQ3192.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Thu, 17 Jun 2010 22:32:04 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100617213204.YZFU1593.aamtaout04-winn.ispmail.ntl.com@[192.168.1.5]>;
          Thu, 17 Jun 2010 22:32:04 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <7v7hlyg5nh.fsf@alter.siamese.dyndns.org>
X-Cloudmark-Analysis: v=1.1 cv=ZtHxNT4mZm3rCuM0SmWmgWxeBwJsziC8EqOrwwVkrhA= c=1 sm=0 a=e9SKNfV3wpcA:10 a=uEzv4HemXiYA:10 a=8nJEP1OIZ-IA:10 a=qOz2pZ_4AAAA:8 a=0F9xrvqO7EHz5EQEgKEA:9 a=QlEyQxcGcdVqsXv021EA:7 a=gATVMVon4XSaAKoSoB9j0SfUMf0A:4 a=wPNLvfGTeEIA:10 a=7qzHkXPk5l4A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149329>

Add a notification in the command prompt specifying whether (and optionally how
far) your branch has diverged from its upstream.  This is especially helpful in
small teams that very frequently (forget to) push to each other.

Support git-svn upstream detection as a special case, as migrators from
centralised version control systems are especially likely to forget to push.

Support for other types of upstream than SVN should be easy to add if anyone is
so inclined.

Signed-off-by: Andrew Sayers <andrew-git@pileofstuff.org>
---
 contrib/completion/git-completion.bash |  144 +++++++++++++++++++++++++++++++-
 1 files changed, 143 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 57245a8..6e6f458 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -42,6 +42,24 @@
 #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're
 #       untracked files, then a '%' will be shown next to the branch name.
 #
+#       If you would like to see the difference between HEAD and its
+#       upstream, set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates
+#       you are behind, ">" indicates you are ahead, and "<>"
+#       indicates you have diverged.  You can further control
+#       behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated
+#       list of values:
+#           verbose       show number of commits ahead/behind (+/-) upstream
+#           legacy        don't use the '--count' option available in recent
+#                         versions of git-rev-list
+#           git           always compare HEAD to @{upstream}
+#           svn           always compare HEAD to your SVN upstream
+#       By default, __git_ps1 will compare HEAD to your SVN upstream
+#       if it can find one, or @{upstream} otherwise.  Once you have
+#       set GIT_PS1_SHOWUPSTREAM, you can override it on a
+#       per-repository basis by setting the bash.showUpstream config
+#       variable.
+#
+#
 # To submit patches:
 #
 #    *) Read Documentation/SubmittingPatches
@@ -78,6 +96,125 @@ __gitdir ()
 	fi
 }
 
+# stores the divergence from upstream in $p
+# used by GIT_PS1_SHOWUPSTREAM
+__git_ps1_show_upstream ()
+{
+	local key value
+	local svn_remote=() svn_url_pattern count n
+	local upstream=git legacy="" verbose=""
+
+	# get some config options from git-config
+	while read key value; do
+		case "$key" in
+		bash.showupstream)
+			GIT_PS1_SHOWUPSTREAM="$value"
+			if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
+				p=""
+				return
+			fi
+			;;
+		svn-remote.*.url)
+			svn_remote[ $((${#svn_remote[@]} + 1)) ]="$value"
+			svn_url_pattern+="\\|$value"
+			upstream=svn+git # default upstream is SVN if available, else git
+			;;
+		esac
+	done < <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')
+
+	# parse configuration values
+	for option in ${GIT_PS1_SHOWUPSTREAM}; do
+		case "$option" in
+		git|svn) upstream="$option" ;;
+		verbose) verbose=1 ;;
+		legacy)  legacy=1  ;;
+		esac
+	done
+
+	# Find our upstream
+	case "$upstream" in
+	git)    upstream="@{upstream}" ;;
+	svn*)
+		# get the upstream from the "git-svn-id: ..." in a commit message
+		# (git-svn uses essentially the same procedure internally)
+		local svn_upstream=($(git log --first-parent -1 \
+					--grep="^git-svn-id: \(${svn_url_pattern:2}\)" 2>/dev/null))
+		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
+			svn_upstream=${svn_upstream[ ${#svn_upstream[@]} - 2 ]}
+			svn_upstream=${svn_upstream%@*}
+			for ((n=1; "$n" <= "${#svn_remote[@]}"; ++n)); do
+				svn_upstream=${svn_upstream#${svn_remote[$n]}}
+			done
+
+			if [[ -z "$svn_upstream" ]]; then
+				# default branch name for checkouts with no layout:
+				upstream=${GIT_SVN_ID:-git-svn}
+			else
+				upstream=${svn_upstream#/}
+			fi
+		elif [[ "svn+git" = "$upstream" ]]; then
+			upstream="@{upstream}"
+		fi
+		;;
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
+				"<"*) let ++behind
+					;;
+				*)    let ++ahead
+					;;
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
+		"") # no upstream
+			p="" ;;
+		"0	0") # equal to upstream
+			p="=" ;;
+		"0	"*) # ahead of upstream
+			p=">" ;;
+		*"	0") # behind upstream
+			p="<" ;;
+		*)	    # diverged from upstream
+			p="<>" ;;
+		esac
+	else
+		case "$count" in
+		"") # no upstream
+			p="" ;;
+		"0	0") # equal to upstream
+			p=" u=" ;;
+		"0	"*) # ahead of upstream
+			p=" u+${count#0	}" ;;
+		*"	0") # behind upstream
+			p=" u-${count%	0}" ;;
+		*)	    # diverged from upstream
+			p=" u+${count#*	}-${count%	*}" ;;
+		esac
+	fi
+
+}
+
+
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
 # returns text to add to bash PS1 prompt (includes branch name)
 __git_ps1 ()
@@ -132,6 +269,7 @@ __git_ps1 ()
 		local s
 		local u
 		local c
+		local p
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
 			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
@@ -159,10 +297,14 @@ __git_ps1 ()
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
