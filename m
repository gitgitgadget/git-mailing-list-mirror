From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 08/14] remote.c: report specific errors from
 branch_get_upstream
Date: Thu, 21 May 2015 20:49:11 -0400
Message-ID: <20150522004910.GB11739@peff.net>
References: <20150521044429.GA5857@peff.net>
 <20150521044532.GH23409@peff.net>
 <xmqq7fs1kcfd.fsf@gitster.dls.corp.google.com>
 <20150521184910.GA3490@peff.net>
 <xmqqpp5tivga.fsf@gitster.dls.corp.google.com>
 <20150522004643.GA11739@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 02:49:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvb9Q-00057x-9H
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 02:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbbEVAtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 20:49:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:34392 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932339AbbEVAtN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 20:49:13 -0400
Received: (qmail 30007 invoked by uid 102); 22 May 2015 00:49:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 19:49:13 -0500
Received: (qmail 9903 invoked by uid 107); 22 May 2015 00:49:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 20:49:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 20:49:11 -0400
Content-Disposition: inline
In-Reply-To: <20150522004643.GA11739@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269678>

On Thu, May 21, 2015 at 08:46:43PM -0400, Jeff King wrote:

> On Thu, May 21, 2015 at 12:25:57PM -0700, Junio C Hamano wrote:
> 
> > > Note also that the original may dereference branch->merge[0] even if it
> > > is NULL. I think that can't actually happen in practice (we only
> > > allocate branch->merge if we have at least one item to put in it, and
> > > all of the checks of branch->merge[0] are actually being over-careful).
> > > But the code I just wrote above does not have that problem.
> > 
> > Perhaps update the patch with this explanation in the log message,
> > as a separate preparatory step?
> 
> I decided on a separate patch on top which improves the logic and
> explains the issues. Here it is (it goes on top of the existing patch 8,
> "report specific errors from branch_get_upstream").
> 
> -- >8 --
> Subject: remote.c: untangle error logic in branch_get_upstream

And then on top of that, we can add in this cleanup I showed earlier.

Both of these should insert into the series without any trouble, but let
me know if you run into problems and I can repost the whole thing.

-- >8 --
Subject: remote.c: return upstream name from stat_tracking_info

After calling stat_tracking_info, callers often want to
print the name of the upstream branch (in addition to the
tracking count). To do this, they have to access
branch->merge->dst[0] themselves. This is not wrong, as the
return value from stat_tracking_info tells us whether we
have an upstream branch or not. But it is a bit leaky, as we
make an assumption about how it calculated the upstream
name.

Instead, let's add an out-parameter that lets the caller
know the upstream name we found.

As a bonus, we can get rid of the unusual tri-state return
from the function. We no longer need to use it to
differentiate between "no tracking config" and "tracking ref
does not exist" (since you can check the upstream_name for
that), so we can just use the usual 0/-1 convention for
success/error.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c       | 16 +++++-----------
 builtin/for-each-ref.c |  4 ++--
 remote.c               | 35 +++++++++++++++++------------------
 remote.h               |  3 ++-
 wt-status.c            | 18 ++++++------------
 5 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index cc55ff2..8ecabd1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -425,25 +425,19 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	int ours, theirs;
 	char *ref = NULL;
 	struct branch *branch = branch_get(branch_name);
+	const char *upstream;
 	struct strbuf fancy = STRBUF_INIT;
 	int upstream_is_gone = 0;
 	int added_decoration = 1;
 
-	switch (stat_tracking_info(branch, &ours, &theirs)) {
-	case 0:
-		/* no base */
-		return;
-	case -1:
-		/* with "gone" base */
+	if (stat_tracking_info(branch, &ours, &theirs, &upstream) < 0) {
+		if (!upstream)
+			return;
 		upstream_is_gone = 1;
-		break;
-	default:
-		/* with base */
-		break;
 	}
 
 	if (show_upstream_ref) {
-		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+		ref = shorten_unambiguous_ref(upstream, 0);
 		if (want_color(branch_use_color))
 			strbuf_addf(&fancy, "%s%s%s",
 					branch_get_color(BRANCH_COLOR_UPSTREAM),
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 18d209b..92bd2b2 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -716,7 +716,7 @@ static void populate_value(struct refinfo *ref)
 				char buf[40];
 
 				if (stat_tracking_info(branch, &num_ours,
-						       &num_theirs) != 1)
+						       &num_theirs, NULL))
 					continue;
 
 				if (!num_ours && !num_theirs)
@@ -738,7 +738,7 @@ static void populate_value(struct refinfo *ref)
 				assert(branch);
 
 				if (stat_tracking_info(branch, &num_ours,
-							&num_theirs) != 1)
+							&num_theirs, NULL))
 					continue;
 
 				if (!num_ours && !num_theirs)
diff --git a/remote.c b/remote.c
index d2519c2..c884574 100644
--- a/remote.c
+++ b/remote.c
@@ -1938,12 +1938,15 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
 
 /*
  * Compare a branch with its upstream, and save their differences (number
- * of commits) in *num_ours and *num_theirs.
+ * of commits) in *num_ours and *num_theirs. The name of the upstream branch
+ * (or NULL if no upstream is defined) is returned via *upstream_name, if it
+ * is not itself NULL.
  *
- * Return 0 if branch has no upstream (no base), -1 if upstream is missing
- * (with "gone" base), otherwise 1 (with base).
+ * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
+ * upstream defined, or ref does not exist), 0 otherwise.
  */
-int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
+int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
+		       const char **upstream_name)
 {
 	unsigned char sha1[20];
 	struct commit *ours, *theirs;
@@ -1954,8 +1957,10 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 
 	/* Cannot stat unless we are marked to build on top of somebody else. */
 	base = branch_get_upstream(branch, NULL);
+	if (upstream_name)
+		*upstream_name = base;
 	if (!base)
-		return 0;
+		return -1;
 
 	/* Cannot stat if what we used to build on no longer exists */
 	if (read_ref(base, sha1))
@@ -1973,7 +1978,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	/* are we the same? */
 	if (theirs == ours) {
 		*num_theirs = *num_ours = 0;
-		return 1;
+		return 0;
 	}
 
 	/* Run "rev-list --left-right ours...theirs" internally... */
@@ -2009,7 +2014,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	/* clear object flags smudged by the above traversal */
 	clear_commit_marks(ours, ALL_REV_FLAGS);
 	clear_commit_marks(theirs, ALL_REV_FLAGS);
-	return 1;
+	return 0;
 }
 
 /*
@@ -2018,23 +2023,17 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 int format_tracking_info(struct branch *branch, struct strbuf *sb)
 {
 	int ours, theirs;
+	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
 
-	switch (stat_tracking_info(branch, &ours, &theirs)) {
-	case 0:
-		/* no base */
-		return 0;
-	case -1:
-		/* with "gone" base */
+	if (stat_tracking_info(branch, &ours, &theirs, &full_base) < 0) {
+		if (!full_base)
+			return 0;
 		upstream_is_gone = 1;
-		break;
-	default:
-		/* with base */
-		break;
 	}
 
-	base = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+	base = shorten_unambiguous_ref(full_base, 0);
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
diff --git a/remote.h b/remote.h
index 03ca005..357a909 100644
--- a/remote.h
+++ b/remote.h
@@ -239,7 +239,8 @@ enum match_refs_flags {
 };
 
 /* Reporting of tracking info */
-int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs);
+int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
+		       const char **upstream_name);
 int format_tracking_info(struct branch *branch, struct strbuf *sb);
 
 struct ref *get_local_heads(void);
diff --git a/wt-status.c b/wt-status.c
index 38cb165..7c8ae57 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1532,21 +1532,15 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
-	switch (stat_tracking_info(branch, &num_ours, &num_theirs)) {
-	case 0:
-		/* no base */
-		fputc(s->null_termination ? '\0' : '\n', s->fp);
-		return;
-	case -1:
-		/* with "gone" base */
+	if (stat_tracking_info(branch, &num_ours, &num_theirs, &base) < 0) {
+		if (!base) {
+			fputc(s->null_termination ? '\0' : '\n', s->fp);
+			return;
+		}
+
 		upstream_is_gone = 1;
-		break;
-	default:
-		/* with base */
-		break;
 	}
 
-	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
 	color_fprintf(s->fp, header_color, "...");
 	color_fprintf(s->fp, branch_color_remote, "%s", base);
-- 
2.4.1.528.g00591e3
