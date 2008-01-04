From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-diff-* --color oddness
Date: Fri, 4 Jan 2008 03:59:34 -0500
Message-ID: <20080104085934.GA3706@coredump.intra.peff.net>
References: <20080104081429.GA30635@coredump.intra.peff.net> <7vabnmm1ww.fsf@gitster.siamese.dyndns.org> <20080104083252.GB3300@coredump.intra.peff.net> <7vsl1ekmg5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, win@wincent.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 10:00:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAiPQ-0005Zh-37
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 10:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbYADI7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 03:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbYADI7h
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 03:59:37 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2381 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753040AbYADI7h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 03:59:37 -0500
Received: (qmail 16069 invoked by uid 111); 4 Jan 2008 08:59:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 03:59:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 03:59:34 -0500
Content-Disposition: inline
In-Reply-To: <7vsl1ekmg5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69567>

On Fri, Jan 04, 2008 at 12:46:18AM -0800, Junio C Hamano wrote:

> > It's for user diff drivers, and it looks like the funcname pattern. Not
> > sure why we want to demand-load that stuff at all...I wonder if it
> > should just go into git_default_config (or a git_basic_diff_config).
> 
> Yeah, moving some to the diff-basic-config sounds sane.

OK, below is a patch that fixes the color issues I was having.

>  * I'd prefer to keep low-level produce consistent diff that can
>    be reliably applied with git-apply without getting broken by
>    user configuration while Porcelain level diff can be tweaked
>    by the user to do whatever "human readable" crap they would
>    want to see on the screen (such as "side by side"), and my
>    gut feeling is that we should keep the user-level driver
>    definition in ui-config, never to affect plumbing.

OK. In that case, we need a way for the plumbing to tell the diff
machinery "don't ever try loading the ui config."

>  * using or not-using colors should stay in ui-config;

Agreed.

>  * funcname-pattern can go either way; that affects what appears
>    at the end of @@ context @@ lines, and would not have risk to
>    corrupt the patch for plumbing.

I don't personally use this, so I don't care too much. But I am inclined
to say low-level since it cannot break the patch (and it will be used
and presented by porcelains like "git add -i").

>  * color choice can also go either way, but probably is better
>    to be in the low-level.  Cnce color is used the output cannot
>    be fed sanely to patch or git-apply _anyway_ so we can be
>    sure that "git diff-plumbing --color" is run to produce human
>    readable output.

Definitely low-level IMHO, since we have porcelain which relies on the
low-level's output (and there is no way to set it manually from the
command line).

Patch to add diff_basic_config infrastructure and fix the color
selection issue is below. It just does the color, but we can move other
stuff over as discussion ensues.

-- >8 --
add a "basic" diff config callback

The diff porcelain uses git_diff_ui_config to set
porcelain-ish config options, like automatically turning on
color. The plumbing specifically avoids calling this
function, since it doesn't want things like automatic color
or rename detection.

However, some diff options should be set for both plumbing
and porcelain. For example, one can still turn on color in
git-diff-files using the --color command line option. This
means we want the color config from color.diff.* (so that
once color is on, we use the user's preferred scheme), but
_not_ the color.diff variable.

We split the diff config into "ui" and "basic", where
"basic" is suitable for use by plumbing (so _most_ things
affecting the output should still go into the "ui" part).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-diff-files.c |    2 +-
 builtin-diff-index.c |    2 +-
 builtin-diff-tree.c  |    2 +-
 diff.c               |    6 ++++++
 diff.h               |    1 +
 5 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 9c04111..4abe3c2 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -21,7 +21,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 
 	prefix = setup_git_directory_gently(&nongit);
 	init_revisions(&rev, prefix);
-	git_config(git_default_config); /* no "diff" UI options */
+	git_config(git_diff_basic_config); /* no "diff" UI options */
 	rev.abbrev = 0;
 
 	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 0f2390a..2b955de 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -17,7 +17,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	int result;
 
 	init_revisions(&rev, prefix);
-	git_config(git_default_config); /* no "diff" UI options */
+	git_config(git_diff_basic_config); /* no "diff" UI options */
 	rev.abbrev = 0;
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index ebc50ef..832797f 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -68,7 +68,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	int read_stdin = 0;
 
 	init_revisions(opt, prefix);
-	git_config(git_default_config); /* no "diff" UI options */
+	git_config(git_diff_basic_config); /* no "diff" UI options */
 	nr_sha1 = 0;
 	opt->abbrev = 0;
 	opt->diff = 1;
diff --git a/diff.c b/diff.c
index f6a8515..6bb0f62 100644
--- a/diff.c
+++ b/diff.c
@@ -183,6 +183,12 @@ int git_diff_ui_config(const char *var, const char *value)
 				return parse_funcname_pattern(var, ep, value);
 		}
 	}
+
+	return git_diff_basic_config(var, value);
+}
+
+int git_diff_basic_config(const char *var, const char *value)
+{
 	if (!prefixcmp(var, "diff.color.") || !prefixcmp(var, "color.diff.")) {
 		int slot = parse_diff_color_slot(var, 11);
 		color_parse(value, var, diff_colors[slot]);
diff --git a/diff.h b/diff.h
index beccf85..073d5cb 100644
--- a/diff.h
+++ b/diff.h
@@ -172,6 +172,7 @@ extern void diff_unmerge(struct diff_options *,
 #define DIFF_SETUP_USE_CACHE		2
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
+extern int git_diff_basic_config(const char *var, const char *value);
 extern int git_diff_ui_config(const char *var, const char *value);
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int);
-- 
1.5.4.rc2.1123.gce734-dirty
