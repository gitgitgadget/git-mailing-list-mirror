From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: fix issues with COMP_WORDBREAKS
Date: Mon, 16 Apr 2012 00:17:34 +0300
Message-ID: <1334524654-13482-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 23:18:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJWq4-0003Gm-Ig
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 23:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab2DOVSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 17:18:00 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39766 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab2DOVR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 17:17:59 -0400
Received: by lbom4 with SMTP id m4so8198lbo.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=MQFPVeV7KlWRErQbrgZdhdosW5f08NMyFiKm/UTc1co=;
        b=D9EbMquaJzUETx5Im94XrtCdEFUyTQ7qsQ1EhCdnljd2ri0HZxt0qtXOIXaMPZjl39
         Lgg1nwOf81jVX4CFN0X+VYLOiXwuG3YJaMW7qvUgdsH1i3eONMSj7Js7a3YVkI7FSRl4
         OL69zknV/X4BIIdX809VgbrfXHCHGr8VRhv9fR+Wmz6l+FQ5t0lmmrqr1rQXX3WS1CKq
         M2OTS9d9W49Drl1/f7ex30ppR9rgiN5ANjkM455cQ/b9fygdGtB0w4wqtn1OoAqeWYq4
         xl8Hexo2EvLq8GEsYwsJ8B0MfL39jvQVpnK6M3CMHvbeYTNqTmFU26hhL+XrXkzWV5ia
         ahAQ==
Received: by 10.112.28.1 with SMTP id x1mr3900395lbg.82.1334524677784;
        Sun, 15 Apr 2012 14:17:57 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id pb13sm17125468lab.16.2012.04.15.14.17.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 14:17:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195589>

The situation regarding COMP_WORDBREAKS has changed through time, but
right now due to changes in bash 4 we are using _get_comp_words_by_ref
and there's no need to mess directly with COMP_WORDBREAKS any more.

In fact if COMP_WORDBREAKS doesn't contain a colon the completion gets
all messed up. For example:

 git push origin master:<TAB>
 git diff master:<TAB>

The "master:" prefix would be added again, unnecessarily.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f56ec7..d9771f2 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -65,11 +65,6 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 	autoload -U +X bashcompinit && bashcompinit
 fi
 
-case "$COMP_WORDBREAKS" in
-*:*) : great ;;
-*)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
-esac
-
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # returns location of .git repo
 __gitdir ()
@@ -671,11 +666,6 @@ __git_complete_revlist_file ()
 			;;
 		esac
 
-		case "$COMP_WORDBREAKS" in
-		*:*) : great ;;
-		*)   pfx="$ref:$pfx" ;;
-		esac
-
 		local IFS=$'\n'
 		COMPREPLY=($(compgen -P "$pfx" \
 			-W "$(git --git-dir="$(__gitdir)" ls-tree "$ls" \
@@ -758,10 +748,6 @@ __git_complete_remote_or_refspec ()
 	[ "$remote" = "." ] && remote=
 	case "$cur_" in
 	*:*)
-		case "$COMP_WORDBREAKS" in
-		*:*) : great ;;
-		*)   pfx="${cur_%%:*}:" ;;
-		esac
 		cur_="${cur_#*:}"
 		lhs=0
 		;;
-- 
1.7.10
