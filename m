From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/12] Fix some reference-related races
Date: Tue, 11 Jun 2013 23:48:20 +0200
Message-ID: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:48:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWQz-0003gs-G3
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab3FKVsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 17:48:53 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50736 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753253Ab3FKVsw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 17:48:52 -0400
X-AuditID: 12074413-b7f136d000006de1-9a-51b79b43986f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id BB.45.28129.34B97B15; Tue, 11 Jun 2013 17:48:51 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BLmbio015717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 17:48:49 -0400
X-Mailer: git-send-email 1.8.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsUixO6iqOs8e3ugwal7MhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTtjw6HlLAWnlSt2vDrK3MC4Q6aLkYNDQsBE4uKVjC5GTiBTTOLCvfVsXYxcHEIClxkl
	JvRNZ4FwLjBJnPh1hQmkik1AV2JRTzOYLSKgJjGx7RBYEbNAO6PEu+Z9zCBThQXMJR7e8gep
	YRFQlXi/8C8biM0r4CyxaPlrVohtchLv7+ximcDIvYCRYRWjXGJOaa5ubmJmTnFqsm5xcmJe
	XmqRrrlebmaJXmpK6SZGSIgI72DcdVLuEKMAB6MSD6+E5fZAIdbEsuLK3EOMkhxMSqK8bNOA
	QnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4dXOBcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp
	2ampBalFMFkZDg4lCd6QWUCNgkWp6akVaZk5JQhpJg5OEMEFsoEHaAMfSCFvcUFibnFmOkTR
	KUZFKXHeFJCEAEgiozQPbgAsml8xigP9I8zrDVLFA0wEcN2vgAYzAQ0uygAbXJKIkJJqYJwQ
	4OPXoLaqJkqApdOCiy/SYoWLraZlhtj9t0zzDY9oFkRN+P5sgYaZbdy3jM1r8/Nu+t7ln6AQ
	Ls/dufZ3yyaDcxGn635lTPp5yGZZeZT7nkkFLTklbvHzhHt/12cJqQlsW/0ksuaRnkdL4wxz
	Wc0LH3MlI7wuiF6Uzn+yzbmZ81rH/oMHlViKMxINtZiLihMB2OD2GMECAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227519>

*This patch series must be built on top of mh/reflife.*

This patch series fixes some races reading loose and packed refs.
Most of the problems, and some of the solutions, were pointed out by
Jeff King [1] but some other work was necessary to prevent his fixes
from causing problems elsewhere.

The basic race being addressed is that at any time "pack-refs --prune"
might be run at any time.  It rewrites the packed-refs file and then
deletes the just-packed loose refs.

Readers, then, to get a self-consistent snapshot of references [2],
must be sure to read all of the loose references it will need *before*
reading the packed references (or at least verifying that the packed
references that it read earlier are still valid).  But given the
lazy-loading of the loose references cache, this was not always the
case.

So the core of this patch series is to force loose references for an
iteration to be read all at once into the cache, and *then* to verify
that the packed-refs cache is up-to-date and if not to reload it.
Similarly, when looking up single references, a loose reference is
sought first, and then the validity of the packed-refs cache is
verified, and then the loose reference is sought in the cache.

The problem is that there was a lot of code that assumed that the
lifetime of the reference cache was essentially infinite.  The
mh/reflife patch series (which has made it to next) fixed callers who
retained pointers to refnames in the cache.

The other problem was that the for_each_ref() functions will die if
the ref cache that they are iterating over is freed out from under
them.  This problem is solved by using reference counts to avoid
freeing the old packed ref cache (even if it is no longer valid) until
all users are done with it.

Once those are done, it is possible to invalidate the packed refs
cache when needed.  So (1) we always read all loose references that
will be needed in an iteration before the iteration starts, and (2) we
add a check (based on file metadata) whenever the packed-refs cache is
accessed that it is still up-to-date WRT the packed-refs file, and if
not reread it (but leave the old copy in memory as long as its
refcount is nonzero).

Along the way, this patch series adds simple transactions around the
packed-refs file/cache.  The transaction interface is public.  I think
this is a step in a good direction, because other race conditions not
addressed by this patch series are likely to require transactions
across the whole reference namespace to be made 100% reliable.

As a stress test, the test suite can be run with a simulated
"hyperactive repository" in which the packed-refs file is made to look
like it changes every time it is checked (except when its lock is
held):

    ------------------------------------ refs.c ------------------------------------
    @@ -1075,8 +1075,8 @@ static struct packed_ref_cache *get_packed_ref_cache(struct ref_cache *refs)
     	else
     		packed_refs_file = git_path("packed-refs");

    -	if (refs->packed &&
    -	    !stat_validity_check(&refs->packed->validity, packed_refs_file))
    +	if (refs->packed && !refs->packed->lock
    +	    /*!stat_validity_check(&refs->packed->validity, packed_refs_file)*/)
     		clear_packed_ref_cache(refs);

     	if (!refs->packed) {


It passes the stress test.

[1] http://thread.gmane.org/gmane.comp.version-control.git/223299/focus=223526

Jeff King (2):
  get_packed_ref_cache: reload packed-refs file when it changes
  for_each_ref: load all loose refs before packed refs

Michael Haggerty (10):
  repack_without_ref(): split list curation and entry writing
  pack_refs(): split creation of packed refs and entry writing
  refs: wrap the packed refs cache in a level of indirection
  refs: implement simple transactions for the packed-refs file
  refs: manage lifetime of packed refs cache via reference counting
  do_for_each_entry(): increment the packed refs cache refcount
  packed_ref_cache: increment refcount when locked
  Extract a struct stat_data from cache_entry
  add a stat_validity struct
  refs: do not invalidate the packed-refs cache unnecessarily

 builtin/clone.c    |   7 +-
 builtin/ls-files.c |  12 ++-
 cache.h            |  60 +++++++++--
 read-cache.c       | 181 +++++++++++++++++++------------
 refs.c             | 308 ++++++++++++++++++++++++++++++++++++++++++++---------
 refs.h             |  27 ++++-
 6 files changed, 464 insertions(+), 131 deletions(-)

-- 
1.8.3
