From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 2/2] learn to pick/revert into unborn branch
Date: Fri, 21 Dec 2012 11:10:11 -0800
Message-ID: <1356117013-20613-2-git-send-email-martinvonz@gmail.com>
References: <1356117013-20613-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 20:40:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm8SL-0007Km-KI
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 20:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab2LUTkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 14:40:11 -0500
Received: from mail-vc0-f202.google.com ([209.85.220.202]:44609 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab2LUTkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 14:40:09 -0500
Received: by mail-vc0-f202.google.com with SMTP id m8so510945vcd.5
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 11:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=EJLeTgoFLClGw9eIfbP9gf/b0Q4gBomrMqExMFxC0vk=;
        b=TDBu+OmlWpaSs35U7NCHLmyQFNgaabtKm/dreJVuABUjFAELnNLSyNBpoOwKAArEnB
         kmtP4xUdIt5J/MKO4cGyx2WMC2jocvbP03bhLOrSwvvz9bQtarVkm/N6FeBwJAj6qyLd
         WGDvOFFKTy3wi+KZa3w/F8vk4BFwFxgNO8pfa+DK+fHxWQvdH248qsLlM3IjE4rBFlii
         2CGV016EJ6mRq02SPsTeWhputKs9OOeOVR6KwNUbIR9xPkcOpF1jS5+Yrt0MbKgDDsri
         TsVBpPuXCBdys3G/Az5teqDIsHa0+X24EU2D2c+Bji7o5gZ1+fOfCy8XtD+0J0d6cTzm
         cIgA==
X-Received: by 10.236.93.42 with SMTP id k30mr6041276yhf.19.1356117021486;
        Fri, 21 Dec 2012 11:10:21 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id j11si604380ank.2.2012.12.21.11.10.21
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 21 Dec 2012 11:10:21 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 37859100047;
	Fri, 21 Dec 2012 11:10:21 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id EDBFF101386; Fri, 21 Dec 2012 11:10:20 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.240.ge8a1f5a
In-Reply-To: <1356117013-20613-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmxJXJI5vkmSRd0AknFWJVs51EoVJgVjwEhWavKK1gLSDWSgT3C7Ia0xHM3zxeAKEdRnAHdLUoHR9LQp/lvrjKoBrRVfLcgwFGrePNffGWwtKmPCPzlsw+W7sMVYpIISJu3T7zzwn43yFg5TMx6RWAdg/oRf9Oc0ab5H060Z7wDaNwM2Vut0TUWlYxHTwHH7nFIIl/o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212006>

>From the user's point of view, it seems natural to think that
cherry-picking into an unborn branch should work, so make it work,
with or without --ff.

Cherry-picking anything other than a commit that only adds files, will
naturally result in conflicts. Similarly, revert also works, but will
result in conflicts unless the specified revision only deletes files.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>

---

The plan is to use this for fixing "git rebase --root" as discussed in
http://thread.gmane.org/gmane.comp.version-control.git/205796

Is there a better way of creating an unborn branch than what I do in
the test cases?

 sequencer.c                   | 19 +++++++++++--------
 t/t3501-revert-cherry-pick.sh |  9 +++++++++
 t/t3506-cherry-pick-ff.sh     |  8 ++++++++
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 2260490..1ac1ceb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -186,14 +186,15 @@ static int error_dirty_index(struct replay_opts *opts)
 	return -1;
 }
 
-static int fast_forward_to(const unsigned char *to, const unsigned char *from)
+static int fast_forward_to(const unsigned char *to, const unsigned char *from,
+			   int unborn)
 {
 	struct ref_lock *ref_lock;
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
-	ref_lock = lock_any_ref_for_update("HEAD", from, 0);
+	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from, 0);
 	return write_ref_sha1(ref_lock, to, "cherry-pick");
 }
 
@@ -390,7 +391,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res;
+	int res, unborn = 0;
 
 	if (opts->no_commit) {
 		/*
@@ -402,9 +403,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		if (write_cache_as_tree(head, 0, NULL))
 			die (_("Your index file is unmerged."));
 	} else {
-		if (get_sha1("HEAD", head))
-			return error(_("You do not have a valid HEAD"));
-		if (index_differs_from("HEAD", 0))
+		unborn = get_sha1("HEAD", head);
+		if (unborn)
+			hashcpy(head, EMPTY_TREE_SHA1_BIN);
+		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0))
 			return error_dirty_index(opts);
 	}
 	discard_cache();
@@ -435,8 +437,9 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	else
 		parent = commit->parents->item;
 
-	if (opts->allow_ff && parent && !hashcmp(parent->object.sha1, head))
-		return fast_forward_to(commit->object.sha1, head);
+	if (opts->allow_ff &&
+	    (parent && !hashcmp(parent->object.sha1, head) || !parent && unborn))
+	     return fast_forward_to(commit->object.sha1, head, unborn);
 
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be "revert" or
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 34c86e5..6f489e2 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -100,4 +100,13 @@ test_expect_success 'revert forbidden on dirty working tree' '
 
 '
 
+test_expect_success 'chery-pick on unborn branch' '
+	git checkout --orphan unborn &&
+	git rm --cached -r . &&
+	rm -rf * &&
+	git cherry-pick initial &&
+	git diff --quiet initial &&
+	! test_cmp_rev initial HEAD
+'
+
 test_done
diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index 51ca391..373aad6 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -105,4 +105,12 @@ test_expect_success 'cherry pick a root commit with --ff' '
 	test "$(git rev-parse --verify HEAD)" = "1df192cd8bc58a2b275d842cede4d221ad9000d1"
 '
 
+test_expect_success 'chery-pick --ff on unborn branch' '
+	git checkout --orphan unborn &&
+	git rm --cached -r . &&
+	rm -rf * &&
+	git cherry-pick --ff first &&
+	test_cmp_rev first HEAD
+'
+
 test_done
-- 
1.8.0.1.240.ge8a1f5a
