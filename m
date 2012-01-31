From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] vcs-svn: Fix some compiler warnings
Date: Tue, 31 Jan 2012 18:48:47 +0000
Message-ID: <4F28378F.6080108@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: david.barr@cordelta.com, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 19:51:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsInn-0001wJ-SU
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 19:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548Ab2AaSv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 13:51:26 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:33354 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754498Ab2AaSvV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2012 13:51:21 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1RsInX-00003d-lD; Tue, 31 Jan 2012 18:51:20 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189464>


In particular, some versions of gcc complains as follows:

        CC vcs-svn/sliding_window.o
    vcs-svn/sliding_window.c: In function `check_overflow':
    vcs-svn/sliding_window.c:36: warning: comparison is always false \
        due to limited range of data type

        CC vcs-svn/fast_export.o
    vcs-svn/fast_export.c: In function `fast_export_blob_delta':
    vcs-svn/fast_export.c:303: warning: comparison is always false due \
        to limited range of data type

Simply casting the (limited range unsigned) variable in the comparison
to an uintmax_t does not suppress the warning, however, since gcc is
"smart" enough to know that the cast does not change anything regarding
the value of the casted expression. In order to suppress the warning, we
replace the variable with a new uintmax_t variable initialized with the
value of the original variable.

Note that the "some versions of gcc" which complain includes 3.4.4 and
4.1.2, whereas gcc version 4.4.0 compiles the code without complaint.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jonathan,

When I wrote this patch, your "jn/svn-fe" branch was still in pu, so I was
going to ask you to squash this, or some variant, into any re-roll ...

Note, in the original version of this patch, the change to check_overflow()
was much simpler; it was effectively the same 2-line change (modulo some
variable names) which is applied to fast_export_blob_delta(). But it just
didn't look right (not sure why!), which prompted the renaming of the
function parameter names. This is, obviously, an unrelated change, so maybe
the change to sliding_window.c should be reverted to the 2-line change ...

ATB,
Ramsay Jones

 vcs-svn/fast_export.c    |    3 ++-
 vcs-svn/sliding_window.c |   11 ++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 19d7c34..6edd37e 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -300,7 +300,8 @@ void fast_export_blob_delta(uint32_t mode,
 				uint32_t len, struct line_buffer *input)
 {
 	long postimage_len;
-	if (len > maximum_signed_value_of_type(off_t))
+	uintmax_t delta_len = (uintmax_t) len;
+	if (delta_len > maximum_signed_value_of_type(off_t))
 		die("enormous delta");
 	postimage_len = apply_delta((off_t) len, input, old_data, old_mode);
 	if (mode == REPO_MODE_LNK) {
diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
index 1bac7a4..49a7293 100644
--- a/vcs-svn/sliding_window.c
+++ b/vcs-svn/sliding_window.c
@@ -31,15 +31,16 @@ static int read_to_fill_or_whine(struct line_buffer *file,
 	return 0;
 }
 
-static int check_overflow(off_t a, size_t b)
+static int check_overflow(off_t offset, size_t len)
 {
-	if (b > maximum_signed_value_of_type(off_t))
+	uintmax_t delta_len = (uintmax_t) len;
+	if (delta_len > maximum_signed_value_of_type(off_t))
 		return error("unrepresentable length in delta: "
-				"%"PRIuMAX" > OFF_MAX", (uintmax_t) b);
-	if (signed_add_overflows(a, (off_t) b))
+				"%"PRIuMAX" > OFF_MAX", delta_len);
+	if (signed_add_overflows(offset, (off_t) len))
 		return error("unrepresentable offset in delta: "
 				"%"PRIuMAX" + %"PRIuMAX" > OFF_MAX",
-				(uintmax_t) a, (uintmax_t) b);
+				(uintmax_t) offset, delta_len);
 	return 0;
 }
 
-- 
1.7.9
