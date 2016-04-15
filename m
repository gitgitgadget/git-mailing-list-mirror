From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [RFC PATCH, WAS: "weird diff output?" v2 0/2] implement empty line diff chunk heuristic
Date: Fri, 15 Apr 2016 14:56:20 -0700
Message-ID: <20160415215622.6040-1-jacob.e.keller@intel.com>
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 23:56:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBj4-0003mw-Pa
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbcDOV4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:56:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:29979 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbcDOV4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:56:25 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP; 15 Apr 2016 14:56:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,489,1455004800"; 
   d="scan'208";a="86046757"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.173])
  by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2016 14:56:24 -0700
X-Mailer: git-send-email 2.8.1.369.geae769a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291673>

From: Jacob Keller <jacob.keller@gmail.com>

Second version of my series with a few more minor fixups. I left the
diff command line and configuration option alone for now, suspecting
that long term we either (a) remove it or (b) use a gitattribute, so
there is no reason to bikeshed the name or its contents right now.

TODO:
* add some tests
* think about whether we need a git attribute or not (I did some
  thinking, and if we do need to configure this at all, this is where I
  would put it)
* figure out how to make is_emptyline CRLF aware

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

For reviewer convenience, the interdiff between v1 and v2:

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index cebf82702d2a..9265d60d9571 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -173,8 +173,8 @@ include::mergetools-diff.txt[]
 diff.emptyLineHeuristic::
 	Set this option to true to enable the empty line chunk heuristic when
 	producing diff output. This heuristic will attempt to shift hunks such
-	that a common empty line occurs below the hunk with the rest of the
-	context above it.
+	that the last common empty line occurs below the hunk with the rest of
+	the context above it.
 
 diff.algorithm::
 	Choose a diff algorithm.  The variants are as follows:
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 83984b90f82f..9436ad735243 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -405,7 +405,7 @@ static int is_emptyline(const char *recs)
 	return recs[0] == '\n'; /* CRLF not covered here */
 }
 
-static int xdl_hash_and_recmatch(xrecord_t **recs, long ixs, long ix, long flags)
+static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 {
 	return (recs[ixs]->ha == recs[ix]->ha &&
 		xdl_recmatch(recs[ixs]->ptr, recs[ixs]->size,
@@ -457,9 +457,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the last line of the current change group, shift backward
 			 * the group.
 			 */
-			while (ixs > 0 && xdl_hash_and_recmatch(recs, ixs - 1, ix - 1, flags)) {
-				emptylines += is_emptyline(recs[ix - 1]->ptr);
-
+			while (ixs > 0 && recs_match(recs, ixs - 1, ix - 1, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
 
@@ -486,7 +484,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the line next of the current change group, shift forward
 			 * the group.
 			 */
-			while (ix < nrec && xdl_hash_and_recmatch(recs, ixs, ix, flags)) {
+			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
 				emptylines += is_emptyline(recs[ix]->ptr);
 
 				rchg[ixs++] = 0;
@@ -527,7 +525,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		if ((flags & XDF_EMPTY_LINE_HEURISTIC) && emptylines) {
 			while (ixs > 0 &&
 			       !is_emptyline(recs[ix - 1]->ptr) &&
-			       xdl_hash_and_recmatch(recs, ixs - 1, ix - 1, flags)) {
+			       recs_match(recs, ixs - 1, ix - 1, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
 			}

Jacob Keller (1):
  xdiff: add recs_match helper function

Stefan Beller (1):
  xdiff: implement empty line chunk heuristic

 Documentation/diff-config.txt  |  6 ++++++
 Documentation/diff-options.txt |  6 ++++++
 diff.c                         | 11 +++++++++++
 xdiff/xdiff.h                  |  2 ++
 xdiff/xdiffi.c                 | 40 ++++++++++++++++++++++++++++++++++++----
 5 files changed, 61 insertions(+), 4 deletions(-)

-- 
2.8.1.369.geae769a
