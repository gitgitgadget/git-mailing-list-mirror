From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 4/4] ls-remote: add support for showing symrefs
Date: Sun, 17 Jan 2016 12:04:03 +0100
Message-ID: <1453028643-13978-6-git-send-email-t.gummerer@gmail.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sun Jan 17 12:04:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKl7s-0005Ap-2m
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 12:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbcAQLD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 06:03:59 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36062 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbcAQLD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 06:03:57 -0500
Received: by mail-wm0-f65.google.com with SMTP id l65so11108039wmf.3
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 03:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZGeEe5YLJ0+b4QwZOPHkomVT1toYMD43M0T3r44VCNk=;
        b=PEREsH6RJQNyCBCmuXiDZl1zbP+q80LHwBu87c2KigiDWJ/x3oQpVhUVuLX1adoHaz
         0Oe+aGTFLBa/fQzxNq/GsLCkUVdo42z71L98l+oggxB8Tjvs0RKUh1XK7DtU5fXI68US
         Ozv9WJbTfl3Apz2FI5eb1IsVpQ0ygajv3FpT6U7fLekzezs0ObgGbkysXQZfno6syH5Z
         XC6pI0adrxqBJBI2VOiiVQ0qsj8D3ZgKdKpGgh4HMCOhtWToASkHqkmZHqmvEiwA8WkG
         gVnRlPOD2yXgCUN0cZS2LV5rQZJyVJQ5htZROxbxngA3Z0OlIB2wfTuKLbbhdxCdLwvT
         tjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZGeEe5YLJ0+b4QwZOPHkomVT1toYMD43M0T3r44VCNk=;
        b=c+fG7Et6FgiEDi/6L+E9GL9FApxHBK0S5NBrhBCsR30BVLSOnI6jKESM5Fuzt7c3MX
         DM2wsFZGZY3e5G9h9CVeqVcV9HKbEUdyxX1wF/mVzxkKt9k4+AYuk+mepBdNjUL33miZ
         7FFR907mWsN24G4KhaYyf2f458zTk4W8SUiNEEgTeMh9fvoe3DGQvZQNEPahrWLBIHhD
         ormTWb/pAFmnwOT+zuiZmnRKnL8fO2xX6XtzD+zRpR6oqpIgQ4Ju9RVLUENJ6WnPwFiA
         lzrKiK8tLNkMXR75hEmQmR8SsgDPsPGHVuJBn95y+IveWFxrwZ8lZoahb3dT5iCd8KNd
         JSWg==
X-Gm-Message-State: AG10YOQuo7P3h9FEhCmwCq9V1UwHRZkf5cAMd9j5+az5e+5I/rC86UWdjVY6liCRnoF6ZQ==
X-Received: by 10.28.174.77 with SMTP id x74mr7125047wme.99.1453028635748;
        Sun, 17 Jan 2016 03:03:55 -0800 (PST)
Received: from localhost ([95.233.44.41])
        by smtp.gmail.com with ESMTPSA id u191sm10744864wmd.4.2016.01.17.03.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 03:03:54 -0800 (PST)
X-Mailer: git-send-email 2.7.0.14.g2b6d3d6
In-Reply-To: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284253>

Sometimes it's useful to know the main branch of a git repository
without actually downloading the repository.  This can be done by
looking at the symrefs stored in the remote repository.  Currently git
doesn't provide a simple way to show the symrefs stored on the remote
repository, even though the information is available.  Add a --symrefs
command line argument to the ls-remote command, which shows the symrefs
on the remote repository.

The new argument works similar to the --heads and --tags arguments.
When only --symrefs is given, only the symrefs are shown.  It can
however be combined with the --refs, --heads or --tags arguments, to
show all refs, heads, or tags as well.

Suggested-by: pedro rijo <pedrorijo91@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-ls-remote.txt |  8 +++++++-
 builtin/ls-remote.c             |  9 ++++++++-
 t/t5512-ls-remote.sh            | 20 ++++++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 31c1427..5b606dd 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags]  [--upload-pack=<exec>]
-	      [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]
+	      [-q | --quiet] [--exit-code] [--get-url]
+	      [--symrefs] [<repository> [<refs>...]]
 
 DESCRIPTION
 -----------
@@ -50,6 +51,11 @@ OPTIONS
 	"url.<base>.insteadOf" config setting (See linkgit:git-config[1]) and
 	exit without talking to the remote.
 
+--symrefs::
+	Show the symrefs on the server.  Shows only the symrefs by
+	default, and can be combined with --tags and --heads to show
+	refs/heads and refs/tags as well.
+
 <repository>::
 	The "remote" repository to query.  This parameter can be
 	either a URL or the name of a remote (see the GIT URLS and
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 6ee7b0e..f33ada9 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -5,7 +5,8 @@
 
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--heads] [--tags]  [--upload-pack=<exec>]\n"
-	   "                     [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]"),
+	   "                     [-q | --quiet] [--exit-code] [--get-url]\n"
+	   "                     [--symrefs] [<repository> [<refs>...]]"),
 	NULL
 };
 
@@ -38,6 +39,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	int status = 0;
 	int tags = 0, heads = 0, refs = 0;
+	int symrefs = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
 
@@ -58,6 +60,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			    N_("take url.<base>.insteadOf into account"), 1),
 		OPT_SET_INT(0, "exit-code", &status,
 			    N_("exit with exit code 2 if no matching refs are found"), 2),
+		OPT_BOOL(0, "symrefs", &symrefs, N_("show symrefs")),
 		OPT_END()
 	};
 
@@ -98,6 +101,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", *remote->url);
 	for ( ; ref; ref = ref->next) {
+		if (symrefs && ref->symref)
+			printf("symref: %s	%s\n", ref->symref, ref->name);
+		if (symrefs && !flags)
+			continue;
 		if (!check_ref_type(ref, flags))
 			continue;
 		if (!tail_match(pattern, ref->name))
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index aadaac5..68a1429 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -163,4 +163,24 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
 	grep refs/tags/magic actual
 '
 
+test_expect_success 'ls-remote --symrefs' '
+	cat >expect <<-EOF &&
+	symref: refs/heads/master	HEAD
+	EOF
+	git ls-remote --symrefs >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-remote with symrefs and refs combined' '
+	cat >expect <<-EOF &&
+	symref: refs/heads/master	HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
+	EOF
+	git ls-remote --symrefs --refs >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.7.0.14.g2b6d3d6
