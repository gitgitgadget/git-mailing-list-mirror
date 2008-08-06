From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] files given on the command line are relative to $cwd
Date: Wed, 06 Aug 2008 11:43:47 -0700
Message-ID: <7vr692oufw.fsf@gitster.siamese.dyndns.org>
References: <48997D2E.9030708@obry.net>
 <20080806104432.GG7121@bit.office.eurotux.com> <4899848C.6030800@obry.net>
 <7v3alirw6b.fsf@gitster.siamese.dyndns.org> <4899D119.1080403@obry.net>
 <7vy73aqe9m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luciano Rocha <luciano@eurotux.com>, pascal@obry.net,
	Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 20:45:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQo0N-0002PH-E5
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 20:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597AbYHFSoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 14:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755543AbYHFSn7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 14:43:59 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbYHFSn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 14:43:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4FA5D4D183;
	Wed,  6 Aug 2008 14:43:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6893A4D17F; Wed,  6 Aug 2008 14:43:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A08CD8F2-63E7-11DD-A1AA-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91532>

When running "git commit -F file" and "git tag -F file" from a
subdirectory, we should take it as relative to the directory we started
from, not relative to the top-level directory.

This adds a helper function "parse_options_fix_filename()" to make it more
convenient to fix this class of issues.  Ideally, parse_options() should
support a new type of option, "OPT_FILENAME", to do this uniformly, but
this patch is meant to go to 'maint' to fix it minimally.

One thing to note is that value for "commit template file" that comes from
the command line is taken as relative to $cwd just like other parameters,
but when it comes from the configuration varilable 'commit.template', it
is taken as relative to the working tree root as before.  I think this
difference actually is sensible (not that I particularly think
commit.template itself is sensible).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c  |   11 +++++++----
 builtin-tag.c     |    1 +
 parse-options.c   |   12 ++++++++++++
 parse-options.h   |    2 ++
 t/t7500-commit.sh |   11 +++++++++++
 5 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index bcbea38..0c6d1f4 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -45,7 +45,7 @@ static enum {
 	COMMIT_PARTIAL,
 } commit_style;
 
-static char *logfile, *force_author;
+static const char *logfile, *force_author;
 static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
@@ -700,11 +700,14 @@ static int message_is_empty(struct strbuf *sb, int start)
 }
 
 static int parse_and_validate_options(int argc, const char *argv[],
-				      const char * const usage[])
+				      const char * const usage[],
+				      const char *prefix)
 {
 	int f = 0;
 
 	argc = parse_options(argc, argv, builtin_commit_options, usage, 0);
+	logfile = parse_options_fix_filename(prefix, logfile);
+	template_file = parse_options_fix_filename(prefix, template_file);
 
 	if (logfile || message.len || use_message)
 		use_editor = 0;
@@ -814,7 +817,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (wt_status_use_color == -1)
 		wt_status_use_color = git_use_color_default;
 
-	argc = parse_and_validate_options(argc, argv, builtin_status_usage);
+	argc = parse_and_validate_options(argc, argv, builtin_status_usage, prefix);
 
 	index_file = prepare_index(argc, argv, prefix);
 
@@ -907,7 +910,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	git_config(git_commit_config, NULL);
 
-	argc = parse_and_validate_options(argc, argv, builtin_commit_usage);
+	argc = parse_and_validate_options(argc, argv, builtin_commit_usage, prefix);
 
 	index_file = prepare_index(argc, argv, prefix);
 
diff --git a/builtin-tag.c b/builtin-tag.c
index 3c97c69..3f77ba9 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -411,6 +411,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	git_config(git_tag_config, NULL);
 
 	argc = parse_options(argc, argv, options, git_tag_usage, 0);
+	msgfile = parse_options_fix_filename(prefix, msgfile);
 
 	if (keyid) {
 		sign = 1;
diff --git a/parse-options.c b/parse-options.c
index f8d52e2..d771bf4 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -425,3 +425,15 @@ int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
 	*(unsigned long *)(opt->value) = approxidate(arg);
 	return 0;
 }
+
+/*
+ * This should really be OPTION_FILENAME type as a part of
+ * parse_options that take prefix to do this while parsing.
+ */
+extern const char *parse_options_fix_filename(const char *prefix, const char *file)
+{
+	if (!file || !prefix || is_absolute_path(file))
+		return file;
+	return prefix_filename(prefix, strlen(prefix), file);
+}
+
diff --git a/parse-options.h b/parse-options.h
index 4ee443d..13ad158 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -123,4 +123,6 @@ extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
 	  "use <n> digits to display SHA-1s", \
 	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
 
+extern const char *parse_options_fix_filename(const char *prefix, const char *file);
+
 #endif
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index baed6ce..026d787 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -138,4 +138,15 @@ test_expect_success '--signoff' '
 	diff expect output
 '
 
+test_expect_success 'commit message from file' '
+	mkdir subdir &&
+	echo "Log in top directory" >log &&
+	echo "Log in sub directory" >subdir/log &&
+	(
+		cd subdir &&
+		git commit --allow-empty -F log
+	) &&
+	commit_msg_is "Log in sub directory"
+'
+
 test_done
