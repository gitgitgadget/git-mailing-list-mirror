From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/21] replacement for dt/refs-backend-lmdb v7 patch 04/33
Date: Wed, 23 Mar 2016 11:04:17 +0100
Message-ID: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:16:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiflc-00007C-3M
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbcCWKLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:11:53 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49374 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751039AbcCWKLv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:11:51 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Mar 2016 06:11:51 EDT
X-AuditID: 1207440c-99fff700000008b4-8c-56f26a3fdcd2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F5.D9.02228.F3A62F65; Wed, 23 Mar 2016 06:04:47 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g15018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:04:44 -0400
X-Mailer: git-send-email 2.8.0.rc3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsUixO6iqGuf9SnM4OFKJYuuK91MFg29V5gt
	bq+Yz2zRPeUto8WPlh5mi5lXrR3YPP6+/8DksXPWXXaPZ717GD0uXlL22L90G5vH501yAWxR
	3DZJiSVlwZnpefp2CdwZmx83sBSck644MukyYwPjdLEuRk4OCQETiSfnXjN1MXJxCAlsZZQ4
	vnwPI4Rzkklix+5WJpAqNgFdiUU9zWC2iICaxMS2QywgRcwCCxglNi5ezAySEBbwkmhsusoI
	YrMIqErcv/MHzOYVMJc4tLeBEWKdksSGBxeYJjByLWBkWMUol5hTmqubm5iZU5yarFucnJiX
	l1qka6iXm1mil5pSuokREiA8Oxi/rZM5xCjAwajEwytx5mOYEGtiWXFl7iFGSQ4mJVHe80Gf
	woT4kvJTKjMSizPii0pzUosPMUpwMCuJ8DZnAuV4UxIrq1KL8mFS0hwsSuK8qkvU/YQE0hNL
	UrNTUwtSi2CyMhwcShK87SCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aCgji8G
	hjVIigdobyvY3uKCxFygKETrKUZFKXFeb5CEAEgiozQPbiws7l8xigN9Kcy7EqSKB5gy4Lpf
	AQ1mAhq80AdscEkiQkqqgdG0tOqPksuZM2td3+qsD56u1/hvyou4X1s2vgwMnsqyZ+Hkm3+D
	VAIkRfTWCRveVNN0Sb5RP/+2o/WCY2o9TNPLxUQqVMWuHjhmESzHpa961lr/xnqLFN3qAsHK
	8MgJV1MXsVosMls/R+2j9FOrA4UMKbxfL5/8KPnv4o1o1eRNU08dVVSZcFyJpTgj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289632>

Patch 04/33 in David Turner's refs-backend-lmdb series v7 [1] did way
too much in a single patch, and in fact got a few minor things wrong.
Instead of that patch, I suggest this patch series, which

* Splits the changes into smaller steps.

* Adds a bunch of tests of deleting references with invalid but safe
  names, including symbolic references and including references
  reached via symbolic references. Two of these tests fail when run
  against David's patch 04 due to changes in output.

* Arranges for the "flags" argument to read_raw_ref() always to be
  non-NULL, which eliminates the need for a lot of "if (flags)"
  guards.

* Eliminates the now-superfluous "bad_name" local variable.

* Move the management of the scratch space sb_path from
  resolve_ref_unsafe() to read_raw_ref().

* Inlines resolve_ref_1() into resolve_ref_unsafe().

* Changes some callers of resolve_ref_unsafe() to pass flags=NULL
  instead of creating a local flags variable that is never used.

* Changes some callers to check for errors before using the return
  value of resolve_ref_unsafe().

I hope that the result is easier to understand and audit, even though
it consists of more patches (indeed, *because* of that).

This patch series applies on top of David's patch 03/33 the same place
David applied it in his repo [2]. It is also available in situ from my
GitHub repo [3] as branch "pluggable-backends-patch4"

If this series is used, later patches from David's series would need
to be rebased on top of it. This is a little bit messy but not
difficult; the result can be seen in branch
"pluggable-backends-rebased" in my GitHub repo [3] (albeit without
adjusting the LMDB-related patches).

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/287971
[2] https://github.com/dturner-tw/git/tree/dturner/pluggable-backends
[3] https://github.com/mhagger/git

David Turner (1):
  files-backend: break out ref reading

Michael Haggerty (20):
  t1430: test the output and error of some commands more carefully
  t1430: clean up broken refs/tags/shadow
  t1430: don't rely on symbolic-ref for creating broken symrefs
  t1430: test for-each-ref in the presence of badly-named refs
  t1430: improve test coverage of deletion of badly-named refs
  resolve_missing_loose_ref(): simplify semantics
  resolve_ref_unsafe(): use for loop to count up to MAXDEPTH
  resolve_ref_unsafe(): ensure flags is always set
  resolve_ref_1(): eliminate local variable
  resolve_ref_1(): reorder code
  resolve_ref_1(): eliminate local variable "bad_name"
  read_raw_ref(): manage own scratch space
  Inline resolve_ref_1() into resolve_ref_unsafe()
  read_raw_ref(): change flags parameter to unsigned int
  fsck_head_link(): remove unneeded flag variable
  cmd_merge(): remove unneeded flag variable
  get_default_remote(): remove unneeded flag variable
  checkout_paths(): remove unneeded flag variable
  check_aliased_update(): check that dst_name is non-NULL
  show_head_ref(): check the result of resolve_ref_namespace()

 builtin/checkout.c          |   3 +-
 builtin/fsck.c              |   3 +-
 builtin/merge.c             |   4 +-
 builtin/receive-pack.c      |   2 +-
 builtin/submodule--helper.c |   3 +-
 http-backend.c              |   4 +-
 refs/files-backend.c        | 341 ++++++++++++++++++++++++--------------------
 t/t1430-bad-ref-name.sh     | 132 +++++++++++++++--
 8 files changed, 312 insertions(+), 180 deletions(-)

-- 
2.8.0.rc3
