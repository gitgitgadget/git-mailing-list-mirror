From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 6/8] t9114.2: Don't use --track option against "svn-remote"-tracking branches
Date: Sat, 20 Apr 2013 17:06:01 +0200
Message-ID: <1366470363-22309-7-git-send-email-johan@herland.net>
References: <1366470363-22309-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 20 17:06:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZND-0000BZ-2o
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 17:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420Ab3DTPGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 11:06:40 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:54289 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab3DTPGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 11:06:40 -0400
Received: by mail-lb0-f172.google.com with SMTP id u10so4546118lbi.17
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 08:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=leMsIwO2TPmUmnKmq+TAgIoQDAeFYZvffSnqyBXDd5U=;
        b=EtBWldZOShqIj+i3DhdmasjJSMovxb7NtmKRPpknUDeqeGF3pCcQbUDjrDlBeE1Fkv
         G3+U0AbCv2FPCBW0NL96K3oz3ysoC3w+HWwRTJV1VSF+0OtKbBdcX7rc3xswOrBFV7P/
         uK6IMhyrNAEWDcTdh9yY3aECaYTrEj4l3lSJ5C6CEffmgB4KqpDcDbuWjivCyu+N3TZR
         zd5McQhB8fcJ/E31bUPEyXuyNdP3VgnhcEdZpUAvTc3djNjhusaTbg49FGH2+6Vlu8gV
         i2uTxw3arGbo72nZXkwsKErASzf8wcG2l5dofPa4rZDZGXGgNBrN8imZ71tNfQ0oSOE7
         I8Ig==
X-Received: by 10.152.115.173 with SMTP id jp13mr3339613lab.49.1366470398509;
        Sat, 20 Apr 2013 08:06:38 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id sl5sm7539983lbb.10.2013.04.20.08.06.35
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 08:06:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366470363-22309-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221867>

We are formalizing a requirement that any remote-tracking branch to be used
as an upstream (i.e. as an argument to --track), _must_ "belong" to a
configured remote by being matched by the "dst" side of a fetch refspec.

This test uses --track against a "remotes/trunk" ref which does not belong
to any configured (git) remotes, but is instead created by "git svn fetch"
operating on an svn-remote. It does not make sense to use an svn-remote as
an upstream for a local branch, as a regular "git pull" from (or "git push"
to) it would obviously fail (instead you would need to use "git svn" to
communicate with this remote). Furthermore, the usage of --track in this
case is unnecessary, since the upstreaming config that would be created is
never used.

Simply removing --track fixes the issue without changing the expected
behavior of the test.

Cc: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t9114-git-svn-dcommit-merge.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index 3077851..f524d2f 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -48,7 +48,7 @@ test_expect_success 'setup svn repository' '
 test_expect_success 'setup git mirror and merge' '
 	git svn init "$svnrepo" -t tags -T trunk -b branches &&
 	git svn fetch &&
-	git checkout --track -b svn remotes/trunk &&
+	git checkout -b svn remotes/trunk &&
 	git checkout -b merge &&
 	echo new file > new_file &&
 	git add new_file &&
-- 
1.8.1.3.704.g33f7d4f
