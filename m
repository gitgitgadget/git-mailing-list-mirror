From: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
Subject: [PATCH,RFC] Implement 'git rm --if-missing'
Date: Wed, 16 Jul 2008 19:00:50 +0100
Message-ID: <1216231250-21141-1-git-send-email-ciaran.mccreesh@googlemail.com>
Cc: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 20:02:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJBKB-00056J-AJ
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 20:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbYGPSBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbYGPSBA
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:01:00 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:10056 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbYGPSA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 14:00:59 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3548312fkq.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=pUgxQ4SFDeFXeawtU8i8YB8e7MCx/LFANLb3mqCxMDg=;
        b=H+TMUQB5Kfi0v8BxPn/JpBVESGQdXNLYwK7q7oXMxl5TdlV9Hn6qhJyEfsV42w7Qet
         EY8bGyrXbdEfS4NVIrMFf/94nWcqNNKlDZAxi53E+Od5N3okjMjqOGUN3uS5i884izT6
         QKO0bcmhRVwCXXJPqhi7kj/jR8/2b8HHGCYDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=eqsnSKpgly7k4iqvoKiuBT0qw0lE/RqeWNPpFZHCMVuvbBY8jLUH3GP7bpIssM0QzM
         h7Y/BP9wmH+YZIg6bXxZZmEq14S3eG+Duey+TnguJYDc31o7y6cqz39igJiH4JtgpScq
         4K0pOxYYQy1N4sSYe2trefHx6gcKvirhMzRZw=
Received: by 10.187.233.6 with SMTP id k6mr197467far.64.1216231256845;
        Wed, 16 Jul 2008 11:00:56 -0700 (PDT)
Received: from localhost.localdomain ( [92.235.187.79])
        by mx.google.com with ESMTPS id o37sm944337hub.34.2008.07.16.11.00.55
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 11:00:56 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88702>

git rm --if-missing will only remove files if they've already been removed from
disk.

Signed-off-by: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
---

There's nothing here that can't be done using git update-index, but git rm
is less scary.

Regarding exit status: I'm not sure whether exit status should be based upon
whether any files were actually removed, or whether it should be based upon
whether or not all of the supplied patterns were matched. I've gone for the
latter, so that 'git rm --if-missing -r .' succeeds if there's nothing to
remove.

I'm not sure whether 'missing' is the best word. '--if-noent' might be more
appropriate, but less familiar to some. Or is this worth a short option?

 Documentation/git-rm.txt |    8 +++++++-
 builtin-rm.c             |    9 ++++++++-
 t/t3600-rm.sh            |   43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 4d0c495..f9335f3 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -7,7 +7,8 @@ git-rm - Remove files from the working tree and from the index
 
 SYNOPSIS
 --------
-'git rm' [-f] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...
+'git rm' [-f] [-n] [-r] [--cached] [--ignore-unmatch] [--if-missing]
+	  [--quiet] [--] <file>...
 
 DESCRIPTION
 -----------
@@ -61,6 +62,11 @@ OPTIONS
 --ignore-unmatch::
 	Exit with a zero status even if no files matched.
 
+--if-missing::
+	Only remove files if they have been removed from disk. Exit status
+	is still based upon whether matches succeed, not whether a remove
+	actually took place.
+
 -q::
 --quiet::
 	'git-rm' normally outputs one line (in the form of an "rm" command)
diff --git a/builtin-rm.c b/builtin-rm.c
index 22c9bd1..4b89705 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -125,7 +125,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 static struct lock_file lock_file;
 
 static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
-static int ignore_unmatch = 0;
+static int ignore_unmatch = 0, if_missing = 0;
 
 static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only),
@@ -135,6 +135,7 @@ static struct option builtin_rm_options[] = {
 	OPT_BOOLEAN('r', NULL,             &recursive,  "allow recursive removal"),
 	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
 				"exit with a zero status even if nothing matched"),
+	OPT_BOOLEAN( 0 , "if-missing",     &if_missing, "only remove missing files"),
 	OPT_END(),
 };
 
@@ -168,6 +169,12 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		struct cache_entry *ce = active_cache[i];
 		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			continue;
+		if (if_missing)
+		{
+			struct stat st;
+			if ((lstat(ce->name, &st) == 0) || (errno != ENOENT))
+				continue;
+		}
 		add_list(ce->name);
 	}
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index f542f0a..c7c1810 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -143,6 +143,45 @@ test_expect_success '"rm" command suppressed with --quiet' '
 	git commit -m "remove file from rm --quiet test"
 '
 
+test_expect_success 'Test that "rm --if-missing" works' '
+	echo frotz > test-file &&
+	echo frotz > other-file &&
+	git add test-file other-file &&
+	git commit -m "add files from rm --if-missing test" &&
+	rm test-file &&
+	git rm --if-missing test-file other-file &&
+	! git ls-files --error-unmatch test-file &&
+	git ls-files --error-unmatch other-file &&
+	git rm other-file &&
+	git commit -m "remove file from rm --if-missing test"
+'
+
+test_expect_success 'Test that "rm --if-missing -r *" works' '
+	echo frotz > test-file &&
+	mkdir -p frotz &&
+	echo frotz > frotz/other-file &&
+	git add test-file frotz/other-file &&
+	git commit -m "add file from rm --if-missing -r * test" &&
+	rm frotz/other-file
+	git rm --if-missing --ignore-unmatch -r \* &&
+	git ls-files --error-unmatch test-file &&
+	git rm test-file &&
+	git commit -m "remove file from rm --missing -r * test &&
+	! test -d frotz"
+'
+
+test_expect_success 'Test that "rm --if-missing -r *" works even if nothing is removed' '
+	echo frotz > test-file &&
+	mkdir -p frotz &&
+	echo frotz > frotz/other-file &&
+	git add test-file frotz/other-file &&
+	git commit -m "add file from rm --if-missing -r * test" &&
+	git rm --if-missing --ignore-unmatch -r \* &&
+	git rm test-file frotz/other-file &&
+	git commit -m "remove file from rm --missing -r * test &&
+	! test -d frotz"
+'
+
 # Now, failure cases.
 test_expect_success 'Re-add foo and baz' '
 	git add foo baz &&
@@ -217,4 +256,8 @@ test_expect_success 'Remove nonexistent file returns nonzero exit status' '
 	! git rm nonexistent
 '
 
+test_expect_success 'Test that "rm --if-missing nonexistent" fails' '
+	! git rm --if-missing nonexistent
+'
+
 test_done
-- 
1.5.6.3.385.g7c3f1
