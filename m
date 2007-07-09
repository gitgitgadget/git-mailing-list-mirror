From: bdowning@lavos.net (Brian Downing)
Subject: Preferring shallower deltas on repack
Date: Sun, 8 Jul 2007 23:43:26 -0500
Message-ID: <20070709044326.GH4087@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 06:43:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7l63-000233-Qc
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 06:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXGIEnh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 00:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbXGIEnh
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 00:43:37 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:1029 "EHLO
	asav13.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbXGIEng (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 00:43:36 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav13.insightbb.com with ESMTP; 09 Jul 2007 00:43:35 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnA9AHVZkUZKhvbzR2dsb2JhbACBTIVdiAQBAT8B
Received: by mail.lavos.net (Postfix, from userid 1000)
	id CE2D1309F31; Sun,  8 Jul 2007 23:43:26 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51949>

SBCL, a Lisp implementation, has a file in their (CVS) repository called
"version.lisp-expr" which is updated every commit.  This file looks like:

------------------------------------------------------------------------
;;; This is the master value for LISP-IMPLEMENTATION-VERSION. It's
;;; separated into its own file here so that it's easy for
;;; text-munging make-ish or cvs-ish scripts to find and tweak it. For
;;; the convenience of such scripts, only a simple subset of Lisp
;;; reader syntax should be used here: semicolon-delimited comments,
;;; possible blank lines or other whitespace, and a single
;;; double-quoted string value alone on its own line.
;;;
;;; ANSI says LISP-IMPLEMENTATION-VERSION can be NIL "if no
;;; appropriate and relevant result can be produced", but as long as
;;; we control the build, we can always assign an appropriate and
;;; relevant result, so this must be a string, not NIL.
;;;
;;; Conventionally a string like "0.6.6", with three numeric fields,
;;; is used for released versions, and a string like "0.6.5.xyzzy",
;;; with something arbitrary in the fourth field, is used for CVS
;;; checkins which aren't released. (And occasionally for internal
;;; versions, especially for internal versions off the main CVS
;;; branch, it gets hairier, e.g. "0.pre7.14.flaky4.13".)
"1.0.7.10"
------------------------------------------------------------------------

Only very rarely does anything but the last line change.

The current repack implementation, when given values like "--window=100
--depth=1000", happily generates an incredibly deep tree for this file,
maxing out the depth.  (I'm only using such a high depth to demonstrate
the pessimal behavior.)  I noticed that it just takes the first delta
it finds that is the smallest; it then only looks for deltas with a
max_size of the old size - 1, so it can never find better matches with
regard to depth.

I modified this to prefer shallower deltas of the same size.  This made
the deltas for this file a very wide tree with a maximum depth of about
65.  Other (much smaller) improvements were seen elsewhere in the pack.
Runtime does not seem to have been affected, as most of the work had
already been done when it was tossing deltas before.

Some simple statistics:

SBCL, standard pack-objects, window 100, depth 1000:
  Max depth: 980
  Mean depth: 100.223622114502
  Median depth: 12
  Standard deviation: 188.214331919176

SBCL, patched pack-objects, window 100, depth 1000:
  Max depth: 787
  Mean depth: 61.5669990817656
  Median depth: 11
  Standard deviation: 127.644652607399

git, standard pack-objects, window 100, depth 1000:
  Max depth: 925
  Mean depth: 77.184264479754
  Median depth: 8
  Standard deviation: 150.112998198182

git, patched pack-objects, window 100, depth 1000:
  Max depth: 913
  Mean depth: 74.9981877425496
  Median depth: 7
  Standard deviation: 147.900721785959

The only negative effect I could see from this patch might be pack
locality.  Unfortunately I don't know enough (read: anything) about pack
access patterns to determine if this is the case.

Patch to follow.

-bcd
