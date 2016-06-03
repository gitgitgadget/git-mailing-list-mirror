From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/38] Virtualization of the refs API
Date: Fri,  3 Jun 2016 23:03:35 +0200
Message-ID: <cover.1464983301.git.mhagger@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Fri Jun 03 23:07:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wJE-0002Gf-Oz
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbcFCVHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 17:07:08 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47035 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932807AbcFCVE1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:27 -0400
X-AuditID: 1207440d-bc7ff7000000090b-ad-5751f0d72226
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id D0.32.02315.7D0F1575; Fri,  3 Jun 2016 17:04:24 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4KcQ003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:21 -0400
X-Mailer: git-send-email 2.8.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqHvjQ2C4wYV/LBbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M7Yd/8te0GjTsWcM/wNjKtUuhg5
	OSQETCTev3zF1MXIxSEksJVRYveqp4wQznEmiY9X97KCVLEJ6Eos6mlmArFFBCIkGl61gBUx
	C8xhkrj9sJMZJCEsYCpx8VIrG4jNIqAq8WXFNHYQm1fAXOL0zYuMEOvkJC5Pf8AGEReUODnz
	CUsXIwfQIHWJ9fOEQMLMAvISzVtnM09g5J2FpGoWQtUsJFULGJlXMcol5pTm6uYmZuYUpybr
	Ficn5uWlFuka6eVmluilppRuYoQENO8Oxv/rZA4xCnAwKvHwnngRGC7EmlhWXJl7iFGSg0lJ
	lHfvHaAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6U10A53pTEyqrUonyYlDQHi5I4r9oSdT8h
	gfTEktTs1NSC1CKYrAwHh5IE76L3QI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnx
	oPiKLwZGGEiKB2jvOZB23uKCxFygKETrKUZFKXHeQyAJAZBERmke3FhYmnrFKA70pTDvbZAq
	HmCKg+t+BTSYCWhwwSN/kMEliQgpqQbGnqXcPK+237pS3fTStH1+ykwG69ySgkaWfZ0HVxq3
	PN23Q4q5ft95p7MZCutuVXobzs1pVLB4uCbYRMnD63E8++pK28W9tnzz3+8+P1M5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296409>

Since the that ref-iterator [1] changes seem to have gotten a positive
reception, let's try to keep up the momentum. I hope I'm not
overloading the review pipeline...

I think all of the groundwork is in place now to virtualize the refs
API. This will open the way to storing refs in ways other than the
familiar loose refs / packed refs format, such as David Turner's
proposed LMDB-based storage [2].

This is a long patch series, but most of the patches are pretty simple
and formulaic. The goal is to implement a `ref_store`. In the language
of object-oriented programming, `ref_store` is an abstract base class
representing a reference storage backend. It provides methods to read,
write, and delete references and symrefs, and to iterate over
references, reflogs, and reflog entries, plus a number of other
things=E2=80=9419 methods in all.

The one concrete implementation of this class is files_ref_store,
which implements the traditional loose/packed refs scheme with
caching. After this patch series, about the only things left in
`refs/files-backend.c` with external linkage are vtables.

On these 19 methods are built the refs API as used by the rest of Git.
The OO interface is not exposed; instead, the OO implementation is
wrapped in traditional C functions. In fact, this patch series doesn't
change the existing public interface at all, and adds only two new
functions!

Somebody who wants to implement a new way to store references needs to
implement a new class derived from `ref_store`, including its 19
methods, plus one or two supporting ref_iterator classes, and wire it
up to be instantiated when needed.

This patch series opens up a lot of possibilities for improving the
internal design of the files backend; I've described some of my plans
in recent emails [3,4]. But that can be done separately; for now, the
main point of this series is to clear the way for LMDB-based reference
storage.

This patch series owes a lot to Ronnie Sahlberg and David Turner, who
wrote earlier drafts along the same basic lines. The current patch
series differs from theirs in many details of where exactly to draw
the line of abstraction. But the most important difference in my
opinion is that this series allows multiple ref_stores of different
types to coexist. I think this is important for the UI (for example,
if somebody converts a submodule to use a different reference storage
scheme than the umbrella repository uses), but also because it allows
ref_stores to be compounded together internally to decrease the
coupling between different parts of the system. I've tried to retain
their authorship of any patches that are more or less recognizable
from their versions (hopefully without introducing any bugs!) But the
spirit of their versions permeates this patch series. Thanks a lot to
both of you!

This series applies on top of the "ref-iterator v2" series that I just
submitted [1]. It can also be obtained from my GitHub repo [5] as
branch "ref-store".

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/296322
[2] http://thread.gmane.org/gmane.comp.version-control.git/286572
[3] http://thread.gmane.org/gmane.comp.version-control.git/295961/focus=
=3D296096
[4] http://thread.gmane.org/gmane.comp.version-control.git/295961/focus=
=3D296186
[5] https://github.com/mhagger/git

David Turner (8):
  rename_ref_available(): add docstring
  refs: add methods for reflog
  refs: add method for initial ref transaction commit
  refs: add method for delete_refs
  refs: add methods to init refs db
  refs: add method to rename refs
  refs: make lock generic
  refs: implement iteration over only per-worktree refs

Michael Haggerty (28):
  resolve_gitlink_ref(): eliminate temporary variable
  refs: rename struct ref_cache to files_ref_store
  refs: create a base class "ref_store" for files_ref_store
  add_packed_ref(): add a files_ref_store argument
  get_packed_ref(): add a files_ref_store argument
  resolve_missing_loose_ref(): add a files_ref_store argument
  {lock,commit,rollback}_packed_refs(): add files_ref_store arguments
  refs: reorder definitions
  resolve_packed_ref(): rename function from resolve_missing_loose_ref(=
)
  resolve_gitlink_packed_ref(): remove function
  read_raw_ref(): take a (struct ref_store *) argument
  resolve_ref_recursively(): new function
  resolve_gitlink_ref(): implement using resolve_ref_recursively()
  resolve_gitlink_ref(): avoid memory allocation in many cases
  resolve_gitlink_ref(): rename path parameter to submodule
  refs: make read_raw_ref() virtual
  refs: make verify_refname_available() virtual
  refs: make pack_refs() virtual
  refs: make create_symref() virtual
  refs: make peel_ref() virtual
  repack_without_refs(): add a files_ref_store argument
  lock_raw_ref(): add a files_ref_store argument
  commit_ref_update(): add a files_ref_store argument
  lock_ref_for_update(): add a files_ref_store argument
  lock_ref_sha1_basic(): add a files_ref_store argument
  split_symref_update(): add a files_ref_store argument
  files_ref_iterator_begin(): take a ref_store argument
  refs: add method iterator_begin

Ronnie Sahlberg (2):
  refs: add a backend method structure
  refs: add a transaction_commit() method

 builtin/init-db.c    |  21 +-
 refs.c               | 294 +++++++++++++++++++++++++-
 refs.h               |  13 +-
 refs/files-backend.c | 567 +++++++++++++++++++++++++++----------------=
--------
 refs/refs-internal.h | 213 +++++++++++++++++--
 5 files changed, 799 insertions(+), 309 deletions(-)

--=20
2.8.1
