From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] checkout: respect GIT_REFLOG_ACTION
Date: Mon, 10 Jun 2013 21:52:11 +0530
Message-ID: <1370881332-9231-3-git-send-email-artagnon@gmail.com>
References: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 10 18:20:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um4pd-0005MA-PM
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 18:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab3FJQU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 12:20:26 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49454 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab3FJQUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 12:20:25 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so2407072pbb.33
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lABEp4qTePlhvSczBoT/LjlhNMPI5+jjjuxxtGKMRBY=;
        b=Z5tV+C6P+JbfAgI85BrIr9EV4Ew3bYsMpLMt83rl33PtV3a1LaxfEW7lZ1gBzBZ4qn
         v9YRNfi/kZODq8XNmUA7ovy4OMkrH/MeTDTjrarYLP9ITzh8RJR0LgtDK3keXpPP21sd
         c8Vq4vPdPNJsAIRIyeTWjnm6u4XbUMpsT8cY2a1hktFUcmZR9gUnVMJV5jTnxbnQhcPz
         AlFEZqKU8efKI0+y2fyw+w0EDMhIGRNyjg9wx5lByWhjmYqZtt7M2rvkkHw2APVbAk+g
         6/HckHleIvYQBcNGnZ4oR+dm82FNlA2Nx02aAT+ti5rNs9W/5bpujoizhbMXSo+QuE1t
         Rm+g==
X-Received: by 10.66.251.65 with SMTP id zi1mr14919713pac.200.1370881224441;
        Mon, 10 Jun 2013 09:20:24 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id 6sm10895528pbn.45.2013.06.10.09.20.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 09:20:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.254.g60f9e5b
In-Reply-To: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227315>

GIT_REFLOG_ACTION is an environment variable specifying the reflog
message to write after an action is completed.  Other commands including
merge, reset, and commit respect it.

This incidentally fixes a bug in t/checkout-last.  You can now expect

  $ git checkout -

to work fine after an interactive rebase.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/checkout.c       | 11 ++++++++---
 t/t2012-checkout-last.sh |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f5b50e5..1e2af85 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -587,7 +587,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				   struct branch_info *new)
 {
 	struct strbuf msg = STRBUF_INIT;
-	const char *old_desc;
+	const char *old_desc, *reflog_msg;
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
@@ -620,8 +620,13 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	old_desc = old->name;
 	if (!old_desc && old->commit)
 		old_desc = sha1_to_hex(old->commit->object.sha1);
-	strbuf_addf(&msg, "checkout: moving from %s to %s",
-		    old_desc ? old_desc : "(invalid)", new->name);
+
+	reflog_msg = getenv("GIT_REFLOG_ACTION");
+	if (!reflog_msg)
+		strbuf_addf(&msg, "checkout: moving from %s to %s",
+			old_desc ? old_desc : "(invalid)", new->name);
+	else
+		strbuf_insert(&msg, 0, reflog_msg, strlen(reflog_msg));
 
 	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) {
 		/* Nothing to do. */
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index 5729487..ab80da7 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -116,7 +116,7 @@ test_expect_success 'master...' '
 	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
 '
 
-test_expect_failure '"checkout -" works after an interactive rebase' '
+test_expect_success '"checkout -" works after an interactive rebase' '
 	git checkout master &&
 	git checkout other &&
 	git rebase -i master &&
-- 
1.8.3.254.g60f9e5b
