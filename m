From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 1/5] Allow alternate "low-level" emit function from xdl_diff
Date: Thu, 21 Aug 2008 18:21:57 -0500
Message-ID: <1219360921-28529-2-git-send-email-bdowning@lavos.net>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net>
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 01:34:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWJfF-0003Ti-2Q
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 01:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbYHUXct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 19:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755357AbYHUXcs
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 19:32:48 -0400
Received: from mail.somat.com ([63.252.84.66]:50096 "EHLO somat1.somat.local"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754788AbYHUXcq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 19:32:46 -0400
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Aug 2008 19:32:39 EDT
Received: from silvara.lavos.net ([192.168.0.108]) by somat1.somat.local with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 21 Aug 2008 18:22:01 -0500
Received: (nullmailer pid 28564 invoked by uid 1000);
	Thu, 21 Aug 2008 23:22:01 -0000
X-Mailer: git-send-email 1.5.6.1
In-Reply-To: <1219360921-28529-1-git-send-email-bdowning@lavos.net>
X-OriginalArrivalTime: 21 Aug 2008 23:22:01.0664 (UTC) FILETIME=[B721C400:01C903E4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93227>

For some users (e.g. git blame), getting textual patch output is just
extra work, as they can get all the information they need from the low-
level diff structures.  Allow for an alternate low-level emit function
to be defined to allow bypassing the textual patch generation; set
xemitconf_t's emit_func member to enable this.

The (void (*)()) type is pretty ugly, but the alternative would be to
include most of the private xdiff headers in xdiff.h to get the types
required for the "proper" function prototype.  Also, a (void *) won't
work, as ANSI C doesn't allow a function pointer to be cast to an
object pointer.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 xdiff/xdiff.h  |    1 +
 xdiff/xdiffi.c |    4 +++-
 xdiff/xemit.c  |    3 +--
 xdiff/xemit.h  |    3 +++
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 413082e..281fc0b 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -81,6 +81,7 @@ typedef struct s_xdemitconf {
 	unsigned long flags;
 	find_func_t find_func;
 	void *find_func_priv;
+	void (*emit_func)();
 } xdemitconf_t;
 
 typedef struct s_bdiffparam {
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 1bad846..9d0324a 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -538,6 +538,8 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
 	xdchange_t *xscr;
 	xdfenv_t xe;
+	emit_func_t ef = xecfg->emit_func ?
+		(emit_func_t)xecfg->emit_func : xdl_emit_diff;
 
 	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0) {
 
@@ -551,7 +553,7 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		return -1;
 	}
 	if (xscr) {
-		if (xdl_emit_diff(&xe, xscr, ecb, xecfg) < 0) {
+		if (ef(&xe, xscr, ecb, xecfg) < 0) {
 
 			xdl_free_script(xscr);
 			xdl_free_env(&xe);
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index d3d9c84..4625c1b 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -27,7 +27,6 @@
 
 static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec);
 static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb);
-static xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg);
 
 
 
@@ -58,7 +57,7 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
  * Starting at the passed change atom, find the latest change atom to be included
  * inside the differential hunk according to the specified configuration.
  */
-static xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg) {
+xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg) {
 	xdchange_t *xch, *xchp;
 
 	for (xchp = xscr, xch = xscr->next; xch; xchp = xch, xch = xch->next)
diff --git a/xdiff/xemit.h b/xdiff/xemit.h
index 440a739..c2e2e83 100644
--- a/xdiff/xemit.h
+++ b/xdiff/xemit.h
@@ -24,7 +24,10 @@
 #define XEMIT_H
 
 
+typedef int (*emit_func_t)(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
+			   xdemitconf_t const *xecfg);
 
+xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg);
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg);
 
-- 
1.5.6.1
