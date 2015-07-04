From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 12/23] checkout: drop 'checkout_opts' dependency from prepare_linked_checkout
Date: Fri,  3 Jul 2015 20:17:21 -0400
Message-ID: <1435969052-540-13-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBBO-0000cR-L3
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114AbbGDATp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:19:45 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35361 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920AbbGDASh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:37 -0400
Received: by iecuq6 with SMTP id uq6so84336446iec.2
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+bWO6r/q1JtSyek/rtZRIh0fsLJYefuiD/SRpleHrzg=;
        b=zPrcb2FFp51oq0zL4J14ZW6GnaEllthuXGBwBBaBvwk8BT9vIT2zmRZg8jbaU4c5f8
         57JL3SF2iYVuK4pXGJHV07HsyM6framezcohj7+gEawSlUei2XOrFbbvCUuMQSfs3ywg
         mroZ8nsi9xB3rlhNrsYxVFp8J4fINApGjkyHNWuZJZTzIZeom4KIa+o42uxHcl2L849m
         cxJrt2cnCWM6BWh1wn5hZoUe/ShUh4hbNODNm5Qt4L3PmpLy37oP3Hc7QikYJv2l0jNt
         CVvKgutOSPAfMfe4sDE+twk7uWSmn7avrY54xlJ/xwDKkVD+KRKFcrs57jBhor+C3G5c
         10cg==
X-Received: by 10.50.4.66 with SMTP id i2mr54736323igi.40.1435969117216;
        Fri, 03 Jul 2015 17:18:37 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.36
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273336>

The plan is to relocate "git checkout --to" functionality to "git
worktree add", however, worktree.c won't have access to the 'struct
checkout_opts' passed to prepare_linked_worktree(), which it consults
for the pathname of the new worktree and the argv[] of the command it
should run to populate the new worktree. Facilitate relocation of
prepare_linked_worktree() by instead having it accept the pathname and
argv[] directly, thus eliminating the final references to 'struct
checkout_opts'.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 86b1745..30fe786 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -854,11 +854,11 @@ static void remove_junk_on_signal(int signo)
 	raise(signo);
 }
 
-static int prepare_linked_checkout(const struct checkout_opts *opts)
+static int prepare_linked_checkout(const char *path, const char **child_argv)
 {
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
-	const char *path = opts->new_worktree, *name;
+	const char *name;
 	struct stat st;
 	struct child_process cp;
 	int counter = 0, len, ret;
@@ -938,7 +938,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts)
 	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd = 1;
-	cp.argv = opts->saved_argv;
+	cp.argv = child_argv;
 	ret = run_command(&cp);
 	if (!ret) {
 		is_junk = 0;
@@ -1297,7 +1297,8 @@ static int checkout_branch(struct checkout_opts *opts,
 	if (opts->new_worktree) {
 		if (!new->commit)
 			die(_("no branch specified"));
-		return prepare_linked_checkout(opts);
+		return prepare_linked_checkout(opts->new_worktree,
+					       opts->saved_argv);
 	}
 
 	if (!new->commit && opts->new_branch) {
-- 
2.5.0.rc1.197.g417e668
