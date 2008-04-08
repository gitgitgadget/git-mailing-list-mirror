From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] log and rev-list: Fixed newline termination issues
 with --graph
Date: Mon, 07 Apr 2008 17:11:34 -0700
Message-ID: <7vmyo5nr2h.fsf@gitster.siamese.dyndns.org>
References: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-2-git-send-email-adam@adamsimpkins.net>
 <7vod8mqdlw.fsf@gitster.siamese.dyndns.org>
 <7vwsnaoxlz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Simpkins <adam@adamsimpkins.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 08 02:12:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jj1S2-00031W-RG
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 02:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472AbYDHALz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 20:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755449AbYDHALz
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 20:11:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbYDHALy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 20:11:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E44F10D5D;
	Mon,  7 Apr 2008 20:11:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1E91910D58; Mon,  7 Apr 2008 20:11:42 -0400 (EDT)
In-Reply-To: <7vwsnaoxlz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 07 Apr 2008 01:52:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78990>

Junio C Hamano <gitster@pobox.com> writes:

>  (2) Presence of %n in "--pretty=format:..." means a multi-line output and
>      uses separator as before; lack of %n means it is a one-line format
>      and uses terminator.

After thinking about this a bit more, I think a slight variant of the
above probably is the least intrusive both from code and semantics point
of view, and would match end-user expectations pretty well.

This attached patch introduces a single bit "use_terminator" in "struct
rev_info", which is normally false (i.e. most formats use separator
semantics) but by flipping it to true, you can ask for terminator
semantics just like oneline format does.

The function get_commit_format(), which is what parses "--pretty=" option,
now takes a pointer to "struct rev_info" and updates its commit_format and
use_terminator fields.  It used to return the value of type "enum
cmit_fmt", but all the callers assigned it to rev->commit_format.

There are only two cases the code turns use_terminator on.  Obviously, the
traditional oneline format (--pretty=oneline) is one of them, and the new
case is --pretty=format:... that does not end with "%n".

When the custom format "--pretty=format:" is:

	"A: %an <%ae>%nC: %cn <%ce>%n"

it represents a record with two lines (author and committer), and these
are output with an extra LF in between, just like the regular --pretty
without customization will get an extra separator.  The custom format

	"A: %an <%ae> C: %cn <%ce>"

will give a one-line-per-commit output, each of which is terminated with
LF.  And

	"A: %an <%ae>%nC: %cn <%ce>"

will give two line per commit without extra separator.

---

 builtin-commit.c |    2 +-
 builtin-log.c    |    3 ++-
 commit.h         |    3 ++-
 log-tree.c       |    4 ++--
 pretty.c         |   25 ++++++++++++++++++-------
 revision.c       |    2 +-
 revision.h       |    3 ++-
 7 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 660a345..8bf3503 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -810,7 +810,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 	rev.verbose_header = 1;
 	rev.show_root_diff = 1;
-	rev.commit_format = get_commit_format("format:%h: %s");
+	get_commit_format("format:%h: %s", &rev);
 	rev.always_show_header = 0;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 100;
diff --git a/builtin-log.c b/builtin-log.c
index 5c00725..1670d0b 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -56,7 +56,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
 	if (fmt_pretty)
-		rev->commit_format = get_commit_format(fmt_pretty);
+		get_commit_format(fmt_pretty, rev);
 	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->show_root_diff = default_show_root;
@@ -400,6 +400,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	 * allow us to set a different default.
 	 */
 	rev.commit_format = CMIT_FMT_ONELINE;
+	rev.use_terminator = 1;
 	rev.always_show_header = 1;
 
 	/*
diff --git a/commit.h b/commit.h
index 2f63bc8..2d94d41 100644
--- a/commit.h
+++ b/commit.h
@@ -63,7 +63,8 @@ enum cmit_fmt {
 };
 
 extern int non_ascii(int);
-extern enum cmit_fmt get_commit_format(const char *arg);
+struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
+extern void get_commit_format(const char *arg, struct rev_info *);
 extern void format_commit_message(const struct commit *commit,
                                   const void *format, struct strbuf *sb);
 extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit*,
diff --git a/log-tree.c b/log-tree.c
index 5b29639..d246147 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -249,9 +249,9 @@ void show_log(struct rev_info *opt, const char *sep)
 	 *    not have an empty line between entries.
 	 */
 	extra = "";
-	if (*sep != '\n' && opt->commit_format == CMIT_FMT_ONELINE)
+	if (*sep != '\n' && opt->use_terminator)
 		extra = "\n";
-	if (opt->shown_one && opt->commit_format != CMIT_FMT_ONELINE)
+	if (opt->shown_one && !opt->use_terminator)
 		putchar(opt->diffopt.line_termination);
 	opt->shown_one = 1;
 
diff --git a/pretty.c b/pretty.c
index 16bfb86..365e387 100644
--- a/pretty.c
+++ b/pretty.c
@@ -21,23 +21,34 @@ static struct cmt_fmt_map {
 
 static char *user_format;
 
-enum cmit_fmt get_commit_format(const char *arg)
+void get_commit_format(const char *arg, struct rev_info *rev)
 {
 	int i;
 
-	if (!arg || !*arg)
-		return CMIT_FMT_DEFAULT;
+	rev->use_terminator = 0;
+	if (!arg || !*arg) {
+		rev->commit_format = CMIT_FMT_DEFAULT;
+		return;
+	}
 	if (*arg == '=')
 		arg++;
 	if (!prefixcmp(arg, "format:")) {
+		size_t len = strlen(arg + 7);
 		free(user_format);
 		user_format = xstrdup(arg + 7);
-		return CMIT_FMT_USERFORMAT;
+		if (len < 2 || strcmp(user_format + len - 2, "%n"))
+			rev->use_terminator = 1;
+		rev->commit_format = CMIT_FMT_USERFORMAT;
+		return;
 	}
-	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
+	for (i = 0; i < ARRAY_SIZE(cmt_fmts) - 1; i++) {
 		if (!strncmp(arg, cmt_fmts[i].n, cmt_fmts[i].cmp_len) &&
-		    !strncmp(arg, cmt_fmts[i].n, strlen(arg)))
-			return cmt_fmts[i].v;
+		    !strncmp(arg, cmt_fmts[i].n, strlen(arg))) {
+			if (cmt_fmts[i].v == CMIT_FMT_ONELINE)
+				rev->use_terminator = 0;
+			rev->commit_format = cmt_fmts[i].v;
+			return;
+		}
 	}
 
 	die("invalid --pretty format: %s", arg);
diff --git a/revision.c b/revision.c
index 196fedc..781c503 100644
--- a/revision.c
+++ b/revision.c
@@ -1198,7 +1198,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			}
 			if (!prefixcmp(arg, "--pretty")) {
 				revs->verbose_header = 1;
-				revs->commit_format = get_commit_format(arg+8);
+				get_commit_format(arg+8, revs);
 				continue;
 			}
 			if (!strcmp(arg, "--root")) {
diff --git a/revision.h b/revision.h
index c8b3b94..31217f8 100644
--- a/revision.h
+++ b/revision.h
@@ -64,7 +64,8 @@ struct rev_info {
 
 	/* Format info */
 	unsigned int	shown_one:1,
-			abbrev_commit:1;
+			abbrev_commit:1,
+			use_terminator:1;
 	enum date_mode date_mode;
 
 	const char **ignore_packed; /* pretend objects in these are unpacked */
