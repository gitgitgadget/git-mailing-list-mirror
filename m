From: mhagger@alum.mit.edu
Subject: [PATCH v2 00/18] Read loose references lazily
Date: Fri, 27 Apr 2012 00:26:49 +0200
Message-ID: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:27:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNX9l-0007ew-9B
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759410Ab2DZW1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:27:15 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:37036 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755500Ab2DZW1O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:27:14 -0400
Received: from michael.berlin.jpk.com (michael2.berlin.jpk.com [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id D49DE2480F8;
	Fri, 27 Apr 2012 00:27:11 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196425>

From: Michael Haggerty <mhagger@alum.mit.edu>

This is the next installment of the ref-api saga.  The main result of
this patch series is to teach git to read loose references one
directory at a time, only when they are needed.

This version of the patch series differs from v1 by avoiding the
conversion of code from using (struct ref_dir *) to (struct ref_entry
*).  As Junio rightly pointed out, the use of ref_entry as the data
type for dealing with directory entries was awkward and error-prone.

This version also changes how bits in ref_entry::flag are assigned,
also at Junio's suggestion.

The first nine patches are unchanged from v1 except for a trivial
change to a commit message.  These patches convert get_ref_dir() and
do_for_each_reflog() to use strbufs and to tighten up their
specifications.

Patch 10 fixes a git_path() related bug in bisect.c.  A filename
obtained from git_path() was being used long after it was created.
With the changes later in this patch series, the
lazy-loose-reference-reading code will be activated while
check_good_are_ancestors_of_bad() is still holding on to the filename.
Therefore, this fix is a prerequisite to the later patches.

[I am nervous that there might be analogous bugs elsewhere in the
code.  Since the lazy-loose-reference-reading code can now spring to
life in many situations where references are used, it might flush out
problems in sloppy code elsewhere.  But what can we do, short of
getting rid of get_pathname() once and for all?]

Patch 11 Converts find_containing_dir() to use a strbuf.  It makes the
code a bit more straightforward but is otherwise not very interesting.

The rest of the patches teach the code to read loose references
lazily.  This is done by setting a REF_INCOMPLETE bit in
ref_entry::flag for loose directory entries that haven't been read
yet.  The entries are read when they are accessed, namely when
get_ref_dir() is called to extract a ref_dir from a directory
ref_entry.

This patch series depends on mh/ref-api, which just recently made it
to master.  It passes all tests.

Michael Haggerty (18):
  get_ref_dir(): return early if directory cannot be read
  get_ref_dir(): use a strbuf to hold refname
  get_ref_dir(): rename "base" parameter to "dirname"
  get_ref_dir(): require that the dirname argument ends in '/'
  refs.c: extract function search_for_subdir()
  get_ref_dir(): take the containing directory as argument
  do_for_each_reflog(): return early on error
  do_for_each_reflog(): use a strbuf to hold logfile name
  do_for_each_reflog(): reuse strbuf across recursive function calls
  bisect: copy filename string obtained from git_path()
  find_containing_dir(): use strbuf in implementation of this function
  refs: wrap top-level ref_dirs in ref_entries
  read_loose_refs(): rename function from get_ref_dir()
  get_ref_dir(): add function for getting a ref_dir from a ref_entry
  search_for_subdir(): return (ref_dir *) instead of (ref_entry *)
  struct ref_dir: store a reference to the enclosing ref_cache
  read_loose_refs(): eliminate ref_cache argument
  refs: read loose references lazily

 bisect.c |    8 +-
 refs.c   |  378 ++++++++++++++++++++++++++++++++++++++++----------------------
 2 files changed, 247 insertions(+), 139 deletions(-)

-- 
1.7.10
