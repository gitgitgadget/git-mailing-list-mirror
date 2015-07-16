From: Joey Hess <joey@joeyh.name>
Subject: [PATCH] support bash completion for add-on commands
Date: Thu, 16 Jul 2015 13:22:34 -0400
Message-ID: <20150716172234.GA3865@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 19:22:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFmrx-00086P-3i
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 19:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118AbbGPRWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 13:22:45 -0400
Received: from kitenet.net ([66.228.36.95]:53728 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbbGPRWo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 13:22:44 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=kVB/G+GK;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1437067354; bh=S41M8xrs0gjLpTaf2Y78ysFHAKcge7Ulwdhy/OHE+N8=;
	h=Date:From:To:Subject:From;
	b=kVB/G+GKKLHrAS99NIkJVVzUp5fFhkDT+KmoUt4RAfoInQq+gOpPDIHOoT8uo/ikU
	 5KuhVw2HYK7SKgPUi+h5okRafG+i0Y65RlM49f4k9jFoJ43oU0F3p4k3npGYsM3Tef
	 OwtYrGNA0M4+15XcBl0yKMcBSpRIFfj9hI2uoLgg=
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-91.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BRBL_LASTEXT,RCVD_IN_PBL,
	RCVD_IN_RP_RNBL,RCVD_IN_SORBS_DUL,RDNS_NONE,SPF_SOFTFAIL,URIBL_BLOCKED,
	USER_IN_WHITELIST autolearn=no autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274034>

This makes it possible to implement bash completion for add-on commands,
that will work even when the bash completion scripts are being loaded
on-demand, as is done by the bash-completion package.

git's bash completion handles subcommands by running a _git_$command
function. As well as the many such functions included in
git-completion.bash, there can be other functions defined elsewhere
to support third-party add-on git commands, and they'll happily be used.

But, bash completion scripts are often loaded on demand, as shown in the
completion_loader example in bash's man page, and the bash-completion
implementation that is commonly used on many Linux systems. The demand
loading will load this very script from some place like
/usr/share/bash-completion/completions/git, when the user complete a git
command. But, completion scripts for git add-on commands don't get loaded.

For example, when I wrote a git-annex bash completion script,
bash was unable to tab complete "git annex foo", until I tab completed a
"git-annex" command. Which loaded the git-annex completion, and then
that same completion worked to make "git annex foo" tab complete. An
inconsistent UI..

So, if the git completion script is unable to find the wanted
_git_$command function, have it fall-back to looking for a git-$command
completion script, and loading it. The add-on script is looked for in the
same directory as the git completion script, which we can find by looking
at BASH_SOURCE.

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 contrib/completion/git-completion.bash | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c97c648..ba91b2a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2614,7 +2614,16 @@ __git_main ()
 	if [ -n "$expansion" ]; then
 		words[1]=$expansion
 		completion_func="_git_${expansion//-/_}"
-		declare -f $completion_func >/dev/null && $completion_func
+		declare -f $completion_func >/dev/null && $completion_func && return
+	fi
+
+	# As a fallback, if no completion function is defined for the
+	# command, look for add-on command completion script in same
+	# directory as this completion script, and if found, source it,
+	# and restart completion using it.
+	local compdir="${BASH_SOURCE%/*}"
+	if [ -e "$compdir/git-$command" ]; then
+		source "$compdir/git-$command" && __git_main "$@"
 	fi
 }
 

-- 
2.1.4
