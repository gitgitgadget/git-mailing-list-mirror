From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] grep: stop using object_array
Date: Mon, 26 Aug 2013 15:54:34 -0400
Message-ID: <20130826195434.GA21074@sigill.intra.peff.net>
References: <20130826195331.GA21051@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 21:54:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE2s6-0008VQ-FS
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 21:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab3HZTyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 15:54:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:39524 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab3HZTyi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 15:54:38 -0400
Received: (qmail 28171 invoked by uid 102); 26 Aug 2013 19:54:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Aug 2013 14:54:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Aug 2013 15:54:34 -0400
Content-Disposition: inline
In-Reply-To: <20130826195331.GA21051@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233017>

We use an object_array to store the set of objects to grep
that we received on the command-line. There is no particular
reason to use object_array here except that its code was
already written, and it contained the elements we needed
(though we did not care about mode at all).

However, future patches will need to remember more about the
arguments than object_array can provide. Let's use our own
custom struct. Thanks to the ALLOC_GROW macro, this is really
only a few lines longer (and we even save a few bytes of
memory as we do not care about the mode, and we know that we
do not have to copy the name strings, as they come from
argv).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d3b3b1d..ee47d49 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -23,6 +23,11 @@ static char const * const grep_usage[] = {
 	NULL
 };
 
+struct object_to_grep {
+	struct object *item;
+	const char *name;
+};
+
 static int use_threads = 1;
 
 #ifndef NO_PTHREADS
@@ -493,16 +498,15 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
-			const struct object_array *list)
+			const struct object_to_grep *list, int nr)
 {
 	unsigned int i;
 	int hit = 0;
-	const unsigned int nr = list->nr;
 
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
-		real_obj = deref_tag(list->objects[i].item, NULL, 0);
-		if (grep_object(opt, pathspec, real_obj, list->objects[i].name)) {
+		real_obj = deref_tag(list[i].item, NULL, 0);
+		if (grep_object(opt, pathspec, real_obj, list[i].name)) {
 			hit = 1;
 			if (opt->status_only)
 				break;
@@ -628,7 +632,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int external_grep_allowed__ignored;
 	const char *show_in_pager = NULL, *default_pager = "dummy";
 	struct grep_opt opt;
-	struct object_array list = OBJECT_ARRAY_INIT;
+	struct object_to_grep *list = NULL;
+	int list_nr = 0, list_alloc = 0;
 	const char **paths = NULL;
 	struct pathspec pathspec;
 	struct string_list path_list = STRING_LIST_INIT_NODUP;
@@ -822,7 +827,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			struct object *object = parse_object_or_die(sha1, arg);
 			if (!seen_dashdash)
 				verify_non_filename(prefix, arg);
-			add_object_array(object, arg, &list);
+
+			ALLOC_GROW(list, list_nr+1, list_alloc);
+			list[list_nr].item = object;
+			list[list_nr].name = arg;
+			list_nr++;
 			continue;
 		}
 		if (!strcmp(arg, "--")) {
@@ -833,7 +842,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 #ifndef NO_PTHREADS
-	if (list.nr || cached || online_cpus() == 1)
+	if (list_nr || cached || online_cpus() == 1)
 		use_threads = 0;
 #else
 	use_threads = 0;
@@ -861,7 +870,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.max_depth = opt.max_depth;
 	pathspec.recursive = 1;
 
-	if (show_in_pager && (cached || list.nr))
+	if (show_in_pager && (cached || list_nr))
 		die(_("--open-files-in-pager only works on the worktree"));
 
 	if (show_in_pager && opt.pattern_list && !opt.pattern_list->next) {
@@ -889,12 +898,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (!use_index || untracked) {
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
-		if (list.nr)
+		if (list_nr)
 			die(_("--no-index or --untracked cannot be used with revs."));
 		hit = grep_directory(&opt, &pathspec, use_exclude);
 	} else if (0 <= opt_exclude) {
 		die(_("--[no-]exclude-standard cannot be used for tracked contents."));
-	} else if (!list.nr) {
+	} else if (!list_nr) {
 		if (!cached)
 			setup_work_tree();
 
@@ -902,7 +911,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	} else {
 		if (cached)
 			die(_("both --cached and trees are given."));
-		hit = grep_objects(&opt, &pathspec, &list);
+		hit = grep_objects(&opt, &pathspec, list, list_nr);
 	}
 
 	if (use_threads)
-- 
1.8.4.2.g87d4a77
