From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 6/8] t9114.2: Don't use --track option against "svn-remote"-tracking branches
Date: Sun, 21 Apr 2013 23:52:04 +0200
Message-ID: <1366581126-3880-7-git-send-email-johan@herland.net>
References: <1366581126-3880-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 21 23:53:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU2Bz-0000Ui-0x
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 23:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab3DUVw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 17:52:56 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:46797 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab3DUVwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 17:52:54 -0400
Received: by mail-lb0-f182.google.com with SMTP id z13so5112880lbh.27
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 14:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bDhtzHUGJNEa+a6f2AS2Wvs9tHIgqiKpaoLW0Mjdx60=;
        b=Oa/t2VgvohxAHfQTZbszmDiD1K+VC6URfFUw2F/Vi0ZimA6Ho6QXU+HRItt46E7HTu
         NLAYUs8Ox1c7v6twI2P3d2y4P/FalW6b9J7oOvOdy6O6fvMB1KCSiLuHo9C3kxaSCNJj
         bC1wuvtVMrVTVpqbOPDgd6z86IUWOo7f4HZQ1NquCYs6yy6oP1gabURXdGdSGLqqKHbP
         uZN//770sb+VTC5ij6BZqtrkLvClZojSSS0KKbO8my/HejsEkneoDh7NeIoe4PoAr0ve
         /n8QF9MmGFjKLadycs6XJ5Byx73BJcNrNhk9E+TcvFnHzdUEFgqWaKdvvZdvBTqgS6mt
         /Pig==
X-Received: by 10.112.162.130 with SMTP id ya2mr11952113lbb.122.1366581172820;
        Sun, 21 Apr 2013 14:52:52 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id ak4sm9489460lbc.12.2013.04.21.14.52.51
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 14:52:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366581126-3880-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221975>

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

Acked-by: Eric Wong <normalperson@yhbt.net>
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
