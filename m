From: mhagger@alum.mit.edu
Subject: [PATCH v2 00/12] Use refs API more consistently
Date: Fri, 28 Oct 2011 13:27:52 +0200
Message-ID: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 13:28:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJkc5-0002WA-Sm
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 13:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262Ab1J1L2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 07:28:17 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:54965 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab1J1L2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 07:28:14 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJkVI-0007Cx-Cr; Fri, 28 Oct 2011 13:21:40 +0200
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184368>

From: Michael Haggerty <mhagger@alum.mit.edu>

This is a re-roll of the patch series on top of v3 of "Tidying up
references code", which in turn applies to gitster/master.

This series conflicts with the "Checking full vs. partial refnames"
series but not in a fundamental way.  Unless there is an important
reason to merge the latter to master before this patch series, I
suggest that I reroll "Checking full vs. partial refnames" on top of
these ref-api changes after they hit master.

This patch series primarily has to do with using the refs API more
consistently within refs.c itself.  We want to minimize the surface
area for accessing the ref_cache data structure so that when it is
changed into a tree (we're on the verge of that change now, I
promise!) we don't have to change callers more than necessary.  There
is also a bit of an eat-your-own-dogfood thing going on here; if
for_each_ref() and its friends are good enough for "outsiders", they
should be good enough for most internal use.

The first two patches are trivial preparation cleanups.

The third verifies that refnames read from packed-ref files are
properly formatted.  When the REFNAME_FULL changes become available,
this check can be tightened up.

The do_for_each_ref_in_{array,arrays}() functions provide an
iterator-like interface to iterating over a single ref_array and
iterating over two ref_arrays in parallel.  These are useful
abstractions in and of themselves (the former is used to reimplement
repack_without_ref() and is_refname_available() in patches 9 and 12
respectively).  And they will be even more useful when references are
stored hierarchically.

Michael Haggerty (12):
  Rename another local variable name -> refname
  repack_without_ref(): remove temporary
  parse_ref_line(): add a check that the refname is properly formatted
  create_ref_entry(): extract function from add_ref()
  add_ref(): take a (struct ref_entry *) parameter
  do_for_each_ref(): correctly terminate while processesing extra_refs
  do_for_each_ref_in_array(): new function
  do_for_each_ref_in_arrays(): new function
  repack_without_ref(): reimplement using do_for_each_ref_in_array()
  names_conflict(): new function, extracted from is_refname_available()
  names_conflict(): simplify implementation
  is_refname_available(): reimplement using do_for_each_ref_in_array()

 refs.c |  255 ++++++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 160 insertions(+), 95 deletions(-)

-- 
1.7.7
