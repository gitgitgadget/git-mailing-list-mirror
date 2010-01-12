From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Display author and committer after "git commit"
Date: Tue, 12 Jan 2010 09:24:06 -0500
Message-ID: <20100112142405.GA13369@coredump.intra.peff.net>
References: <xuu2fx6m4vdi.fsf@nowhere.com>
 <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com>
 <xuu2zl4tfuij.fsf@nowhere.com>
 <20100106073806.6117@nanako3.lavabit.com>
 <7v4omz17xz.fsf@alter.siamese.dyndns.org>
 <xuu28wc9xd42.fsf@nowhere.com>
 <7vskagh9fg.fsf@alter.siamese.dyndns.org>
 <xuu2fx6d9rzb.fsf_-_@nowhere.com>
 <7vzl4lw160.fsf@alter.siamese.dyndns.org>
 <xuu2zl4kks3s.fsf@nowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam Megacz <adam@megacz.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 15:24:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUhff-00023M-Lb
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 15:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab0ALOYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 09:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753845Ab0ALOYR
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 09:24:17 -0500
Received: from peff.net ([208.65.91.99]:35043 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917Ab0ALOYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 09:24:15 -0500
Received: (qmail 7587 invoked by uid 107); 12 Jan 2010 14:29:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 Jan 2010 09:29:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2010 09:24:06 -0500
Content-Disposition: inline
In-Reply-To: <xuu2zl4kks3s.fsf@nowhere.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136721>

On Tue, Jan 12, 2010 at 01:51:51AM +0000, Adam Megacz wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> > Why isn't the "# Author:" and "# Committer:" information you see along
> > with "git status" output in the editor "git commit" gives you sufficient
> > if it is to avoid unconfigured/misconfigured names and e-mail
> > addresses?
> 
> It is sufficient!  But, as others have mentioned, it is not displayed
> when "git commit -m" is used.  The patch in this thread rectifies that
> omission.

I think it is sensible to reiterate the information in the summary for
the "interesting" cases, as it does make it available to people who do
not see the template, and as the uncommon case, is not usually
cluttering the output.

But I don't understand why the original patch needed to touch anything
outside of builtin-commit.c:print_summary. Something like this should
work (though see below for why it isn't ready for inclusion):

diff --git a/builtin-commit.c b/builtin-commit.c
index 1e353f6..6ee6b10 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1054,9 +1054,12 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 {
 	struct rev_info rev;
 	struct commit *commit;
-	static const char *format = "format:%h] %s";
+	struct strbuf format = STRBUF_INIT;
 	unsigned char junk_sha1[20];
 	const char *head = resolve_ref("HEAD", junk_sha1, 0, NULL);
+	struct pretty_print_context pctx = {0};
+	struct strbuf author_ident = STRBUF_INIT;
+	struct strbuf committer_ident = STRBUF_INIT;
 
 	commit = lookup_commit(sha1);
 	if (!commit)
@@ -1064,6 +1067,22 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	if (!commit || parse_commit(commit))
 		die("could not parse newly created commit");
 
+	strbuf_addstr(&format, "format:%h] %s");
+
+	format_commit_message(commit, "%an <%ae>", &author_ident, &pctx);
+	format_commit_message(commit, "%cn <%ce>", &committer_ident, &pctx);
+	if (strbuf_cmp(&author_ident, &committer_ident)) {
+		int i;
+		strbuf_addstr(&format, "\n Author: ");
+		for (i = 0; i < author_ident.len; i++) {
+			if (author_ident.buf[i] == '%')
+				strbuf_addch(&format, '%');
+			strbuf_addch(&format, author_ident.buf[i]);
+		}
+	}
+	strbuf_release(&author_ident);
+	strbuf_release(&committer_ident);
+
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 
@@ -1074,7 +1093,8 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 	rev.verbose_header = 1;
 	rev.show_root_diff = 1;
-	get_commit_format(format, &rev);
+	get_commit_format(format.buf, &rev);
+	strbuf_release(&format);
 	rev.always_show_header = 0;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 100;
@@ -1093,7 +1113,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 		struct pretty_print_context ctx = {0};
 		struct strbuf buf = STRBUF_INIT;
 		ctx.date_mode = DATE_NORMAL;
-		format_commit_message(commit, format + 7, &buf, &ctx);
+		format_commit_message(commit, format.buf + 7, &buf, &ctx);
 		printf("%s\n", buf.buf);
 		strbuf_release(&buf);
 	}

It's not appropriate for inclusion because:

  - I didn't actually test it beyond "GIT_AUTHOR_NAME=Foo git commit
    -m". I think what the code does is correct, but it may be breaking
    output in the test suite.

  - It tries to quote any percents in the author name, but user formats
    don't actually have a quoting mechanism! Probably we should
    interpret "%%" as "%". Even though it's a behavior change, I
    consider the current behavior buggy.

    Side note: it feels a little hack-ish that I have to actually use a
    user-format to get the author and committer. But we don't seem to
    have any infrastructure for something as simple as "give me a string
    with the author name of this commit".

  - It only handles author != committer as interesting. We should also
    check user_ident_explicitly_given and show the committer in that
    case, as the editor template does.

-Peff
