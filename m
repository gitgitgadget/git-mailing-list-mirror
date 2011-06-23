From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/4] git-instaweb: Move all actions at the end of script
Date: Thu, 23 Jun 2011 22:59:26 +0200
Message-ID: <20110623195652.18265.50516.stgit@localhost.localdomain>
References: <20110623194624.18265.82482.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Gurjeet Singh <singh.gurjeet@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 23:00:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZr0K-000141-25
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 23:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab1FWU7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 16:59:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46754 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab1FWU7y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 16:59:54 -0400
Received: by fxm17 with SMTP id 17so1504478fxm.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=88qGLM0FuEilqGLNRcwu2X3/h+tfVfe7allqrKULeoo=;
        b=N+w4wXItGKmVQBlEYICp+ncTSumnj9jCy+jAHR1Qw9njP6If+a5ksFDPqqxys720S4
         fm4vDhNEo0/aRGNGvZx32qXuRbUkGkSzehKx8+fAIwtNzl1AN8KDHWEENNm5MD9AYc2a
         +6QQ2bJYu4CQxJ+RlTRM8oaJPaM/tUzPNe3zA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=wVlj/ZlrNfx8LREsN5oVfIgX40/fxtgEzccpMyeDZqIxtzeyTi2ijz6BHchYq06xKD
         k7M2Vnd2YVEElxIgPjOPUtTWuoY97P89DqrBfhvnFMPz7ZLRWLnRC8lymvu4DpQCqh8K
         fPMeskamJ2MtN4XFvoPTXGzbwwD1qbUefimao=
Received: by 10.223.79.139 with SMTP id p11mr3229653fak.118.1308862792899;
        Thu, 23 Jun 2011 13:59:52 -0700 (PDT)
Received: from localhost.localdomain (abva28.neoplus.adsl.tpnet.pl [83.8.198.28])
        by mx.google.com with ESMTPS id n27sm1226819faa.4.2011.06.23.13.59.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 13:59:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5NKxQk2019465;
	Thu, 23 Jun 2011 22:59:37 +0200
In-Reply-To: <20110623194624.18265.82482.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176292>

As a nice side-effect now the order of parameters does not matter:

  $ git instaweb --httpd=apache2 --start

is now (after this patch) the same as

  $ git instaweb --start --httpd=apache2

Before this commit --start, --stop, --restart (and their subcommand
versions start, stop, restart) exited immediately.


This is preparatory work for making start/restart check that correct
configuration is set up; this change was required to have access in
start_httpd to requested web browser etc.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Unfortunately there are no tests for git-instaweb, so I couldn't test
if it is really no much of a functional change.

BTW. if you thought of a better subject for this commit, please speak
up.

 git-instaweb.sh |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 2be22a0..9a2f20f 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -27,6 +27,7 @@ httpd="$(git config --get instaweb.httpd)"
 root="$(git config --get instaweb.gitwebdir)"
 port=$(git config --get instaweb.port)
 module_path="$(git config --get instaweb.modulepath)"
+action="browse"
 
 conf="$GIT_DIR/gitweb/httpd.conf"
 
@@ -148,17 +149,13 @@ while test $# != 0
 do
 	case "$1" in
 	--stop|stop)
-		stop_httpd
-		exit 0
+		action="stop"
 		;;
 	--start|start)
-		start_httpd
-		exit 0
+		action="start"
 		;;
 	--restart|restart)
-		stop_httpd
-		start_httpd
-		exit 0
+		action="restart"
 		;;
 	-l|--local)
 		local=true
@@ -611,6 +608,22 @@ configure_httpd() {
 	esac
 }
 
+case "$action" in
+stop)
+	stop_httpd
+	exit 0
+	;;
+start)
+	start_httpd
+	exit 0
+	;;
+restart)
+	stop_httpd
+	start_httpd
+	exit 0
+	;;
+esac
+
 gitweb_conf
 
 resolve_full_httpd
