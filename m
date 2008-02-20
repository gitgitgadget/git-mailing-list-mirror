From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-clean: handle errors if removing files fails
Date: Thu, 21 Feb 2008 00:41:54 +0100
Message-ID: <20080220234154.GS31441@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 00:43:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRyab-0004SX-Uv
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 00:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbYBTXmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 18:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755980AbYBTXmZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 18:42:25 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:43826 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbYBTXmY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 18:42:24 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JRyZh-0000hK-3o
	from <vmiklos@frugalware.org>; Thu, 21 Feb 2008 00:42:21 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 917CC119019F; Thu, 21 Feb 2008 00:41:54 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.0
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.0 required=5.9 tests=BAYES_50 autolearn=no SpamAssassin version=3.2.3
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4691]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74570>

Consider the following case:

$ sudo mkdir foo
$ sudo touch foo/bar

This is the old output:

$ git clean -f -d
Removing foo/

No error message.

This is the new output:

$ ~/git/git/git clean -f -d
Removing foo/
fatal: failed to remove 'foo/'

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-clean.c  |   14 ++++++++------
 t/t7300-clean.sh |    9 +++++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index eb853a3..c8753a5 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -137,12 +137,13 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			if (show_only && (remove_directories || matches)) {
 				printf("Would remove %s\n",
 				       directory.buf + prefix_offset);
-			} else if (quiet && (remove_directories || matches)) {
-				remove_dir_recursively(&directory, 0);
 			} else if (remove_directories || matches) {
-				printf("Removing %s\n",
-				       directory.buf + prefix_offset);
-				remove_dir_recursively(&directory, 0);
+				if (!quiet)
+					printf("Removing %s\n",
+					       directory.buf + prefix_offset);
+				if (remove_dir_recursively(&directory, 0) != 0)
+					die("failed to remove '%s'",
+						directory.buf + prefix_offset);
 			} else if (show_only) {
 				printf("Would not remove %s\n",
 				       directory.buf + prefix_offset);
@@ -162,7 +163,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				printf("Removing %s\n",
 				       ent->name + prefix_offset);
 			}
-			unlink(ent->name);
+			if (unlink(ent->name) != 0)
+				die("failed to remove '%s'", ent->name);
 		}
 	}
 	free(seen);
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index dfd1188..bd0a814 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -316,4 +316,13 @@ test_expect_success 'core.excludesfile' '
 
 '
 
+test_expect_success 'removal failure' '
+
+	mkdir foo &&
+	touch foo/bar &&
+	chmod 0 foo &&
+	! git clean -f -d
+
+'
+
 test_done
-- 
1.5.4.1
