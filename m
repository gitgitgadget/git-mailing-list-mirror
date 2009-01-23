From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH] Allow cloning an empty repository
Date: Fri, 23 Jan 2009 01:07:32 +0100
Message-ID: <1232669252-21881-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 02:09:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQAXc-0001hx-FH
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 02:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbZAWBHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 20:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755298AbZAWBHi
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 20:07:38 -0500
Received: from mailfe11.swip.net ([212.247.155.65]:35025 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753595AbZAWBHh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 20:07:37 -0500
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jan 2009 20:07:36 EST
X-Cloudmark-Score: 0.000000 []
X-Cloudmark-Analysis: v=1.0 c=1 a=E-kudrXTvjgA:10 a=avaZzRB4Cncbk6OtvmOs9w==:17 a=MGlPWax27DtrdyUT6tAA:9 a=3IOR3_NyS0T9RushFvPSyRxu0KcA:4 a=q2uTnOXaV24A:10 a=MSl-tDqOz04A:10 a=955elKCOoL8A:10
Received: from [87.211.114.138] (account cxu-984-6hm@tele2.nl HELO localhost.localdomain)
  by mailfe11.swip.net (CommuniGate Pro SMTP 5.2.6)
  with ESMTPA id 1012137174; Fri, 23 Jan 2009 01:07:32 +0100
X-Mailer: git-send-email 1.6.1.399.g0d272.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106816>

Cloning an empty repository manually (that is, doing 'git init' and
then doing all configuration by hand) can be a lot of work. Save the
user this work by allowing the cloning of empty repositories.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

Thanks to Dscho for giving some pointers on how to do this.

 builtin-clone.c        |   17 +++++++++++++----
 t/t5701-clone-local.sh |   16 ++++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index f7e5a7b..d5bba0e 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -522,14 +522,23 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					     option_upload_pack);
 
 		refs = transport_get_remote_refs(transport);
-		transport_fetch_refs(transport, refs);
+		if(refs)
+			transport_fetch_refs(transport, refs);
 	}
 
-	clear_extra_refs();
+	if(refs) {
+		clear_extra_refs();
 
-	mapped_refs = write_remote_refs(refs, &refspec, reflog_msg.buf);
+		mapped_refs = write_remote_refs(refs, &refspec, reflog_msg.buf);
 
-	head_points_at = locate_head(refs, mapped_refs, &remote_head);
+		head_points_at = locate_head(refs, mapped_refs, &remote_head);
+	}
+	else {
+		warning("You appear to have cloned an empty repository.");
+		head_points_at = NULL;
+		remote_head = NULL;
+		option_no_checkout = 1;
+	}
 
 	if (head_points_at) {
 		/* Local default branch link */
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 8dfaaa4..fbd9bfa 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -116,4 +116,20 @@ test_expect_success 'bundle clone with nonexistent HEAD' '
 	test ! -e .git/refs/heads/master
 '
 
+test_expect_success 'clone empty repository' '
+	cd "$D" &&
+	mkdir empty &&
+	(cd empty && git init) &&
+	git clone empty empty-clone &&
+	test_tick &&
+	(cd empty-clone
+	 echo "content" >> foo &&
+	 git add foo &&
+	 git commit -m "Initial commit" &&
+	 git push origin master &&
+	 expected=$(git rev-parse master) &&
+	 actual=$(git --git-dir=../empty/.git rev-parse master) &&
+	 test $actual = $expected)
+'
+
 test_done
-- 
1.6.1.399.g0d272.dirty
