From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 14:53:47 -0700
Message-ID: <7v8x5jgdck.fsf@gitster.siamese.dyndns.org>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de>
	<7vodefj2lk.fsf@gitster.siamese.dyndns.org>
	<20071031055303.GB3326@atjola.homenet>
	<20071031134358.GD15182@dpotapov.dyndns.org>
	<20071031140028.GA30207@diana.vm.bytemark.co.uk>
	<20071031143641.GF15182@dpotapov.dyndns.org>
	<20071031180557.GA12211@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:54:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InLWM-0004vu-MR
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774AbXJaVx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbXJaVx6
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:53:58 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:42448 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbXJaVx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:53:57 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 27AA22EF;
	Wed, 31 Oct 2007 17:54:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 21CFF90CDA;
	Wed, 31 Oct 2007 17:54:11 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62885>

Jeff King <peff@peff.net> writes:

> It is our old friend vger adding the iso-8859-1 header, I think, since
> no encoding was specified.
>
> I think the problem is that git-format-patch only decides whether to
> append a MIME header based on the commit message contents; it does not
> take the Signed-Off-By into account. This may also be the cause of the
> recent complaints from Matti Aarnio.

I agree.  "Signed-off-by" as part of the existing commit message
should be fine, but with "format-patch -s" the code needs to be
careful.

The following is on top of 'master'.  I haven't tested it.  If it
works, great.  If it doesn't, at least it should illustrate what
needs to be touched.

Ideally a fix to 'maint' is needed --- the pretty-print
infrastructure on the 'master' side has strbuf changes and the
patch may have conflicts at the textual level, but it should be
straightforward to adjust to it by anybody so inclined (hint,
hint).

---

 builtin-branch.c      |    2 +-
 builtin-log.c         |    2 +-
 builtin-rev-list.c    |    3 ++-
 builtin-show-branch.c |    2 +-
 commit.c              |    5 ++---
 commit.h              |    4 +++-
 log-tree.c            |   15 ++++++++++++++-
 7 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 3da8b55..3e020cc 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -276,7 +276,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		commit = lookup_commit(item->sha1);
 		if (commit && !parse_commit(commit)) {
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
-					    &subject, 0, NULL, NULL, 0);
+					    &subject, 0, NULL, NULL, 0, 0);
 			sub = subject.buf;
 		}
 		printf("%c %s%-*s%s %s %s\n", c, branch_get_color(color),
diff --git a/builtin-log.c b/builtin-log.c
index e8b982d..8b2bf63 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -787,7 +787,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			struct strbuf buf;
 			strbuf_init(&buf, 0);
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
-			                    &buf, 0, NULL, NULL, 0);
+			                    &buf, 0, NULL, NULL, 0, 0);
 			printf("%c %s %s\n", sign,
 			       sha1_to_hex(commit->object.sha1), buf.buf);
 			strbuf_release(&buf);
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 4439332..6970467 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -86,7 +86,8 @@ static void show_commit(struct commit *commit)
 		struct strbuf buf;
 		strbuf_init(&buf, 0);
 		pretty_print_commit(revs.commit_format, commit,
-					&buf, revs.abbrev, NULL, NULL, revs.date_mode);
+				    &buf, revs.abbrev, NULL, NULL,
+				    revs.date_mode, 0);
 		if (buf.len)
 			printf("%s%c", buf.buf, hdr_termination);
 		strbuf_release(&buf);
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 07a0c23..6dc835d 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -266,7 +266,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 	strbuf_init(&pretty, 0);
 	if (commit->object.parsed) {
 		pretty_print_commit(CMIT_FMT_ONELINE, commit,
-					&pretty, 0, NULL, NULL, 0);
+				    &pretty, 0, NULL, NULL, 0, 0);
 		pretty_str = pretty.buf;
 	}
 	if (!prefixcmp(pretty_str, "[PATCH] "))
diff --git a/commit.c b/commit.c
index ac24266..8262f6a 100644
--- a/commit.c
+++ b/commit.c
@@ -479,7 +479,7 @@ static int get_one_line(const char *msg)
 }
 
 /* High bit set, or ISO-2022-INT */
-static int non_ascii(int ch)
+int non_ascii(int ch)
 {
 	ch = (ch & 0xff);
 	return ((ch & 0x80) || (ch == 0x1b));
@@ -1046,12 +1046,11 @@ static void pp_remainder(enum cmit_fmt fmt,
 void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 				  struct strbuf *sb, int abbrev,
 				  const char *subject, const char *after_subject,
-				  enum date_mode dmode)
+				  enum date_mode dmode, int plain_non_ascii)
 {
 	unsigned long beginning_of_body;
 	int indent = 4;
 	const char *msg = commit->buffer;
-	int plain_non_ascii = 0;
 	char *reencoded;
 	const char *encoding;
 
diff --git a/commit.h b/commit.h
index b779de8..678c62b 100644
--- a/commit.h
+++ b/commit.h
@@ -61,13 +61,15 @@ enum cmit_fmt {
 	CMIT_FMT_UNSPECIFIED,
 };
 
+extern int non_ascii(int);
 extern enum cmit_fmt get_commit_format(const char *arg);
 extern void format_commit_message(const struct commit *commit,
                                   const void *format, struct strbuf *sb);
 extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit*,
                                 struct strbuf *,
                                 int abbrev, const char *subject,
-                                const char *after_subject, enum date_mode);
+                                const char *after_subject, enum date_mode,
+				int non_ascii_present);
 
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
diff --git a/log-tree.c b/log-tree.c
index 3763ce9..a34beb0 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -125,6 +125,18 @@ static unsigned int digits_in_number(unsigned int number)
 	return result;
 }
 
+static int has_non_ascii(const char *s)
+{
+	int ch;
+	if (!s)
+		return 0;
+	while ((ch = *s++) != '\0') {
+		if (non_ascii(ch))
+			return 1;
+	}
+	return 0;
+}
+
 void show_log(struct rev_info *opt, const char *sep)
 {
 	struct strbuf msgbuf;
@@ -273,7 +285,8 @@ void show_log(struct rev_info *opt, const char *sep)
 	 */
 	strbuf_init(&msgbuf, 0);
 	pretty_print_commit(opt->commit_format, commit, &msgbuf,
-				  abbrev, subject, extra_headers, opt->date_mode);
+			    abbrev, subject, extra_headers, opt->date_mode,
+			    has_non_ascii(opt->add_signoff));
 
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, opt->add_signoff);
