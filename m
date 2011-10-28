From: mhagger@alum.mit.edu
Subject: [PATCH 00/28] Store references hierarchically in cache
Date: Fri, 28 Oct 2011 14:28:13 +0200
Message-ID: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:29:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlZI-0003uv-QE
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666Ab1J1M3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:29:31 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55677 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755565Ab1J1M2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:28:50 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-CT; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184382>

From: Michael Haggerty <mhagger@alum.mit.edu>

This patch series applies on top of v3 of "Use refs API more
consistently", which ultimately branches from gitster/master.

This patch series changes how references are stored in the reference
cache data structures (entirely internal to refs.c).  Previously, the
packed refs were stored in one big array of pointers-to-struct, and
the loose refs were stored in another.  This had a few problems:

* Whenever any loose refs were needed, the whole refs tree had to be
  read from disk into memory.  This can be quite expensive when there
  are a lot of loose references.  And it is often overkill, as
  frequently only a small part of the refs tree is needed.  For
  example:

  * refs/replace is almost *always* needed even though it often
    doesn't even exist.  Thus the presence of many loose references
    slows down *many* git commands for no reason whatsoever.

  * When a new reference is created, is_refname_available() is called
    to see whether there is another another reference whose name
    conflicts with the new one.  Currently this loads and iterates
    through *all* references.  But there are only a few refnames that
    can possibly conflict; for example, given the refname
    "refs/heads/foo/bar", the only possible conflicts are with
    "refs/heads/foo" and "refs/heads/foo/bar/*".  Therefore it is
    silly to load and iterate through the whole refname hierarchy.

  * "git for-each-ref" is capable of searching a subtree of the
    references.  But currently this causes all references to be
    loaded.

Therefore, this patch series changes the data structure used to store
the reference cache from a single array of pointers-to-struct into a
tree-like structure in which each subdirectory of the reference
namespace is stored as an array of pointers-to-entry and entries can
be either references or subdirectories containing more references.
Moreover, each subdirectory of loose references is only read from disk
when a reference from that subdirectory (or one of its descendants) is
needed.  This slightly slows down commands that need to iterate
through all references (simply because the new data structures are
more complicated), but it *dramatically* decreases the time needed for
some common operations.  For example, in a test repository with 20000
revisions and 10000 loose tags:

* the time to create a new branch goes from 180 ms to less than 10 ms
  (my test resolution only includes two decimal places) and the time
  to checkout a new branch does the same.

* the time for a "git filter-branch" of all commits (which used to
  scale like N^2) goes from 4 hours to 13 minutes.  (Since
  filter-branch necessarily *creates* lots of loose references, the
  savings are also there if the references are originally packed.)

The efficiency gains are such that some operations are now faster with
loose references than with packed references; however, some operations
with packed references slow down a bit.

These changes do not increase the amount of space per reference needed
for the reference cache, but they do add one similarly-sized entry for
each subdirectory (for each of loose and packed).  I don't think that
the space increase should be significant in any reasonable situation.

After these changes, there is a benefit to sharding the reference
namespace, especially for loose references.


The patches:

The first few patches are just preparation.

Patch 6 "refs: store references hierarchically" introduces the big
data structure change.  It causes much extra sorting to be done and
therefore slows down performance significantly, but the following two
commits restore performance to approximately the old level.

Patches 11-24 change most of the internal functions to work with
"struct ref_entry *" (namely the kind of ref_entry that holds a
directory of references) instead of "struct ref_dir *".  The reason
for this change it to allow these functions access to the "flag" and
"name" fields that are stored in ref_entry and thereby avoid having to
store redundant information in "struct ref_dir" (which would increase
the size of *every* ref_entry because of its presence in the union).

The other patches (9-10 and 25-28) reap the benefits of the new data
structure:

* do_for_each_ref() can iterate only over the desired subtree instead
  of iterating over all references and filtering out the unwanted ones

* loose references can be read on demand, one directory at a time

* is_refname_available() can query only the possibly-conflicting parts
  of the reference namespace

Michael Haggerty (28):
  refs.c: reorder definitions more logically
  free_ref_entry(): new function
  check_refname_component(): return 0 for zero-length components
  struct ref_entry: nest the value part in a union
  refs.c: rename ref_array -> ref_dir
  refs: store references hierarchically
  sort_ref_dir(): do not sort if already sorted
  refs: sort ref_dirs lazily
  do_for_each_ref(): only iterate over the subtree that was requested
  get_ref_dir(): keep track of the current ref_dir
  refs: wrap top-level ref_dirs in ref_entries
  get_packed_refs(): return (ref_entry *) instead of (ref_dir *)
  get_loose_refs(): return (ref_entry *) instead of (ref_dir *)
  is_refname_available(): take (ref_entry *) instead of (ref_dir *)
  find_ref(): take (ref_entry *) instead of (ref_dir *)
  read_packed_refs(): take (ref_entry *) instead of (ref_dir *)
  add_ref(): take (ref_entry *) instead of (ref_dir *)
  find_containing_direntry(): use (ref_entry *) instead of (ref_dir *)
  search_ref_dir(): take (ref_entry *) instead of (ref_dir *)
  add_entry(): take (ref_entry *) instead of (ref_dir *)
  do_for_each_ref_in_dir*(): take (ref_entry *) instead of (ref_dir *)
  sort_ref_dir(): take (ref_entry *) instead of (ref_dir *)
  struct ref_dir: store a reference to the enclosing ref_cache
  read_loose_refs(): take a (ref_entry *) as argument
  refs: read loose references lazily
  is_refname_available(): query only possibly-conflicting references
  read_packed_refs(): keep track of the directory being worked in
  repack_without_ref(): call clear_packed_ref_cache()

 refs.c | 1268 ++++++++++++++++++++++++++++++++++++++++++---------------------
 refs.h |    7 +-
 2 files changed, 850 insertions(+), 425 deletions(-)

-- 
1.7.7
