From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Document levenshtein.c
Date: Thu, 20 Nov 2008 14:27:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811201426100.30769@pacific.mpi-cbg.de>
References: <20081118185326.12721.71576.stgit@arrakis.enst.fr> <alpine.DEB.1.00.0811190151000.30769@pacific.mpi-cbg.de> <2008-11-19-09-42-45+trackit+sam@rfc1149.net> <alpine.DEB.1.00.0811191053250.30769@pacific.mpi-cbg.de> <7vhc63svsl.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811201255120.30769@pacific.mpi-cbg.de> <2008-11-20-13-00-31+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 14:20:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L39Sf-0002Ys-Hf
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 14:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbYKTNTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736AbYKTNTa
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:19:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:51754 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752394AbYKTNTa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:19:30 -0500
Received: (qmail invoked by alias); 20 Nov 2008 13:19:28 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp010) with SMTP; 20 Nov 2008 14:19:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18sGJgJP0UsmBXwkYwq4GumMOumHdEl8/d2eUfai9
	LYauseJepR3F3O
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <2008-11-20-13-00-31+trackit+sam@rfc1149.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101425>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 20 Nov 2008, Samuel Tardieu wrote:

	> * Johannes Schindelin <Johannes.Schindelin@gmx.de> [2008-11-20 
	>   13:00:35 +0100]
	> 
	> | 	How about this?
	> 
	> I think it still lacks a note about what "deletion" and 
	> "insertion" means (is that a character deleted from string1 to obtain 
	> string2 or the reverse?). In most implementation, you use the same
	> cost for insertion and deletion so the function is symetrical, but
	> this implementation is more powerful.

	Second paragraph and last sentence were added.

 levenshtein.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/levenshtein.c b/levenshtein.c
index db52f2c..ebef34b 100644
--- a/levenshtein.c
+++ b/levenshtein.c
@@ -1,6 +1,43 @@
 #include "cache.h"
 #include "levenshtein.h"
 
+/*
+ * This function implements the Damerau-Levenshtein algorithm to
+ * calculate a distance between strings.
+ *
+ * Basically, it says how many letters need to be swapped, substituted,
+ * deleted from, or added to string1, at least, to get string2.
+ *
+ * The idea is to build a distance matrix for the substrings of both
+ * strings.  To avoid a large space complexity, only the last three rows
+ * are kept in memory (if swaps had the same or higher cost as one deletion
+ * plus one insertion, only two rows would be needed).
+ *
+ * At any stage, "i + 1" denotes the length of the current substring of
+ * string1 that the distance is calculated for.
+ *
+ * row2 holds the current row, row1 the previous row (i.e. for the substring
+ * of string1 of length "i"), and row0 the row before that.
+ *
+ * In other words, at the start of the big loop, row2[j + 1] contains the
+ * Damerau-Levenshtein distance between the substring of string1 of length
+ * "i" and the substring of string2 of length "j + 1".
+ *
+ * All the big loop does is determine the partial minimum-cost paths.
+ *
+ * It does so by calculating the costs of the path ending in characters
+ * i (in string1) and j (in string2), respectively, given that the last
+ * operation is a substition, a swap, a deletion, or an insertion.
+ *
+ * This implementation allows the costs to be weighted:
+ *
+ * - w (as in "sWap")
+ * - s (as in "Substition")
+ * - a (for insertion, AKA "Add")
+ * - d (as in "Deletion")
+ *
+ * Note that this algorithm calculates a distance _iff_ d == a.
+ */
 int levenshtein(const char *string1, const char *string2,
 		int w, int s, int a, int d)
 {
-- 
1.6.0.2.763.g72663
