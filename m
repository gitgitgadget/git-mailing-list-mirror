From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 09/48] t6036: criss-cross with weird content can fool git into clean merge
Date: Wed,  8 Jun 2011 01:30:39 -0600
Message-ID: <1307518278-23814-10-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:32:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDFV-0007JK-Gk
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab1FHHcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:32:00 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43667 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab1FHH3L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:11 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so118978pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=jbV1UNZ71xh5GoICoAcTCPSJPd3SNY5NBzv9YcOx1Ug=;
        b=eJMUcA1dj56Rcak0I+GTTVieBt1EtpNfsUN/ur9s0EMO/1u9ZAYSjoU7VKmUk+AABP
         TFDDQsGRfie1WifFDyLskYSWMXloe4WY8Og1JdrPkQgqXAHKC4pj+70nVfZA3gQKRsZ2
         PBkcCH/NmzaFCTZOvHg3qKiq2AgKlbJ59lsMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CefZ3hvVjAyrJYTlgdpUKajsvp8Mb786wfdppuJzVYAeDLl6DAzp35cUkX5zKbAJ/X
         1SRcaCcn3vlT2C08Iee1idxDDSYkwbRPKsqimEqvkZB+whR299nf3e7jz7hJCmr2QUeC
         zXp+by0e6+6+6UkQ3/eYTOf1MSFyFoA0GVjhY=
Received: by 10.68.10.105 with SMTP id h9mr593260pbb.108.1307518151063;
        Wed, 08 Jun 2011 00:29:11 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.08
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175340>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh |   83 +++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 52d2ecf..dab52a4 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -314,4 +314,87 @@ test_expect_failure 'git detects conflict merging criss-cross+modify/delete, rev
 	test $(git rev-parse :3:file) = $(git rev-parse B:file)
 '
 
+#
+# criss-cross + modify/modify with very contrived file contents:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: file with contents 'A\n'
+#   Commit B: file with contents 'B\n'
+#   Commit C: file with contents 'C\n'
+#   Commit D: file with contents 'D\n'
+#   Commit E: file with contents:
+#      <<<<<<< Temporary merge branch 1
+#      C
+#      =======
+#      B
+#      >>>>>>> Temporary merge branch 2
+#
+# Now, when we merge commits D & E, does git detect the conflict?
+
+test_expect_success 'setup differently handled merges of content conflict' '
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	echo A >file &&
+	git add file &&
+	test_tick &&
+	git commit -m A &&
+
+	git branch B &&
+	git checkout -b C &&
+	echo C >file &&
+	git add file &&
+	test_tick &&
+	git commit -m C &&
+
+	git checkout B &&
+	echo B >file &&
+	git add file &&
+	test_tick &&
+	git commit -m B &&
+
+	git checkout B^0 &&
+	test_must_fail git merge C &&
+	echo D >file &&
+	git add file &&
+	test_tick &&
+	git commit -m D &&
+	git tag D &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	cat <<EOF >file &&
+<<<<<<< Temporary merge branch 1
+C
+=======
+B
+>>>>>>> Temporary merge branch 2
+EOF
+	git add file &&
+	test_tick &&
+	git commit -m E &&
+	git tag E
+'
+
+test_expect_failure 'git detects conflict w/ criss-cross+contrived resolution' '
+	git checkout D^0 &&
+
+	test_must_fail git merge -s recursive E^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :2:file) = $(git rev-parse D:file) &&
+	test $(git rev-parse :3:file) = $(git rev-parse E:file)
+'
+
 test_done
-- 
1.7.6.rc0.62.g2d69f
