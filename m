From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] tag: do not show ambiguous tag names as "tags/foo"
Date: Sun, 24 Jan 2016 18:08:40 -0500
Message-ID: <20160124230840.GB16455@sigill.intra.peff.net>
References: <20160124230531.GB29115@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pete Harlan <pgit@tento.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 00:08:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNTm3-0004IG-BP
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 00:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbcAXXIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 18:08:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:59648 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752265AbcAXXIm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 18:08:42 -0500
Received: (qmail 15912 invoked by uid 102); 24 Jan 2016 23:08:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jan 2016 18:08:42 -0500
Received: (qmail 13201 invoked by uid 107); 24 Jan 2016 23:09:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jan 2016 18:09:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Jan 2016 18:08:40 -0500
Content-Disposition: inline
In-Reply-To: <20160124230531.GB29115@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284703>

Since b7cc53e9 (tag.c: use 'ref-filter' APIs, 2015-07-11),
git-tag has started showing tags with ambiguous names (i.e.,
when both "heads/foo" and "tags/foo" exists) as "tags/foo"
instead of just "foo". This is both:

  - pointless; the output of "git tag" includes only
    refs/tags, so we know that "foo" means the one in
    "refs/tags".

and

  - ambiguous; in the original output, we know that the line
    "foo" means that "refs/tags/foo" exists. In the new
    output, it is unclear whether we mean "refs/tags/foo" or
    "refs/tags/tags/foo".

The reason this happens is that commit b7cc53e9 switched
git-tag to use ref-filter's "%(refname:short)" output
formatting, which was adapted from for-each-ref. This more
general code does not know that we care only about tags, and
uses shorten_unambiguous_ref to get the short-name. We need
to tell it that we care only about "refs/tags/", and it
should shorten with respect to that value.

In theory, the ref-filter code could figure this out by us
passing FILTER_REFS_TAGS. But there are two complications
there:

  1. The handling of refname:short is deep in formatting
     code that does not even have our ref_filter struct, let
     alone the arguments to the filter_ref struct.

  2. In git v2.7.0, we expose the formatting language to the
     user. If we follow this path, it will mean that
     "%(refname:short)" behaves differently for "tag" versus
     "for-each-ref" (including "for-each-ref refs/tags/"),
     which can lead to confusion.

Instead, let's add a new modifier to the formatting
language, "strip", to remove a specific set of prefix
components. This fixes "git tag", and lets users invoke the
same behavior from their own custom formats (for "tag" or
"for-each-ref") while leaving ":short" with its same
consistent meaning in all places.

We introduce a test in t7004 for "git tag", which fails
without this patch. We also add a similar test in t3203 for
"git branch", which does not actually fail. But since it is
likely that "branch" will eventually use the same formatting
code, the test helps defend against future regressions.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-for-each-ref.txt |  6 +++++-
 Documentation/git-tag.txt          |  2 +-
 builtin/tag.c                      |  4 ++--
 ref-filter.c                       | 13 ++++++++++++-
 t/t3203-branch-output.sh           |  8 ++++++++
 t/t6300-for-each-ref.sh            |  4 ++++
 t/t7004-tag.sh                     |  8 ++++++++
 7 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 06208c4..f15c817 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -92,7 +92,11 @@ refname::
 	The name of the ref (the part after $GIT_DIR/).
 	For a non-ambiguous short name of the ref append `:short`.
 	The option core.warnAmbiguousRefs is used to select the strict
-	abbreviation mode.
+	abbreviation mode. If `strip=<N>` is appended, strips `<N>`
+	slash-separated path components from the front of the refname
+	(e.g., `%(refname:strip=2)` turns `refs/tags/foo` into `foo`.
+	If the ref has fewer components than `<N>`, the whole,
+	unstripped `%(refname)` is printed.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 7220e5e..abab481 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -163,7 +163,7 @@ This option is only applicable when listing tags without annotation lines.
 	A string that interpolates `%(fieldname)` from the object
 	pointed at by a ref being shown.  The format is the same as
 	that of linkgit:git-for-each-ref[1].  When unspecified,
-	defaults to `%(refname:short)`.
+	defaults to `%(refname:strip=2)`.
 
 --[no-]merged [<commit>]::
 	Only list tags whose tips are reachable, or not reachable
diff --git a/builtin/tag.c b/builtin/tag.c
index 8db8c87..1705c94 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -44,11 +44,11 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 	if (!format) {
 		if (filter->lines) {
 			to_free = xstrfmt("%s %%(contents:lines=%d)",
-					  "%(align:15)%(refname:short)%(end)",
+					  "%(align:15)%(refname:strip=2)%(end)",
 					  filter->lines);
 			format = to_free;
 		} else
-			format = "%(refname:short)";
+			format = "%(refname:strip=2)";
 	}
 
 	verify_ref_format(format);
diff --git a/ref-filter.c b/ref-filter.c
index 7bef7f8..9f54adc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -909,12 +909,23 @@ static void populate_value(struct ref_array_item *ref)
 		formatp = strchr(name, ':');
 		if (formatp) {
 			int num_ours, num_theirs;
+			const char *arg;
 
 			formatp++;
 			if (!strcmp(formatp, "short"))
 				refname = shorten_unambiguous_ref(refname,
 						      warn_ambiguous_refs);
-			else if (!strcmp(formatp, "track") &&
+			else if (skip_prefix(formatp, "strip=", &arg)) {
+				int strip = atoi(arg);
+				const char *start = refname;
+				while (strip && *start) {
+					if (*start == '/')
+						strip--;
+					start++;
+				}
+				if (!strip)
+					refname = start;
+			} else if (!strcmp(formatp, "track") &&
 				 (starts_with(name, "upstream") ||
 				  starts_with(name, "push"))) {
 
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index d3913f9..4261403 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -176,4 +176,12 @@ test_expect_success 'git branch --points-at option' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ambiguous branch/tag not marked' '
+	git tag ambiguous &&
+	git branch ambiguous &&
+	echo "  ambiguous" >expect &&
+	git branch --list ambiguous >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 859b237..1f3abeb 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -50,6 +50,10 @@ test_atom() {
 
 test_atom head refname refs/heads/master
 test_atom head refname:short master
+test_atom head refname:strip=0 refs/heads/master
+test_atom head refname:strip=1 heads/master
+test_atom head refname:strip=2 master
+test_atom head refname:strip=3 refs/heads/master
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
 test_atom head push refs/remotes/myfork/master
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 2797f22..cf3469b 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1558,4 +1558,12 @@ test_expect_success '--no-merged show unmerged tags' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ambiguous branch/tags not marked' '
+	git tag ambiguous &&
+	git branch ambiguous &&
+	echo ambiguous >expect &&
+	git tag -l ambiguous >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.7.0.427.g4c6e021
