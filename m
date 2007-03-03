From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 5/6] Fix some "comparison is always true/false" warnings.
Date: Sat, 03 Mar 2007 18:28:57 +0000
Message-ID: <45E9BE69.4070508@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 19:29:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNYzJ-0007UJ-VY
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 19:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbXCCS3d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 13:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbXCCS3d
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 13:29:33 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:2821 "EHLO
	anchor-post-31.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030361AbXCCS3Y (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Mar 2007 13:29:24 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.42)
	id 1HNYyr-000C26-5C; Sat, 03 Mar 2007 18:29:18 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41308>


On Cygwin the wchar_t type is an unsigned short (16-bit) int.
This results in the above warnings from the return statement in
the wcwidth() function (in particular, the expressions involving
constants with values larger than 0xffff). Simply replace the
use of wchar_t with an unsigned int, typedef-ed as ucs_char_t.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
  utf8.c |   10 ++++++----
  1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/utf8.c b/utf8.c
index 7c80eec..211e100 100644
--- a/utf8.c
+++ b/utf8.c
@@ -3,13 +3,15 @@

  /* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */

+typedef unsigned int ucs_char_t;  /* assuming 32bit int */
+
  struct interval {
    int first;
    int last;
  };

  /* auxiliary function for binary search in interval table */
-static int bisearch(wchar_t ucs, const struct interval *table, int max) {
+static int bisearch(ucs_char_t ucs, const struct interval *table, int max) {
  	int min = 0;
  	int mid;

@@ -56,11 +58,11 @@ static int bisearch(wchar_t ucs, const struct interval *table, int max) {
   *      ISO 8859-1 and WGL4 characters, Unicode control characters,
   *      etc.) have a column width of 1.
   *
- * This implementation assumes that wchar_t characters are encoded
+ * This implementation assumes that ucs_char_t characters are encoded
   * in ISO 10646.
   */

-static int wcwidth(wchar_t ch)
+static int wcwidth(ucs_char_t ch)
  {
  	/*
  	 * Sorted list of non-overlapping intervals of non-spacing characters,
@@ -157,7 +159,7 @@ static int wcwidth(wchar_t ch)
  int utf8_width(const char **start)
  {
  	unsigned char *s = (unsigned char *)*start;
-	wchar_t ch;
+	ucs_char_t ch;

  	if (*s < 0x80) {
  		/* 0xxxxxxx */
-- 
1.5.0
