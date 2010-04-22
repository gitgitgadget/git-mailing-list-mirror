From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2] t1304,t2007: quell output to stdout and stderr
Date: Thu, 22 Apr 2010 22:45:23 +0200
Message-ID: <5ef48a01f29730a24b74d599bb9b89e77591decf.1271969046.git.git@drmicha.warpmail.net>
References: <20100421151236.GB8726@progeny.tock>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 22 22:45:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O53HY-0006ze-NJ
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 22:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758649Ab0DVUpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 16:45:46 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36112 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756050Ab0DVUp1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 16:45:27 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BB123EB4D5;
	Thu, 22 Apr 2010 16:45:26 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 22 Apr 2010 16:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=PAurDkllBVeRJEFPsZNvu+NBxh4=; b=VnZctV29kihLA8Jlj+40BxzE7qywX5IjbEfsuXUvFQtbV+o9G14pXBbPHpKAH2iBlg8jF9cytCjzwenA4+eDhou1ejKgAY+S8FCnwz/TaN5a6FDWXDC5WLFWmpTlPZHHoa4kKWun40qtM+K3SCimZ8YUquAeyrY0b/3vK1JjJ1g=
X-Sasl-enc: FGk2GVHG9YUdshgh25Paho48oGxwV8MEDiUbM1cU5t6Y 1271969125
Received: from localhost (p5DCC0786.dip0.t-ipconnect.de [93.204.7.134])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9E8C84B9A39;
	Thu, 22 Apr 2010 16:45:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc1.248.gcefbb
In-Reply-To: <20100421151236.GB8726@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145560>

These tests send output to stdout or stderr even without -v. This is
distracting because unexpected output flashing by during make test
usually indicates problems.

Shut them up unconditionally by integrating them in test code: In both
cases, the output was due to intermediate commands in between the actual
test cases.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t1304-default-acl.sh      |   10 +++++++++-
 t/t2007-checkout-symlink.sh |    5 ++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 055ad00..8b3ff7a 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -15,7 +15,15 @@ umask 077
 # is a good candidate: exists on all unices, and it has permission
 # anyway, so we don't create a security hole running the testsuite.
 
-if ! setfacl -m u:root:rwx .; then
+test_expect_success 'Setup: try to set an ACL' '
+	if setfacl -m u:root:rwx .
+	then
+		test_set_prereq ACL
+	fi
+'
+
+if ! test_have_prereq ACL
+then
     say "Skipping ACL tests: unable to use setfacl"
     test_done
 fi
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index 20f3343..e98ec4c 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -44,11 +44,10 @@ test_expect_success 'switch from symlink to dir' '
 
 '
 
-rm -fr frotz xyzzy nitfol &&
-git checkout -f master || exit
-
 test_expect_success 'switch from dir to symlink' '
 
+	rm -fr frotz xyzzy nitfol &&
+	git checkout -f master &&
 	git checkout side
 
 '
-- 
1.7.1.rc1.248.gcefbb
