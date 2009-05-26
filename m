From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] t9120: don't expect failure with SVN_HTTPD_PORT unset
Date: Mon, 25 May 2009 23:15:47 -0700
Message-ID: <1243318547-20023-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 08:15:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8px8-0003ew-V3
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 08:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938AbZEZGPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 02:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754738AbZEZGPu
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 02:15:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:36516 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754834AbZEZGPt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 02:15:49 -0400
Received: by rv-out-0506.google.com with SMTP id f6so867200rvb.5
        for <git@vger.kernel.org>; Mon, 25 May 2009 23:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=FnmC7Nt+v3AMIvHwYLb+pp4xHOlO6rPHWH//+JRvy1E=;
        b=t2Bb+9+hM0He8+5/ibVtplX0o2Fljtscvp6UCoPqVrxB5GCyHT/6ATKYesHcxtsqoQ
         ycUd8fOigXB5IO5fGJGZD5s6gbw+Apd5fiiumOFOQ+g5GMCkGYzjjaKD/sRSMG6fq9RD
         qWJRbZHmKyL65ZBxJWJvuhsWrDGC8hETy11K0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XnkM86q2J8rR7SY6xF+mRLXs9V7SeOpGS+85SsKiPft0TDifOfxUkdAfjHAR4b+ZnO
         ceksm1KSilSTScOCDeI8+MwciD192qSPojKpiVvBsJrESWv1wWWWf21nH4zhIni/e5gU
         lsE4USkJOjRusuWH3P6vZIY+JkrzGOT+TGSHE=
Received: by 10.142.49.4 with SMTP id w4mr1385923wfw.174.1243318550947;
        Mon, 25 May 2009 23:15:50 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 22sm32328wfd.39.2009.05.25.23.15.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 23:15:50 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 25 May 2009 23:15:47 -0700
X-Mailer: git-send-email 1.6.3.1.152.g9619f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119998>

The test still passes when SVN_HTTPD_PORT is not set. Futhermore, t9115
and t9118 don't check if SVN_HTTPD_PORT is set even though they both use
start_httpd() from lib-git-svn.sh. Admittedly, the test is not very
meaningful without SVN_HTTPD_PORT, as commit f5530b (support for funky
branch and project names over HTTP(S) 2007-11-11) states that the URI
escaping is only done over HTTP(S).

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 t/t9120-git-svn-clone-with-percent-escapes.sh |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
index 555a018..f159ab6 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -14,17 +14,12 @@ test_expect_success 'setup svnrepo' '
 	start_httpd
 '
 
-if test "$SVN_HTTPD_PORT" = ""
-then
-	test_expect_failure 'test clone with percent escapes - needs SVN_HTTPD_PORT set' 'false'
-else
-	test_expect_success 'test clone with percent escapes' '
-		git svn clone "$svnrepo/pr%20ject" clone &&
-		cd clone &&
-			git rev-parse refs/${remotes_git_svn} &&
-		cd ..
-	'
-fi
+test_expect_success 'test clone with percent escapes' '
+	git svn clone "$svnrepo/pr%20ject" clone &&
+	cd clone &&
+		git rev-parse refs/${remotes_git_svn} &&
+	cd ..
+'
 
 stop_httpd
 
-- 
1.6.3.1.152.g9619f
