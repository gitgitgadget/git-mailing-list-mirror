From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Make Git respect changes to .gitattributes during
 checkout.
Date: Fri, 13 Mar 2009 21:17:50 -0700
Message-ID: <7vprgkg2kx.fsf@gitster.siamese.dyndns.org>
References: <49B8DD1D.3060908@viscovery.net>
 <1236950656-1967-3-git-send-email-kristian.amlie@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kristian Amlie <kristian.amlie@nokia.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 05:21:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiLNE-0000mf-7T
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 05:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbZCNESB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 00:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbZCNESA
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 00:18:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbZCNER7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 00:17:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 860B569A9;
	Sat, 14 Mar 2009 00:17:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 82F4569A8; Sat,
 14 Mar 2009 00:17:53 -0400 (EDT)
In-Reply-To: <1236950656-1967-3-git-send-email-kristian.amlie@nokia.com>
 (Kristian Amlie's message of "Fri, 13 Mar 2009 14:24:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 186481FE-104F-11DE-886F-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113233>

Kristian Amlie <kristian.amlie@nokia.com> writes:

> The fix is twofold:
>
> First, we force .gitattributes files to always be the first ones
> checked out. This is the part in check_updates().
>
> Second, we make sure that the checked out attributes get honored by
> popping off elements on the attribute stack, until we reach the level
> where a new .gitattributes was checked out. The next time someone
> calls git_checkattr(), it will reconstruct the attributes from that
> point.

Yikes.  The patch is too ugly beyond words.

In a well structured git program, we always read from the work tree and
the index (to see if there is something changed---you need to be able to
apply convert_to_git when you do this), internally compute what should
happen (e.g. decide that the new result needs to be checked out for a
path), and then write it out (you apply convert_to_working_tree while you
do this).  So how about doing something like the attached patch?

The patch allows the caller to tell the usual "read from the working tree,
if not use the version from the index as the fallback" logic to be swapped
around, and take the index version.  It may or may not pass your new tests
(I haven't even compile tested it), but I think the damage is minimized
compared to your version.

It is great that you are trying to fix this issue for the most obvious
"switching between two branches while not having a local change" case, but
frankly, I do not think this is solvable in more general cases, and that
is why it was kept "known to be broken, not worth fixing" state.

For example, you may notice that, after making a clean checkout, one path
has a wrong attribute assigned to it, and may try to correct it.  But how?

 $ edit .gitattributes ;# mark foo.dat as binary
 $ rm foo.dat
 $ git checkout foo.dat ;# make sure the new settings is correct???

Without this patch, this would have worked as expected, because we always
use the one from the work tree if available.

We have not "git add"ed .gitattributes yet because we would want to make
sure the change is correct before doing so.  The patch takes attributes
for foo.dat from the old .gitattributes that is sitting in the index,
which still has the wrong information, so in that sense, it is a
regression.

To fix that, I _think_ you can further hack read_attr_from_index() to see
if the attribute file is marked with CE_UPDATE, i.e. it is something we
are checking out in this invocation of "check_updates()", and use it only
if it is, or something like that, but there probably are more corner cases
in which whichever one between the work tree and the index we take, it is
a wrong one.

There are other codepaths that call checkout_entry() that needs a
treatment similar to the one done to check_updates() by this patch, and I
suspect there are a few places that we do not even use checkout_entry().
I think you can fairly easily wrap write_out_results() in builtin-apply.c
in a similar way.  I do not know what merge-recursive does offhand, but I
suspect it would be a lot harder to fix.

Anyway, here is the patch.

 attr.c         |   63 ++++++++++++++++++++++++++++++++++++++++++++-----------
 attr.h         |    6 +++++
 unpack-trees.c |    3 ++
 3 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/attr.c b/attr.c
index 17f6a4d..72f6807 100644
--- a/attr.c
+++ b/attr.c
@@ -1,3 +1,4 @@
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "attr.h"
 
@@ -318,6 +319,9 @@ static struct attr_stack *read_attr_from_array(const char **list)
 	return res;
 }
 
+static enum git_attr_direction direction;
+static struct index_state *use_index;
+
 static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 {
 	FILE *fp = fopen(path, "r");
@@ -340,9 +344,10 @@ static void *read_index_data(const char *path)
 	unsigned long sz;
 	enum object_type type;
 	void *data;
+	struct index_state *istate = use_index ? use_index : &the_index;
 
 	len = strlen(path);
-	pos = cache_name_pos(path, len);
+	pos = index_name_pos(istate, path, len);
 	if (pos < 0) {
 		/*
 		 * We might be in the middle of a merge, in which
@@ -350,15 +355,15 @@ static void *read_index_data(const char *path)
 		 */
 		int i;
 		for (i = -pos - 1;
-		     (pos < 0 && i < active_nr &&
-		      !strcmp(active_cache[i]->name, path));
+		     (pos < 0 && i < istate->cache_nr &&
+		      !strcmp(istate->cache[i]->name, path));
 		     i++)
-			if (ce_stage(active_cache[i]) == 2)
+			if (ce_stage(istate->cache[i]) == 2)
 				pos = i;
 	}
 	if (pos < 0)
 		return NULL;
-	data = read_sha1_file(active_cache[pos]->sha1, &type, &sz);
+	data = read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return NULL;
@@ -366,18 +371,12 @@ static void *read_index_data(const char *path)
 	return data;
 }
 
-static struct attr_stack *read_attr(const char *path, int macro_ok)
+static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 {
 	struct attr_stack *res;
 	char *buf, *sp;
 	int lineno = 0;
 
-	res = read_attr_from_file(path, macro_ok);
-	if (res)
-		return res;
-
-	res = xcalloc(1, sizeof(*res));
-
 	/*
 	 * There is no checked out .gitattributes file there, but
 	 * we might have it in the index.  We allow operation in a
@@ -385,8 +384,9 @@ static struct attr_stack *read_attr(const char *path, int macro_ok)
 	 */
 	buf = read_index_data(path);
 	if (!buf)
-		return res;
+		return NULL;
 
+	res = xcalloc(1, sizeof(*res));
 	for (sp = buf; *sp; ) {
 		char *ep;
 		int more;
@@ -401,6 +401,25 @@ static struct attr_stack *read_attr(const char *path, int macro_ok)
 	return res;
 }
 
+static struct attr_stack *read_attr(const char *path, int macro_ok)
+{
+	struct attr_stack *res;
+
+	if (direction == GIT_ATTR_CHECKOUT) {
+		res = read_attr_from_index(path, macro_ok);
+		if (!res)
+			res = read_attr_from_file(path, macro_ok);
+	}
+	else {
+		res = read_attr_from_file(path, macro_ok);
+		if (!res)
+			res = read_attr_from_index(path, macro_ok);
+	}
+	if (!res)
+		res = xcalloc(1, sizeof(*res));
+	return res;
+}
+
 #if DEBUG_ATTR
 static void debug_info(const char *what, struct attr_stack *elem)
 {
@@ -428,6 +447,15 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
 #define debug_set(a,b,c,d) do { ; } while (0)
 #endif
 
+static void drop_attr_stack(void)
+{
+	while (attr_stack) {
+		struct attr_stack *elem = attr_stack;
+		attr_stack = elem->prev;
+		free_attr_elem(elem);
+	}
+}
+
 static void bootstrap_attr_stack(void)
 {
 	if (!attr_stack) {
@@ -642,3 +670,12 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
 
 	return 0;
 }
+
+void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
+{
+	enum git_attr_direction old = direction;
+	direction = new;
+	if (new != old)
+		drop_attr_stack();
+	use_index = istate;
+}
diff --git a/attr.h b/attr.h
index f1c2038..3a2f4ec 100644
--- a/attr.h
+++ b/attr.h
@@ -31,4 +31,10 @@ struct git_attr_check {
 
 int git_checkattr(const char *path, int, struct git_attr_check *);
 
+enum git_attr_direction {
+	GIT_ATTR_CHECKIN,
+	GIT_ATTR_CHECKOUT
+};
+void git_attr_set_direction(enum git_attr_direction, struct index_state *);
+
 #endif /* ATTR_H */
diff --git a/unpack-trees.c b/unpack-trees.c
index e547282..661218c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -7,6 +7,7 @@
 #include "unpack-trees.h"
 #include "progress.h"
 #include "refs.h"
+#include "attr.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -105,6 +106,7 @@ static int check_updates(struct unpack_trees_options *o)
 		cnt = 0;
 	}
 
+	git_attr_set_direction(GIT_ATTR_CHECKOUT, &o->result);
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -130,6 +132,7 @@ static int check_updates(struct unpack_trees_options *o)
 		}
 	}
 	stop_progress(&progress);
+	git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
 	return errs != 0;
 }
 
