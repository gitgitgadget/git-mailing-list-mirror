From: Simon Ruderich <simon@ruderich.org>
Subject: [PATCH v2 1/3] diffcore-pickaxe: remove unnecessary call to
 get_textconv()
Date: Thu, 4 Apr 2013 22:20:29 +0200
Message-ID: <ed31727421dc3000e943e62a8d82ac1af6589733.1365105971.git.simon@ruderich.org>
References: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:21:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqeb-0004MQ-IX
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764774Ab3DDUUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:20:33 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:34050 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764470Ab3DDUUc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:20:32 -0400
Received: from localhost (pD9E97AF7.dip.t-dialin.net [::ffff:217.233.122.247])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Thu, 04 Apr 2013 22:20:30 +0200
  id 0000000000000022.00000000515DE08E.000038EB
Content-Disposition: inline
In-Reply-To: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220088>

get_textconv() is called in diff_grep() to determine the textconv driver
before calling fill_one() and then again in fill_one(). Remove this
unnecessary call by determining the textconv driver before calling
fill_one().

With this change it's also no longer necessary for fill_one() to
modify the textconv argument, therefore pass a pointer instead of
a pointer to a pointer.

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---

Hello,

I've reordered the patches as requested and included Jeff's
cleanup patch.

Regards
Simon

 diffcore-pickaxe.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index b097fa7..8f955f8 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -75,11 +75,10 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
 }
 
 static void fill_one(struct diff_filespec *one,
-		     mmfile_t *mf, struct userdiff_driver **textconv)
+		     mmfile_t *mf, struct userdiff_driver *textconv)
 {
 	if (DIFF_FILE_VALID(one)) {
-		*textconv = get_textconv(one);
-		mf->size = fill_textconv(*textconv, one, &mf->ptr);
+		mf->size = fill_textconv(textconv, one, &mf->ptr);
 	} else {
 		memset(mf, 0, sizeof(*mf));
 	}
@@ -97,8 +96,11 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 	if (diff_unmodified_pair(p))
 		return 0;
 
-	fill_one(p->one, &mf1, &textconv_one);
-	fill_one(p->two, &mf2, &textconv_two);
+	textconv_one = get_textconv(p->one);
+	textconv_two = get_textconv(p->two);
+
+	fill_one(p->one, &mf1, textconv_one);
+	fill_one(p->two, &mf2, textconv_two);
 
 	if (!mf1.ptr) {
 		if (!mf2.ptr)
@@ -201,14 +203,17 @@ static unsigned int contains(mmfile_t *mf, struct diff_options *o,
 static int has_changes(struct diff_filepair *p, struct diff_options *o,
 		       regex_t *regexp, kwset_t kws)
 {
-	struct userdiff_driver *textconv_one = get_textconv(p->one);
-	struct userdiff_driver *textconv_two = get_textconv(p->two);
+	struct userdiff_driver *textconv_one = NULL;
+	struct userdiff_driver *textconv_two = NULL;
 	mmfile_t mf1, mf2;
 	int ret;
 
 	if (!o->pickaxe[0])
 		return 0;
 
+	textconv_one = get_textconv(p->one);
+	textconv_two = get_textconv(p->two);
+
 	/*
 	 * If we have an unmodified pair, we know that the count will be the
 	 * same and don't even have to load the blobs. Unless textconv is in
@@ -219,8 +224,8 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 	if (textconv_one == textconv_two && diff_unmodified_pair(p))
 		return 0;
 
-	fill_one(p->one, &mf1, &textconv_one);
-	fill_one(p->two, &mf2, &textconv_two);
+	fill_one(p->one, &mf1, textconv_one);
+	fill_one(p->two, &mf2, textconv_two);
 
 	if (!mf1.ptr) {
 		if (!mf2.ptr)
-- 
1.8.2

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
