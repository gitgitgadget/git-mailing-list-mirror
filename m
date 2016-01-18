From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 5/5] ls-remote: add support for showing symrefs
Date: Mon, 18 Jan 2016 17:57:18 +0100
Message-ID: <1453136238-19448-6-git-send-email-t.gummerer@gmail.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 17:57:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLD7T-0003Xc-Au
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 17:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974AbcARQ51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 11:57:27 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33541 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921AbcARQ5S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 11:57:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id u188so17716417wmu.0
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 08:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wrSnudb+HrjUttl817nTpbQeKgIRRQLXS6UJtdlzp/U=;
        b=OFGMyIPlv2qN2bdljazrjqT2YK0lNlgTIBf7f+7S+iBFpMFQ5BcSCjXU0zuaBMtt2R
         Q4SczTq+j0ibdFU6rSWszkaRmP8tGmX8efwTiIc1wCoNUzO/c6GJkOdc75eFf1GoR7Oo
         hClebSsSjWO1AuEZIO7S1B6qEjeXiTbo0xGrBxS+kCjxPN8z1BCV/u3aIC3OeA0xDOaK
         3mHDE08ry/2ZNw5sRyO8h9WbThqISKpkKG4d1sZ1PZPqi0bbI2CdZNumXqJW+b7bBhZU
         0uWjwlb4vmd/1XY4xe9gN9dA3dyyJanpdIqROBPC6RRjGSHm4TOQxJVcsCoIEBU7B1xE
         MuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wrSnudb+HrjUttl817nTpbQeKgIRRQLXS6UJtdlzp/U=;
        b=DV3lr++26TJuAZwfkc8oXDoZIWWKlxSnJi5MniAg/F16H5kpeBkSP35E84dvdvCYKc
         XHeQvkTq1uu1Jg6wnB9g0IfnwIfmESiHUuuQQT5ttLd4zbnokEDOFqekNvPAQTCl5bwr
         Q8I5PhyRx/zOhxj76g5guJhCcv0oLyXCTPJDHp0ljPGP252qlVW8I0BJ1z1bqXsPPwwD
         +8sMEJwnt/5mlon8RpX/B3Sx6VmHqA8yID2cMQKrT+OKyqhVPrJi6LyFiJpgwI45dUL9
         FgzQ38yOW9NySAN4l6AHNgaDoco9XfSaB9KbY35R6AbUkgw494wdcf3ZDOO5dSbPXDsC
         AYcA==
X-Gm-Message-State: AG10YORycWuG2idkjNPTYiaamK/xkAEFWSxUxj36ps2xNnyazoEvc7jSGmG+pq3gP0Xp5Q==
X-Received: by 10.28.178.206 with SMTP id b197mr13673173wmf.72.1453136237268;
        Mon, 18 Jan 2016 08:57:17 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id w17sm16555198wmw.15.2016.01.18.08.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 08:57:15 -0800 (PST)
X-Mailer: git-send-email 2.7.0.30.gd0a78e9.dirty
In-Reply-To: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284298>

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

While there, replace a literal tab in the format string with \t to make
it more obvious to the reader.

Suggested-by: pedro rijo <pedrorijo91@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-ls-remote.txt |  6 +++++-
 builtin/ls-remote.c             |  9 +++++++--
 t/t5512-ls-remote.sh            | 22 ++++++++++++++++++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index f7d1091..9356df2 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
-	      [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]
+	      [-q | --quiet] [--exit-code] [--get-url]
+	      [--symrefs] [<repository> [<refs>...]]
 
 DESCRIPTION
 -----------
@@ -54,6 +55,9 @@ OPTIONS
 	"url.<base>.insteadOf" config setting (See linkgit:git-config[1]) and
 	exit without talking to the remote.
 
+--symrefs::
+	Show the symrefs in addition to the other refs.
+
 <repository>::
 	The "remote" repository to query.  This parameter can be
 	either a URL or the name of a remote (see the GIT URLS and
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 3a20378..ea73d53 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -5,7 +5,8 @@
 
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
-	   "                     [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]"),
+	   "                     [-q | --quiet] [--exit-code] [--get-url]\n"
+	   "                     [--symrefs] [<repository> [<refs>...]]"),
 	NULL
 };
 
@@ -37,6 +38,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int get_url = 0;
 	int quiet = 0;
 	int status = 0;
+	int symrefs = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
 
@@ -58,6 +60,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			 N_("take url.<base>.insteadOf into account")),
 		OPT_SET_INT(0, "exit-code", &status,
 			    N_("exit with exit code 2 if no matching refs are found"), 2),
+		OPT_BOOL(0, "symrefs", &symrefs, N_("show symrefs")),
 		OPT_END()
 	};
 
@@ -101,7 +104,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
-		printf("%s	%s\n", oid_to_hex(&ref->old_oid), ref->name);
+		if (symrefs && ref->symref)
+			printf("ref: %s\t%s\n", ref->symref, ref->name);
+		printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
 		status = 0; /* we found something */
 	}
 	return status;
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index aadaac5..3edbc9e 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -163,4 +163,26 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
 	grep refs/tags/magic actual
 '
 
+test_expect_success 'ls-remote --symrefs' '
+	cat >expect <<-EOF &&
+	ref: refs/heads/master	HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
+	EOF
+	git ls-remote --symrefs >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-remote with filtered symrefs' '
+	cat >expect <<-EOF &&
+	ref: refs/heads/master	HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
+	EOF
+	git ls-remote --symrefs . HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.7.0.30.gd0a78e9.dirty
