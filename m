From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 5/5] ls-remote: add support for showing symrefs
Date: Tue, 19 Jan 2016 00:20:50 +0100
Message-ID: <1453159250-21298-6-git-send-email-t.gummerer@gmail.com>
References: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453159250-21298-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 00:21:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLJ72-0006mm-Kz
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 00:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbcARXV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 18:21:26 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33750 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599AbcARXUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 18:20:53 -0500
Received: by mail-wm0-f68.google.com with SMTP id u188so19464590wmu.0
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 15:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2i4S0nlxeY+MmSw3Gs8j0IjHeDnSsT06gC+bbdI0JSs=;
        b=Weflu5PqgxspB1cqTOsQb0lmFDrjisYV4Nc0GdbGW7j4X616lqVoX2gvDiAfpaSJER
         lfzbAoIY7C4T5o2VQuICNa/u8HfNDk4AL7F2oqCEbwNYsLGriCJVpveuc2czN59iLuje
         /apJTr68h7gpZdylAYoQ5KsUlNkKKUhYMhwNsYV/ZvDE9bZp+S7OPtG5Be9veLzRjaBT
         kIGrv9JjNzyaAyP9ScXwxQ+VDjO0uxFK4YRYe3kxq2j//KM75T0Xhulky8ejO2FzIgA8
         gjn70PL5mmS80CCZoic4RiozYf5G0blz9XO4Luu8qY+lfQc1I14DM8JfP3FXj9ZtpgE1
         fR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2i4S0nlxeY+MmSw3Gs8j0IjHeDnSsT06gC+bbdI0JSs=;
        b=XV/HHpdExAQmZ7rcCzaWDaZQ0RLF1S8xA06dgl9UcEdnnmvKC7LDSNQvWxKaTZqfaC
         xvbKkNnsPOS1qKcRvko1UrSdN8INK8PoyetZB6V77S8CYe4M2VlQEAiJsc5+aeYxcTRw
         4z0s4Lgje9m8YQUJZDvwnx75owkf9EPbEUXXhYMQfXu9LKI35aP1/Qjo5iIrSRLe1lZA
         21lX1zcm5uL5Z5KegQ9a3Jkf21vd9jrC2iwb8Fh4D4FMaxyEPmwNYp6QG9vRQZxbtMyR
         sZfGq2jA++fc8/Tp4R7mxNFrl1Ep+5ukO9h63WlYNShMxq2YNWNuuWng8CCL1jOABdxg
         /Xew==
X-Gm-Message-State: AG10YOT9SjMk80yP98Z7bttDD2fyEPUkboumyS6dcY1cmnyUi6ZSi8+zqOrD+X+wYy40IQ==
X-Received: by 10.28.22.199 with SMTP id 190mr16642846wmw.54.1453159251446;
        Mon, 18 Jan 2016 15:20:51 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id gb9sm25849067wjb.26.2016.01.18.15.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 15:20:50 -0800 (PST)
X-Mailer: git-send-email 2.7.0.30.g56a8654.dirty
In-Reply-To: <1453159250-21298-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284340>

Sometimes it's useful to know the main branch of a git repository
without actually downloading the repository.  This can be done by
looking at the symrefs stored in the remote repository.  Currently git
doesn't provide a simple way to show the symrefs stored on the remote
repository, even though the information is available.  Add a --symref
command line argument to the ls-remote command, which shows the symrefs
in the remote repository.

While there, replace a literal tab in the format string with \t to make
it more obvious to the reader.

Suggested-by: pedro rijo <pedrorijo91@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-ls-remote.txt |  9 ++++++++-
 builtin/ls-remote.c             | 10 +++++++--
 t/t5512-ls-remote.sh            | 45 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 453e93c..5f2628c 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
-	      [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]
+	      [-q | --quiet] [--exit-code] [--get-url]
+	      [--symref] [<repository> [<refs>...]]
 
 DESCRIPTION
 -----------
@@ -53,6 +54,12 @@ OPTIONS
 	"url.<base>.insteadOf" config setting (See linkgit:git-config[1]) and
 	exit without talking to the remote.
 
+--symref::
+	In addition to the object pointed by it, show the underlying
+	ref pointed by it when showing a symbolic ref.  Currently,
+	upload-pack only shows the symref HEAD, so it will be the only
+	one shown by ls-remote.
+
 <repository>::
 	The "remote" repository to query.  This parameter can be
 	either a URL or the name of a remote (see the GIT URLS and
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 3a20378..66cdd45 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -5,7 +5,8 @@
 
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
-	   "                     [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]"),
+	   "                     [-q | --quiet] [--exit-code] [--get-url]\n"
+	   "                     [--symref] [<repository> [<refs>...]]"),
 	NULL
 };
 
@@ -37,6 +38,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int get_url = 0;
 	int quiet = 0;
 	int status = 0;
+	int show_symref_target = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
 
@@ -58,6 +60,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			 N_("take url.<base>.insteadOf into account")),
 		OPT_SET_INT(0, "exit-code", &status,
 			    N_("exit with exit code 2 if no matching refs are found"), 2),
+		OPT_BOOL(0, "symref", &show_symref_target,
+			 N_("show underlying ref in addition to the object pointed by it")),
 		OPT_END()
 	};
 
@@ -101,7 +105,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
-		printf("%s	%s\n", oid_to_hex(&ref->old_oid), ref->name);
+		if (show_symref_target && ref->symref)
+			printf("ref: %s\t%s\n", ref->symref, ref->name);
+		printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
 		status = 0; /* we found something */
 	}
 	return status;
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index aadaac5..819b9dd 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -163,4 +163,49 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
 	grep refs/tags/magic actual
 '
 
+test_expect_success 'ls-remote --symref' '
+	cat >expect <<-\EOF &&
+	ref: refs/heads/master	HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
+	EOF
+	git ls-remote --symref >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-remote with filtered symref (refname)' '
+	cat >expect <<-\EOF &&
+	ref: refs/heads/master	HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
+	EOF
+	git ls-remote --symref . HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'ls-remote with filtered symref (--heads)' '
+	git symbolic-ref refs/heads/foo refs/tags/mark &&
+	cat >expect <<-\EOF &&
+	ref: refs/tags/mark	refs/heads/foo
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
+	EOF
+	git ls-remote --symref --heads . >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-remote --symref omits filtered-out matches' '
+	cat >expect <<-\EOF &&
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
+	EOF
+	git ls-remote --symref --heads . >actual &&
+	test_cmp expect actual &&
+	git ls-remote --symref . "refs/heads/*" >actual &&
+	test_cmp expect actual
+'
+
+
 test_done
-- 
2.7.0.30.g56a8654.dirty
