From: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
Subject: [PATCH 03/10] diffcore-pickaxe.c: Refactor pickaxe_fn signature
Date: Thu, 27 Mar 2014 14:50:49 -0400
Message-ID: <6822f9d947ffb589df25537e2c1e7c4ead7656b0.1395942768.git.davidad@alum.mit.edu>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
Cc: peff@peff.net, l.s.r@web.de,
	"Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 19:52:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFPC-00058A-Eu
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215AbaC0Sva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:51:30 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:64408 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757137AbaC0Sv0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 14:51:26 -0400
X-AuditID: 12074411-f79ab6d000002f0e-48-5334732ddb4c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id A9.81.12046.D2374335; Thu, 27 Mar 2014 14:51:25 -0400 (EDT)
Received: from zayin.local.com ([74.212.183.186])
	(authenticated bits=0)
        (User authenticated as davidad@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2RIp9TL013586
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 27 Mar 2014 14:51:25 -0400
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
In-Reply-To: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
References: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsUixO6iqKtbbBJs8OShicXclU1MFl/O3WKz
	6LrSzWRxZms/s8WPlh5mB1aPv+8/MHk0nTnK7PGsdw+jx+dNch63n21jCWCN4rJJSc3JLEst
	0rdL4Mp4/DKvYKppxYmXJ5gaGCdrdTFyckgImEhcuNTAAmGLSVy4t56ti5GLQ0jgMqPEzDtt
	7CAJIYGVTBIPOspBbDYBZ4lNv/YzgdgiAuISb4/PZAdpYBZYyCjxds9kZpCEsICHxMtNz9lA
	bBYBVYlv23+A2bwCURKHJ15jhthmIPHp2Rkwm1PAQWLy/I1ANgfQMnuJj0ttIcLREq+3LmaD
	uCEKyD7JMoGRfwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXVO93MwSvdSU0k2MkAAU3ME4
	46TcIUYBDkYlHt6L2SbBQqyJZcWVuYcYJTiYlUR45xYAhXhTEiurUovy44tKc1KLDzFKc7Ao
	ifPyLVH3ExJITyxJzU5NLUgtgskycXBKNTC6R0dvvTHnrn1aG7+k4D35DdvcfojvCpiV+nZp
	eFofy4Sjlztvn5KfV5TYyHGs42rS9ZOM6Q/Uj28ue8cVc3BBebnNIrZ9DlKhnftanneefrzW
	QczlR23VTMWAyyv8HGYW59prWyR9L/sR3rUrlu1KRYKwL6sMm5LIbLNXp+dJTkvmEL/rKKXE
	UpyRaKjFXFScCAAd201GPAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245318>

From: "Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>

This function type previously accepted separate regex_t and kwset_t
parameters, which conceptually go together. Here we create a struct to
encapsulate them, in anticipation of adding a third field that
pickaxe_fn's may require.

This parallels the existing diffgrep_cb structure for passing possibly
relevant values through to the callbacks invoked by xdi_diff_outf.

Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
---
 diffcore-pickaxe.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 0d36a3c..7e65095 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -8,17 +8,22 @@
 #include "xdiff-interface.h"
 #include "kwset.h"
 
+struct fn_options {
+	regex_t *regex;
+	kwset_t kws;
+};
+
 typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
 			  struct diff_options *o,
-			  regex_t *regexp, kwset_t kws);
+			  struct fn_options *fno);
 
 static void compile_regex(regex_t *r, const char *s, int cflags);
 
 static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
-			 regex_t *regexp, kwset_t kws, pickaxe_fn fn);
+			 pickaxe_fn fn, struct fn_options *fno);
 
 static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
-		    regex_t *regexp, kwset_t kws, pickaxe_fn fn)
+		    pickaxe_fn fn, struct fn_options *fno)
 {
 	int i;
 	struct diff_queue_struct outq;
@@ -29,7 +34,7 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 		/* Showing the whole changeset if needle exists */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (pickaxe_match(p, o, regexp, kws, fn))
+			if (pickaxe_match(p, o, fn, fno))
 				return; /* do not munge the queue */
 		}
 
@@ -44,7 +49,7 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 		/* Showing only the filepairs that has the needle */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (pickaxe_match(p, o, regexp, kws, fn))
+			if (pickaxe_match(p, o, fn, fno))
 				diff_q(&outq, p);
 			else
 				diff_free_filepair(p);
@@ -83,7 +88,7 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
 
 static int diff_grep(mmfile_t *one, mmfile_t *two,
 		     struct diff_options *o,
-		     regex_t *regexp, kwset_t kws)
+		     struct fn_options *fno)
 {
 	regmatch_t regmatch;
 	struct diffgrep_cb ecbdata;
@@ -91,9 +96,9 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	xdemitconf_t xecfg;
 
 	if (!one)
-		return !regexec(regexp, two->ptr, 1, &regmatch, 0);
+		return !regexec(fno->regex, two->ptr, 1, &regmatch, 0);
 	if (!two)
-		return !regexec(regexp, one->ptr, 1, &regmatch, 0);
+		return !regexec(fno->regex, one->ptr, 1, &regmatch, 0);
 
 	/*
 	 * We have both sides; need to run textual diff and see if
@@ -101,7 +106,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	 */
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
-	ecbdata.regexp = regexp;
+	ecbdata.regexp = fno->regex;
 	ecbdata.hit = 0;
 	xecfg.ctxlen = o->context;
 	xecfg.interhunkctxlen = o->interhunkcontext;
@@ -113,6 +118,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 static void diffcore_pickaxe_grep(struct diff_options *o)
 {
 	regex_t regex;
+	struct fn_options fno;
 	int cflags = REG_EXTENDED | REG_NEWLINE;
 
 	if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
@@ -120,13 +126,14 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
 
 	compile_regex(&regex, o->pickaxe, cflags);
 
-	pickaxe(&diff_queued_diff, o, &regex, NULL, diff_grep);
+	fno.regex = &regex;
+	pickaxe(&diff_queued_diff, o, diff_grep, &fno);
 
 	regfree(&regex);
 	return;
 }
 
-static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
+static unsigned int contains(mmfile_t *mf, struct fn_options *fno)
 {
 	unsigned int cnt;
 	unsigned long sz;
@@ -136,12 +143,12 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 	data = mf->ptr;
 	cnt = 0;
 
-	if (regexp) {
+	if (fno->regex) {
 		regmatch_t regmatch;
 		int flags = 0;
 
 		assert(data[sz] == '\0');
-		while (*data && !regexec(regexp, data, 1, &regmatch, flags)) {
+		while (*data && !regexec(fno->regex, data, 1, &regmatch, flags)) {
 			flags |= REG_NOTBOL;
 			data += regmatch.rm_eo;
 			if (*data && regmatch.rm_so == regmatch.rm_eo)
@@ -152,7 +159,7 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 	} else { /* Classic exact string match */
 		while (sz) {
 			struct kwsmatch kwsm;
-			size_t offset = kwsexec(kws, data, sz, &kwsm);
+			size_t offset = kwsexec(fno->kws, data, sz, &kwsm);
 			const char *found;
 			if (offset == -1)
 				break;
@@ -168,10 +175,10 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 
 static int has_changes(mmfile_t *one, mmfile_t *two,
 		       struct diff_options *o,
-		       regex_t *regexp, kwset_t kws)
+		       struct fn_options *fno)
 {
-	unsigned int one_contains = one ? contains(one, regexp, kws) : 0;
-	unsigned int two_contains = two ? contains(two, regexp, kws) : 0;
+	unsigned int one_contains = one ? contains(one, fno) : 0;
+	unsigned int two_contains = two ? contains(two, fno) : 0;
 	return one_contains != two_contains;
 }
 
@@ -188,7 +195,7 @@ static void compile_regex(regex_t *r, const char *s, int cflags)
 }
 
 static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
-			 regex_t *regexp, kwset_t kws, pickaxe_fn fn)
+			 pickaxe_fn fn, struct fn_options *fno)
 {
 	struct userdiff_driver *textconv_one = NULL;
 	struct userdiff_driver *textconv_two = NULL;
@@ -222,7 +229,7 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 
 	ret = fn(DIFF_FILE_VALID(p->one) ? &mf1 : NULL,
 		 DIFF_FILE_VALID(p->two) ? &mf2 : NULL,
-		 o, regexp, kws);
+		 o, fno);
 
 	if (textconv_one)
 		free(mf1.ptr);
@@ -236,6 +243,7 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 
 static void diffcore_pickaxe_count(struct diff_options *o)
 {
+	struct fn_options fno;
 	const char *needle = o->pickaxe;
 	int opts = o->pickaxe_opts;
 	unsigned long len = strlen(needle);
@@ -252,7 +260,9 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 		kwsprep(kws);
 	}
 
-	pickaxe(&diff_queued_diff, o, regexp, kws, has_changes);
+	fno.regex = regexp;
+	fno.kws = kws;
+	pickaxe(&diff_queued_diff, o, has_changes, &fno);
 
 	if (opts & DIFF_PICKAXE_REGEX)
 		regfree(&regex);
-- 
1.7.12.4 (Apple Git-37)
