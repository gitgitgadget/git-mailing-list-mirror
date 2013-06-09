From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/4] push: make upstream, simple work with pushdefault
Date: Sun,  9 Jun 2013 22:43:18 +0530
Message-ID: <1370798000-2358-3-git-send-email-artagnon@gmail.com>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:15:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljDL-0001pk-AT
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332Ab3FIRP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:15:29 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:65405 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab3FIRP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:15:27 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so770234pab.25
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/pASgaP/fwa/oebBXn0+ouWRF4UO28/qRIVHOYM4GXg=;
        b=TrO9w2vI1vC7ViE/uRPnCvcmJel/wlwjs1DpQ1VavjTwoVW/i88a3dwRQLs/D91/D4
         W9Fk4rL63MBw9Oe2+W0tJXxB9du8/tsYTire3S2oO+jUP8zedCeWQyAkAmHeQoiiG9Vi
         wSSDNWFimOmJz75ryZ5rDLfVBvWKvW/HtG8eIg/K8u6mIqP6u9LF18KZYWDJkGtZpd+O
         CRuTVib/zPfrO7VZA+p7CiBijVwMBhZvm1sKiPOpIKfcixkUYQ6gMcqIhjrOdiMX1946
         JJ8s7Tds495Dc7XYJfuAl/s6rI5mVNrlNgkLrHdhkssAEYtjj0h9zHSZXhh6SGTKs/RP
         cKjw==
X-Received: by 10.66.197.165 with SMTP id iv5mr11024645pac.67.1370798127310;
        Sun, 09 Jun 2013 10:15:27 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id rn7sm7235373pbc.12.2013.06.09.10.15.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:15:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227030>

rr/triangle (4d35924, 2013-04-07) introduced support for triangular
workflows, but did not think through the effect of the new configuration
variables in the upstream and simple modes.  When remote.pushdefault or
branch.<name>.pushremote is set, and push.default is set to upstream or
simple, this happens (master@{u} != origin):

  $ git push
  fatal: You are pushing to remote 'origin', which is not the upstream of
  your current branch 'master', without telling me what to push
  to update which remote branch.

The configuration variables work as expected with push.default = current
and matching, which makes the above unexpected and counter-intuitive.
It happens because upstream and simple were designed with central
workflows in mind.  Even when these configuration variables are not set,

  $ git push origin
  fatal: You are pushing to remote 'origin', which is not the upstream of
  your current branch 'master', without telling me what to push
  to update which remote branch.

This artificial limitation imposed on setup_push_upstream() was
introduced by 135dad (push: error out when the "upstream" semantics does
not make sense, 2012-03-30), but has no basis; a push.default value
should only dictate a refspec, and the push destination is orthogonal to
this.  Remove this artificial limitation, fixing the bug.  Only one test
needs to be changed subtly.

Reported-by: Leandro Lucarella <leandro.lucarella@sociomantic.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/push.c          | 5 -----
 t/t5528-push-default.sh | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 2d84d10..b253a64 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -137,11 +137,6 @@ static void setup_push_upstream(struct remote *remote, int simple)
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
-	if (strcmp(branch->remote_name, remote->name))
-		die(_("You are pushing to remote '%s', which is not the upstream of\n"
-		      "your current branch '%s', without telling me what to push\n"
-		      "to update which remote branch."),
-		    remote->name, branch->name);
 	if (simple && strcmp(branch->refname, branch->merge[0]->src))
 		die_push_simple(branch, remote);
 
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 69ce6bf..4e4824e 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -60,13 +60,13 @@ test_expect_success '"upstream" does not push on unconfigured branch' '
 	test_push_failure upstream
 '
 
-test_expect_success '"upstream" does not push when remotes do not match' '
+test_expect_success '"upstream" pushes when remotes do not match' '
 	git checkout master &&
 	test_config branch.master.remote parent1 &&
 	test_config branch.master.merge refs/heads/foo &&
 	test_config push.default upstream &&
 	test_commit five &&
-	test_must_fail git push parent2
+	git push parent2
 '
 
 test_expect_success 'push from/to new branch with upstream, matching and simple' '
-- 
1.8.3.247.g485169c
