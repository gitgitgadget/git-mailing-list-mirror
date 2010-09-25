From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 4/4] rev-parse: make --flags imply --no-revs for remaining arguments.
Date: Sun, 26 Sep 2010 02:18:35 +1000
Message-ID: <1285431515-21321-5-git-send-email-jon.seymour@gmail.com>
References: <1285431515-21321-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 18:16:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzXPt-0000Zx-UP
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 18:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830Ab0IYQPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 12:15:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63719 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755397Ab0IYQPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 12:15:45 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so864227pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QJ3dpGhp8T0VADMmFcqvUgDqRuCiXO21X4hyJjDZZ+Q=;
        b=oW5zhgTFhdkRXegzFluW0Eb++WFfGw92r/LtRAYltlYEOfBIRI6VKZVXAWDhReii1z
         dBZRev9jhpXSpeZdqU6nqN/v2XBOmzOibQ8fl1T5zyvboPNo7Adn6WrR8Xae022PqKB+
         0MmKK9l4ym328UnZFsolE2Jp9jnqp168oFxb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YxslTQoUnqxDdUySPbVKAEWsJX2Oi/L+zX1nvFR9ueAMfzOdRs8XoqwHCdxIgpH5Cq
         GA/hTi0EyA9refWE6BiaD4+5MZPYMEHO7tMfWnZsuP5hOLloP/xSjm3wWwXjTCKN+Kql
         iWDID6BfjOhBXgoLhfwzmwg0XoOqyANX96DfI=
Received: by 10.114.92.3 with SMTP id p3mr5500553wab.77.1285431345027;
        Sat, 25 Sep 2010 09:15:45 -0700 (PDT)
Received: from localhost.localdomain (124-169-4-134.dyn.iinet.net.au [124.169.4.134])
        by mx.google.com with ESMTPS id c24sm6056766wam.7.2010.09.25.09.15.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 09:15:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4.g73371.dirty
In-Reply-To: <1285431515-21321-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157161>

This change ensures that git rev-parse --flags complies with its documentation,
namely:

   "Do not output non-flag parameters".

Previously:
   $ git rev-parse --flags HEAD
   <sha1 hash of HEAD>
   $

Now:
   $ git rev-parse --flags HEAD
   $

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-rev-parse.txt |   24 +++++++++++++-----------
 builtin/rev-parse.c             |    6 +++++-
 t/t1510-rev-parse-flags.sh      |   24 +++++++++++++++++++++---
 3 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index f5e6637..f26fc7b 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -49,20 +49,22 @@ OPTIONS
 	'git rev-list' command.
 
 --flags::
-	Do not output non-flag parameters which are not also revisions.
-	+
-	If specified, this option causes 'git rev-parse' to stop
-	interpreting remaining arguments as options for its own
-	consumption. As such, this option should be specified
-	after all other options that 'git rev-parse' is expected
-	to interpret.
+	Do not output non-flag parameters.
++
+If specified, this option causes 'git rev-parse' to stop
+interpreting remaining arguments as options for its own
+consumption. As such, this option should be specified
+after all other options that 'git rev-parse' is expected
+to interpret.
++
+If `--flags` is specified, `--no-revs` is implied.
 
 --no-flags::
 	Do not output flag parameters.
-	+
-	If both `--flags` and `--no-flags` are specified, the first
-	option specified wins and the other option is treated like
-	a non-option argument.
++
+If both `--flags` and `--no-flags` are specified, the first
+option specified wins and the other option is treated like
+a non-option argument.
 
 --default <arg>::
 	If there is no parameter given by the user, use `<arg>`
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2ad269a..0655424 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -521,7 +521,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--flags")) {
-				filter &= ~DO_NONFLAGS;
+				if (!(filter & DO_FLAGS)) {
+					/* prevent --flags being interpreted if --no-flags has been seen */
+					continue;
+				}
+				filter &= ~(DO_NONFLAGS|DO_REVS);
 				continue;
 			}
 			if (!strcmp(arg, "--no-flags")) {
diff --git a/t/t1510-rev-parse-flags.sh b/t/t1510-rev-parse-flags.sh
index ef0b4ad..7df2081 100755
--- a/t/t1510-rev-parse-flags.sh
+++ b/t/t1510-rev-parse-flags.sh
@@ -29,10 +29,10 @@ test_expect_success 'git rev-parse --no-revs --flags HEAD -> ""' \
 	test_cmp expected actual
 '
 
-test_expect_success 'git rev-parse --symbolic --flags HEAD -> "HEAD"' \
+test_expect_success 'git rev-parse --flags HEAD -> ""' \
 '
-	echo HEAD > expected &&
-	git rev-parse --symbolic --flags HEAD >actual &&
+	: > expected &&
+	git rev-parse --flags HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -106,4 +106,22 @@ test_expect_success 'git rev-parse --symbolic --no-flags --flags HEAD -> "HEAD"'
 	test_cmp expected actual
 '
 
+test_expect_success 'git rev-parse --no-revs file -> "file"' \
+'
+	echo foo >file &&
+	echo file >expected &&
+	git rev-parse --no-revs file >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --no-revs -- not-a-file -> "-- not-a-file"' \
+'
+	cat >expected <<-EOF &&
+--
+not-a-file
+	EOF
+	git rev-parse --no-revs -- not-a-file >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.3.4.g73371.dirty
