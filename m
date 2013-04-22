From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/33] Various cleanups around reference packing and peeling
Date: Mon, 22 Apr 2013 21:52:08 +0200
Message-ID: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:53:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMno-0004IU-5p
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964Ab3DVTxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:53:24 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:50314 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754910Ab3DVTxX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:23 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-bd-51759531a160
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 5B.64.02295.13595715; Mon, 22 Apr 2013 15:53:21 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOD008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:19 -0400
X-Mailer: git-send-email 1.8.2.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqGs4tTTQ4E2XrkXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGcsuzSTvWC/bMWxDTeZGhg3
	i3cxcnJICJhIPJ1znRnCFpO4cG89WxcjF4eQwGVGiTXvT7FCOBeYJGa0vmYCqWIT0JVY1NMM
	ZosIqElMbDvEAmIzCzhIbP7cyAhiCwv4S3w5uxashkVAVeLA2g1Agzg4eAVcJKZ+NIZYpiBx
	fPs2xgmM3AsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrq5WaW6KWmlG5ihPieZwfjt3Uy
	hxgFOBiVeHgF3EsDhVgTy4orcw8xSnIwKYnyckwBCvEl5adUZiQWZ8QXleakFh9ilOBgVhLh
	Fc0HyvGmJFZWpRblw6SkOViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiUJHgzQIYKFqWmp1ak
	ZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEgwI9vhgY6iApHqC9kSDtvMUFiblAUYjWU4y6HLO2
	PnnNKMSSl5+XKiXOWz0JqEgApCijNA9uBSzSXzGKA30szDsJZBQPMEnATXoFtIQJaElmQgnI
	kpJEhJRUA6OE3kWdsjuLn6jacL3esk69Oum7XLqSJ8MqwYfXGv91Gvb/M3igwf2pTead6bqf
	1f+Es2VNJ2r19t664XZ63+FpJ+7nFAbZ/86WlS/59ln1+/2U1jkTvq1cMF8zvkDjYw6n5ecf
	UpfXLOTpnrdy/pJLBpt+8c7zeC3KI7/DsN3KLnyFZdaXKeJKLMUZiYZazEXFiQDy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222050>

Thanks for the feedback; here is a re-roll.  A number of points
discussed on the mailing list were fixed.  The main change, in patch
17, is how repack_without_ref() deals with references that cannot be
peeled when re-writing the packed-refs file:

if ISBROKEN:
    emit an error and omit reference from the output
else if !has_sha1_file(...):
    if there is an overriding loose reference:
        silently omit reference from the output
    else:
        emit an error and omit reference from the output

Please note that this creates a relatively harmless race condition
very similar to the ones discussed for pack-refs; see the commit
message for patch 17 for a long explanation.  I would like to fix all
of the races as part of a separate patch series.

For now I left the sleeps in t3210.  Given that the problem will be
solved by topic jc/prune-all, building a fancier workaround into this
test for the old broken --expire behavior seems like a waste of time.
I propose that the sleeps be removed when this patch series is merged
with jc/prune-all.  (In fact, when jc/prune-all is landed, other tests
can also be simplified.)  If this suggestion is not ok, then the
easiest thing would probably be to remove the sleeps immediately and
declare jc/prune-all a prerequisite of this series.

I also removed the trailing comma from the "enum peel_status"
definition, because a recent email on the mailing list claimed that
some compilers don't like them.

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
 refs.c               | 733 +++++++++++++++++++++++++++++++++++++++------------
 refs.h               |  35 +++
 t/t3210-pack-refs.sh |  36 +++
 t/t3211-peel-ref.sh  |   9 +
 9 files changed, 643 insertions(+), 341 deletions(-)
 delete mode 100644 pack-refs.c
 delete mode 100644 pack-refs.h

-- 
1.8.2.1
