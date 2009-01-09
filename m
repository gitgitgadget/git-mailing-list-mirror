From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 9 Jan 2009 14:07:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901091405460.30769@pacific.mpi-cbg.de>
References: <20090108195511.GA8734@chistera.yi.org> <7v7i552clz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Clemens Buchacher <drizzd@aon.at>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 14:08:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLH5z-0005rJ-AL
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 14:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbZAINGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 08:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbZAINGu
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 08:06:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:50620 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752228AbZAINGu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 08:06:50 -0500
Received: (qmail invoked by alias); 09 Jan 2009 13:06:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 09 Jan 2009 14:06:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VRFRcMnaV+OJEwymlbZfa5MHNGFiUCIbc2exzaX
	5jYxRDqzbKAh26
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v7i552clz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105011>

Hi,

On Thu, 8 Jan 2009, Junio C Hamano wrote:

> If we find the "common" context lines that have only blank and 
> punctuation letters in Dscho output, turn each of them into "-" and "+", 
> and rearrange them so that all "-" are together followed by "+", it will 
> match Bzr output.

So we'd need something like this (I still think we should treat curly 
brackets the same as punctuation, and for good measure I just handled 
everything that is not alphanumerical the same):

-- snipsnap --
[TOY PATCH] Add diff option '--collapse-non-alnums'

With the option --collapse-non-alnums, there will be no interhunks
consisting solely of non-alphanumerical letters.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c         |    2 ++
 xdiff/xdiff.h  |    1 +
 xdiff/xdiffi.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index c7ddb60..4b387fb 100644
--- a/diff.c
+++ b/diff.c
@@ -2503,6 +2503,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts |= XDF_PATIENCE_DIFF;
+	else if (!strcmp(arg, "--collapse-non-alnums"))
+		options->xdl_opts |= XDF_COLLAPSE_NON_ALNUMS;
 
 	/* flags options */
 	else if (!strcmp(arg, "--binary")) {
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 4da052a..a444f9a 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -33,6 +33,7 @@ extern "C" {
 #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
 #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
 #define XDF_PATIENCE_DIFF (1 << 5)
+#define XDF_COLLAPSE_NON_ALNUMS (1 << 6)
 #define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
 
 #define XDL_PATCH_NORMAL '-'
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 3e97462..b8e7ee8 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -396,6 +396,50 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 	return xch;
 }
 
+static int xdl_record_contains_alnum(xrecord_t *record)
+{
+	long i;
+	for (i = 0; i < record->size; i++)
+		if (isalnum(record->ptr[i]))
+			return 1;
+	return 0;
+}
+
+static int xdl_collapse_non_alnum(xdfile_t *xdf, xdfile_t *xdfo)
+{
+	long ix, ixo, len = 0;
+
+	/*
+	 * Collapse all interhunk parts consisting solely of non-alnum
+	 * characters into the hunks.
+	 */
+	for (ix = 0, ixo = 0; ix < xdf->nrec && ixo < xdfo->nrec; ix++, ixo++) {
+		if (xdf->rchg[ix] == 1 || xdfo->rchg[ixo] == 1) {
+			/* collapse non-alnum interhunks */
+			while (len > 0) {
+				xdf->rchg[ix - len] = 1;
+				xdfo->rchg[ixo - len] = 1;
+				len--;
+			}
+
+			/* look for end of hunk */
+			while (ix < xdf->nrec && xdf->rchg[ix] == 1)
+				ix++;
+			while (ixo < xdfo->nrec && xdfo->rchg[ixo] == 1)
+				ixo++;
+			if (ix >= xdf->nrec)
+				return 0;
+			len = !xdl_record_contains_alnum(xdf->recs[ix]);
+		}
+		else if (len > 0) {
+			if (xdl_record_contains_alnum(xdf->recs[ix]))
+				len = 0;
+			else
+				len++;
+		}
+	}
+	return 0;
+}
 
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
@@ -548,7 +592,9 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 
 		return -1;
 	}
-	if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
+	if (((xpp->flags & XDF_COLLAPSE_NON_ALNUMS) &&
+	     xdl_collapse_non_alnum(&xe.xdf1, &xe.xdf2)) ||
+	    xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
 	    xdl_build_script(&xe, &xscr) < 0) {
 
-- 
1.6.1.203.gc8be3
