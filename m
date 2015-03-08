From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] t5528: do not fail with FreeBSD shell
Date: Sun,  8 Mar 2015 08:37:50 -0700
Message-ID: <e3bfc53363b14826d828e1adffbbeea@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 16:38:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUdHJ-00021g-8V
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 16:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbbCHPiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 11:38:00 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:46139 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbbCHPh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 11:37:59 -0400
Received: by pdev10 with SMTP id v10so28299081pde.13
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=izBzEFhEz/Z7LRI0dylUak2+zwzJ5dmWPkTBk78N5UQ=;
        b=mAF1z4jSkl0wJwIbi1zxD+F/6k1PsXpt8s3r0+B/VX2Z4oQwE+FYMH2NUnHRusj8Ro
         +rYIJ5F4qU6eAoYA1inrW6h+y7hGW+WO2QcE2FHlaQ0YSePJJ7StfpBW1EQkJyDMYV1n
         nGp/IUJk3+HlIcUWhv0cYOEFXN9InIdnY2MddAv888shAksKOnur97+YAdKDl02e++dt
         Q7W4kSmVfIk31h/D7VehA+pnrshaSgyCLjdG1BNOnpg+6eH2JKVufxze6ngEXR72Fb8k
         uRotb4TPnHUd1zRH98S/VmVPn3NuojbdJW5+pK5F1MZLo+6IYLbphA/Ofd4z9SnHDss3
         noQA==
X-Received: by 10.67.5.230 with SMTP id cp6mr4398854pad.55.1425829078985;
        Sun, 08 Mar 2015 08:37:58 -0700 (PDT)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id fi8sm5889395pdb.43.2015.03.08.08.37.57
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 08 Mar 2015 08:37:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265094>

The FreeBSD shell converts this expression:

  git ${1:+-c push.default="$1"} push

to this when "$1" is not empty:

  git "-c push.default=$1" push

which causes git to fail.  To avoid this we simply break up the
expansion into two parts so that the whitespace which creates
two arguments instead of one is outside the ${...} like so:

  git ${1:+-c} ${1:+push.default="$1"} push

This has the desired effect on all platforms allowing the test
to pass on FreeBSD.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 t/t5528-push-default.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index cc745190..73f4bb63 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -26,7 +26,7 @@ check_pushed_commit () {
 # $2 = expected target branch for the push
 # $3 = [optional] repo to check for actual output (repo1 by default)
 test_push_success () {
-	git ${1:+-c push.default="$1"} push &&
+	git ${1:+-c} ${1:+push.default="$1"} push &&
 	check_pushed_commit HEAD "$2" "$3"
 }
 
@@ -34,7 +34,7 @@ test_push_success () {
 # check that push fails and does not modify any remote branch
 test_push_failure () {
 	git --git-dir=repo1 log --no-walk --format='%h %s' --all >expect &&
-	test_must_fail git ${1:+-c push.default="$1"} push &&
+	test_must_fail git ${1:+-c} ${1:+push.default="$1"} push &&
 	git --git-dir=repo1 log --no-walk --format='%h %s' --all >actual &&
 	test_cmp expect actual
 }
---
