From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [RFC PATCH, WAS: "weird diff output?" v2 1/2] xdiff: add recs_match helper function
Date: Fri, 15 Apr 2016 14:56:21 -0700
Message-ID: <20160415215622.6040-2-jacob.e.keller@intel.com>
References: <20160415215622.6040-1-jacob.e.keller@intel.com>
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 23:56:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBj6-0003mw-Bw
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbcDOV41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:56:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:29979 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbcDOV40 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:56:26 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP; 15 Apr 2016 14:56:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,489,1455004800"; 
   d="scan'208";a="86046761"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.173])
  by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2016 14:56:24 -0700
X-Mailer: git-send-email 2.8.1.369.geae769a
In-Reply-To: <20160415215622.6040-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291672>

From: Jacob Keller <jacob.keller@gmail.com>

It is a common pattern in xdl_change_compact to check that hashes and
strings match. The resulting code to perform this change causes very
long lines and makes it hard to follow the intention. Introduce a helper
function recs_match which performs both checks to increase
code readability.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 xdiff/xdiffi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 2358a2d6326e..d14c47de5e36 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -400,6 +400,14 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
+static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
+{
+	return (recs[ixs]->ha == recs[ix]->ha &&
+		xdl_recmatch(recs[ixs]->ptr, recs[ixs]->size,
+			     recs[ix]->ptr, recs[ix]->size,
+			     flags));
+}
+
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
@@ -442,8 +450,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the last line of the current change group, shift backward
 			 * the group.
 			 */
-			while (ixs > 0 && recs[ixs - 1]->ha == recs[ix - 1]->ha &&
-			       xdl_recmatch(recs[ixs - 1]->ptr, recs[ixs - 1]->size, recs[ix - 1]->ptr, recs[ix - 1]->size, flags)) {
+			while (ixs > 0 && recs_match(recs, ixs - 1, ix - 1, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
 
@@ -470,8 +477,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the line next of the current change group, shift forward
 			 * the group.
 			 */
-			while (ix < nrec && recs[ixs]->ha == recs[ix]->ha &&
-			       xdl_recmatch(recs[ixs]->ptr, recs[ixs]->size, recs[ix]->ptr, recs[ix]->size, flags)) {
+			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
+				emptylines += is_emptyline(recs[ix]->ptr);
+
 				rchg[ixs++] = 0;
 				rchg[ix++] = 1;
 
-- 
2.8.1.369.geae769a
