From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/5] diff: factor out match_func_rec()
Date: Sat, 21 May 2016 20:45:01 +0200
Message-ID: <5740ACAD.4060901@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4BuH-00011E-Hm
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 20:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbcEUSpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 14:45:32 -0400
Received: from mout.web.de ([212.227.15.4]:61744 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbcEUSpa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 14:45:30 -0400
Received: from [192.168.178.36] ([79.237.63.247]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LxqwW-1bZzwn10Sq-015LIS; Sat, 21 May 2016 20:45:17
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <5740AC28.6010202@web.de>
X-Provags-ID: V03:K0:AtD+LOyGcbcFXlIT46VP4W55XymcaqoPBNYXSBkTUwCc3jfTiiR
 UfH6BHRWpm7Y3OR5LcJ5YjemHDrS8JzY7TZAP6ZnX5RwjGFtvjKIEMJBdRS+sqXEPw4QrYG
 b/LHvPMcjMdXptQMkWAPdpdqAmfhK6iWwEpDwoaBbfD+tS+Fbp9WXoDLDScjxd7Q9cM4UKP
 FcCMmrdGLCNF/qJT2r+6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y7b1fkGKPPM=:n9utV2ghbJwoaqM7v3C3Co
 z/uvzLt6lHAFHQnzcyQJRKindb6NgBUcLjZdlJnj73Y3HafbjFTYz8Coel7bf0PYfiOQ1b9in
 BcdUcJcLgTJmfBvd8CSdZ6epOgayxn88myj6DgFDuv88EwYe7BQRG6IN/E7qmlVtBxYum6jzm
 Ahonh3rUJqETvncU2oeH7sDNqt3H0ctPyK439DTAJRdTcW/qa0EV4iMCHEdC9BCxBIV8XfYMI
 sDs4k2sx0nPiVSAztKN358bAZFDI5IjJA+Sw2IznYKTxxja/ACJdAmJhlVzoZHiUGdXhaFFl3
 YBZsxV6UnwZtxsbM28dlaHRvxKk0Lj7EXX6X28IZjgIXZjPBULKZ6JUDpMT8LHoE4Auk2CURs
 fvq7Zkhe4UTRBodEjMq1XT/OuK8IVzDv2J6WK8S2fneI8jt1+s+ub/phnz1kEHMItZPPdtkw1
 1erR52zIXhmYzV+YgjPmI6T7I1d3LqARLmTKcFqcn9fhyENkhbzqK8pl2+dQPqmbOxp3BKPOh
 P7jiBvZOqSVllVizaVhGsBPT73F7cx2HOgeuZtbwRRT9+/28IAxU0FnOAEGTNdrwYx8EDiINJ
 3wjSeOulsqKyT4fM9BN4R71Ca5PobW4M+mKk2Xnq0oNtHbAH0sO7kFmiQ3l3To4RG2aNqyGjV
 a/0DK28tjmAtHkOv7DXbMuuGiud/N5EvnMUQNUs93cTBbXiQ5nDyBBsZmQKvFavahv+U1CA1X
 J2sGZbOhqxWY6a+7CwrEF0cUJ1p4r3WEpVJUNxRO5T7nQjTyCUuwt7ZMtoMV8HiXbb7MAzl/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295233>

Add match_func_rec(), a helper that wraps accessing a record and calling
the appropriate function for checking if it contains a function line.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
We'll use it in the next patch.  A follow-up patch could inline def_ff()
into it.

 xdiff/xemit.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 993724b..0c87637 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -120,6 +120,16 @@ static long def_ff(const char *rec, long len, char *buf, long sz, void *priv)
 	return -1;
 }
 
+static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
+			   char *buf, long sz)
+{
+	const char *rec;
+	long len = xdl_get_rec(xdf, ri, &rec);
+	if (!xecfg->find_func)
+		return def_ff(rec, len, buf, sz, xecfg->find_func_priv);
+	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
+}
+
 struct func_line {
 	long len;
 	char buf[80];
@@ -128,7 +138,6 @@ struct func_line {
 static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 			  struct func_line *func_line, long start, long limit)
 {
-	find_func_t ff = xecfg->find_func ? xecfg->find_func : def_ff;
 	long l, size, step = (start > limit) ? -1 : 1;
 	char *buf, dummy[1];
 
@@ -136,9 +145,7 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 	size = func_line ? sizeof(func_line->buf) : sizeof(dummy);
 
 	for (l = start; l != limit && 0 <= l && l < xe->xdf1.nrec; l += step) {
-		const char *rec;
-		long reclen = xdl_get_rec(&xe->xdf1, l, &rec);
-		long len = ff(rec, reclen, buf, size, xecfg->find_func_priv);
+		long len = match_func_rec(&xe->xdf1, xecfg, l, buf, size);
 		if (len >= 0) {
 			if (func_line)
 				func_line->len = len;
-- 
2.8.3
