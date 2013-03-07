From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] line-log: Fix sparse warnings
Date: Thu, 07 Mar 2013 18:27:24 +0000
Message-ID: <5138DC0C.80508@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Thu Mar 07 19:44:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDfo6-00005G-PN
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 19:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684Ab3CGSoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 13:44:20 -0500
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:48375 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755969Ab3CGSoU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 13:44:20 -0500
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 0A1E018C864;
	Thu,  7 Mar 2013 18:44:18 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 895E718C747;
	Thu,  7 Mar 2013 18:44:16 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Thu,  7 Mar 2013 18:44:15 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217609>


Sparse issues the following warnings:

    line-log.c:17:6: warning: symbol 'range_set_grow' was not declared. Should it be static?
    line-log.c:25:6: warning: symbol 'range_set_init' was not declared. Should it be static?
    line-log.c:33:6: warning: symbol 'range_set_release' was not declared. Should it be static?
    line-log.c:41:6: warning: symbol 'range_set_copy' was not declared. Should it be static?
    line-log.c:47:6: warning: symbol 'range_set_move' was not declared. Should it be static?
    line-log.c:58:6: warning: symbol 'range_set_append' was not declared. Should it be static?
    line-log.c:299:46: warning: Using plain integer as NULL pointer
    line-log.c:444:12: warning: symbol 'parse_loc' was not declared. Should it be static?
    line-log.c:681:49: warning: Using plain integer as NULL pointer
    line-log.c:684:58: warning: Using plain integer as NULL pointer
    builtin/log.c:120:57: warning: Using plain integer as NULL pointer
    builtin/log.c:120:60: warning: Using plain integer as NULL pointer

In order to suppress the "... was not declared" warnings, we simply
add the static modifier to the declarations of those symbols, since
they do not need more than file scope.

In order to suppress the "NULL pointer" warnings, we simply replace
the use of the integer constant zero as a representation of the null
pointer with the NULL symbol.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Thomas,

If you need to re-roll the patches in your 'tr/line-log' branch, could
you please squash these changes in. [Note that this patch applies to the
tip of the pu branch ;-) ]

Also, I noticed some things in passing, viz:

   971	static void load_tree_desc(struct tree_desc *desc, void **tree,
   972			const unsigned char *sha1)
   973	{
   974		unsigned long size;
   975		*tree = read_object_with_reference(sha1, tree_type, &size, NULL);
   976		if (!tree)
   977			die("Unable to read tree (%s)", sha1_to_hex(sha1));
   978		init_tree_desc(desc, *tree, size);
   979	}

The die() on line 977 will never trigger, since (given that !tree
holds) we will already have dumped core on line 975! ;-)

  1401	int line_log_filter(struct rev_info *rev)
  1402	{
  1403		struct commit *commit;
  1404		struct commit_list *list = rev->commits;
  1405		struct commit_list *out = NULL, *cur = NULL;
  1406
  1407		list = rev->commits;
  1408		while (list) {

Note that the assignment on line 1407 is redundant and can be
removed; list has been initialized to the same value in it's
declaration on line 1404.

HTH

ATB,
Ramsay Jones

 builtin/log.c |  2 +-
 line-log.c    | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c5d2313..a551d8d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -117,7 +117,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 {
 	struct userformat_want w;
 	int quiet = 0, source = 0, mailmap = 0;
-	static struct line_opt_callback_data line_cb = {0, 0, STRING_LIST_INIT_DUP};
+	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
 
 	const struct option builtin_log_options[] = {
 		OPT_BOOLEAN(0, "quiet", &quiet, N_("suppress diff output")),
diff --git a/line-log.c b/line-log.c
index a74bbaf..4d01798 100644
--- a/line-log.c
+++ b/line-log.c
@@ -14,7 +14,7 @@
 #include "userdiff.h"
 #include "line-log.h"
 
-void range_set_grow (struct range_set *rs, size_t extra)
+static void range_set_grow (struct range_set *rs, size_t extra)
 {
 	ALLOC_GROW(rs->ranges, rs->nr + extra, rs->alloc);
 }
@@ -22,7 +22,7 @@ void range_set_grow (struct range_set *rs, size_t extra)
 /* Either initialization would be fine */
 #define RANGE_SET_INIT {0}
 
-void range_set_init (struct range_set *rs, size_t prealloc)
+static void range_set_init (struct range_set *rs, size_t prealloc)
 {
 	rs->alloc = rs->nr = 0;
 	rs->ranges = NULL;
@@ -30,7 +30,7 @@ void range_set_init (struct range_set *rs, size_t prealloc)
 		range_set_grow(rs, prealloc);
 }
 
-void range_set_release (struct range_set *rs)
+static void range_set_release (struct range_set *rs)
 {
 	free(rs->ranges);
 	rs->alloc = rs->nr = 0;
@@ -38,13 +38,13 @@ void range_set_release (struct range_set *rs)
 }
 
 /* dst must be uninitialized! */
-void range_set_copy (struct range_set *dst, struct range_set *src)
+static void range_set_copy (struct range_set *dst, struct range_set *src)
 {
 	range_set_init(dst, src->nr);
 	memcpy(dst->ranges, src->ranges, src->nr*sizeof(struct range_set));
 	dst->nr = src->nr;
 }
-void range_set_move (struct range_set *dst, struct range_set *src)
+static void range_set_move (struct range_set *dst, struct range_set *src)
 {
 	range_set_release(dst);
 	dst->ranges = src->ranges;
@@ -55,7 +55,7 @@ void range_set_move (struct range_set *dst, struct range_set *src)
 }
 
 /* tack on a _new_ range _at the end_ */
-void range_set_append (struct range_set *rs, long a, long b)
+static void range_set_append (struct range_set *rs, long a, long b)
 {
 	assert(a <= b);
 	assert(rs->nr == 0 || rs->ranges[rs->nr-1].end <= a);
@@ -296,7 +296,7 @@ static int collect_diff_cb (long start_a, long count_a,
 
 static void collect_diff (mmfile_t *parent, mmfile_t *target, struct diff_ranges *out)
 {
-	struct collect_diff_cbdata cbdata = {0};
+	struct collect_diff_cbdata cbdata = {NULL};
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
@@ -441,7 +441,7 @@ static void range_set_map_across_diff (struct range_set *out,
 /*
  * Parse one item in the -L option
  */
-const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
+static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 		void *data, long lines, long begin, long *ret)
 {
 	char *term;
@@ -678,10 +678,10 @@ const char *skip_range_arg(const char *arg)
 	if (*arg == ':')
 		return parse_range_funcname(arg, NULL, NULL, 0, NULL, NULL, NULL);
 
-	arg = parse_loc(arg, NULL, NULL, 0, -1, 0);
+	arg = parse_loc(arg, NULL, NULL, 0, -1, NULL);
 
 	if (*arg == ',')
-		arg = parse_loc(arg+1, NULL, NULL, 0, 0, 0);
+		arg = parse_loc(arg+1, NULL, NULL, 0, 0, NULL);
 
 	return arg;
 }
-- 
1.8.1
