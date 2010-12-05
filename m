From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v5] generalizing sorted-array handling
Date: Sun, 5 Dec 2010 13:02:38 +0100
Message-ID: <20101205120238.GB7466@home.lan>
References: <1291545247-4151-1-git-send-email-ydirson@altern.org>
 <20101205104426.GG4332@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 13:02:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPDIq-0003yI-AB
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 13:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895Ab0LEMCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 07:02:47 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:41304 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754462Ab0LEMCq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 07:02:46 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 9F4FDD48079;
	Sun,  5 Dec 2010 13:02:39 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PPDIc-0002SD-FV; Sun, 05 Dec 2010 13:02:38 +0100
Content-Disposition: inline
In-Reply-To: <20101205104426.GG4332@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162944>

On Sun, Dec 05, 2010 at 04:44:26AM -0600, Jonathan Nieder wrote:
> Yann Dirson wrote:
> 
> > * better API documentation (was previously lacking or plain obsolete)
> 
> Thanks!  In general I find it is easiest to read and write
> documentation out of line for this sort of thing.  That way, even
> after the documentation grows obsolete it doesn't seem so out of
> place.
> 
> See Documentation/technical/api-strbuf.txt, api-sigchain, and
> api-allocation-growing for some nice (up-to-date) examples.

OK, can do that.

> In particular:
> 
> > * This API is very verbose, and I'm not happy with that aspect.
> 
> Could you give a quick stripped-down usage example?

Well, patches 2-5 in the series provide good examples - probably
better seen with the "New version" checkbos in gitk, did not find a
commandline flag equivalent (is there one ?).

Patch 4 is probably the simplest example: we use the new macros to
define the same insert API (except for the "number of element" var,
which used a non-standard naming scheme here).  Since the lookup API
was only used inside the insert func, there was no need for a lookup
wrapper here, so we just declare the generic search+ insert funcs, and
an insert wrapper.

---------------------------- builtin/pack-objects.c ----------------------------
index 3cbeb29..887a55c 100644
@@ -16,6 +16,7 @@
 #include "list-objects.h"
 #include "progress.h"
 #include "refs.h"
+#include "sorted-array.h"
 
 #ifndef NO_PTHREADS
 #include <pthread.h>
@@ -871,45 +872,23 @@ static void add_pbase_object(struct tree_desc *tree,
 	}
 }
 
+static int unsigned_cmp(unsigned ref, unsigned *elem)
 {
+	if (ref == *elem)
+		return 0;
+	if (ref < *elem)
+		return -1;
+	return 1;
 }
+static void unsigned_init(unsigned *elem, unsigned ref)
 {
+	*elem = ref;
 }
+declare_sorted_array(static, unsigned, done_pbase_paths);
+declare_gen_binsearch(static, unsigned, done_pbase_path_pos, unsigned);
+declare_gen_sorted_insert(static, unsigned, _check_pbase_path, done_pbase_path_pos, unsigned);
+declare_sorted_array_insert_checkbool(static, check_pbase_path, unsigned, _check_pbase_path,
+				      done_pbase_paths, unsigned_cmp, unsigned_init);
 
 static void add_preferred_base_object(const char *name)
 {
@@ -987,7 +966,7 @@ static void cleanup_preferred_base(void)
 
 	free(done_pbase_paths);
 	done_pbase_paths = NULL;
+	done_pbase_paths_nr = done_pbase_paths_alloc = 0;
 }
 
 static void check_object(struct object_entry *entry)
----------------------------


Patch 2 is a more complete example, where the oiginal API used a
single function with an additional boolean arg to select the
behaviour.  So here we also define a search wrapper, and this make the
callsites more explicit.

------------------------------ diffcore-rename.c ------------------------------
index df41be5..a655017 100644
@@ -5,52 +5,36 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "hash.h"
+#include "sorted-array.h"
 
 /* Table of rename/copy destinations */
 
+struct diff_rename_dst {
 	struct diff_filespec *two;
 	struct diff_filepair *pair;
+};
 
+static int rename_dst_cmp(struct diff_filespec *ref_spec, struct diff_rename_dst *elem)
 {
+	return strcmp(ref_spec->path, elem->two->path);
+}
+static void rename_dst_init(struct diff_rename_dst *elem, struct diff_filespec *ref_spec)
+{
+	elem->two = alloc_filespec(ref_spec->path);
+	fill_filespec(elem->two, ref_spec->sha1, ref_spec->mode);
+	elem->pair = NULL;
 }
+declare_sorted_array(static, struct diff_rename_dst, rename_dst);
+declare_gen_binsearch(static, struct diff_rename_dst, _locate_rename_dst,
+		      struct diff_filespec *);
+declare_sorted_array_search_elem(static, struct diff_rename_dst, locate_rename_dst,
+				 struct diff_filespec *, _locate_rename_dst,
+				 rename_dst, rename_dst_cmp);
+declare_gen_sorted_insert(static, struct diff_rename_dst, _register_rename_dst,
+			  _locate_rename_dst, struct diff_filespec *);
+declare_sorted_array_insert_checkbool(static, register_rename_dst, struct diff_filespec *,
+				      _register_rename_dst,
+				      rename_dst, rename_dst_cmp, rename_dst_init);
 
 /* Table of rename/copy src files */
 static struct diff_rename_src {
@@ -437,7 +421,7 @@ void diffcore_rename(struct diff_options *options)
 				 strcmp(options->single_follow, p->two->path))
 				continue; /* not interested */
 			else
+				register_rename_dst(p->two);
 		}
 		else if (!DIFF_FILE_VALID(p->two)) {
 			/*
@@ -582,7 +566,7 @@ void diffcore_rename(struct diff_options *options)
 			 * not been turned into a rename/copy already.
 			 */
 			struct diff_rename_dst *dst =
+				locate_rename_dst(p->two);
 			if (dst && dst->pair) {
 				diff_q(&outq, dst->pair);
 				pair_to_free = p;
@@ -613,7 +597,7 @@ void diffcore_rename(struct diff_options *options)
 			if (DIFF_PAIR_BROKEN(p)) {
 				/* broken delete */
 				struct diff_rename_dst *dst =
+					locate_rename_dst(p->one);
 				if (dst && dst->pair)
 					/* counterpart is now rename/copy */
 					pair_to_free = p;
------------------------------

> [...]
> > Adding "simple" API variants that would call all the necessary stuff
> > would help code readability, but adding yet more entry points seems a
> > dubious approach.
> 
> On the contrary, simple API variants don't sound so bad to me,
> once the fundamentals are in good shape.

The problem is with the number of combinations.  We already have
potentially 6 wrappers (not all of which are defined yet), with:

* operation: search | insert
* return-value semantic: check | checkbool | elem

If we add to these basic building-blocks:

* wrapper variants that declare the generic func: we double the count
* insert-wrapper variants that declare the generic search: *1.5

... which gives something like 18 wrappers.  And this number will
still raise by 6 each time we feel the need for a new return-value
semantic.
