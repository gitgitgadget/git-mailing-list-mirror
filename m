From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/17] Remove assumptions about refname lifetimes
Date: Sun, 19 May 2013 22:26:55 +0200
Message-ID: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:27:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeACq-00044J-Ca
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469Ab3ESU1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:27:44 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:55026 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754167Ab3ESU1n (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:27:43 -0400
X-AuditID: 1207440f-b7f0e6d000000957-c7-519935be0f5f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F0.6C.02391.EB539915; Sun, 19 May 2013 16:27:42 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5J026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:27:40 -0400
X-Mailer: git-send-email 1.8.2.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsUixO6iqLvPdGagwbQmVYuuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MDqwef99/YPK49PI7m8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ2xY1ZpwR+ViotPdjI2MJ6V7WLk5JAQMJFoabnFBGGLSVy4t56ti5GLQ0jgMqPE/TUt
	LBDOeSaJq7v2sYJUsQnoSizqaQbrEBGQlfh+eCMjiM0sMIFRYml/IYgtLOAo0b5jKTOIzSKg
	KrF69gWwel4BF4mvr/8wQmxTkLg8aw3zBEbuBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0
	TfRyM0v0UlNKNzFCQoR/B2PXeplDjAIcjEo8vBrvpgcKsSaWFVfmHmKU5GBSEuV9ZzIzUIgv
	KT+lMiOxOCO+qDQntfgQowQHs5II7x4hoBxvSmJlVWpRPkxKmoNFSZxXfYm6n5BAemJJanZq
	akFqEUxWhoNDSYLXHWSoYFFqempFWmZOCUKaiYMTRHCBbOAB2nAfpJC3uCAxtzgzHaLoFKOi
	lDjvRZCEAEgiozQPbgAsml8xigP9I8x7BKSKB5gI4LpfAQ1mAhrMem0qyOCSRISUVAOj66yt
	Jyaa/wqV3GgavyBeeeuMvim2dS/kDS0n+Mpl/lCK3/Yv51LJu9k1PgyHEzVWW8RJXc19IB/c
	qS/3nb/prULL97z8CYHZVYUl/9ddqlBffemi/O2pxZt//b7z1/7XohO8M/u/hbhU8+xdpOFz
	f0MQT8GB0O/pWdf77+c1OyU9/LXIKPiAEktxRqKhFnNRcSIAd8FIx8ECAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224906>

Prior to this patch series, the refs API said nothing about the
lifetime of the refname parameter passed to each_ref_fn callbacks by
the for_each_ref()-style iteration functions.  De facto, the refnames
usually had long lives because they were pointers into the ref_cache
data structures, and those are only invalidated under rare
circumstances.  And some callers were assuming a long lifetime, for
example storing references to the refname string instead of copying
it.

But it has long been the case that ref caches could be invalidated,
for example when a packed ref is deleted.  AFAIK there was never much
clarity about what that might mean for callers.

Recently a number of race conditions related to references have been
discovered.  There is likely to be a two-pronged solution to the
races:

* For traditional, filesystem-based references, there will have to be
  more checks that the ref caches are still up-to-date at the time of
  their use (see, for example, [1]).  If not, the ref cache will have
  to be invalidated and reloaded.  Assuming that the invalidation of
  the old cache includes freeing its memory, such an invalidation will
  cause lots of refname strings to be freed even though callers might
  still hold references to them.

* For server-class installations, filesystem-based references might
  not be robust enough for 100% reliable operation, because the
  reading of the complete set of references is not an atomic
  operation.  If another reference storage mechanism is developed,
  there is no reason to expect the refnames strings to have long
  lifetimes.

A prerequisite for either of these approaches is to harmonize what
callers assume and what the API guarantees.

The purpose of this patch series is to track down callers who assume
that the refnames that they receive via a each_ref_fn callback have
lifetimes beyond the duration of the callback invocation and to
rewrite them to work without that assumption.  The final patch
documents explicitly that callers should not retain references to the
refnames.

A word about how I audited the code:

To find callers making unwarranted assumptions, I (temporarily)
changed do_one_ref() to do a xstrdup() of the refname, pass the copy
to the callback function, then free() the copy.  This caused
ill-behaved callers to access freed memory, which could be detected by
running the testsuite under valgrind.  There were indeed a number of
such errors.  All of them are fixed by this patch series, and the test
just described now runs without errors.

I plan to do a second audit by hand to see if the test suite and/or
valgrind missed anything.

The last two patches are RFCs.  I would like some input on the second
to last because I am not very familiar with how the object array entry
names are used, how many might be created, etc.  The last patch is an
illustration of how I would like to change the API docs, but it will
only be ready when all of the code has been audited and adapted.
Please see especially my comments on these two patches for more
information.

[1] http://thread.gmane.org/gmane.comp.version-control.git/223299

Michael Haggerty (17):
  describe: make own copy of refname
  fetch: make own copies of refnames
  add_rev_cmdline(): make a copy of the name argument
  builtin_diff_tree(): make it obvious that function wants two entries
  cmd_diff(): use an object_array for holding trees
  cmd_diff(): rename local variable "list" -> "entry"
  cmd_diff(): make it obvious which cases are exclusive of each other
  revision: split some overly-long lines
  gc_boundary(): move the check "alloc <= nr" to caller
  get_revision_internal(): make check less mysterious
  object_array: add function object_array_filter()
  object_array_remove_duplicates(): rewrite to reduce copying
  fsck: don't put a void*-shaped peg in a char*-shaped hole
  find_first_merges(): initialize merges variable using initializer
  find_first_merges(): remove unnecessary code
  object_array_entry: copy name before storing in name field
  refs: document the lifetime of the refname passed to each_ref_fn

 builtin/describe.c |  6 +++--
 builtin/diff.c     | 68 ++++++++++++++++++++++++++----------------------------
 builtin/fetch.c    |  4 ++--
 builtin/fsck.c     |  2 +-
 object.c           | 50 +++++++++++++++++++++++++++++++--------
 object.h           | 23 ++++++++++++++++--
 refs.h             | 22 +++++++++++++-----
 revision.c         | 61 +++++++++++++++++++++++++-----------------------
 revision.h         | 32 ++++++++++++++++---------
 submodule.c        |  6 ++---
 10 files changed, 172 insertions(+), 102 deletions(-)

-- 
1.8.2.3
