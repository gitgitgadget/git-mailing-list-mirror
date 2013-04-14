From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/33] Various cleanups around reference packing and peeling
Date: Sun, 14 Apr 2013 14:54:15 +0200
Message-ID: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:55:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMSy-000411-44
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab3DNMzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:18 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:52896 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751824Ab3DNMzQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:16 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-44-516aa733bf23
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 84.D8.02380.337AA615; Sun, 14 Apr 2013 08:55:15 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAjv007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:13 -0400
X-Mailer: git-send-email 1.8.2.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqGu8PCvQoP+FiUXXlW4mi4beK8wW
	Kx/fZba4vWI+s8WPlh5mB1aPv+8/MHm0v3/H7PGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGf8bz/AXnBKoeJl3232BsY+qS5GDg4JAROJZzvVuhg5gUwxiQv31rN1MXJxCAlcZpRY
	sP8wK4Rzlkni54zH7CBVbAK6Eot6mplAmkUEsiV2r5UHCTMLOEhs/tzICGILC/hIrD4/A6yc
	RUBVYvXq/2BxXgEXiX8bZrNDLFOQOL59G+MERu4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JS
	i3SN9XIzS/RSU0o3MUIChG8HY/t6mUOMAhyMSjy8LxizAoVYE8uKK3MPMUpyMCmJ8p5cBhTi
	S8pPqcxILM6ILyrNSS0+xCjBwawkwuvYCpTjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1O
	TS1ILYLJynBwKEnwpoMMFSxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAeFeXwxMNBB
	UjxAe+eBtPMWFyTmAkUhWk8x6nLM2vrkNaMQS15+XqqUOG8KSJEASFFGaR7cClg6eMUoDvSx
	MO80kCoeYCqBm/QKaAkT0BKfvekgS0oSEVJSDYxqJxznPf28bb+vzpy93BrBP5Xebts/6Y1e
	uHpM8w9up4dhE8zCj/z/cGvbzduHHdR2lAq0OEz2eLD0eq2sgfW/R7YbBD0u8F1Q+KNZ7WGd
	+Tf39XIT//XvDsnZyXa8dn+34KyxiLTn3wKFN/bZm4Jy/mfPPL3GeatFKUf01NUT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221100>

The highlight of this patch series are that (1) peeled references are
not lost from the packed-refs file when a packed reference is deleted
and (2) there is more code sharing between the code used by "git
packed-refs" and the code used by repack_without_ref() for deleting a
packed reference.  Along the way I have added a lot of documentation
and fixed several smaller bugs.

I had to add some sleeps in test t3210 but I hope that somebody can
find a way to eliminate them.

The last patch implements a change that I brushed off a long time ago
when Heiko suggested it.  He was right (probably not for performance
reasons, but because it simplifies the code).

Summary:

Patches 1-4 document existing code.

Patches 5-6 random cleanup.

Patches 7-9 change the semantics of get_packed_ref() to make it more
reusable and change other locations to use this function.

Patch 10 extracts a function ref_resolves_to_object().

Patches 11-14 unify reference-peeling in two new functions,
peel_object() and peel_entry() (and fix an inconsistency in
peel_ref()).

Patch 15 introduces a new internal reference-iteration API and adjusts
some internal code to use it.  The new API gives the callback function
direct access to the ref_entry.  This corrects the handling of
current_ref during an iteration over only packed references.

Patches 16-17 add and fix a test of a spurious error message.

Patches 18-22 change the reference-deleting code to write peeled refs
to the packed-refs file.  (Previously, whenever a packed reference was
deleted, all of the peeled values were lost when the packed-refs file
was rewritten.)

Patches 23-31 move the code from pack-refs.{c,h} into refs.{c,h},
adjust it to its new surroundings, and change it to share some code
with repack_without_ref().

Patches 32-33 simplify access to the main reference cache.

Michael Haggerty (33):
  refs: document flags constants REF_*
  refs: document the fields of struct ref_value
  refs: document do_for_each_ref() and do_one_ref()
  refs: document how current_ref is used
  refs: define constant PEELED_LINE_LENGTH
  do_for_each_ref_in_dirs(): remove dead code
  get_packed_ref(): return a ref_entry
  peel_ref(): use function get_packed_ref()
  repack_without_ref(): use function get_packed_ref()
  refs: extract a function ref_resolves_to_object()
  refs: extract function peel_object()
  peel_object(): give more specific information in return value
  peel_ref(): fix return value for non-peelable, not-current reference
  refs: extract a function peel_entry()
  refs: change the internal reference-iteration API
  t3210: test for spurious error messages for dangling packed refs
  repack_without_ref(): silence errors for dangling packed refs
  search_ref_dir(): return an index rather than a pointer
  refs: change how packed refs are deleted
  t3211: demonstrate loss of peeled refs if a packed ref is deleted
  repack_without_ref(): write peeled refs in the rewritten file
  refs: extract a function write_packed_entry()
  pack-refs: rename handle_one_ref() to pack_one_ref()
  pack-refs: merge code from pack-refs.{c,h} into refs.{c,h}
  pack_one_ref(): rename "path" parameter to "refname"
  refs: use same lock_file object for both ref-packing functions
  pack_refs(): change to use do_for_each_entry()
  refs: inline function do_not_prune()
  pack_one_ref(): use function peel_entry()
  pack_one_ref(): use write_packed_entry() to do the writing
  pack_one_ref(): do some cheap tests before a more expensive one
  refs: change do_for_each_*() functions to take ref_cache arguments
  refs: handle the main ref_cache specially

 Makefile             |   2 -
 builtin/clone.c      |   1 -
 builtin/pack-refs.c  |   2 +-
 pack-refs.c          | 148 -----------
 pack-refs.h          |  18 --
 refs.c               | 699 ++++++++++++++++++++++++++++++++++++++-------------
 refs.h               |  35 +++
 t/t3210-pack-refs.sh |  36 +++
 t/t3211-peel-ref.sh  |   9 +
 9 files changed, 609 insertions(+), 341 deletions(-)
 delete mode 100644 pack-refs.c
 delete mode 100644 pack-refs.h

-- 
1.8.2.1
