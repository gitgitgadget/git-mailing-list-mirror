From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 3/5] diff: ignore empty lines before added functions with -W
Date: Sat, 21 May 2016 20:46:13 +0200
Message-ID: <5740ACF5.4060107@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Bv5-0001Zm-3e
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 20:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbcEUSqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 14:46:35 -0400
Received: from mout.web.de ([212.227.15.3]:64559 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbcEUSqe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 14:46:34 -0400
Received: from [192.168.178.36] ([79.237.63.247]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M4Zps-1bTQTZ2b9g-00yiZU; Sat, 21 May 2016 20:46:29
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <5740AC28.6010202@web.de>
X-Provags-ID: V03:K0:4sT+pxijX/79iVDdUrIye3QNF5BV2F2VT+WbqnBbMD99V0jadkg
 3vj9BVPNLAcrDdH+7bZHPy+7b4Z4a2czEbHoPOlORMQWvi8i3W/7HZZUzXg/qVGMirmNsOQ
 WGKVf8kD7mTDEwbwSvy0Mt6x0ibGq8ujs0UpqKsaKAkXisq+Gl7Op25EhWkpIoNShr7576p
 9yMUwtqjYjXSigvx0ZCPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MpKVl83/ESw=:eN3nRwIY/iLoLrysv41cf7
 OxkYfQqcTKa3Pluf3Y20Ae+UiftkQMjLv9OxzU7mfS/pWSBNXwigfmSUlRJrh4iGvbmWlXmMa
 P/m2vztKiVcHEs1ENOx6j9ZPXU+A/O78+9X23c+1VpSfxSG8iFPkUPmt1I6GEfgqn1avTUalE
 z6XJi+s+rkwmbC4x1euDtgSAaewfPz4cJkGFJEyfnNJ5pZtYBsSAX4OQ1nox1KAYvre3xM0Vo
 ueS30hg1NJohRAha49nondAQpjJjfU8QkmtZLWawavBJsLQiC3RAsRw4nheRHMrNEBtAZcM8T
 Ost4j0ewzp5/24Qdf+5+TWXVzVg/a+g91zumUNIlM0eFDmoU2HCbQhpQtz76VWRmsT28w5QbW
 p6Pgk7/HXKumpaNmt2yfNWXKzAK2k1VhoPC7B+JcFOWvZMA/+AKdLjscnAlWUSWQJkUvKVODf
 awMgymFpYx5qM3lSGXjws7ZSRZVPjjeV6P2nQ14Ao+LE9sBJunYUs+WUEkz3qvEG6s6z5butX
 g2fwA7j5EMZ3AvfEba/DAe2dfzcDm51sm//4UOpvAL9RcJ+mjOn3YXYRJlldkVvdWBpi/8EOF
 l+QpnlBTC3rczxPTTQEJg00WZGLfLoU11ba65qyePUcLVI+YNYCaonP78sd42qwJ34qaAN0eH
 wdvy4z8dg2Qb6megtMXiAARVdeT+cKsXzqINQb7sDZmKn54nUtjUEtDNJxaorLljo8Q+QDwCN
 id4UEB9MONC7K8HHuXYzDHYl1BBpOdd1N227IlOPJ5CePq7/lMvls+6d1O7dz5vSBaDrFxq5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295235>

If a new function and a preceding empty line is appended, diff -W shows
the previous function in full in order to provide context for that empty
line.  In most languages empty lines between sections are not 
interesting in and off themselves and showing a whole extra function for
them is not what we want.

Skip empty lines when checking of the appended chunk starts with a
function line, thereby avoiding to extend the context just for them.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 xdiff/xemit.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 969100d..087956a 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -155,6 +155,18 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 	return -1;
 }
 
+static int is_empty_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
+{
+	const char *rec;
+	long len = xdl_get_rec(xdf, ri, &rec);
+
+	while (len > 0 && isspace(*rec)) {
+		rec++;
+		len--;
+	}
+	return !len;
+}
+
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg) {
 	long s1, s2, e1, e2, lctx;
@@ -176,12 +188,18 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			/* Appended chunk? */
 			if (i1 >= xe->xdf1.nrec) {
 				char dummy[1];
+				long i2 = xch->i2;
 
 				/*
 				 * We don't need additional context if
-				 * a whole function was added.
+				 * a whole function was added, possibly
+				 * starting with empty lines.
 				 */
-				if (match_func_rec(&xe->xdf2, xecfg, xch->i2,
+				while (i2 < xe->xdf2.nrec &&
+				       is_empty_rec(&xe->xdf2, xecfg, i2))
+					i2++;
+				if (i2 < xe->xdf2.nrec &&
+				    match_func_rec(&xe->xdf2, xecfg, i2,
 						   dummy, sizeof(dummy)) >= 0)
 					goto post_context_calculation;
 
-- 
2.8.3
