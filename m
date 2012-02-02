From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2] vcs-svn: Fix some compiler warnings
Date: Thu, 02 Feb 2012 18:36:26 +0000
Message-ID: <4F2AD7AA.9090904@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 19:38:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt1YA-0003YM-Ft
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 19:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933264Ab2BBSiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 13:38:19 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:35383 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932549Ab2BBSiS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 13:38:18 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1Rt1Y0-0001d6-Z6; Thu, 02 Feb 2012 18:38:17 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189667>


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
introduce a static inline function to hide the (implicit) cast of the
original variable to an uintmax_t type prior to using it in the overflow
check comparison expression.

Note that the "some versions of gcc" which complain includes 3.4.4 and
4.1.2, whereas gcc version 4.4.0 compiles the code without complaint.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jonathan,

Any suggestions for a better name than "value_too_large_for_off_t" will
be greatly accepted! :)

Also, I suppose you could make a similar change to the other two sites
in vcs-svn with similar range checks (fast_export.c:174 and svndiff.c:150).

ATB,
Ramsay Jones

 git-compat-util.h        |    5 +++++
 vcs-svn/fast_export.c    |    2 +-
 vcs-svn/sliding_window.c |    2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8f3972c..6a6a25a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -450,6 +450,11 @@ static inline size_t xsize_t(off_t len)
 	return (size_t)len;
 }
 
+static inline int value_too_large_for_off_t(uintmax_t val)
+{
+	return val > maximum_signed_value_of_type(off_t);
+}
+
 static inline int has_extension(const char *filename, const char *ext)
 {
 	size_t len = strlen(filename);
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 19d7c34..2e0dcb0 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -300,7 +300,7 @@ void fast_export_blob_delta(uint32_t mode,
 				uint32_t len, struct line_buffer *input)
 {
 	long postimage_len;
-	if (len > maximum_signed_value_of_type(off_t))
+	if (value_too_large_for_off_t(len))
 		die("enormous delta");
 	postimage_len = apply_delta((off_t) len, input, old_data, old_mode);
 	if (mode == REPO_MODE_LNK) {
diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
index 1bac7a4..0d38482 100644
--- a/vcs-svn/sliding_window.c
+++ b/vcs-svn/sliding_window.c
@@ -33,7 +33,7 @@ static int read_to_fill_or_whine(struct line_buffer *file,
 
 static int check_overflow(off_t a, size_t b)
 {
-	if (b > maximum_signed_value_of_type(off_t))
+	if (value_too_large_for_off_t(b))
 		return error("unrepresentable length in delta: "
 				"%"PRIuMAX" > OFF_MAX", (uintmax_t) b);
 	if (signed_add_overflows(a, (off_t) b))
-- 
1.7.9
