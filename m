From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [RFC PATCH, WAS: "weird diff output?" v3 0/2] implement empty line diff chunk heuristic
Date: Fri, 15 Apr 2016 15:57:16 -0700
Message-ID: <20160415225718.13610-1-jacob.e.keller@intel.com>
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 00:57:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arCg3-0003f7-DW
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbcDOW5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:57:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:55313 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbcDOW5W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:57:22 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 15 Apr 2016 15:57:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,489,1455004800"; 
   d="scan'208";a="946203953"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.173])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2016 15:57:21 -0700
X-Mailer: git-send-email 2.8.1.369.geae769a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291691>

From: Jacob Keller <jacob.keller@gmail.com>

Third version of my series with a few more minor fixups. I left the
diff command line and configuration option alone for now, suspecting
that long term we either (a) remove it or (b) use a gitattribute, so
there is no reason to bikeshed the name or its contents right now.

TODO:
* add some tests
* think about whether we need a git attribute or not (I did some
  thinking, and if we do need to configure this at all, this is where I
  would put it)
* figure out how to make is_emptyline CRLF aware

Changes since my v2:
* fixed is_emptylines in the wrong patch

Changes since my v1:
* rename xdl_hash_and_recmatch to recs_match
* remove counting empty lines in the first section of the looping

Changes since Stefan's v1:
* Added a patch to implement xdl_hash_and_recmatch as Junio suggested.
* Fixed a segfault in Stefan's patch
* Added XDL flag to configure the behavior
* Used an int and counted empty lines via += instead of |=
* Renamed starts_with_emptyline to is_emptyline
* Added diff command line and config options

The interdiff between v2 and v3 is very small:

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 9436ad735243..dd93e6781e8b 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -485,6 +485,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the group.
 			 */
 			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
+
 				emptylines += is_emptyline(recs[ix]->ptr);
 
 				rchg[ixs++] = 0;

Jacob Keller (1):
  xdiff: add recs_match helper function

Stefan Beller (1):
  xdiff: implement empty line chunk heuristic

 Documentation/diff-config.txt  |  6 ++++++
 Documentation/diff-options.txt |  6 ++++++
 diff.c                         | 11 +++++++++++
 xdiff/xdiff.h                  |  2 ++
 xdiff/xdiffi.c                 | 41 +++++++++++++++++++++++++++++++++++++----
 5 files changed, 62 insertions(+), 4 deletions(-)

-- 
2.8.1.369.geae769a
