From: mhagger@alum.mit.edu
Subject: [PATCH v2 00/51] ref-api-C and ref-api-D re-roll
Date: Mon, 12 Dec 2011 06:38:07 +0100
Message-ID: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:39:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyc1-0000LO-0O
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990Ab1LLFja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:39:30 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34516 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab1LLFj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:29 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aD015577;
	Mon, 12 Dec 2011 06:39:08 +0100
X-Mailer: git-send-email 1.7.8
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186824>

From: Michael Haggerty <mhagger@alum.mit.edu>

Following is a re-roll of the combination of the following patch
series:

ref-api-C == mh/ref-api-3 [1]
    [PATCH v2 00/12] Use refs API more consistently

ref-api-D == mh/ref-api-take-2 [2]
    [PATCH 00/28] Store references hierarchically in cache

ref-api-D-fix-v1 [3]
    [PATCH] Fix "is_refname_available(): query only possibly-conflicting references"

It differs from the original patch series in the following ways:

* Re-rolled onto the current master.

* Combined some patches that logically belonged together but were
  split in earlier series (mainly textual changes like variable
  renamings); made other minor cleanups.

* Incorporated ref-api-D-fix-v1 into the commit that it was fixing.

* Removed any changes to the enforcement of refname checks.  The
  earlier patch series included some changes that slightly tightened
  up the checks applied to refnames, and could therefore have
  theoretically caused problems for people whose repositories
  currently include invalid reference names.  Following Junio's
  suggestion, I separated those changes out of this patch series so
  that they can be addressed separately.

Otherwise, this patch series includes the substance of the earlier
patch series, which is basically a change to storing reference-caches
hierarchically and reading loose references lazily.  This, in turn,
brings big performance improvements for repositories with many
references (especially many loose references) [4].

[1] http://permalink.gmane.org/gmane.comp.version-control.git/184368
[2] http://permalink.gmane.org/gmane.comp.version-control.git/184382
[3] http://permalink.gmane.org/gmane.comp.version-control.git/185423
[4] http://permalink.gmane.org/gmane.comp.version-control.git/185541

Michael Haggerty (51):
  struct ref_entry: document name member
  refs: rename "refname" variables
  refs: rename parameters result -> sha1
  clear_ref_array(): rename from free_ref_array()
  is_refname_available(): remove the "quiet" argument
  parse_ref_line(): add docstring
  add_ref(): add docstring
  is_dup_ref(): extract function from sort_ref_array()
  refs: change signatures of get_packed_refs() and get_loose_refs()
  get_ref_dir(): change signature
  resolve_gitlink_ref(): improve docstring
  Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
  resolve_gitlink_ref_recursive(): change to work with struct ref_cache
  repack_without_ref(): remove temporary
  create_ref_entry(): extract function from add_ref()
  add_ref(): take a (struct ref_entry *) parameter
  do_for_each_ref(): correctly terminate while processesing extra_refs
  do_for_each_ref_in_array(): new function
  do_for_each_ref_in_arrays(): new function
  repack_without_ref(): reimplement using do_for_each_ref_in_array()
  names_conflict(): new function, extracted from is_refname_available()
  names_conflict(): simplify implementation
  is_refname_available(): reimplement using do_for_each_ref_in_array()
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

 cache.h |    6 +-
 refs.c  | 1569 ++++++++++++++++++++++++++++++++++++++++----------------------
 refs.h  |   41 +-
 3 files changed, 1041 insertions(+), 575 deletions(-)

-- 
1.7.8
