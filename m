From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: [RFC/PATCHv2] bash completion: Support "divergence from upstream"
 warnings in __git_ps1
Date: Tue, 08 Jun 2010 22:36:49 +0100
Message-ID: <4C0EB7F1.1030707@pileofstuff.org>
References: <4C0AE640.3040503@pileofstuff.org> <201006062014.59386.trast@student.ethz.ch> <4C0C09BF.4070503@pileofstuff.org> <201006070942.34753.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 08 23:37:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM6Ub-0004vf-Ft
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 23:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316Ab0FHVht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 17:37:49 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:51222 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755330Ab0FHVhs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 17:37:48 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100608213741.XIBB3192.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Tue, 8 Jun 2010 22:37:41 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100608213712.GLM1593.aamtaout04-winn.ispmail.ntl.com@[192.168.1.5]>;
          Tue, 8 Jun 2010 22:37:12 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <201006070942.34753.trast@student.ethz.ch>
X-Cloudmark-Analysis: v=1.1 cv=ZtHxNT4mZm3rCuM0SmWmgWxeBwJsziC8EqOrwwVkrhA= c=1 sm=0 a=ns1_rNwsptAA:10 a=uEzv4HemXiYA:10 a=8nJEP1OIZ-IA:10 a=qOz2pZ_4AAAA:8 a=zxblWZ4NWbfarmDdK9oA:9 a=5ywgQj-lR6YOf1umNKg2R-TMRiUA:4 a=wPNLvfGTeEIA:10 a=7qzHkXPk5l4A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148722>

Add a notification in the command prompt specifying whether you're ahead of
(>), behind (<), diverged from (<>) or at (=) your upstream.  This is
especially helpful in small teams that (forget to) push to each other very
frequently.

Support git-svn upstream detection as a special case, as migraters from
centralised version control systems are especially likely to forget to push.

Support for other types of upstream than SVN should be easy to add if anyone is
so inclined.

Signed-off-by: Andrew Sayers <andrew-git@pileofstuff.org>
---

This patch includes Thomas Rast's feedback - thanks Thomas for the education :)

This patch makes unashamed use of shell arrays and substring expansion that
would normally not be allowed.  As Jakub Narebski mentioned, this is probably ok
in a bash-specific script.

Unlike other prompt options, I've put the divergence characters on the left of the
branch name.  I'm really not sure about this, and I'd like to hear people's
opinions.

This patch produces output like this when I have unpushed commits:

[andrew@pc myrepo >master] # my master is ahead of upstream

Intuitively, I like having a ">" when I'm ahead, although it would be more
logical to have something like this:

[andrew@pc myrepo <master] # upstream less-than master

Putting the symbol on the right makes this problem go away, but looks ridiculous
if you use a prompt like PS1='\W:$(__git_ps1 "(%s)")> '

myrepo:master>> # master greater-than upstream
myrepo:master<> # master less-than upstream
myrepo:master<>> # master and upstream have diverged

I'd rather not rely on colour prompts to clear this up - using colour as the
only way to convey important information to the user rarely ends well.

Adding a "u" to the symbol could also clear this up:

[andrew@pc myrepo u<master] # upstream less-than master

Using "u<", "u=", "u>" and "<>" would mean that the prompt always used either
two or zero characters, which would keep prompts lined up over time.  But it
would also eat horizontal space for an issue you'd stop seeing after a few
minutes.

Finally, my apologies to anyone that tried to apply my previous patch - to make
a long story short, it turns out I need this feature more than I realised :)

 contrib/completion/git-completion.bash |   58 +++++++++++++++++++++++++++++++-
 1 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 57245a8..1dc80fd 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -42,6 +42,14 @@
 #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're
 #       untracked files, then a '%' will be shown next to the branch name.
 #
+#       If you would like to see the difference bitween HEAD and its
+#       upstream, set GIT_PS1_SHOWUPSTREAM to a nonempty value.
+#       Unpushed commits (>), unmerged commits (<), both (<>) and
+#       neither (=) will be shown on the left of the branch name.  You
+#       can enable git-svn mode by setting GIT_PS1_SHOWUPSTREAM=svn
+#       and set the value per-repository with the bash.showUpstream
+#       variable.
+#
 # To submit patches:
 #
 #    *) Read Documentation/SubmittingPatches
@@ -132,6 +140,7 @@ __git_ps1 ()
 		local s
 		local u
 		local c
+		local p
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
 			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
@@ -159,10 +168,57 @@ __git_ps1 ()
 			      u="%"
 			   fi
 			fi
+
+			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+
+				# Note: 'p' is used as a temporary throughout this block,
+				# before finally being assigned its correct value
+
+				if p="$(git config --get bash.showUpstream)"
+				then
+					GIT_PS1_SHOWUPSTREAM="$p"
+				fi
+
+				local upstream
+
+				if [ "${GIT_PS1_SHOWUPSTREAM-}" = "svn" ]; then
+
+					# git-svn upstream checking
+					p="$( git config --get svn-remote.svn.url )"
+					upstream=( $( git log --first-parent -1 \
+						--grep="^git-svn-id: $p" ) )
+					upstream=${upstream[ ${#upstream[@]} - 2 ]}
+					upstream=${upstream%@*}
+					upstream=${upstream#*$p/}
+
+				else # git upstream checking
+				  upstream="@{upstream}"
+				fi
+
+				if p="$( git rev-list \
+						--left-right "$upstream"...HEAD 2>/dev/null )"
+				then
+					case "$p" in
+						\<*\>*|\>*\<* ) p="<>" ;;
+						*\<*          ) p="<"  ;;
+						*\>*          ) p=">"  ;;
+						""            ) p="="  ;;
+
+						# the following case shouldn't be possible
+						# if you see this, please report it as a bug
+						* ) p="?ERROR($p)?" ;;
+
+					esac
+				else
+					p=""
+				fi
+
+			fi
+
 		fi
 
 		local f="$w$i$s$u"
-		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r"
+		printf "${1:- (%s)}" "$c$p${b##refs/heads/}${f:+ $f}$r"
 	fi
 }
 
-- 
1.7.0.4
