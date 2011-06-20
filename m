From: Jeff King <peff@peff.net>
Subject: [PATCH] tag: accept multiple patterns for --list
Date: Mon, 20 Jun 2011 12:59:28 -0400
Message-ID: <20110620165928.GA20887@sigill.intra.peff.net>
References: <1308511149-10933-1-git-send-email-billiob@gmail.com>
 <1308511149-10933-2-git-send-email-billiob@gmail.com>
 <7vtyble9k8.fsf@alter.siamese.dyndns.org>
 <4DFEEB60.5000005@viscovery.net>
 <20110620070316.GA15246@sigill.intra.peff.net>
 <4DFF2A1D.3060206@drmicha.warpmail.net>
 <20110620130945.GA19011@sigill.intra.peff.net>
 <7v1uyoecgn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boris Faure <billiob@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 18:59:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYhp7-0001TM-C7
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 18:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388Ab1FTQ7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 12:59:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56501
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125Ab1FTQ7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 12:59:30 -0400
Received: (qmail 22354 invoked by uid 107); 20 Jun 2011 16:59:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jun 2011 12:59:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2011 12:59:28 -0400
Content-Disposition: inline
In-Reply-To: <7v1uyoecgn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176079>

On Mon, Jun 20, 2011 at 08:42:32AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ? For "tag -l", we seem to silently ignore any arguments past the first:
> >
> >   $ git tag -l 'v1.7.4.*' 'v1.7.5.*'
> >   v1.7.4.1
> >   v1.7.4.2
> >   v1.7.4.3
> >   v1.7.4.4
> >   v1.7.4.5
> >
> > We should at least warn and say "your second argument is being ignored"
> > or show the usage message.
> 
> I think it is just a bug; no need for "being ignored" warning.
> 
> > But perhaps it is even friendlier to accept
> > a list of patterns.
> 
> Yes indeed; please make it so ;-)

Here's a patch.

-- >8 --
Subject: [PATCH] tag: accept multiple patterns for --list

Until now, "git tag -l foo* bar*" would silently ignore the
second argument, showing only refs starting with "foo". It's
not just unfriendly not to take a second pattern; we
actually generated subtly wrong results (from the user's
perspective) because some of the requested tags were
omitted.

This patch allows an arbitrary number of patterns on the
command line; if any of them matches, the ref is shown.

While we're tweaking the documentation, let's also make it
clear that the pattern is fnmatch.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-tag.txt |    9 ++++++---
 builtin/tag.c             |   26 +++++++++++++++++---------
 t/t7004-tag.sh            |    5 +++++
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index d82f621..fb1c0ac 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>]
+'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>...]
 'git tag' -v <tagname>...
 
 DESCRIPTION
@@ -69,8 +69,11 @@ OPTIONS
 	If the tag is not annotated, the commit message is displayed instead.
 
 -l <pattern>::
-	List tags with names that match the given pattern (or all if no pattern is given).
-	Typing "git tag" without arguments, also lists all tags.
+	List tags with names that match the given pattern (or all if no
+	pattern is given).  Running "git tag" without arguments also
+	lists all tags. The pattern is a shell wildcard (i.e., matched
+	using fnmatch(3)).  Multiple patterns may be given; if any of
+	them matches, the tag is shown.
 
 --contains <commit>::
 	Only list tags which contain the specified commit.
diff --git a/builtin/tag.c b/builtin/tag.c
index ec926fc..cef2726 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -16,7 +16,7 @@
 static const char * const git_tag_usage[] = {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
 	"git tag -d <tagname>...",
-	"git tag -l [-n[<num>]] [<pattern>]",
+	"git tag -l [-n[<num>]] [<pattern>...]",
 	"git tag -v <tagname>...",
 	NULL
 };
@@ -24,17 +24,28 @@ static const char * const git_tag_usage[] = {
 static char signingkey[1000];
 
 struct tag_filter {
-	const char *pattern;
+	const char **patterns;
 	int lines;
 	struct commit_list *with_commit;
 };
 
+static int match_pattern(const char **patterns, const char *ref)
+{
+	/* no pattern means match everything */
+	if (!*patterns)
+		return 1;
+	for (; *patterns; patterns++)
+		if (!fnmatch(*patterns, ref, 0))
+			return 1;
+	return 0;
+}
+
 static int show_reference(const char *refname, const unsigned char *sha1,
 			  int flag, void *cb_data)
 {
 	struct tag_filter *filter = cb_data;
 
-	if (!fnmatch(filter->pattern, refname, 0)) {
+	if (match_pattern(filter->patterns, refname)) {
 		int i;
 		unsigned long size;
 		enum object_type type;
@@ -88,15 +99,12 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
-static int list_tags(const char *pattern, int lines,
+static int list_tags(const char **patterns, int lines,
 			struct commit_list *with_commit)
 {
 	struct tag_filter filter;
 
-	if (pattern == NULL)
-		pattern = "*";
-
-	filter.pattern = pattern;
+	filter.patterns = patterns;
 	filter.lines = lines;
 	filter.with_commit = with_commit;
 
@@ -425,7 +433,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (list + delete + verify > 1)
 		usage_with_options(git_tag_usage, options);
 	if (list)
-		return list_tags(argv[0], lines == -1 ? 0 : lines,
+		return list_tags(argv, lines == -1 ? 0 : lines,
 				 with_commit);
 	if (lines != -1)
 		die(_("-n option is only allowed with -l."));
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 2ac1c66..097ce2b 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -257,6 +257,11 @@ test_expect_success \
 	test_cmp expect actual
 '
 
+test_expect_success 'tag -l can accept multiple patterns' '
+	git tag -l "v1*" "v0*" >actual &&
+	test_cmp expect actual
+'
+
 # creating and verifying lightweight tags:
 
 test_expect_success \
-- 
1.7.6.rc1.38.g97f64.dirty
