From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: [PATCH] bash completion: Support "divergence from upstream" messages
 in __git_ps1
Date: Sat, 12 Jun 2010 21:50:51 +0100
Message-ID: <4C13F32B.7060106@pileofstuff.org>
References: <20100612000002.GA30196@neumann> <cover.1276336602.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jun 12 22:51:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONXfm-0007ec-VP
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 22:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381Ab0FLUvK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 16:51:10 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:40820 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752315Ab0FLUvI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jun 2010 16:51:08 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100612205100.XRTU3192.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Sat, 12 Jun 2010 21:51:00 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100612205059.OWOX1598.aamtaout03-winn.ispmail.ntl.com@[192.168.1.5]>;
          Sat, 12 Jun 2010 21:50:59 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <cover.1276336602.git.trast@student.ethz.ch>
X-Cloudmark-Analysis: v=1.1 cv=1ggfb5FlKZQUfF3vzm9UBYZ2uTfLsbs/8dSljwg5+mE= c=1 sm=0 a=ObDsETojVOcA:10 a=uEzv4HemXiYA:10 a=IkcTkHD0fZMA:10 a=kUhK3Ky5nUueRzYQ_sIA:9 a=dFQ8Fc84Pi6pbjYjJBkA:7 a=P-v4BzZcwP_YyhEcpAbLl1e4OukA:4 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149029>

Add a notification in the command prompt specifying whether (and option=
ally how
far) your branch has diverged from its upstream.  This is especially he=
lpful in
small teams that very frequently (forget to) push to each other.

Support git-svn upstream detection as a special case, as migrators from
centralised version control systems are especially likely to forget to =
push.

Also provide ways for the user to specify a custom upstream, or code th=
at
figures out the upstream.

Support for other types of upstream than SVN should be easy to add if a=
nyone is
so inclined.
---

This is based largely on Thomas' patch, but with some significant
differences.  Thanks once again Thomas.

I've made the quieter </> behaviour the default.  A major use case for
me will be over-the-shoulder checking for the rest of my team - I can
probably add a couple of characters to their prompts without raising
any eyebrows, but " u+1-2" is enough UI to provoke people's curiosity.
If they're not interested in this feature, it will be harder for me to
justify 6+ interesting characters than 2 boring ones.  I haven't gone
with Steven's =E2=86=91/=E2=86=93 idea because I don't want to field co=
mplaints
about "my terminal is Unicode-aware but those characters are
unreadable in my default font".  I'd rather people edit the source for
that sort of thing.

I've added a message in the "equal to upstream" case, to differentiate
it from the "no upstream" case.  Again, this is an over-the-shoulder
issue - when I see an "=3D" (or " u=3D") in someone's prompt, I don't h=
ave
to patronise them about whether they've e.g. misconfigured their
branch.

I've added a legacy mode to make the script work without "git rev-list
--count".  I really like the "git rev-list --count" option, but
getting my team to run a patched version of git would be quite a bit
more trouble than it's worth.  If people strongly object to this
feature then I can hide it better or remove it from the public patch.

The documentation for the "legacy" option currently reads "don't use
the '--count' option available in recent versions of git-rev-list".
If/when "--count" makes it into master, this could be changed to
"compatibility mode for git versions less than <version when --count
went in>".

I've made several efficiency improvements, only one of which is
particularly interesting: instead of doing an `echo`, the code now
sets `p=3D` directly.  Admittedly this is messier, but $p is dynamicall=
y
scoped and testing suggests that setting it knocks 10% or so off
run-time.

The code should now handle multiple SVN repositories, by getting all
svn-remote.*.url config options with a --get-regexp.

I like the "ref" option, but I'm not really sure when "eval" would be
useful.  I've changed it here to "cmd" so people are encouraged to put
their work in a script.

I've tried to take Szeder's comments on board, but I'm not really sure
what the problem with unnecessary empty lines is.  If this is a
convention I'm not aware of, could you explain in a bit more detail?

	- Andrew

 contrib/completion/git-completion.bash |  144 ++++++++++++++++++++++++=
+++++++-
 1 files changed, 143 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 57245a8..7e40f65 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -42,6 +42,23 @@
 #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there'r=
e
 #       untracked files, then a '%' will be shown next to the branch n=
ame.
 #
+#       If you would like to see the difference between HEAD and its
+#       upstream, set GIT_PS1_SHOWUPSTREAM to a nonempty value.  A "<"
+#       indicates you are behind, ">" indicates you are ahead, and
+#       "<>" indicates you have diverged.  You can further control the
+#       output by setting GIT_PS1_SHOWUPSTREAM to a space-separated
+#       list of values:
+#           git           compare HEAD to @{upstream}
+#           svn           compare HEAD to your SVN upstream
+#           ref=3D<ref>     compare HEAD to <ref>
+#           cmd=3D<command> compare HEAD to the output of <command>
+#           verbose       show number of commits ahead/behind (+/-) up=
stream
+#           legacy        don't use the '--count' option available in =
recent
+#                         versions of git-rev-list
+#       If none of 'git', 'svn', 'ref' or 'cmd' are specified, your SV=
N
+#       upstream will be used if configured, or your git upstream othe=
rwise.
+#
+#
 # To submit patches:
 #
 #    *) Read Documentation/SubmittingPatches
@@ -78,6 +95,126 @@ __gitdir ()
 	fi
 }
=20
+# stores the divergence from upstream in $p
+# used by GIT_PS1_SHOWUPSTREAM
+__git_ps1_show_upstream ()
+{
+	local cfg=3D( $( git config --get-regexp '^bash\.showUpstream$|^svn-r=
emote\..*\.url$' 2>/dev/null ) )
+	local svn_remote=3D() svn_url_pattern count n
+	local upstream=3Dgit legacy verbose
+
+	# get some config options from git-config
+	for (( n=3D0; "$n" !=3D "${#cfg[@]}"; ++n )); do
+		case "${cfg[$n]}" in
+			bash.showUpstream)
+				GIT_PS1_SHOWUPSTREAM=3D"${cfg[$((n+1))]}"
+				if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
+					p=3D""
+					return
+				fi
+				;;
+			svn-remote.*.url)
+				svn_remote[ $(( ${#svn_remote[@]} + 1 )) ]=3D"${cfg[$((n+1))]}"
+				svn_url_pattern+=3D"\\|${cfg[$((n+1))]}"
+				upstream=3Dsvn # default upstream is SVN if available
+				;;
+		esac
+	done
+
+	# parse configuration values
+	for option in ${GIT_PS1_SHOWUPSTREAM}; do
+		case "$option" in
+			git|svn|"ref=3D"*|"cmd=3D"*) upstream=3D"$option" ;;
+			verbose) verbose=3D1 ;;
+			legacy)  legacy=3D1  ;;
+		esac
+	done
+
+	# Find our upstream
+	case "$upstream" in
+		git)    upstream=3D"@{upstream}" ;;
+		ref\=3D*) upstream=3D"${option:4}" ;;
+		cmd\=3D*) upstream=3D$( "${option:4}" ) ;;
+		svn)
+			# get the upstream from the "git-svn-id: ..." in a commit message
+			# (git-svn uses essentially the same procedure internally)
+			upstream=3D( $(git log --first-parent -1 \
+					--grep=3D"^git-svn-id: \(${svn_url_pattern:2}\)") )
+			if [[ -n "$upstream" ]]; then
+				upstream=3D${upstream[ ${#upstream[@]} - 2 ]}
+				upstream=3D${upstream%@*}
+				for (( n=3D1; "$n" <=3D "${#svn_remote[@]}"; ++n )); do
+					upstream=3D${upstream#${svn_remote[$n]}}
+				done
+
+				if [[ -z "$upstream" ]]; then
+					# default branch name for checkouts with no layout:
+					upstream=3D${GIT_SVN_ID:-git-svn}
+				else
+					upstream=3D${upstream#/}
+				fi
+
+			fi
+			;;
+	esac
+
+	# Find how many commits we are ahead/behind our upstream
+	if [[ -z "$legacy" ]]; then
+		count=3D"$(git rev-list --count --left-right \
+				"$upstream"...HEAD 2>/dev/null)"
+	else
+		# produce equivalent output to --count for older versions of git
+		local commits
+		if commits=3D"$( git rev-list --left-right "$upstream"...HEAD 2>/dev=
/null )"
+		then
+			local commit behind=3D0 ahead=3D0
+			for commit in $commits
+			do
+				case "$commit" in
+					"<"*) let ++behind
+						;;
+					*)    let ++ahead
+						;;
+				esac
+			done
+			count=3D"$behind	$ahead"
+		else
+			count=3D""
+		fi
+	fi
+
+	# calculate the result
+	if [[ -z "$verbose" ]]; then
+		case "$count" in
+			"") # no upstream
+				p=3D"" ;;
+			"0	0") # equal to upstream
+				p=3D"=3D" ;;
+			"0	"*) # ahead of upstream
+				p=3D">" ;;
+			*"	0") # behind upstream
+				p=3D"<" ;;
+			*)	    # diverged from upstream
+				p=3D"<>" ;;
+		esac
+	else
+		case "$count" in
+			"") # no upstream
+				p=3D"" ;;
+			"0	0") # equal to upstream
+				p=3D" u=3D" ;;
+			"0	"*) # ahead of upstream
+				p=3D" u+${count#0	}" ;;
+			*"	0") # behind upstream
+				p=3D" u-${count%	0}" ;;
+			*)	    # diverged from upstream
+				p=3D" u+${count#*	}-${count%	*}" ;;
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
=20
 		if [ "true" =3D "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]=
; then
 			if [ "true" =3D "$(git rev-parse --is-bare-repository 2>/dev/null)"=
 ]; then
@@ -159,10 +297,14 @@ __git_ps1 ()
 			      u=3D"%"
 			   fi
 			fi
+
+			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+				__git_ps1_show_upstream
+			fi
 		fi
=20
 		local f=3D"$w$i$s$u"
-		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r"
+		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
 	fi
 }
=20
--=20
1.7.0.4
