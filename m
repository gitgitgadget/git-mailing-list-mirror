From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/13] refs: introduce an iterator interface
Date: Fri,  3 Jun 2016 14:33:49 +0200
Message-ID: <58923ed69b2a290a9f42e187da25e43f54cfc879.1464957077.git.mhagger@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 14:34:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8oJI-0005RU-Cd
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbcFCMeZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 08:34:25 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:57650 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932263AbcFCMeT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 08:34:19 -0400
X-AuditID: 1207440c-c3fff70000000b85-31-57517949b322
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 37.57.02949.94971575; Fri,  3 Jun 2016 08:34:17 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53CXtit005761
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 08:34:15 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464957077.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqOtZGRhusGq3vsX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDNWv3jHXLB2OlPF5Tt72RsYPz9k
	7GLk5JAQMJG4f/QxmC0ksJVR4vdPXgj7OJPEliNCIDabgK7Eop5mJhBbRCBCouFVC1A9Fwez
	wBwmidsPO5m7GDk4hAXsJe62iIPUsAioSlza8x9sJq9AlMSrG1ugdslJXJ7+gA3E5hSwkOi7
	94MdYpe5xMM5u9kh6gUlTs58wgIykllAXWL9PLATmAXkJZq3zmaewMg/C0nVLISqWUiqFjAy
	r2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdTLzSzRS00p3cQIiQCeHYzf1skcYhTgYFTi4V2x
	ICBciDWxrLgy9xCjJAeTkijv+bNAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8fwoCw4V4UxIr
	q1KL8mFS0hwsSuK8qkvU/YQE0hNLUrNTUwtSi2CyMhwcShK8P8qBGgWLUtNTK9Iyc0oQ0kwc
	nCDDuaREilPzUlKLEktLMuJB8RhfDIxIkBQP0N7PIO28xQWJuUBRiNZTjMYcm35cW8vEsWXB
	jbVMQix5+XmpUuK8DCClAiClGaV5cItgqe8VozjQ38K8PhVAVTzAtAk37xXQKiagVQWP/EFW
	lSQipKQaGKNe7e7yNrrwo+3nmrf3lG7caeI9LX3lmNCnbqeOnzbKajsWs7p9uLVM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296327>

Currently, the API for iterating over references is via a family of
for_each_ref()-type functions that invoke a callback function for each
selected reference. All of these eventually call do_for_each_ref(),
which knows how to do one thing: iterate in parallel through two
ref_caches, one for loose and one for packed refs, giving loose
references precedence over packed refs. This is rather complicated code=
,
and is quite specialized to the files backend. It also requires callers
to encapsulate their work into a callback function, which often means
that they have to define and use a "cb_data" struct to manage their
context.

The current design is already bursting at the seams, and will become
even more awkward in the upcoming world of multiple reference storage
backends:

* Per-worktree vs. shared references are currently handled via a kludge
  in git_path() rather than iterating over each part of the reference
  namespace separately and merging the results. This kludge will cease
  to work when we have multiple reference storage backends.

* The current scheme is inflexible. What if we sometimes want to bypass
  the ref_cache, or use it only for packed or only for loose refs? What
  if we want to store symbolic refs in one type of storage backend and
  non-symbolic ones in another?

In the future, each reference backend will need to define its own way o=
f
iterating over references. The crux of the problem with the current
design is that it is impossible to compose for_each_ref()-style
iterations, because the flow of control is owned by the for_each_ref()
function. There is nothing that a caller can do but iterate through all
references in a single burst, so there is no way for it to interleave
references from multiple backends and present the result to the rest of
the world as a single compound backend.

This commit introduces a new iteration primitive for references: a
ref_iterator. A ref_iterator is a polymorphic object that a reference
storage backend can be asked to instantiate. There are three functions
that can be applied to a ref_iterator:

* ref_iterator_advance(): move to the next reference in the iteration
* ref_iterator_abort(): end the iteration before it is exhausted
* ref_iterator_peel(): peel the reference currently being looked at

Iterating using a ref_iterator leaves the flow of control in the hands
of the caller, which means that ref_iterators from multiple
sources (e.g., loose and packed refs) can be composed and presented to
the world as a single compound ref_iterator.

It also means that the backend code for implementing reference iteratio=
n
will sometimes be more complicated. For example, the
cache_ref_iterator (which iterates over a ref_cache) can't use the C
stack to recurse; instead, it must manage its own stack internally as
explicit data structures. There is also a lot of boilerplate connected
with object-oriented programming in C.

Eventually, end-user callers will be able to be written in a more
natural way=E2=80=94managing their own flow of control rather than havi=
ng to
work via callbacks. Since there will only be a few reference backends
but there are many consumers of this API, this is a good tradeoff.

More importantly, we gain composability, and especially the possibility
of writing interchangeable parts that can work with any ref_iterator.

=46or example, merge_ref_iterator implements a generic way of merging t=
he
contents of any two ref_iterators. It is used to merge loose + packed
refs as part of the implementation of the files_ref_iterator. But it
will also be possible to use it to merge other pairs of reference
sources (e.g., per-worktree vs. shared refs).

Another example is prefix_ref_iterator, which can be used to trim a
prefix off the front of reference names before presenting them to the
caller (e.g., "refs/heads/master" -> "master").

In this patch, we introduce the iterator abstraction and many utilities=
,
and implement a reference iterator for the files ref storage backend.
(I've written several other obvious utilities, for example a generic wa=
y
to filter references being iterated over. These will probably be useful
in the future. But they are not needed for this patch series, so I am
not including them at this time.)

In a moment we will rewrite do_for_each_ref() to work via reference
iterators (allowing some special-purpose code to be discarded), and do
something similar for reflogs. In future patch series, we will expose
the ref_iterator abstraction in the public refs API so that callers can
use it directly.

Implementation note: I tried abstracting this a layer further to allow
generic iterators (over arbitrary types of objects) and generic
utilities like a generic merge_iterator. But the implementation in C wa=
s
very cumbersome, involving (in my opinion) too much boilerplate and too
much unsafe casting, some of which would have had to be done on the
caller side. However, I did put a few iterator-related constants in a
top-level header file, iterator.h, as they will be useful in a moment t=
o
implement iteration over directory trees and possibly other types of
iterators in the future.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Makefile             |   1 +
 iterator.h           |  81 ++++++++++++
 refs.h               |   4 +-
 refs/files-backend.c | 281 ++++++++++++++++++++++++++++++++++++++++
 refs/iterator.c      | 355 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 refs/refs-internal.h | 194 ++++++++++++++++++++++++++++
 6 files changed, 915 insertions(+), 1 deletion(-)
 create mode 100644 iterator.h
 create mode 100644 refs/iterator.c

diff --git a/Makefile b/Makefile
index a83e322..ac8f365 100644
--- a/Makefile
+++ b/Makefile
@@ -786,6 +786,7 @@ LIB_OBJS +=3D read-cache.o
 LIB_OBJS +=3D reflog-walk.o
 LIB_OBJS +=3D refs.o
 LIB_OBJS +=3D refs/files-backend.o
+LIB_OBJS +=3D refs/iterator.o
 LIB_OBJS +=3D ref-filter.o
 LIB_OBJS +=3D remote.o
 LIB_OBJS +=3D replace_object.o
diff --git a/iterator.h b/iterator.h
new file mode 100644
index 0000000..0f6900e
--- /dev/null
+++ b/iterator.h
@@ -0,0 +1,81 @@
+#ifndef ITERATOR_H
+#define ITERATOR_H
+
+/*
+ * Generic constants related to iterators.
+ */
+
+/*
+ * The attempt to advance the iterator was successful; the iterator
+ * reflects the new current entry.
+ */
+#define ITER_OK 0
+
+/*
+ * The iterator is exhausted and has been freed.
+ */
+#define ITER_DONE -1
+
+/*
+ * The iterator experienced an error. The iteration has been aborted
+ * and the iterator has been freed.
+ */
+#define ITER_ERROR -2
+
+/*
+ * Return values for selector functions for merge iterators. The
+ * numerical values of these constants are important and must be
+ * compatible with ITER_DONE and ITER_ERROR.
+ */
+enum iterator_selection {
+	/* End the iteration without an error: */
+	ITER_SELECT_DONE =3D ITER_DONE,
+
+	/* Report an error and abort the iteration: */
+	ITER_SELECT_ERROR =3D ITER_ERROR,
+
+	/*
+	 * The next group of constants are masks that are useful
+	 * mainly internally.
+	 */
+
+	/* The LSB selects whether iter0/iter1 is the "current" iterator: */
+	ITER_CURRENT_SELECTION_MASK =3D 0x01,
+
+	/* iter0 is the "current" iterator this round: */
+	ITER_CURRENT_SELECTION_0 =3D 0x00,
+
+	/* iter1 is the "current" iterator this round: */
+	ITER_CURRENT_SELECTION_1 =3D 0x01,
+
+	/* Yield the value from the current iterator? */
+	ITER_YIELD_CURRENT =3D 0x02,
+
+	/* Discard the value from the secondary iterator? */
+	ITER_SKIP_SECONDARY =3D 0x04,
+
+	/*
+	 * The constants that a selector function should usually
+	 * return.
+	 */
+
+	/* Yield the value from iter0: */
+	ITER_SELECT_0 =3D ITER_CURRENT_SELECTION_0 | ITER_YIELD_CURRENT,
+
+	/* Yield the value from iter0 and discard the one from iter1: */
+	ITER_SELECT_0_SKIP_1 =3D ITER_SELECT_0 | ITER_SKIP_SECONDARY,
+
+	/* Discard the value from iter0 without yielding anything this round:=
 */
+	ITER_SKIP_0 =3D ITER_CURRENT_SELECTION_1 | ITER_SKIP_SECONDARY,
+
+	/* Yield the value from iter1: */
+	ITER_SELECT_1 =3D ITER_CURRENT_SELECTION_1 | ITER_YIELD_CURRENT,
+
+	/* Yield the value from iter1 and discard the one from iter0: */
+	ITER_SELECT_1_SKIP_0 =3D ITER_SELECT_1 | ITER_SKIP_SECONDARY,
+
+	/* Discard the value from iter1 without yielding anything this round:=
 */
+	ITER_SKIP_1 =3D ITER_CURRENT_SELECTION_0 | ITER_SKIP_SECONDARY
+};
+
+#endif /* ITERATOR_H */
diff --git a/refs.h b/refs.h
index 6d515a4..442c1a5 100644
--- a/refs.h
+++ b/refs.h
@@ -141,7 +141,9 @@ int dwim_log(const char *str, int len, unsigned cha=
r *sha1, char **ref);
 struct ref_transaction;
=20
 /*
- * Bit values set in the flags argument passed to each_ref_fn():
+ * Bit values set in the flags argument passed to each_ref_fn() and
+ * stored in ref_iterator::flags. Other bits are for internal use
+ * only:
  */
=20
 /* Reference is a symbolic reference. */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8ab4d5f..78f2941 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,6 +1,7 @@
 #include "../cache.h"
 #include "../refs.h"
 #include "refs-internal.h"
+#include "../iterator.h"
 #include "../lockfile.h"
 #include "../object.h"
 #include "../dir.h"
@@ -704,6 +705,153 @@ static void prime_ref_dir(struct ref_dir *dir)
 	}
 }
=20
+/*
+ * A level in the reference hierarchy that is currently being iterated
+ * through.
+ */
+struct cache_ref_iterator_level {
+	/*
+	 * The ref_dir being iterated over at this level. The ref_dir
+         * is sorted before being stored here.
+	 */
+	struct ref_dir *dir;
+
+	/*
+	 * The index of the current entry within dir (which might
+	 * itself be a directory). If index =3D=3D -1, then the iteration
+	 * hasn't yet begun. If index =3D=3D dir->nr, then the iteration
+	 * through this level is over.
+	 */
+	int index;
+};
+
+/*
+ * Represent an iteration through a ref_dir in the memory cache. The
+ * iteration recurses through subdirectories.
+ */
+struct cache_ref_iterator {
+	struct ref_iterator base;
+
+	/*
+	 * The number of levels currently on the stack. This is always
+	 * at least 1, because when it becomes zero the iteration is
+	 * ended and this struct is freed.
+	 */
+	size_t levels_nr;
+
+	/* The number of levels that have been allocated on the stack */
+	size_t levels_alloc;
+
+	/*
+	 * A stack of levels. levels[0] is the uppermost level that is
+	 * being iterated over in this iteration. (This is not
+	 * necessary the top level in the references hierarchy. If we
+	 * are iterating through a subtree, then levels[0] will hold
+	 * the ref_dir for that subtree, and subsequent levels will go
+	 * on from there.)
+	 */
+	struct cache_ref_iterator_level *levels;
+};
+
+static int cache_ref_iterator_advance(struct ref_iterator *ref_iterato=
r)
+{
+	struct cache_ref_iterator *iter =3D
+		(struct cache_ref_iterator *)ref_iterator;
+
+	while (1) {
+		struct cache_ref_iterator_level *level =3D
+			&iter->levels[iter->levels_nr - 1];
+		struct ref_dir *dir =3D level->dir;
+		struct ref_entry *entry;
+
+		if (level->index =3D=3D -1)
+			sort_ref_dir(dir);
+
+		if (++level->index =3D=3D level->dir->nr) {
+			/* This level is exhausted; pop up a level */
+			if (--iter->levels_nr =3D=3D 0)
+				return ref_iterator_abort(ref_iterator);
+
+			continue;
+		}
+
+		entry =3D dir->entries[level->index];
+
+		if (entry->flag & REF_DIR) {
+			/* push down a level */
+			ALLOC_GROW(iter->levels, iter->levels_nr + 1,
+				   iter->levels_alloc);
+
+			level =3D &iter->levels[iter->levels_nr++];
+			level->dir =3D get_ref_dir(entry);
+			level->index =3D -1;
+		} else {
+			iter->base.refname =3D entry->name;
+			iter->base.oid =3D &entry->u.value.oid;
+			iter->base.flags =3D entry->flag;
+			return ITER_OK;
+		}
+	}
+}
+
+static enum peel_status peel_entry(struct ref_entry *entry, int repeel=
);
+
+static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				   struct object_id *peeled)
+{
+	struct cache_ref_iterator *iter =3D
+		(struct cache_ref_iterator *)ref_iterator;
+	struct cache_ref_iterator_level *level;
+	struct ref_entry *entry;
+
+	level =3D &iter->levels[iter->levels_nr - 1];
+
+	if (level->index =3D=3D -1)
+		die("BUG: peel called before advance for cache iterator");
+
+	entry =3D level->dir->entries[level->index];
+
+	if (peel_entry(entry, 0))
+		return -1;
+	hashcpy(peeled->hash, entry->u.value.peeled.hash);
+	return 0;
+}
+
+static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct cache_ref_iterator *iter =3D
+		(struct cache_ref_iterator *)ref_iterator;
+
+	free(iter->levels);
+	base_ref_iterator_free(ref_iterator);
+	return ITER_DONE;
+}
+
+struct ref_iterator_vtable cache_ref_iterator_vtable =3D {
+	cache_ref_iterator_advance,
+	cache_ref_iterator_peel,
+	cache_ref_iterator_abort
+};
+
+static struct ref_iterator *cache_ref_iterator_begin(struct ref_dir *d=
ir)
+{
+	struct cache_ref_iterator *iter;
+	struct ref_iterator *ref_iterator;
+	struct cache_ref_iterator_level *level;
+
+	iter =3D xcalloc(1, sizeof(*iter));
+	ref_iterator =3D &iter->base;
+	base_ref_iterator_init(ref_iterator, &cache_ref_iterator_vtable);
+	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
+
+	iter->levels_nr =3D 1;
+	level =3D &iter->levels[0];
+	level->index =3D -1;
+	level->dir =3D dir;
+
+	return ref_iterator;
+}
+
 struct nonmatching_ref_data {
 	const struct string_list *skip;
 	const char *conflicting_refname;
@@ -1843,6 +1991,139 @@ int peel_ref(const char *refname, unsigned char=
 *sha1)
 	return peel_object(base, sha1);
 }
=20
+struct files_ref_iterator {
+	struct ref_iterator base;
+
+	struct packed_ref_cache *packed_ref_cache;
+	struct ref_iterator *iter0;
+	unsigned int flags;
+};
+
+static int files_ref_iterator_advance(struct ref_iterator *ref_iterato=
r)
+{
+	struct files_ref_iterator *iter =3D
+		(struct files_ref_iterator *)ref_iterator;
+	int ok;
+
+	while ((ok =3D ref_iterator_advance(iter->iter0)) =3D=3D ITER_OK) {
+		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+		    !ref_resolves_to_object(iter->iter0->refname,
+					    iter->iter0->oid,
+					    iter->iter0->flags))
+			continue;
+
+		iter->base.refname =3D iter->iter0->refname;
+		iter->base.oid =3D iter->iter0->oid;
+		iter->base.flags =3D iter->iter0->flags;
+		return ITER_OK;
+	}
+
+	iter->iter0 =3D NULL;
+	if (ref_iterator_abort(ref_iterator) !=3D ITER_DONE)
+		ok =3D ITER_ERROR;
+
+	return ok;
+}
+
+static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				   struct object_id *peeled)
+{
+	struct files_ref_iterator *iter =3D
+		(struct files_ref_iterator *)ref_iterator;
+
+	return ref_iterator_peel(iter->iter0, peeled);
+}
+
+static int files_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct files_ref_iterator *iter =3D
+		(struct files_ref_iterator *)ref_iterator;
+	int ok =3D ITER_DONE;
+
+	if (iter->iter0)
+		ok =3D ref_iterator_abort(iter->iter0);
+
+	release_packed_ref_cache(iter->packed_ref_cache);
+	base_ref_iterator_free(ref_iterator);
+	return ok;
+}
+
+struct ref_iterator_vtable files_ref_iterator_vtable =3D {
+	files_ref_iterator_advance,
+	files_ref_iterator_peel,
+	files_ref_iterator_abort
+};
+
+struct ref_iterator *files_ref_iterator_begin(
+		const char *submodule,
+		const char *prefix, unsigned int flags)
+{
+	struct ref_cache *refs =3D get_ref_cache(submodule);
+	struct ref_dir *loose_dir, *packed_dir;
+	struct ref_iterator *loose_iter, *packed_iter;
+	struct files_ref_iterator *iter;
+	struct ref_iterator *ref_iterator;
+
+	if (!refs)
+		return empty_ref_iterator_begin();
+
+	if (ref_paranoia < 0)
+		ref_paranoia =3D git_env_bool("GIT_REF_PARANOIA", 0);
+	if (ref_paranoia)
+		flags |=3D DO_FOR_EACH_INCLUDE_BROKEN;
+
+	iter =3D xcalloc(1, sizeof(*iter));
+	ref_iterator =3D &iter->base;
+	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable);
+
+	/*
+	 * We must make sure that all loose refs are read before
+	 * accessing the packed-refs file; this avoids a race
+	 * condition if loose refs are migrated to the packed-refs
+	 * file by a simultaneous process, but our in-memory view is
+	 * from before the migration. We ensure this as follows:
+	 * First, we call prime_ref_dir(), which pre-reads the loose
+	 * references for the subtree into the cache. (If they've
+	 * already been read, that's OK; we only need to guarantee
+	 * that they're read before the packed refs, not *how much*
+	 * before.) After that, we call get_packed_ref_cache(), which
+	 * internally checks whether the packed-ref cache is up to
+	 * date with what is on disk, and re-reads it if not.
+	 */
+
+	loose_dir =3D get_loose_refs(refs);
+
+	if (prefix && *prefix)
+		loose_dir =3D find_containing_dir(loose_dir, prefix, 0);
+
+	if (loose_dir) {
+		prime_ref_dir(loose_dir);
+		loose_iter =3D cache_ref_iterator_begin(loose_dir);
+	} else {
+		/* There's nothing to iterate over. */
+		loose_iter =3D empty_ref_iterator_begin();
+	}
+
+	iter->packed_ref_cache =3D get_packed_ref_cache(refs);
+	acquire_packed_ref_cache(iter->packed_ref_cache);
+	packed_dir =3D get_packed_ref_dir(iter->packed_ref_cache);
+
+	if (prefix && *prefix)
+		packed_dir =3D find_containing_dir(packed_dir, prefix, 0);
+
+	if (packed_dir) {
+		packed_iter =3D cache_ref_iterator_begin(packed_dir);
+	} else {
+		/* There's nothing to iterate over. */
+		packed_iter =3D empty_ref_iterator_begin();
+	}
+
+	iter->iter0 =3D overlay_ref_iterator_begin(loose_iter, packed_iter);
+	iter->flags =3D flags;
+
+	return ref_iterator;
+}
+
 /*
  * Call fn for each reference in the specified ref_cache, omitting
  * references not in the containing_dir of prefix. Call fn for all
diff --git a/refs/iterator.c b/refs/iterator.c
new file mode 100644
index 0000000..93ba472
--- /dev/null
+++ b/refs/iterator.c
@@ -0,0 +1,355 @@
+/*
+ * Generic reference iterator infrastructure. See refs-internal.h for
+ * documentation about the design and use of reference iterators.
+ */
+
+#include "cache.h"
+#include "refs.h"
+#include "refs/refs-internal.h"
+#include "iterator.h"
+
+int ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	return ref_iterator->vtable->advance(ref_iterator);
+}
+
+int ref_iterator_peel(struct ref_iterator *ref_iterator,
+		      struct object_id *peeled)
+{
+	return ref_iterator->vtable->peel(ref_iterator, peeled);
+}
+
+int ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	return ref_iterator->vtable->abort(ref_iterator);
+}
+
+void base_ref_iterator_init(struct ref_iterator *iter,
+			    struct ref_iterator_vtable *vtable)
+{
+	iter->vtable =3D vtable;
+	iter->refname =3D NULL;
+	iter->oid =3D NULL;
+	iter->flags =3D 0;
+}
+
+void base_ref_iterator_free(struct ref_iterator *iter)
+{
+	/* Help make use-after-free bugs fail quickly: */
+	iter->vtable =3D NULL;
+	free(iter);
+}
+
+struct empty_ref_iterator {
+	struct ref_iterator base;
+};
+
+static int empty_ref_iterator_advance(struct ref_iterator *ref_iterato=
r)
+{
+	return ref_iterator_abort(ref_iterator);
+}
+
+static int empty_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				   struct object_id *peeled)
+{
+	die("BUG: peel called for empty iterator");
+}
+
+static int empty_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	base_ref_iterator_free(ref_iterator);
+	return ITER_DONE;
+}
+
+static struct ref_iterator_vtable empty_ref_iterator_vtable =3D {
+	empty_ref_iterator_advance,
+	empty_ref_iterator_peel,
+	empty_ref_iterator_abort
+};
+
+struct ref_iterator *empty_ref_iterator_begin(void)
+{
+	struct empty_ref_iterator *iter =3D xcalloc(1, sizeof(*iter));
+	struct ref_iterator *ref_iterator =3D &iter->base;
+
+	base_ref_iterator_init(ref_iterator, &empty_ref_iterator_vtable);
+	return ref_iterator;
+}
+
+int is_empty_ref_iterator(struct ref_iterator *ref_iterator)
+{
+	return ref_iterator->vtable =3D=3D &empty_ref_iterator_vtable;
+}
+
+struct merge_ref_iterator {
+	struct ref_iterator base;
+
+	struct ref_iterator *iter0, *iter1;
+
+	ref_iterator_select_fn *select;
+	void *cb_data;
+
+	/*
+	 * A pointer to iter0 or iter1 (whichever is supplying the
+	 * current value), or NULL if advance has not yet been called.
+	 */
+	struct ref_iterator **current;
+};
+
+static int merge_ref_iterator_advance(struct ref_iterator *ref_iterato=
r)
+{
+	struct merge_ref_iterator *iter =3D
+		(struct merge_ref_iterator *)ref_iterator;
+	int ok;
+
+	if (!iter->current) {
+		/* Initialize: advance both iterators to their first entries */
+		if ((ok =3D ref_iterator_advance(iter->iter0)) !=3D ITER_OK) {
+			iter->iter0 =3D NULL;
+			if (ok =3D=3D ITER_ERROR)
+				goto error;
+		}
+		if ((ok =3D ref_iterator_advance(iter->iter1)) !=3D ITER_OK) {
+			iter->iter1 =3D NULL;
+			if (ok =3D=3D ITER_ERROR)
+				goto error;
+		}
+	} else {
+		/*
+		 * Advance the current iterator past the just-used
+		 * entry:
+		 */
+		if ((ok =3D ref_iterator_advance(*iter->current)) !=3D ITER_OK) {
+			*iter->current =3D NULL;
+			if (ok =3D=3D ITER_ERROR)
+				goto error;
+		}
+	}
+
+	/* Loop until we find an entry that we can yield. */
+	while (1) {
+		struct ref_iterator **secondary;
+		enum iterator_selection selection =3D
+			iter->select(iter->iter0, iter->iter1, iter->cb_data);
+
+		if (selection =3D=3D ITER_SELECT_DONE) {
+			return ref_iterator_abort(ref_iterator);
+		} else if (selection =3D=3D ITER_SELECT_ERROR) {
+			ref_iterator_abort(ref_iterator);
+			return ITER_ERROR;
+		}
+
+		if ((selection & ITER_CURRENT_SELECTION_MASK) =3D=3D 0) {
+			iter->current =3D &iter->iter0;
+			secondary =3D &iter->iter1;
+		} else {
+			iter->current =3D &iter->iter1;
+			secondary =3D &iter->iter0;
+		}
+
+		if (selection & ITER_SKIP_SECONDARY) {
+			if ((ok =3D ref_iterator_advance(*secondary)) !=3D ITER_OK) {
+				*secondary =3D NULL;
+				if (ok =3D=3D ITER_ERROR)
+					goto error;
+			}
+		}
+
+		if (selection & ITER_YIELD_CURRENT) {
+			iter->base.refname =3D (*iter->current)->refname;
+			iter->base.oid =3D (*iter->current)->oid;
+			iter->base.flags =3D (*iter->current)->flags;
+			return ITER_OK;
+		}
+	}
+
+error:
+	ref_iterator_abort(ref_iterator);
+	return ITER_ERROR;
+}
+
+static int merge_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				   struct object_id *peeled)
+{
+	struct merge_ref_iterator *iter =3D
+		(struct merge_ref_iterator *)ref_iterator;
+
+	if (!iter->current) {
+		die("BUG: peel called before advance for merge iterator");
+	}
+	return ref_iterator_peel(*iter->current, peeled);
+}
+
+static int merge_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct merge_ref_iterator *iter =3D
+		(struct merge_ref_iterator *)ref_iterator;
+	int ok =3D ITER_DONE;
+
+	if (iter->iter0) {
+		if (ref_iterator_abort(iter->iter0) !=3D ITER_DONE)
+			ok =3D ITER_ERROR;
+	}
+	if (iter->iter1) {
+		if (ref_iterator_abort(iter->iter1) !=3D ITER_DONE)
+			ok =3D ITER_ERROR;
+	}
+	base_ref_iterator_free(ref_iterator);
+	return ok;
+}
+
+static struct ref_iterator_vtable merge_ref_iterator_vtable =3D {
+	merge_ref_iterator_advance,
+	merge_ref_iterator_peel,
+	merge_ref_iterator_abort
+};
+
+struct ref_iterator *merge_ref_iterator_begin(
+		struct ref_iterator *iter0, struct ref_iterator *iter1,
+		ref_iterator_select_fn *select, void *cb_data)
+{
+	struct merge_ref_iterator *iter =3D xcalloc(1, sizeof(*iter));
+	struct ref_iterator *ref_iterator =3D &iter->base;
+
+	/*
+	 * We can't do the same kind of is_empty_ref_iterator()-style
+	 * optimization here as overlay_ref_iterator_begin() does,
+	 * because we don't know the semantics of the select function.
+	 * It might, for example, implement "intersect" by passing
+	 * references through only if they exist in both iterators.
+	 */
+
+	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable);
+	iter->iter0 =3D iter0;
+	iter->iter1 =3D iter1;
+	iter->select =3D select;
+	iter->cb_data =3D cb_data;
+	iter->current =3D NULL;
+	return ref_iterator;
+}
+
+/*
+ * A ref_iterator_select_fn that overlays the items from front on top
+ * of those from back (like loose refs over packed refs). See
+ * overlay_ref_iterator_begin().
+ */
+static enum iterator_selection overlay_iterator_select(
+		struct ref_iterator *front, struct ref_iterator *back,
+		void *cb_data)
+{
+	int cmp;
+
+	if (!back)
+		return front ? ITER_SELECT_0 : ITER_SELECT_DONE;
+	else if (!front)
+		return ITER_SELECT_1;
+
+	cmp =3D strcmp(front->refname, back->refname);
+
+	if (cmp < 0)
+		return ITER_SELECT_0;
+	else if (cmp > 0)
+		return ITER_SELECT_1;
+	else
+		return ITER_SELECT_0_SKIP_1;
+}
+
+struct ref_iterator *overlay_ref_iterator_begin(
+		struct ref_iterator *front, struct ref_iterator *back)
+{
+	/*
+	 * Optimization: if one of the iterators is empty, return the
+	 * other one rather than incurring the overhead of wrapping
+	 * them.
+	 */
+	if (is_empty_ref_iterator(front)) {
+		ref_iterator_abort(front);
+		return back;
+	} else if (is_empty_ref_iterator(back)) {
+		ref_iterator_abort(back);
+		return front;
+	}
+
+	return merge_ref_iterator_begin(front, back,
+					overlay_iterator_select, NULL);
+}
+
+struct prefix_ref_iterator {
+	struct ref_iterator base;
+
+	struct ref_iterator *iter0;
+	char *prefix;
+	int trim;
+};
+
+static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterat=
or)
+{
+	struct prefix_ref_iterator *iter =3D
+		(struct prefix_ref_iterator *)ref_iterator;
+	int ok;
+
+	while ((ok =3D ref_iterator_advance(iter->iter0)) =3D=3D ITER_OK) {
+		if (!starts_with(iter->iter0->refname, iter->prefix))
+			continue;
+
+		iter->base.refname =3D iter->iter0->refname + iter->trim;
+		iter->base.oid =3D iter->iter0->oid;
+		iter->base.flags =3D iter->iter0->flags;
+		return ITER_OK;
+	}
+
+	iter->iter0 =3D NULL;
+	if (ref_iterator_abort(ref_iterator) !=3D ITER_DONE)
+		return ITER_ERROR;
+	return ok;
+}
+
+static int prefix_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				    struct object_id *peeled)
+{
+	struct prefix_ref_iterator *iter =3D
+		(struct prefix_ref_iterator *)ref_iterator;
+
+	return ref_iterator_peel(iter->iter0, peeled);
+}
+
+static int prefix_ref_iterator_abort(struct ref_iterator *ref_iterator=
)
+{
+	struct prefix_ref_iterator *iter =3D
+		(struct prefix_ref_iterator *)ref_iterator;
+	int ok =3D ITER_DONE;
+
+	if (iter->iter0)
+		ok =3D ref_iterator_abort(iter->iter0);
+	free(iter->prefix);
+	base_ref_iterator_free(ref_iterator);
+	return ok;
+}
+
+static struct ref_iterator_vtable prefix_ref_iterator_vtable =3D {
+	prefix_ref_iterator_advance,
+	prefix_ref_iterator_peel,
+	prefix_ref_iterator_abort
+};
+
+struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *it=
er0,
+					       const char *prefix,
+					       int trim)
+{
+	struct prefix_ref_iterator *iter;
+	struct ref_iterator *ref_iterator;
+
+	if (!*prefix && !trim)
+		return iter0; /* optimization: no need to wrap iterator */
+
+	iter =3D xcalloc(1, sizeof(*iter));
+	ref_iterator =3D &iter->base;
+
+	base_ref_iterator_init(ref_iterator, &prefix_ref_iterator_vtable);
+
+	iter->iter0 =3D iter0;
+	iter->prefix =3D xstrdup(prefix);
+	iter->trim =3D trim;
+
+	return ref_iterator;
+}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8ad02d8..fc2088b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -249,6 +249,200 @@ int rename_ref_available(const char *oldname, con=
st char *newname);
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
=20
 /*
+ * Reference iterators
+ *
+ * A reference iterator encapsulates the state of an in-progress
+ * iteration over references. Create an instance of `struct
+ * ref_iterator` via one of the functions in this module.
+ *
+ * A freshly-created ref_iterator doesn't yet point at a reference. To
+ * advance the iterator, call ref_iterator_advance(). If successful,
+ * this sets the iterator's refname, oid, and flags fields to describe
+ * the next reference and returns ITER_OK. The data pointed at by
+ * refname and oid belong to the iterator; if you want to retain them
+ * after calling ref_iterator_advance() again or calling
+ * ref_iterator_abort(), you must make a copy. When the iteration has
+ * been exhausted, ref_iterator_advance() releases any resources
+ * assocated with the iteration, frees the ref_iterator object, and
+ * returns ITER_DONE. If you want to abort the iteration early, call
+ * ref_iterator_abort(), which also frees the ref_iterator object and
+ * any associated resources. If there was an internal error advancing
+ * to the next entry, ref_iterator_advance() aborts the iteration,
+ * frees the ref_iterator, and returns ITER_ERROR.
+ *
+ * The reference currently being looked at can be peeled by calling
+ * ref_iterator_peel(). This function is often faster than peel_ref(),
+ * so it should be preferred when iterating over references.
+ *
+ * Putting it all together, a typical iteration looks like this:
+ *
+ *     int ok;
+ *     struct ref_iterator *iter =3D ...;
+ *
+ *     while ((ok =3D ref_iterator_advance(iter)) =3D=3D ITER_OK) {
+ *             if (want_to_stop_iteration()) {
+ *                     ok =3D ref_iterator_abort(iter);
+ *                     break;
+ *             }
+ *
+ *             // Access information about the current reference:
+ *             if (!(iter->flags & REF_ISSYMREF))
+ *                     printf("%s is %s\n", iter->refname, oid_to_hex(=
&iter->oid));
+ *
+ *             // If you need to peel the reference:
+ *             ref_iterator_peel(iter, &oid);
+ *     }
+ *
+ *     if (ok !=3D ITER_DONE)
+ *             handle_error();
+ */
+struct ref_iterator {
+	struct ref_iterator_vtable *vtable;
+	const char *refname;
+	const struct object_id *oid;
+	unsigned int flags;
+};
+
+/*
+ * Advance the iterator to the first or next item and return ITER_OK.
+ * If the iteration is exhausted, free the resources associated with
+ * the ref_iterator and return ITER_DONE. On errors, free the iterator
+ * resources and return ITER_ERROR. It is a bug to use ref_iterator or
+ * call this function again after it has returned ITER_DONE or
+ * ITER_ERROR.
+ */
+int ref_iterator_advance(struct ref_iterator *ref_iterator);
+
+/*
+ * If possible, peel the reference currently being viewed by the
+ * iterator. Return 0 on success.
+ */
+int ref_iterator_peel(struct ref_iterator *ref_iterator,
+		      struct object_id *peeled);
+
+/*
+ * End the iteration before it has been exhausted, freeing the
+ * reference iterator and any associated resources and returning
+ * ITER_DONE. If the abort itself failed, return ITER_ERROR.
+ */
+int ref_iterator_abort(struct ref_iterator *ref_iterator);
+
+/*
+ * An iterator over nothing (its first ref_iterator_advance() call
+ * returns ITER_DONE).
+ */
+struct ref_iterator *empty_ref_iterator_begin(void);
+
+/*
+ * Return true iff ref_iterator is an empty_ref_iterator.
+ */
+int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
+
+/*
+ * A callback function used to instruct merge_ref_iterator how to
+ * interleave the entries from iter0 and iter1. The function should
+ * return one of the constants defined in enum iterator_selection. It
+ * must not advance either of the iterators itself.
+ *
+ * The function must be prepared to handle the case that iter0 and/or
+ * iter1 is NULL, which indicates that the corresponding sub-iterator
+ * has been exhausted. Its return value must be consistent with the
+ * current states of the iterators; e.g., it must not return
+ * ITER_SKIP_1 if iter1 has already been exhausted.
+ */
+typedef enum iterator_selection ref_iterator_select_fn(
+		struct ref_iterator *iter0, struct ref_iterator *iter1,
+		void *cb_data);
+
+/*
+ * Iterate over the entries from iter0 and iter1, with the values
+ * interleaved as directed by the select function. The iterator takes
+ * ownership of iter0 and iter1 and frees them when the iteration is
+ * over.
+ */
+struct ref_iterator *merge_ref_iterator_begin(
+		struct ref_iterator *iter0, struct ref_iterator *iter1,
+		ref_iterator_select_fn *select, void *cb_data);
+
+/*
+ * An iterator consisting of the union of the entries from front and
+ * back. If there are entries common to the two sub-iterators, use the
+ * one from front. Each iterator must iterate over its entries in
+ * strcmp() order by refname for this to work.
+ *
+ * The new iterator takes ownership of its arguments and frees them
+ * when the iteration is over. As a convenience to callers, if front
+ * or back is an empty_ref_iterator, then abort that one immediately
+ * and return the other iterator directly, without wrapping it.
+ */
+struct ref_iterator *overlay_ref_iterator_begin(
+		struct ref_iterator *front, struct ref_iterator *back);
+
+/*
+ * Wrap iter0, only letting through the references whose names start
+ * with prefix. If trim is set, set iter->refname to the name of the
+ * reference with that many characters trimmed off the front;
+ * otherwise set it to the full refname. The new iterator takes over
+ * ownership of iter0 and frees it when iteration is over. It makes
+ * its own copy of prefix.
+ *
+ * As an convenience to callers, if prefix is the empty string and
+ * trim is zero, this function returns iter0 directly, without
+ * wrapping it.
+ */
+struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *it=
er0,
+					       const char *prefix,
+					       int trim);
+
+/*
+ * Iterate over the packed and loose references in the specified
+ * submodule that are within find_containing_dir(prefix). If prefix is
+ * NULL or the empty string, iterate over all references in the
+ * submodule.
+ */
+struct ref_iterator *files_ref_iterator_begin(const char *submodule,
+					      const char *prefix,
+					      unsigned int flags);
+
+/* Internal implementation of reference iteration: */
+
+/*
+ * Base class constructor for ref_iterators. Initialize the
+ * ref_iterator part of iter, setting its vtable pointer as specified.
+ * This is meant to be called only by the initializers of derived
+ * classes.
+ */
+void base_ref_iterator_init(struct ref_iterator *iter,
+			    struct ref_iterator_vtable *vtable);
+
+/*
+ * Base class destructor for ref_iterators. Destroy the ref_iterator
+ * part of iter and shallow-free the object. This is meant to be
+ * called only by the destructors of derived classes.
+ */
+void base_ref_iterator_free(struct ref_iterator *iter);
+
+/* Virtual function declarations for ref_iterators: */
+
+typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator)=
;
+
+typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
+				 struct object_id *peeled);
+
+/*
+ * Implementations of this function should free any resources specific
+ * to the derived class, then call base_ref_iterator_free() to clean
+ * up and free the ref_iterator object.
+ */
+typedef int ref_iterator_abort_fn(struct ref_iterator *ref_iterator);
+
+struct ref_iterator_vtable {
+	ref_iterator_advance_fn *advance;
+	ref_iterator_peel_fn *peel;
+	ref_iterator_abort_fn *abort;
+};
+
+/*
  * Call fn for each reference in the specified submodule for which the
  * refname begins with prefix. If trim is non-zero, then trim that
  * many characters off the beginning of each refname before passing
--=20
2.8.1
