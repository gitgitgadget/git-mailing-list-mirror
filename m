From: Phil Hord <hordp@cisco.com>
Subject: [PATCH v2] cherry-pick: No advice to commit if --no-commit
Date: Tue, 21 Feb 2012 19:44:17 -0500
Message-ID: <1329871457-12890-1-git-send-email-hordp@cisco.com>
Cc: Phil Hord <hordp@cisco.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 01:44:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S00Jo-0002Cq-Kf
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 01:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab2BVAoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 19:44:24 -0500
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:55480 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374Ab2BVAoX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 19:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=3212; q=dns/txt;
  s=iport; t=1329871463; x=1331081063;
  h=from:to:cc:subject:date:message-id;
  bh=2iRzacscQGVxy9LwlsCZdiNxysAp/jGWS9jUuVwyJM0=;
  b=D9AYtpbUZKwmFuPNfilTPg8dO3VrdFg3mqR2f9ddH3LjXcG6O1ielK8W
   s/47TLmQHW1NnEI3D+0/GXrVPpvjRwIzhS1SbHFfgNJ5sK9svnBzBtAWQ
   PSBjunU+bkJR1Rysz+MxaKwEoCOlLoRA5bW2E2t2r/vuDoLd2exRuFbun
   4=;
X-IronPort-AV: E=Sophos;i="4.73,460,1325462400"; 
   d="scan'208";a="60795428"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-7.cisco.com with ESMTP; 22 Feb 2012 00:44:23 +0000
Received: from iptv-lnx-hordp.cisco.com (rtp-hordp-8912.cisco.com [10.117.80.99])
	by rcdn-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id q1M0iLWk027502;
	Wed, 22 Feb 2012 00:44:22 GMT
X-Mailer: git-send-email 1.7.9.267.gda172.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191206>

When cherry-pick fails it offers a helpful hint about how to
proceed.  The hint tells the user how to do the cleanup
needed by the conflicted cherry-pick and finish the job after
conflict resolution.  In case of cherry-pick --no-commit, the
hint goes too far. It tells the user to finish up with
'git commit'.  That is not what this git-cherry-pick was
trying to do in the first place.

Restrict the hint in case of --no-commit to avoid giving this
extra advice.

Also, add a test verifying the reduced hint for the --no-commit
version of cherry-pick.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 sequencer.c                     |   17 +++++++++++------
 t/t3507-cherry-pick-conflict.sh |   14 ++++++++++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5fcbcb8..9716c63 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -123,7 +123,7 @@ static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)
 	strbuf_release(&buf);
 }
 
-static void print_advice(int show_hint)
+static void print_advice(int show_hint, struct replay_opts *opts)
 {
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
 
@@ -138,10 +138,15 @@ static void print_advice(int show_hint)
 		return;
 	}
 
-	if (show_hint)
-		advise(_("after resolving the conflicts, mark the corrected paths\n"
-			 "with 'git add <paths>' or 'git rm <paths>'\n"
-			 "and commit the result with 'git commit'"));
+	if (show_hint) {
+		if (opts->no_commit)
+			advise(_("after resolving the conflicts, mark the corrected paths\n"
+				 "with 'git add <paths>' or 'git rm <paths>'"));
+		else
+			advise(_("after resolving the conflicts, mark the corrected paths\n"
+				 "with 'git add <paths>' or 'git rm <paths>'\n"
+				 "and commit the result with 'git commit'"));
+    }
 }
 
 static void write_message(struct strbuf *msgbuf, const char *filename)
@@ -423,7 +428,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
 		      msg.subject);
-		print_advice(res == 1);
+		print_advice(res == 1, opts);
 		rerere(opts->allow_rerere_auto);
 	} else {
 		if (!opts->no_commit)
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index ee1659c..0c81b3c 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -59,6 +59,20 @@ test_expect_success 'advice from failed cherry-pick' "
 	test_i18ncmp expected actual
 "
 
+test_expect_success 'advice from failed cherry-pick --no-commit' "
+	pristine_detach initial &&
+
+	picked=\$(git rev-parse --short picked) &&
+	cat <<-EOF >expected &&
+	error: could not apply \$picked... picked
+	hint: after resolving the conflicts, mark the corrected paths
+	hint: with 'git add <paths>' or 'git rm <paths>'
+	EOF
+	test_must_fail git cherry-pick --no-commit picked 2>actual &&
+
+	test_i18ncmp expected actual
+"
+
 test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick picked &&
-- 
1.7.9.267.gda172.dirty
