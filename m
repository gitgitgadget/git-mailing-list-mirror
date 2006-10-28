X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	TVD_RCVD_SPACE_BRACKET,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Bash completion support for aliases
Date: Sat, 28 Oct 2006 14:12:20 +0200
Message-ID: <20061028121220.G3421aba@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 12:12:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30374>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdn37-0004Hb-Fv for gcvg-git@gmane.org; Sat, 28 Oct
 2006 14:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752195AbWJ1MMY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 08:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbWJ1MMY
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 08:12:24 -0400
Received: from kleekamp.stosberg.net ([85.116.201.130]:28291 "EHLO
 kleekamp.stosberg.net") by vger.kernel.org with ESMTP id S1752195AbWJ1MMX
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 08:12:23 -0400
Received: by kleekamp.stosberg.net (Postfix, from userid 500) id 9039B112440;
 Sat, 28 Oct 2006 14:12:20 +0200 (CEST)
Received: from leonov ([unix socket]) by leonov (Cyrus
 v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Sat, 28 Oct 2006 13:35:59
 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

 - Add aliases to the list of available git commands.
 - Make completion work for aliased commands.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 contrib/completion/git-completion.bash |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d9cb17d..b074f4f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -101,6 +101,23 @@ __git_complete_file ()
 	esac
 }
 
+__git_aliases ()
+{
+	git repo-config --list | grep '^alias\.' \
+		| sed -e 's/^alias\.//' -e 's/=.*$//'
+}
+
+__git_aliased_command ()
+{
+	local cmdline=$(git repo-config alias.$1)
+	for word in $cmdline; do
+		if [ "${word##-*}" ]; then
+			echo $word
+			return
+		fi
+	done
+}
+
 _git_branch ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -264,10 +281,18 @@ _git ()
 {
 	if [ $COMP_CWORD = 1 ]; then
 		COMPREPLY=($(compgen \
-			-W "--version $(git help -a|egrep '^ ')" \
+			-W "--version $(git help -a|egrep '^ ') \
+			    $(__git_aliases)" \
 			-- "${COMP_WORDS[COMP_CWORD]}"))
 	else
-		case "${COMP_WORDS[1]}" in
+		local command="${COMP_WORDS[1]}"
+		local expansion=$(__git_aliased_command "$command")
+
+		if [ "$expansion" ]; then
+			command="$expansion"
+		fi
+
+		case "$command" in
 		branch)      _git_branch ;;
 		cat-file)    _git_cat_file ;;
 		checkout)    _git_checkout ;;
-- 
