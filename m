From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Tue, 30 Sep 2008 23:14:01 -0400
Message-ID: <20081001031400.GA24513@coredump.intra.peff.net>
References: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl> <1220634785-55543-1-git-send-email-pdebie@ai.rug.nl> <7vzlmkpltb.fsf@gitster.siamese.dyndns.org> <20080921104238.GA9217@sigill.intra.peff.net> <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl> <20080929224430.GA11545@sigill.intra.peff.net> <48E1C39F.4070906@op5.se> <836C204F-F5AF-4887-99C9-04E70FEEB998@wincent.com> <20080930070938.GA14757@sigill.intra.peff.net> <48E1F87D.2010906@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Wincent Colaiuta <win@wincent.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Oct 01 05:15:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KksBg-000098-OT
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 05:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbYJADOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 23:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800AbYJADOG
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 23:14:06 -0400
Received: from peff.net ([208.65.91.99]:2589 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbYJADOF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 23:14:05 -0400
Received: (qmail 14003 invoked by uid 111); 1 Oct 2008 03:14:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Sep 2008 23:14:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Sep 2008 23:14:01 -0400
Content-Disposition: inline
In-Reply-To: <48E1F87D.2010906@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97186>

On Tue, Sep 30, 2008 at 11:59:25AM +0200, Andreas Ericsson wrote:

> I agree. Obvious solution is to do
>
> subj_len = term_width - (strlen(cruft) + strlen(branch_name))

I think the difficulty is that the printing is sometimes done by our
printf and sometimes by log_tree_commit, and there isn't a convenient
way to hook into log_tree_commit to postprocess the formatted output.

> where strlen(cruft) is just 8 less if we drop 'commit ' from the
> cases. See the patch I just sent though. I sort of like that one.

I like it much better than what is on next (and I thought your commit
message summed up the issue nicely), but...

> Another way would be to write
> <branch>: Created <hash>: "subject line..."

I think I like this even better. My only concern is that many programs
say "program: some error", so you could potentially have a confusing
branch name. But I personally have never used a branch name that would
cause such confusion.

> As <hash> will very, very rarely match anything the user would put
> in his/her commit message themselves. Quoting the subject is probably
> a nice touch, and it can make sense to put it last as it's the least
> interesting of the things we print. Ah well. I'll just await commentary
> on the patch I've already sent before I go ahead and do something like
> that.

Here is a patch for that format on top of next (the patch between this
and what is in master is even more simple, since we are mostly removing
Pieter's helper function).

---
diff --git a/builtin-commit.c b/builtin-commit.c
index 917f638..9954a81 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -876,41 +876,17 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	rollback_index_files();
 
 	return commitable ? 0 : 1;
 }
 
-static char *get_commit_format_string(void)
-{
-	unsigned char sha[20];
-	const char *head = resolve_ref("HEAD", sha, 0, NULL);
-	struct strbuf buf = STRBUF_INIT;
-
-	strbuf_addstr(&buf, "format:%h");
-
-	/* Are we on a detached HEAD? */
-	if (!strcmp("HEAD", head))
-		strbuf_addstr(&buf, " on detached HEAD");
-	else if (!prefixcmp(head, "refs/heads/")) {
-		const char *cp;
-		strbuf_addstr(&buf, " on ");
-		for (cp = head + 11; *cp; cp++) {
-			if (*cp == '%')
-				strbuf_addstr(&buf, "%x25");
-			else
-				strbuf_addch(&buf, *cp);
-		}
-	}
-	strbuf_addstr(&buf, ": %s");
-
-	return strbuf_detach(&buf, NULL);
-}
-
 static void print_summary(const char *prefix, const unsigned char *sha1)
 {
 	struct rev_info rev;
 	struct commit *commit;
-	char *format = get_commit_format_string();
+	static const char *format = "format:%h: \"%s\"";
+	unsigned char junk_sha1[20];
+	const char *head = resolve_ref("HEAD", junk_sha1, 0, NULL);
 
 	commit = lookup_commit(sha1);
 	if (!commit)
 		die("couldn't look up newly created commit");
 	if (!commit || parse_commit(commit))
@@ -931,19 +907,20 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 100;
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
-	printf("Created %scommit ", initial_commit ? "initial " : "");
+	printf("%s%s: created ",
+		!prefixcmp(head, "refs/heads/") ? head + 11 : head,
+		initial_commit ? " (initial)" : "");
 
 	if (!log_tree_commit(&rev, commit)) {
 		struct strbuf buf = STRBUF_INIT;
 		format_commit_message(commit, format + 7, &buf, DATE_NORMAL);
 		printf("%s\n", buf.buf);
 		strbuf_release(&buf);
 	}
-	free(format);
 }
 
 static int git_commit_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "commit.template"))
