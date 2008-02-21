From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-clean: handle errors if removing files fails
Date: Thu, 21 Feb 2008 02:44:46 +0100
Message-ID: <20080221014446.GT31441@genesis.frugalware.org>
References: <20080220234154.GS31441@genesis.frugalware.org> <7vodab182n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 02:46:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS0Vl-00022a-Mz
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 02:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbYBUBpC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 20:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbYBUBpB
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 20:45:01 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:40257 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbYBUBpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 20:45:00 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JS0UW-0000X5-D4
	from <vmiklos@frugalware.org>; Thu, 21 Feb 2008 02:44:58 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B13B5119019F; Thu, 21 Feb 2008 02:44:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vodab182n.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74584>

git-clean simply ignored errors if removing a file or directory failed. This
patch makes it raise a warning and the exit code also greater than zero if
there are remaining files.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Feb 20, 2008 at 04:12:16PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> That's quite different style from the other commit log messages
> in the project, isn't it?

right, i rewrote it.

> While I agree reporting an error is definitely an improvement, I
> do not think dying in the middle is the right thing to do.
>
> Shouldn't it note the error, remove other cruft, and then
> finally signal the error by exiting non-zero?

something like this?

i also noticed that we need a chmod 755 after the last test, otherwise
removing the trash directory will not be possible. i haven't hit this
bug by running the test only once.

 builtin-clean.c  |   22 ++++++++++++++--------
 t/t7300-clean.sh |   10 ++++++++++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index eb853a3..5ed57d7 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -29,7 +29,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int show_only = 0, remove_directories = 0, quiet = 0, ignored = 0;
-	int ignored_only = 0, baselen = 0, config_set = 0;
+	int ignored_only = 0, baselen = 0, config_set = 0, errors = 0;
 	struct strbuf directory;
 	struct dir_struct dir;
 	const char *path, *base;
@@ -137,12 +137,15 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
+				if (remove_dir_recursively(&directory, 0) != 0) {
+					warning("failed to remove '%s'",
+						directory.buf + prefix_offset);
+					errors++;
+				}
 			} else if (show_only) {
 				printf("Would not remove %s\n",
 				       directory.buf + prefix_offset);
@@ -162,11 +165,14 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				printf("Removing %s\n",
 				       ent->name + prefix_offset);
 			}
-			unlink(ent->name);
+			if (unlink(ent->name) != 0) {
+				warning("failed to remove '%s'", ent->name);
+				errors++;
+			}
 		}
 	}
 	free(seen);
 
 	strbuf_release(&directory);
-	return 0;
+	return errors;
 }
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index dfd1188..3840364 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -316,4 +316,14 @@ test_expect_success 'core.excludesfile' '
 
 '
 
+test_expect_success 'removal failure' '
+
+	mkdir foo &&
+	touch foo/bar &&
+	chmod 0 foo &&
+	! git clean -f -d
+
+'
+chmod 755 foo
+
 test_done
-- 
1.5.4.1
