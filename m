From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 0/11] Create ref-filter from for-each-ref
Date: Sun, 14 Jun 2015 10:04:02 +0200
Message-ID: <vpq8ubmemx9.fsf@anie.imag.fr>
References: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 10:04:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z42u2-00078f-MP
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbbFNIEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:04:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34910 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbbFNIEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:04:16 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5E841Te025025
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 14 Jun 2015 10:04:01 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5E8429P026081;
	Sun, 14 Jun 2015 10:04:02 +0200
In-Reply-To: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
	(karthik nayak's message of "Sun, 14 Jun 2015 01:04:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 14 Jun 2015 10:04:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5E841Te025025
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434873842.3541@WPZ/sCPU/YzupTp8+AHUcg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271609>

karthik nayak <karthik.188@gmail.com> writes:

> The previous version of the patch can be found at :
> http://thread.gmane.org/gmane.comp.version-control.git/271423
>
> Changes :
> * Removed an unnecessary commit (v7 3/12)
> * Change a comment in 01/11 (v8)

And change the order of parameters in ref_filter. More precisely the
diff with v7 is the following, and it looks good to me:

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index e2f15e6..7919206 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -58,7 +58,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	memset(&array, 0, sizeof(array));
 	memset(&filter, 0, sizeof(filter));
 	filter.name_patterns = argv;
-	filter_refs(&array, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN, &filter);
+	filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
 	ref_array_sort(sorting, &array);
 
 	if (!maxcount || array.nr < maxcount)
diff --git a/ref-filter.c b/ref-filter.c
index 310ecd6..43502a4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -818,10 +818,10 @@ static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom
 }
 
 /*
- * Return 1 if the refname matches with one of the patterns,
- * otherwise 0.  The patterns can be literal prefix (e.g. a
- * refname "refs/heads/master" matches a pattern "refs/heads/")
- * or a wildcard (e.g. the same ref matches "refs/heads/m*",too).
+ * Return 1 if the refname matches one of the patterns, otherwise 0.
+ * A pattern can be path prefix (e.g. a refname "refs/heads/master"
+ * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
+ * matches "refs/heads/m*",too).
  */
 static int match_name_as_path(const char **pattern, const char *refname)
 {
@@ -912,7 +912,7 @@ void ref_array_clear(struct ref_array *array)
  * as per the given ref_filter structure and finally store the
  * filtered refs in the ref_array structure.
  */
-int filter_refs(struct ref_array *array, unsigned int type, struct ref_filter *filter)
+int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type)
 {
 	struct ref_filter_cbdata ref_cbdata;
 
diff --git a/ref-filter.h b/ref-filter.h
index 6ab2a75..6997984 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -23,7 +23,7 @@ struct atom_value {
 
 struct ref_sorting {
 	struct ref_sorting *next;
-	int atom; /* index into 'struct atom_value *' array */
+	int atom; /* index into used_atom array (internal) */
 	unsigned reverse : 1;
 };
 
@@ -55,7 +55,7 @@ struct ref_filter_cbdata {
  * as per the given ref_filter structure and finally store the
  * filtered refs in the ref_array structure.
  */
-int filter_refs(struct ref_array *array, unsigned int type, struct ref_filter *filter);
+int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
 /*  Parse format string and sort specifiers */

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
