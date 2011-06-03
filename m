From: Andy Lester <andy@petdance.com>
Subject: RFC: C code cleanup
Date: Thu, 2 Jun 2011 22:32:13 -0500
Message-ID: <3ECEA53B-C82C-4F3D-9E40-1D81EC17682E@petdance.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 05:55:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSLTj-0000Qa-7x
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 05:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575Ab1FCDzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 23:55:12 -0400
Received: from huggy.petdance.com ([72.14.176.61]:49326 "EHLO
	huggy.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569Ab1FCDzL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 23:55:11 -0400
X-Greylist: delayed 1373 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jun 2011 23:55:11 EDT
Received: from [192.168.2.130] (99-66-115-101.lightspeed.cicril.sbcglobal.net [99.66.115.101])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: andy)
	by huggy.petdance.com (Postfix) with ESMTP id BCC4CAE233
	for <git@vger.kernel.org>; Thu,  2 Jun 2011 23:32:16 -0400 (EDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174995>

Is the git project interested in patches to code that have no effect on the compiled code, but clean up some of the corners of the code itself?  Or would it be seen as unnecessary code churn?  I'd like to get some feedback before I spend much time on these kinds of cleanups.

Last night I poked around the code tree and turned on gcc's -Wextra flag.  If these sorts of cleanups are something git likes, I'd also look at running under splint (http://splint.org) to see what it might find as well.  I've been doing the same over on the Perl 5 and Parrot projects for years.  It lets me work on more janitorial issues and do what I can to help oft-neglected bits.

Following are some changes I think would be useful.  (I realize they are not in the official SubmittingPatches form.  I'm only listing them as examples of what I think would be helpful.)

Summary:
* Removed an unused argument from a static function.
* Modify local pointers to not cast away constness  
* Remove a test to see if either of two size_t vars are less than zero, which can never happen.
* Make two mmfile_t * function pointers be const mmfile_t *
* Declare three local variables to be const.

I welcome your comments/suggestions/requests.

xoxo,
Andy

commit 2c527e65952ad6aeff4e58270de545724aea8785
Author: Andy Lester <andy@petdance.com>
Date:   Thu Jun 2 09:28:35 2011 -0500

    Removed unused arg from parse_dates()

diff --git a/test-date.c b/test-date.c
index 6bcd5b0..42642ed 100644
--- a/test-date.c
+++ b/test-date.c
@@ -16,7 +16,7 @@ static void show_dates(char **argv, struct timeval *now)
 	}
 }
 
-static void parse_dates(char **argv, struct timeval *now)
+static void parse_dates(char **argv)
 {
 	for (; *argv; argv++) {
 		char result[100];
@@ -61,7 +61,7 @@ int main(int argc, char **argv)
 	if (!strcmp(*argv, "show"))
 		show_dates(argv+1, &now);
 	else if (!strcmp(*argv, "parse"))
-		parse_dates(argv+1, &now);
+		parse_dates(argv+1);
 	else if (!strcmp(*argv, "approxidate"))
 		parse_approxidate(argv+1, &now);
 	else

commit 6c822a7ee8885593f5338cb086d32daa779cb926
Author: Andy Lester <andy@petdance.com>
Date:   Wed Jun 1 23:29:50 2011 -0500

    Change pointers in compare_pt() to be const-correct

diff --git a/builtin/describe.c b/builtin/describe.c
index 66fc291..2983d5d 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -184,8 +184,8 @@ struct possible_tag {
 
 static int compare_pt(const void *a_, const void *b_)
 {
-	struct possible_tag *a = (struct possible_tag *)a_;
-	struct possible_tag *b = (struct possible_tag *)b_;
+	const struct possible_tag *a = (const struct possible_tag *)a_;
+	const struct possible_tag *b = (const struct possible_tag *)b_;
 	if (a->depth != b->depth)
 		return a->depth - b->depth;
 	if (a->found_order != b->found_order)

commit ed2a1e246abab43033351c14603d4ff8a5c3a5ad
Author: Andy Lester <andy@petdance.com>
Date:   Wed Jun 1 23:17:52 2011 -0500

    removed unused sha1 argument from cat_one_file()

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 94632db..389faaa 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -15,7 +15,7 @@
 #define BATCH 1
 #define BATCH_CHECK 2
 
-static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long size)
+static void pprint_tag(const char *buf, unsigned long size)
 {
 	/* the parser in tag.c is useless here. */
 	const char *endp = buf + size;
@@ -131,7 +131,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		if (!buf)
 			die("Cannot read object %s", obj_name);
 		if (type == OBJ_TAG) {
-			pprint_tag(sha1, buf, size);
+			pprint_tag(buf, size);
 			return 0;
 		}
 

commit 151ad9c45f08aa81598664e6e198af881fe52b77
Author: Andy Lester <andy@petdance.com>
Date:   Wed Jun 1 23:16:10 2011 -0500

    Removed unnecessary test in fuzzy_matchlines(). size_t can never be negative

diff --git a/builtin/apply.c b/builtin/apply.c
index 530d4bb..7e6fa4d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -250,9 +250,6 @@ static int fuzzy_matchlines(const char *s1, size_t n1,
 	const char *last2 = s2 + n2 - 1;
 	int result = 0;
 
-	if (n1 < 0 || n2 < 0)
-		return 0;
-
 	/* ignore line endings */
 	while ((*last1 == '\r') || (*last1 == '\n'))
 		last1--;

commit 01659f145328103383d48adadee1afbb3e6b2d5d
Author: Andy Lester <andy@petdance.com>
Date:   Wed Jun 1 22:48:48 2011 -0500

    mmfile_t arguments to count_trailing_blank() and check_blank_at_eof() can be const *

diff --git a/diff.c b/diff.c
index be3d19d..13e79af 100644
--- a/diff.c
+++ b/diff.c
@@ -318,7 +318,7 @@ static unsigned long diff_filespec_size(struct diff_filespec *one)
 	return one->size;
 }
 
-static int count_trailing_blank(mmfile_t *mf, unsigned ws_rule)
+static int count_trailing_blank(const mmfile_t *mf, unsigned ws_rule)
 {
 	const char *ptr = mf->ptr;
 	const long size = mf->size;
@@ -344,7 +344,7 @@ static int count_trailing_blank(mmfile_t *mf, unsigned ws_rule)
 	return cnt;
 }
 
-static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
+static void check_blank_at_eof(const mmfile_t *mf1, const mmfile_t *mf2,
 			       struct emit_callback *ecbdata)
 {
 	int l1, l2, at;

commit c2042e0bc6be027fc6036283b81ef640c1d37b36
Author: Andy Lester <andy@petdance.com>
Date:   Wed Jun 1 22:41:22 2011 -0500

    consted three local vars in count_trailing_blank()

diff --git a/diff.c b/diff.c
index 8f4815b..be3d19d 100644
--- a/diff.c
+++ b/diff.c
@@ -320,8 +320,8 @@ static unsigned long diff_filespec_size(struct diff_filespec *one)
 
 static int count_trailing_blank(mmfile_t *mf, unsigned ws_rule)
 {
-	char *ptr = mf->ptr;
-	long size = mf->size;
+	const char *ptr = mf->ptr;
+	const long size = mf->size;
 	int cnt = 0;
 
 	if (!size)
@@ -332,7 +332,7 @@ static int count_trailing_blank(mmfile_t *mf, unsigned ws_rule)
 	else
 		ptr--; /* skip the last LF */
 	while (mf->ptr < ptr) {
-		char *prev_eol;
+		const char *prev_eol;
 		for (prev_eol = ptr; mf->ptr <= prev_eol; prev_eol--)
 			if (*prev_eol == '\n')
 				break;

--
Andy Lester => andy@petdance.com => www.techworklove.com => AIM:petdance
