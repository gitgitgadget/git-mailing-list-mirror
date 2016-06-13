From: Jeff King <peff@peff.net>
Subject: [PATCH 4/3] use string_list initializer consistently
Date: Mon, 13 Jun 2016 06:04:20 -0400
Message-ID: <20160613100420.GA16229@sigill.intra.peff.net>
References: <20160610115726.4805-1-pclouds@gmail.com>
 <20160612220316.GB5428@sigill.intra.peff.net>
 <CACsJy8C+NtiXRo8NcU3rtgWrMSj8Zv3mYtdYfyvzwYRHifKVCQ@mail.gmail.com>
 <20160613053203.GB3950@sigill.intra.peff.net>
 <CACsJy8CAT54pTotUFKm-piWRppNFz9mjTsnz+5p1+7ykVg60HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 12:04:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCOjM-0005th-D2
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 12:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbcFMKEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 06:04:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:53718 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964862AbcFMKEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 06:04:24 -0400
Received: (qmail 5136 invoked by uid 102); 13 Jun 2016 10:04:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 06:04:24 -0400
Received: (qmail 12099 invoked by uid 107); 13 Jun 2016 10:04:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 06:04:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 06:04:20 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CAT54pTotUFKm-piWRppNFz9mjTsnz+5p1+7ykVg60HQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297175>

On Mon, Jun 13, 2016 at 04:36:14PM +0700, Duy Nguyen wrote:

> > So I'd suggest these patches:
> >
> >   [1/3]: parse_opt_string_list: stop allocating new strings
> >   [2/3]: interpret-trailers: don't duplicate option strings
> >   [3/3]: blame,shortlog: don't make local option variables static
> 
> As usual, it's hard to find things to complain in your patches.

That's only because I work on the easy bits. I'm afraid of things like
shallow-fetch refactoring. :)

> > The first one is what we've been discussing, and the others are just
> > follow-on cleanups.  I stopped short of a fourth patch to convert more
> > cases of:
> >
> >   static struct string_list foo;
> >
> > to:
> >
> >   static struct string_list foo = STRING_LIST_INIT_NODUP;
> >
> > The two are equivalent (mostly due to historical reasons). I tend to
> > think explicit is better than implicit for something like this (not
> > because BSS auto-initialization isn't OK, but because there is an
> > explicit choice of dup/nodup that the writer made, and it is good to
> > communicate that). But maybe people don't want the extra noise.
> 
> I'm on the explicit side. Unless you work a lot with string lists, I
> don't think you can remember whether "all zero" initialization is dup
> or no dup.

Here's the patch for that.

-- >8 --
Subject: use string_list initializer consistently

There are two types of string_lists: those that own the
string memory, and those that don't. You can tell the
difference by the strdup_strings flag, and one should use
either STRING_LIST_INIT_DUP, or STRING_LIST_INIT_NODUP as an
initializer.

Historically, the normal all-zeros initialization has
corresponded to the NODUP case. Many sites use no
initializer at all, and that works as a shorthand for that
case. But for a reader of the code, it can be hard to
remember which is which. Let's be more explicit and actually
have each site declare which type it means to use.

This is a fairly mechanical conversion; I assumed each site
was correct as-is, and just switched them all to NODUP.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/apply.c               | 6 +++---
 builtin/blame.c               | 2 +-
 builtin/clone.c               | 4 ++--
 builtin/log.c                 | 6 +++---
 builtin/remote.c              | 2 +-
 notes.c                       | 2 +-
 submodule.c                   | 2 +-
 t/helper/test-parse-options.c | 2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c770d7d..f27520f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -270,7 +270,7 @@ struct image {
  * the case where more than one patches touch the same file.
  */
 
-static struct string_list fn_table;
+static struct string_list fn_table = STRING_LIST_INIT_NODUP;
 
 static uint32_t hash_line(const char *cp, size_t len)
 {
@@ -1936,7 +1936,7 @@ static void prefix_patch(struct patch *p)
  * include/exclude
  */
 
-static struct string_list limit_by_name;
+static struct string_list limit_by_name = STRING_LIST_INIT_NODUP;
 static int has_include;
 static void add_name_limit(const char *name, int exclude)
 {
@@ -3582,7 +3582,7 @@ static int check_to_create(const char *new_name, int ok_if_exists)
  * it is perfectly fine, as the patch removes a/b to make room
  * to create a directory a/b so that a/b/c can be created.
  */
-static struct string_list symlink_changes;
+static struct string_list symlink_changes = STRING_LIST_INIT_NODUP;
 #define SYMLINK_GOES_AWAY 01
 #define SYMLINK_IN_RESULT 02
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 80d2431..de70153 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -56,7 +56,7 @@ static int show_progress;
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
 
-static struct string_list mailmap;
+static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 
 #ifndef DEBUG
 #define DEBUG 0
diff --git a/builtin/clone.c b/builtin/clone.c
index 5f867e6..70d8213 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -49,8 +49,8 @@ static char *option_upload_pack = "git-upload-pack";
 static int option_verbosity;
 static int option_progress = -1;
 static enum transport_family family;
-static struct string_list option_config;
-static struct string_list option_reference;
+static struct string_list option_config = STRING_LIST_INIT_NODUP;
+static struct string_list option_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
 
diff --git a/builtin/log.c b/builtin/log.c
index 099f4f7..8eef94f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -674,9 +674,9 @@ static int auto_number = 1;
 
 static char *default_attach = NULL;
 
-static struct string_list extra_hdr;
-static struct string_list extra_to;
-static struct string_list extra_cc;
+static struct string_list extra_hdr = STRING_LIST_INIT_NODUP;
+static struct string_list extra_to = STRING_LIST_INIT_NODUP;
+static struct string_list extra_cc = STRING_LIST_INIT_NODUP;
 
 static void add_header(const char *value)
 {
diff --git a/builtin/remote.c b/builtin/remote.c
index d33766b..5ded301 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -247,7 +247,7 @@ struct branch_info {
 	enum { NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE } rebase;
 };
 
-static struct string_list branch_list;
+static struct string_list branch_list = STRING_LIST_INIT_NODUP;
 
 static const char *abbrev_ref(const char *name, const char *prefix)
 {
diff --git a/notes.c b/notes.c
index e4e4854..df4660f 100644
--- a/notes.c
+++ b/notes.c
@@ -70,7 +70,7 @@ struct non_note {
 
 struct notes_tree default_notes_tree;
 
-static struct string_list display_notes_refs;
+static struct string_list display_notes_refs = STRING_LIST_INIT_NODUP;
 static struct notes_tree **display_notes_trees;
 
 static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
diff --git a/submodule.c b/submodule.c
index 4532b11..abc2ac2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -17,7 +17,7 @@
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static int parallel_jobs = 1;
-static struct string_list changed_submodule_paths;
+static struct string_list changed_submodule_paths = STRING_LIST_INIT_NODUP;
 static int initialized_fetch_ref_tips;
 static struct sha1_array ref_tips_before_fetch;
 static struct sha1_array ref_tips_after_fetch;
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 8a1235d..2c63298 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -12,7 +12,7 @@ static int dry_run = 0, quiet = 0;
 static char *string = NULL;
 static char *file = NULL;
 static int ambiguous;
-static struct string_list list;
+static struct string_list list = STRING_LIST_INIT_NODUP;
 
 static struct {
 	int called;
-- 
2.9.0.rc2.149.gd580ccd
