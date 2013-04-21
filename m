From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 7/8] branch.c: Validate tracking branches with refspecs instead of refs/remotes/*
Date: Sun, 21 Apr 2013 23:52:05 +0200
Message-ID: <1366581126-3880-8-git-send-email-johan@herland.net>
References: <1366581126-3880-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 21 23:53:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU2Bz-0000Ui-Fq
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 23:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab3DUVw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 17:52:57 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:38979 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab3DUVw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 17:52:56 -0400
Received: by mail-la0-f45.google.com with SMTP id fp12so935559lab.32
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 14:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5FieziLsIdatGgloiD9wMynz+b5uS76dWktOB3p962E=;
        b=Wz7zfiwczkQ7wk5GiPbjaqZK/iAO6VVwKlPVVzoAtpNmwdJwK2HbQy7LEBNA0YzyCf
         nen1Y0yJvnQteO/LhCbTWr3JdzLf73Lkp/Lfz+DjDcMoyzgFRjuHrmJitdsk2BBxSCML
         9h/4+ruEJZwYJ1CjXcNYHGN0d6z01S/vjAnc164RTlnpamxTRQ7CPKE0CXMBB/yj29HJ
         T5R7bomK+i2pjmHFbQMdNKbEajyagydqFyHfCdMJ5avicrwZ7e3eiPDkItUreBgT7Wtc
         iQD3Tj/jyIQV/keKdDDjNPQmHv9T5WaGsCgykxb0hiep8k1iCDSV7QTWzZAwMAE1F0Fo
         +XVw==
X-Received: by 10.152.120.67 with SMTP id la3mr12173432lab.36.1366581174588;
        Sun, 21 Apr 2013 14:52:54 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id ak4sm9489460lbc.12.2013.04.21.14.52.52
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 14:52:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366581126-3880-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221976>

The current code for validating tracking branches (e.g. the argument to
the -t/--track option) hardcodes refs/heads/* and refs/remotes/* as the
potential locations for tracking branches. This works with the refspecs
created by "git clone" or "git remote add", but is suboptimal in other
cases:

 - If "refs/remotes/foo/bar" exists without any association to a remote
   (i.e. there is no remote named "foo", or no remote with a refspec
   that matches "refs/remotes/foo/bar"), then it is impossible to set up
   a valid upstream config that tracks it. Currently, the code defaults
   to using "refs/remotes/foo/bar" from repo "." as the upstream, which
   works, but is probably not what the user had in mind when running
   "git branch baz --track foo/bar".

 - If the user has tweaked the fetch refspec for a remote to put its
   remote-tracking branches outside of refs/remotes/*, e.g. by running
       git config remote.foo.fetch "+refs/heads/*:refs/foo_stuff/*"
   then the current code will refuse to use its remote-tracking branches
   as --track arguments, since they do not match refs/remotes/*.

This patch removes the "refs/remotes/*" requirement for upstream branches,
and replaces it with explicit checking of the refspecs for each remote to
determine whether a given --track argument is a valid remote-tracking
branch. This solves both of the above problems, since the matching refspec
guarantees that there is a both a remote name and a remote branch name
that can be used for the upstream config.

However, this means that refs located within refs/remotes/* without a
corresponding remote/refspec will no longer be usable as upstreams.
The few existing tests which depended on this behavioral quirk has
already been fixed in the preceding patches.

This patch fixes the last remaining test failure in t2024-checkout-dwim.

Signed-off-by: Johan Herland <johan@herland.net>
---
 branch.c                 | 17 ++++++++++++++++-
 t/t2024-checkout-dwim.sh |  2 +-
 t/t3200-branch.sh        |  2 +-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index 6ae6a4c..beaf11d 100644
--- a/branch.c
+++ b/branch.c
@@ -197,6 +197,21 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 	return 1;
 }
 
+static int check_tracking_branch(struct remote *remote, void *cb_data)
+{
+	char *tracking_branch = cb_data;
+	struct refspec query;
+	memset(&query, 0, sizeof(struct refspec));
+	query.dst = tracking_branch;
+	return !(remote_find_tracking(remote, &query) ||
+		 prefixcmp(query.src, "refs/heads/"));
+}
+
+static int validate_remote_tracking_branch(char *ref)
+{
+	return !for_each_remote(check_tracking_branch, ref);
+}
+
 static const char upstream_not_branch[] =
 N_("Cannot setup tracking information; starting point '%s' is not a branch.");
 static const char upstream_missing[] =
@@ -259,7 +274,7 @@ void create_branch(const char *head,
 	case 1:
 		/* Unique completion -- good, only if it is a real branch */
 		if (prefixcmp(real_ref, "refs/heads/") &&
-		    prefixcmp(real_ref, "refs/remotes/")) {
+		    validate_remote_tracking_branch(real_ref)) {
 			if (explicit_tracking)
 				die(_(upstream_not_branch), start_name);
 			else
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 31e3d47..dee55e4 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -154,7 +154,7 @@ test_expect_success 'checkout of branch from a single remote succeeds #3' '
 	test_branch_upstream spam repo_c spam
 '
 
-test_expect_failure 'checkout of branch from a single remote succeeds #4' '
+test_expect_success 'checkout of branch from a single remote succeeds #4' '
 	git checkout -B master &&
 	test_might_fail git branch -D eggs &&
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 1bfdadc..44ec6a4 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -317,7 +317,7 @@ test_expect_success 'test tracking setup (non-wildcard, matching)' '
 	test $(git config branch.my4.merge) = refs/heads/master
 '
 
-test_expect_failure 'tracking setup fails on non-matching refspec' '
+test_expect_success 'tracking setup fails on non-matching refspec' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-- 
1.8.1.3.704.g33f7d4f
