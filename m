From: Steven Penny <svnpenn@gmail.com>
Subject: [PATCH] git-sh-setup: work around Cygwin path handling gotchas
Date: Wed, 16 May 2012 19:39:42 -0500
Message-ID: <1337215182-4036-1-git-send-email-svnpenn@gmail.com>
Cc: Steven Penny <svnpenn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 02:40:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUold-0004HO-PB
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 02:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757035Ab2EQAk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 20:40:28 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34696 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab2EQAk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 20:40:27 -0400
Received: by obbtb18 with SMTP id tb18so1737837obb.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/9AXew6EBSuz+FIJOI6yTNS5UQnGSLvUmJRsPdykWG0=;
        b=WxJA/Twcv7dXA3/5k/qzYOFK3HPIsdnKbTiJpujraXeFywunZoJnBE3/spWM51PQe8
         aG0vi26uFSnBP9ikwGVgMrgqGraKFvMQy7T6NNzGP+4jj6koNYETaySGt0N/scNQEeRG
         YVrIbRxdo235ba7O/zjoDFMP7fycuF+EJ3hCDg2h7CZSmE4HKoih6+Kq9iTWoAFZR91v
         Wi9j4fNcSUbUVH7QyJ8nx5eQiRll+y9AEvHkeGa0D8WfwC+sB9xXql0dTydm1xAPdNCh
         xZOW/u1H1XTZwbI5ILQVo+Rqhb+A/m5DRE/PC7XJEDz3mSews4WzwfeBc/1QJUBFLGM+
         IQlQ==
Received: by 10.60.3.234 with SMTP id f10mr4581380oef.66.1337215227134;
        Wed, 16 May 2012 17:40:27 -0700 (PDT)
Received: from localhost.localdomain (cpe-76-187-106-31.tx.res.rr.com. [76.187.106.31])
        by mx.google.com with ESMTPS id r8sm3015978oer.6.2012.05.16.17.40.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 17:40:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197907>

On Cygwin, tools built for Cygwin can take both Windows-style paths
(e.g. C:/dir/file.txt or C:\dir\file.txt) and Cygwin-style paths
(e.g. /cygdrive/c/dir/file.txt), but Windows-native tools can only take
Windows-style paths.  Because the paths that are relative to $GIT_DIR,
e.g. the name of the insn sheet file of the "rebase -i" command, are given
to the programs with $GIT_DIR prefixed, and $GIT_DIR in turn is computed
by calling "pwd", wrap "pwd" to call "cygpath -m" to give a Windows-style
path, in a way similar to how mingw does this.

Signed-off-by: Steven Penny <svnpenn@gmail.com>
---
 git-sh-setup.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 7b3ae75..07f54c1 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -260,6 +260,11 @@ case $(uname -s) in
 		return 1
 	}
 	;;
+*CYGWIN*)
+	pwd () {
+		cygpath -m "$PWD"
+	}
+	;;
 *)
 	is_absolute_path () {
 		case "$1" in
-- 
1.7.9
