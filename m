From: Jeff King <peff@peff.net>
Subject: [PATCH] branch: fix shortening of non-remote symrefs
Date: Sun, 3 Apr 2016 00:14:26 -0400
Message-ID: <20160403041426.GA22211@sigill.intra.peff.net>
References: <570085DE.9000002@orcon.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Phil Sainty <psainty@orcon.net.nz>
X-From: git-owner@vger.kernel.org Sun Apr 03 06:14:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amZR5-0007Mb-SG
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 06:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbcDCEOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 00:14:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:43205 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750919AbcDCEO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 00:14:29 -0400
Received: (qmail 28181 invoked by uid 102); 3 Apr 2016 04:14:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 00:14:29 -0400
Received: (qmail 8673 invoked by uid 107); 3 Apr 2016 04:14:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 00:14:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Apr 2016 00:14:26 -0400
Content-Disposition: inline
In-Reply-To: <570085DE.9000002@orcon.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290624>

On Sun, Apr 03, 2016 at 02:54:22PM +1200, Phil Sainty wrote:

> Given the following symbolic reference:
> 
> $ git symbolic-ref refs/heads/m refs/heads/master
> 
> 
> Correct in 2.6.6:
> 
> $ PATH=~/git/git-2.6.6:$PATH git branch
>   m -> master
> * master
> 
> 
> Wrong in 2.7.0:
> 
> $ PATH=~/git/git-2.7.0:$PATH git branch
>   m -> m
> * master

Thanks for an easy test case. Though we don't officially support
arbitrary symrefs in the ref namespace, they do mostly work. And
certainly the current output is nonsense, and it worked before. This
bisects to aedcb7d (branch.c: use 'ref-filter' APIs, 2015-09-23).

The fix is below. Karthik, I didn't look at all how this interacts with
your work to convert branch to ref-filter for printing. I imagine it
drops this code completely, but we should make sure that ref-filter gets
this case right. I almost didn't prepare this patch at all, but I
suspect we may want it for "maint", while the full conversion would wait
for "master".

-- >8 --
Subject: branch: fix shortening of non-remote symrefs

Commit aedcb7d (branch.c: use 'ref-filter' APIs, 2015-09-23)
adjusted the symref-printing code to look like this:

    if (item->symref) {
	    skip_prefix(item->symref, "refs/remotes/", &desc);
	    strbuf_addf(&out, " -> %s", desc);
    }

This has three bugs in it:

  1. It always skips past "refs/remotes/", instead of
     skipping past the prefix associated with the branch we
     are showing (so commonly we see "refs/remotes/" for the
     refs/remotes/origin/HEAD symref, but the previous code
     would skip "refs/heads/" when showing a symref it found
     in refs/heads/.

  2. If skip_prefix() does not match, it leaves "desc"
     untouched, and we show whatever happened to be in it
     (which is the refname from a call to skip_prefix()
     earlier in the function).

  3. If we do match with skip_prefix(), we stomp on the
     "desc" variable, which is later passed to
     add_verbose_info(). We probably want to retain the
     original refname there (though it likely doesn't matter
     in practice, since after all, one points to the other).

The fix to match the original code is fairly easy: record
the prefix to strip based on item->kind, and use it here.
However, since we already have a local variable named "prefix",
let's give the two prefixes verbose names so we don't
confuse them.

Signed-off-by: Jeff King <peff@peff.net>
---
The test makes sure we restored the v2.6.x behavior, namely that
cross-prefix symrefs will not be shortened at all. It might be nice to
show:

  ref-to-remote -> remotes/origin/branch-one

or something, but that should be separate from the fix (and I don't
overly care either way, so I probably won't work on it).

 builtin/branch.c         | 19 ++++++++++++-------
 t/t3203-branch-output.sh | 12 ++++++++++++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..f6c23bf 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -393,22 +393,25 @@ static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
 	int current = 0;
 	int color;
 	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
-	const char *prefix = "";
+	const char *prefix_to_show = "";
+	const char *prefix_to_skip = NULL;
 	const char *desc = item->refname;
 	char *to_free = NULL;
 
 	switch (item->kind) {
 	case FILTER_REFS_BRANCHES:
-		skip_prefix(desc, "refs/heads/", &desc);
+		prefix_to_skip = "refs/heads/";
+		skip_prefix(desc, prefix_to_skip, &desc);
 		if (!filter->detached && !strcmp(desc, head))
 			current = 1;
 		else
 			color = BRANCH_COLOR_LOCAL;
 		break;
 	case FILTER_REFS_REMOTES:
-		skip_prefix(desc, "refs/remotes/", &desc);
+		prefix_to_skip = "refs/remotes/";
+		skip_prefix(desc, prefix_to_skip, &desc);
 		color = BRANCH_COLOR_REMOTE;
-		prefix = remote_prefix;
+		prefix_to_show = remote_prefix;
 		break;
 	case FILTER_REFS_DETACHED_HEAD:
 		desc = to_free = get_head_description();
@@ -425,7 +428,7 @@ static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
 		color = BRANCH_COLOR_CURRENT;
 	}
 
-	strbuf_addf(&name, "%s%s", prefix, desc);
+	strbuf_addf(&name, "%s%s", prefix_to_show, desc);
 	if (filter->verbose) {
 		int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
 		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
@@ -436,8 +439,10 @@ static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
 			    name.buf, branch_get_color(BRANCH_COLOR_RESET));
 
 	if (item->symref) {
-		skip_prefix(item->symref, "refs/remotes/", &desc);
-		strbuf_addf(&out, " -> %s", desc);
+		const char *symref = item->symref;
+		if (prefix_to_skip)
+			skip_prefix(symref, prefix_to_skip, &symref);
+		strbuf_addf(&out, " -> %s", symref);
 	}
 	else if (filter->verbose)
 		/* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 4261403..c6a3ccb 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -184,4 +184,16 @@ test_expect_success 'ambiguous branch/tag not marked' '
 	test_cmp expect actual
 '
 
+test_expect_success 'local-branch symrefs shortened properly' '
+	git symbolic-ref refs/heads/ref-to-branch refs/heads/branch-one &&
+	git symbolic-ref refs/heads/ref-to-remote refs/remotes/origin/branch-one &&
+	cat >expect <<-\EOF &&
+	  ref-to-branch -> branch-one
+	  ref-to-remote -> refs/remotes/origin/branch-one
+	EOF
+	git branch >actual.raw &&
+	grep ref-to <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.8.0.429.gaaf8de0
