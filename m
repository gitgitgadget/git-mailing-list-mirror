From: mhagger@alum.mit.edu
Subject: [PATCH 00/30] Read loose references lazily
Date: Wed, 25 Apr 2012 00:45:06 +0200
Message-ID: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMoas-00059D-T7
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758106Ab2DXWv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:51:59 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:48851 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758096Ab2DXWv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:51:57 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id D6C072480F8;
	Wed, 25 Apr 2012 00:45:46 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196258>

From: Michael Haggerty <mhagger@alum.mit.edu>

This is the next installment of the ref-api saga.  The main result of
this patch series is to teach git to read loose references one
directory at a time, only when they are needed.

The first nine commits are not very interesting; they convert
get_ref_dir() and do_for_each_reflog() to use strbufs and to tighten
up their specifications.  The search_for_subdir() function extracted
in patch 5 will be useful later.  Patch 6 slightly reduces the amount
of work needed to read loose refs from disk, and also changes the
function's API in a way that will be needed later when directories are
read one at a time.

Patches 10 - 25 mostly switch a lot of code from using ref_dir
pointers to using ref_entry pointers as arguments and return values.
This is important, because we want to be able to read directories of
loose references on demand; this means that functions deep in the refs
code need access to the name of directories of references.  Since the
name field is part of ref_entry but not ref_dir, this change has to
percolate through many functions.  The three key patches are patch 18,
which removes the "dirname" argument to get_ref_dir(), and patches 21
and 25, which change search_ref_dir() and sort_ref_dir() to take
ref_entries as argument.  Together, these patches allow
search_ref_dir() and sort_ref_dir() to call get_ref_dir() to fill
directory entries on demand.

Patch 26-28 makes it possible to get from a ref_entry to the ref_cache
of which it is part, and teach get_ref_dir() (renamed to
read_loose_refs()) to use this mechanism to access the name of the
ref_cache that it is to read.

Finally, patches 29 and 30 teach the code to read loose references
lazily.  This is done by adding a distinction between REF_DIR_COMPLETE
and REF_DIR_INCOMPLETE; the latter is used to stub out directories of
loose references that haven't been read yet.  The loose references are
read transparently into a REF_DIR_INCOMPLETE only when they are
needed, at which time the directory entry is transformed into
REF_DIR_COMPLETE.

This patch series has to be applied on top of mh/ref-api (or next).
It passes all tests.  It also includes quite a few assert()s to
verify and document function preconditions.  The asserts should all be
pretty cheap, but if leaving them in is a problem please let me know.

It seems pretty overwhelming, but the changes are implemented in baby
steps and most of the patches are quite simple.

Michael Haggerty (30):
  get_ref_dir(): return early if directory cannot be read
  get_ref_dir(): use a strbuf to hold refname
  get_ref_dir(): rename "base" parameter to "dirname"
  get_ref_dir(): require that the dirname argument ends in '/'
  refs.c: extract function search_for_subdir()
  get_ref_dir(): take the containing directory as argument
  do_for_each_reflog(): return early on error
  do_for_each_reflog(): use a strbuf to hold logfile name
  do_for_each_reflog(): reuse strbuf across recursive function calls
  refs: wrap top-level ref_dirs in ref_entries
  get_packed_refs(): return (ref_entry *) instead of (ref_dir *)
  get_loose_refs(): return (ref_entry *) instead of (ref_dir *)
  is_refname_available(): take (ref_entry *) instead of (ref_dir *)
  find_ref(): take (ref_entry *) instead of (ref_dir *)
  read_packed_refs(): take (ref_entry *) instead of (ref_dir *)
  add_ref(): take (ref_entry *) instead of (ref_dir *)
  find_containing_direntry(): use (ref_entry *) instead of (ref_dir *)
  get_ref_dir(): take (ref_entry *) instead of (ref_dir *)
  get_ref_dir(): remove dirname argument
  search_for_subdir(): take (ref_entry *) instead of (ref_dir *)
  search_ref_dir(): take (ref_entry *) instead of (ref_dir *)
  add_entry(): take (ref_entry *) instead of (ref_dir *)
  do_for_each_ref_in_dirs(): take (ref_entry *) instead of (ref_dir *)
  do_for_each_ref_in_dir(): take (ref_entry *) instead of (ref_dir *)
  sort_ref_dir(): take (ref_entry *) instead of (ref_dir *)
  struct ref_dir: store a reference to the enclosing ref_cache
  read_loose_refs(): rename function from get_ref_dir()
  read_loose_refs(): access ref_cache via the ref_dir field
  create_dir_entry(): allow the flag value to be passed as an argument
  refs: read loose references lazily

 refs.c |  550 +++++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 332 insertions(+), 218 deletions(-)

-- 
1.7.10
