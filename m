From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/5] Allow alternate "low-level" emit function from xdl_diff
Date: Sat, 25 Oct 2008 15:30:54 +0200
Message-ID: <49031F8E.8000203@lsrfire.ath.cx>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net> <1219360921-28529-2-git-send-email-bdowning@lavos.net> <48AFC73F.2010100@lsrfire.ath.cx> <20080824081254.GI31114@lavos.net> <48BF0FBF.3010104@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 15:32:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtjFe-0000Mb-1I
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 15:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbYJYNa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 09:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbYJYNa6
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 09:30:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:56966 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbYJYNa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 09:30:57 -0400
Received: from [10.0.1.100] (p57B7B97B.dip.t-dialin.net [87.183.185.123])
	by india601.server4you.de (Postfix) with ESMTPSA id 213C42F8045;
	Sat, 25 Oct 2008 15:30:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <48BF0FBF.3010104@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99109>

From: Brian Downing <bdowning@lavos.net>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Taken from pu.

 xdiff/xdiff.h  |    1 +
 xdiff/xdiffi.c |    4 +++-
 xdiff/xemit.c  |    3 +--
 xdiff/xemit.h  |    3 +++
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index deebe02..84fff58 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -87,6 +87,7 @@ typedef struct s_xdemitconf {
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
1.6.0.3.514.g2f91b
