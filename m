From: Simon Ruderich <simon@ruderich.org>
Subject: [PATCH 1/2] diffcore-pickaxe: respect --no-textconv
Date: Thu, 4 Apr 2013 18:03:59 +0200
Message-ID: <20130404160359.GA25232@ruderich.org>
References: <vpqd2uay9rq.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 04 18:04:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNmeV-0005uv-Qw
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 18:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762790Ab3DDQEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 12:04:09 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:47413 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762575Ab3DDQEI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 12:04:08 -0400
Received: from localhost (pD9E97AF7.dip.t-dialin.net [::ffff:217.233.122.247])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Thu, 04 Apr 2013 18:04:03 +0200
  id 000000000000001B.00000000515DA473.000059FE
Content-Disposition: inline
In-Reply-To: <vpqd2uay9rq.fsf@grenoble-inp.fr>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220026>

git log -S doesn't respect --no-textconv:

    $ echo '*.txt diff=wrong' > .gitattributes
    $ git -c diff.wrong.textconv='xxx' log --no-textconv -Sfoo
    error: cannot run xxx: No such file or directory
    fatal: unable to read files to diff

Signed-off-by: Simon Ruderich <simon@ruderich.org>
Reported-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
On Thu, Apr 04, 2013 at 10:34:17AM +0200, Matthieu Moy wrote:
> Hi,
>
> It seems the command "git log --no-textconv -Sfoo" still runs the
> textconv filter (noticed because I have a broken textconv filter that
> lets "git log -S" error out).
>
> [snip]

Hello Matthieu,

This patch should fix it. All tests pass.

Regards
Simon

 diffcore-pickaxe.c     | 15 ++++++++++++---
 t/t4209-log-pickaxe.sh | 14 ++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index b097fa7..f814a52 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -78,7 +78,6 @@ static void fill_one(struct diff_filespec *one,
 		     mmfile_t *mf, struct userdiff_driver **textconv)
 {
 	if (DIFF_FILE_VALID(one)) {
-		*textconv = get_textconv(one);
 		mf->size = fill_textconv(*textconv, one, &mf->ptr);
 	} else {
 		memset(mf, 0, sizeof(*mf));
@@ -97,6 +96,11 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 	if (diff_unmodified_pair(p))
 		return 0;
 
+	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
+		textconv_one = get_textconv(p->one);
+		textconv_two = get_textconv(p->two);
+	}
+
 	fill_one(p->one, &mf1, &textconv_one);
 	fill_one(p->two, &mf2, &textconv_two);
 
@@ -201,14 +205,19 @@ static unsigned int contains(mmfile_t *mf, struct diff_options *o,
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
 
+	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
+		textconv_one = get_textconv(p->one);
+		textconv_two = get_textconv(p->two);
+	}
+
 	/*
 	 * If we have an unmodified pair, we know that the count will be the
 	 * same and don't even have to load the blobs. Unless textconv is in
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index eed7273..953cec8 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -116,4 +116,18 @@ test_expect_success 'log -S -i (nomatch)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log -S --textconv (missing textconv tool)' '
+	echo "* diff=test" >.gitattributes &&
+	test_must_fail git -c diff.test.textconv=missing log -Sfoo &&
+	rm .gitattributes
+'
+
+test_expect_success 'log -S --no-textconv (missing textconv tool)' '
+	echo "* diff=test" >.gitattributes &&
+	git -c diff.test.textconv=missing log -Sfoo --no-textconv >actual &&
+	>expect &&
+	test_cmp expect actual &&
+	rm .gitattributes
+'
+
 test_done
-- 
1.8.2

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
