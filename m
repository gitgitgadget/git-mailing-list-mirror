From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/29] Yet more preparation for reference backends
Date: Wed, 27 Apr 2016 18:57:17 +0200
Message-ID: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:05:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avStv-0006Di-2B
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 19:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbcD0RFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 13:05:16 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58768 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752757AbcD0RFO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 13:05:14 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Apr 2016 13:05:14 EDT
X-AuditID: 1207440e-f07ff700000008c5-4f-5720ef9a8127
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 79.8F.02245.A9FE0275; Wed, 27 Apr 2016 12:58:02 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6D022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:57:59 -0400
X-Mailer: git-send-email 2.8.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqDvrvUK4wY4tOhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxznzgLOrwrrqyexNjAuNymi5GTQ0LAROLwjnus
	XYxcHEICWxklfny5yQjhHGeS2H76DTNIFZuArsSinmYmEFtEwEFi+cpf7CBFzAJNTBLflzex
	gCSEBZwkDp5byAZiswioSqztP84KYvMKmEtsXLSDGWKdnMTl6Q/YJjByLWBkWMUol5hTmqub
	m5iZU5yarFucnJiXl1qka6yXm1mil5pSuokREjJ8Oxjb18scYhTgYFTi4S2QUAgXYk0sK67M
	PcQoycGkJMq75CxQiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv9DdAOd6UxMqq1KJ8mJQ0B4uS
	OK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBK/ZO6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU
	1KLE0pKMeFBIxxcDgxokxQO0989bkL3FBYm5QFGI1lOMilLivK4gCQGQREZpHtxYWCJ4xSgO
	9KUwbxDIdh5gEoHrfgU0mAlo8OVDsiCDSxIRUlINjEJqpru+VtpoPtmx/zynze1rn1X75i1L
	DLpz4uB7vgx2oXg3d6+MX5Om6SpIf54YLRVdd33bnaMLZL+z8W6aufQX77tI219vHjqKfq5j
	XbLkaqrnzpSC2wls1yfvkHjrbXGvdHNlq4uTx+WHV9ltz+z+zau53uxGm87py1+e 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292772>

This started as a modest attempt to move the last couple of patches
mentioned here [1] to before the vtable patches. I wanted to do that
because having real changes mixed with the vtable refactoring was
making rebasing and stuff awkward.

But then it snowballed. A lot of what's new is pretty trivial (though
in some cases fixes minor bugs). But a few of the later patches are
pretty major.

The two main problems addressed by this series are:

1. Reference transactions will, in the future, sometimes span two
   completely different reference backends. For example, we already
   have worktree-specific refs like `HEAD` and `refs/bisect/*`, which
   are stored within the worktree, plus shared refs, which live in the
   main repository. It is even possible for a symref in one reference
   backend to point at a reference in another reference backend. Thus
   we need to be able to split one main transaction into one
   transaction per backend.

2. Currently, reference transactions that involve symbolic refs are
   not atomic: the symref is not locked at all, even when its reflog
   is being updated. This is a no-no. It also means that its referent
   can change between the time that the symref is resolved to find out
   its old_oid and the time that the referent is locked. These aren't
   super serious races because symrefs are usually not modified very
   often (especially on Git servers, which is mostly where concurrent
   modifications are an issue). But still...

The approach taken to solve these problems is inspired by David
Turner's patch [2], whose approach was first discussed here [3]. David
wrote a separate function, dereference_symrefs(transaction, ...),
which scanned through the whole transaction and split up any symref
updates into one symref update with the REF_LOG_ONLY option (to update
the symrefs reflog), plus a second update that changes the underlying
reference. This approach solves problem 1 but not problem 2.

This patch series takes a slightly different approach. For each
reference update during the "lock references" part of
ref_transaction_commit(), it

1. Locks the named reference. (If it is a symref, lock *the symref*,
   not its referent!)

2. Reads the reference non-recursively

3. If it is a symref, change the update to REF_LOG_ONLY and add a
   second update to the transaction for the underlying reference.

4. If it is not a symref but was derived from a symref update, record
   the reference's old_oid in the ref_update structure for the
   original symref.

In this way, each reference in a symref chain is locked down *before*
we read it and the lock is held throughout the transaction. As a
bonus, we don't have to use resolve_ref_full() to find old_oid for the
references; it is enough to read the references *once*, because we do
it under lock.

The three patches starting with "refs: resolve symbolic refs first"
involve a lot of new code in an area that is pretty intricate. I've
reviewed them a few times, but it's quite possible I've made some
mistakes (especially in the error-handling code). Careful review here
would be much appreciated.

It's possible that people will think this is too much new code for
fixing a relatively unlikely race. I'm not absolutely convinced myself
that it's not overengineered. But splitting ref_updates is definitely
needed for supporting multiple backends, and I think the approach of
locking then following one reference at a time is more or less a
prerequisite for making symref locking work correctly with multiple
reference backends. So (I think) our choices are to accept this code
or something like it, or to give up the hope of correct atomicity of
transactions that span backends.

This patch series is also available from my GitHub repository [4] as
branch "split-under-lock". It applies to Junio's current master.

Incidentally, a draft of the *next* patch series, which adds a
ref_store vtable abstraction for managing reference backends, is
available as branch "ref-store" in my GitHub repo. That branch passes
all tests but is not yet carefully reviewed.

Following is a table of contents for this patch series...

Chapter 1: Prologue

  This chapter consists of small cleanups that I noticed while working
  on the code.

  * safe_create_leading_directories(): improve docstring
  * remove_dir_recursively(): add docstring
  * refname_is_safe(): use skip_prefix()

  This patch fixes a bug in refname_is_safe():

  * refname_is_safe(): don't allow the empty string

  This one makes refname_is_safe() a little stricter...it shouldn't
  allow refnames like "refs/foo/../bar///baz" because the downstream
  code isn't smart enough to handle them anyway. (At the latest if the
  reference has to be sought in packed-refs, things would fail):

  * refname_is_safe(): insist that the refname already be normalized

Chapter 2: Character development

  Make sure error output goes the right place:

  * commit_ref_update(): write error message to *err, not stderr

  Tighten up some code, rename some parameters:

  * rename_ref(): remove unneeded local variable
  * ref_transaction_commit(): remove local variable n
  * read_raw_ref(): rename flags argument to type
  * read_raw_ref(): clear *type at start of function
  * read_raw_ref(): rename symref argument to referent
  * read_raw_ref(): improve docstring
  * lock_ref_sha1_basic(): remove unneeded local variable

Chapter 3: Small adventures

  Change error messages to adhere to our new policy of starting with
  lower-case letters:

  * refs: make error messages more consistent

  Require REF_NODEREF if REF_ISPRUNING is set:

  * ref_transaction_create(): disallow recursive pruning

  Correctly handle an (unlikely) error path:

  * ref_transaction_commit(): correctly report close_ref() failure

  Oops, here's a problem that could have bit us later. (In fact, it
  did bite me when I implemented one of the later patches):

  * delete_branches(): use resolve_refdup()

Chapter 4: Flashback

  The following two patches are split out of one of David Turner's
  patches mentioned above:

  * refs: allow log-only updates
  * refs: don't dereference on rename

Chapter 5: The tension builds

  The protagonist clearly has something planned...but what?

  * verify_refname_available(): adjust constness in declaration
  * add_update(): initialize the whole ref_update
  * lock_ref_for_update(): new function
  * unlock_ref(): move definition higher in the file

  Here we force a little more refname safety while building up
  ref_transactions:

  * ref_transaction_update(): check refname_is_safe() at a minimum

Chapter 6: The climax

  This is the guts of the patch series. Everything up to this point
  should be pretty uncontroversial. These three patches are the main
  subject of the discussion above. They are pretty large patches, but
  I don't see a reasonable way to break them up more:

  * refs: resolve symbolic refs first
  * lock_ref_for_update(): don't re-read non-symbolic references
  * lock_ref_for_update(): don't resolve symrefs

Chapter 7: Denouement

  Remove some stuff that's not needed anymore.

  * commit_ref_update(): remove the flags parameter
  * lock_ref_sha1_basic(): only handle REF_NODEREF mode

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/289994
[2] http://thread.gmane.org/gmane.comp.version-control.git/287949/focus=287958
[3] http://article.gmane.org/gmane.comp.version-control.git/282927
[4] https://github.com/mhagger/git

David Turner (2):
  refs: allow log-only updates
  refs: don't dereference on rename

Michael Haggerty (27):
  safe_create_leading_directories(): improve docstring
  remove_dir_recursively(): add docstring
  refname_is_safe(): use skip_prefix()
  refname_is_safe(): don't allow the empty string
  refname_is_safe(): insist that the refname already be normalized
  commit_ref_update(): write error message to *err, not stderr
  rename_ref(): remove unneeded local variable
  ref_transaction_commit(): remove local variable n
  read_raw_ref(): rename flags argument to type
  read_raw_ref(): clear *type at start of function
  read_raw_ref(): rename symref argument to referent
  read_raw_ref(): improve docstring
  lock_ref_sha1_basic(): remove unneeded local variable
  refs: make error messages more consistent
  ref_transaction_create(): disallow recursive pruning
  ref_transaction_commit(): correctly report close_ref() failure
  delete_branches(): use resolve_refdup()
  verify_refname_available(): adjust constness in declaration
  add_update(): initialize the whole ref_update
  lock_ref_for_update(): new function
  unlock_ref(): move definition higher in the file
  ref_transaction_update(): check refname_is_safe() at a minimum
  refs: resolve symbolic refs first
  lock_ref_for_update(): don't re-read non-symbolic references
  lock_ref_for_update(): don't resolve symrefs
  commit_ref_update(): remove the flags parameter
  lock_ref_sha1_basic(): only handle REF_NODEREF mode

 builtin/branch.c        |  19 +-
 cache.h                 |   5 +
 dir.h                   |  23 ++
 refs.c                  |  67 ++--
 refs/files-backend.c    | 882 +++++++++++++++++++++++++++++++++++++-----------
 refs/refs-internal.h    |  55 ++-
 t/t1400-update-ref.sh   |  41 ++-
 t/t1430-bad-ref-name.sh |   2 +-
 t/t3200-branch.sh       |   9 +
 9 files changed, 869 insertions(+), 234 deletions(-)

-- 
2.8.1
