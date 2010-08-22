From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 1/5] fmt-merge-msg: Make the number of log entries
	in commit message configurable
Date: Sat, 21 Aug 2010 22:33:30 -0500
Message-ID: <20100822033330.GA12380@belmont.cs.uchicago.edu>
References: <1282384699-16477-1-git-send-email-artagnon@gmail.com> <1282384699-16477-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 22 05:33:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On1Jk-0000gm-DK
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 05:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861Ab0HVDdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 23:33:33 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:36384 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab0HVDdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 23:33:32 -0400
Received: from belmont.cs.uchicago.edu (belmont.cs.uchicago.edu [128.135.11.108])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id B2271A2C9;
	Sat, 21 Aug 2010 22:33:30 -0500 (CDT)
Received: by belmont.cs.uchicago.edu (Postfix, from userid 10442)
	id 98E965A553; Sat, 21 Aug 2010 22:33:30 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1282384699-16477-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154163>

Hi again,

Thanks for working on this.

Ramkumar Ramachandra wrote:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Reported-by: Yaroslav Halchenko <debian <at> onerussian.com>

Looks like some of the @ signs have been corrupted somehow.

> +++ b/builtin/fmt-merge-msg.c
> @@ -12,16 +12,23 @@ static const char * const fmt_merge_msg_usage[] = {
>  };
>  
>  static int merge_summary;
> +static int log_limit = 0;

I still don't see why the merge_summary is needed...

>  static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
[...]
> +	merge_summary = log_limit ? 1 : 0;

... since shouldn't it always be equal to log_limit ? 1 : 0?

> @@ -140,7 +147,7 @@ static void print_joined(const char *singular, const char *plural,
>  }
>  
>  static void shortlog(const char *name, unsigned char *sha1,
> -		struct commit *head, struct rev_info *rev, int limit,
> +		struct commit *head, struct rev_info *rev,

This adds to my confusion.  Suppose the statics have values

	merge_summary = 0;
	log_limit = 11;

and I try

	fmt_merge_msg(5, &in, &out);

What will happen?

Currently (before this patch) the rules are as follows:

	- the merge_summary parameter to fmt_merge_msg
	  alone decides whether a shortlog (of at most 20 items
	  per parent) is printed.

	  To outside users (think "git merge"), the static
	  merge_summary var is simply irrelevant.

	- the static merge_summary variable is used internally by "git
	  fmt-merge-msg" command-line and configuration parsing (with
	  command line winning in ties).

and builtin/merge.c has its own separate code for parsing merge.*
configuration.

FWIW if I were writing it, I would make changes in something like this
order:

 - Change fmt_merge_msg API to

	int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
				int shortlog_len);

   where shortlog_len is 0 for no shortlog, 20 for a shortlog
   with 20 items.  Update all callers (the changed function
   signature makes it easy to find them).

 - Update merge --log and fmt-merge-msg --log options to take
   an optional "size of shortlog" argument.

 - update [merge] log configuration to accept an integer
   "size of shortlog" value.

The first step might look like this.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin.h               |    4 ++--
 builtin/fmt-merge-msg.c |   18 +++++++++---------
 builtin/merge.c         |    3 ++-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin.h b/builtin.h
index ed6ee26..a7352df 100644
--- a/builtin.h
+++ b/builtin.h
@@ -14,8 +14,8 @@ extern const char git_more_info_string[];
 extern void list_common_cmds_help(void);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void prune_packed_objects(int);
-extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
-	struct strbuf *out);
+extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
+			 int shortlog_len);
 extern int fmt_merge_msg_shortlog(struct strbuf *in, struct strbuf *out);
 extern int commit_notes(struct notes_tree *t, const char *msg);
 
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index a76cd4e..83692c1 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -255,9 +255,9 @@ static void do_fmt_merge_msg_title(struct strbuf *out,
 		strbuf_addf(out, " into %s\n", current_branch);
 }
 
-static int do_fmt_merge_msg(int merge_title, int merge_summary,
-	struct strbuf *in, struct strbuf *out) {
-	int limit = 20, i = 0, pos = 0;
+static int do_fmt_merge_msg(int merge_title,
+	struct strbuf *in, struct strbuf *out, int shortlog_len) {
+	int i = 0, pos = 0;
 	unsigned char head_sha1[20];
 	const char *current_branch;
 
@@ -288,7 +288,7 @@ static int do_fmt_merge_msg(int merge_title, int merge_summary,
 	if (merge_title)
 		do_fmt_merge_msg_title(out, current_branch);
 
-	if (merge_summary) {
+	if (shortlog_len) {
 		struct commit *head;
 		struct rev_info rev;
 
@@ -303,17 +303,17 @@ static int do_fmt_merge_msg(int merge_title, int merge_summary,
 
 		for (i = 0; i < origins.nr; i++)
 			shortlog(origins.items[i].string, origins.items[i].util,
-					head, &rev, limit, out);
+					head, &rev, shortlog_len, out);
 	}
 	return 0;
 }
 
-int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
-	return do_fmt_merge_msg(1, merge_summary, in, out);
+int fmt_merge_msg(struct strbuf *in, struct strbuf *out, int shortlog_len) {
+	return do_fmt_merge_msg(1, in, out, shortlog_len);
 }
 
 int fmt_merge_msg_shortlog(struct strbuf *in, struct strbuf *out) {
-	return do_fmt_merge_msg(0, 1, in, out);
+	return do_fmt_merge_msg(0, in, out, 20);
 }
 
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
@@ -346,7 +346,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 
 	if (strbuf_read(&input, fileno(in), 0) < 0)
 		die_errno("could not read input file");
-	ret = fmt_merge_msg(merge_summary, &input, &output);
+	ret = fmt_merge_msg(&input, &output, merge_summary ? 20 : 0);
 	if (ret)
 		return ret;
 	write_in_full(STDOUT_FILENO, output.buf, output.len);
diff --git a/builtin/merge.c b/builtin/merge.c
index 37ce4f5..8b0b2e2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1001,7 +1001,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (have_message && option_log)
 			fmt_merge_msg_shortlog(&merge_names, &merge_msg);
 		else if (!have_message)
-			fmt_merge_msg(option_log, &merge_names, &merge_msg);
+			fmt_merge_msg(&merge_names, &merge_msg,
+					option_log ? 20 : 0);
 
 
 		if (!(have_message && !option_log) && merge_msg.len)
-- 
