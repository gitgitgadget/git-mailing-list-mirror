From: Simon Ruderich <simon@ruderich.org>
Subject: [PATCH v2 3/3] diffcore-pickaxe: respect --no-textconv
Date: Thu, 4 Apr 2013 22:21:55 +0200
Message-ID: <7d36738417942b594c185953115a244ad6f3c7a0.1365105971.git.simon@ruderich.org>
References: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:22:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqfy-0005Tu-2Q
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764450Ab3DDUV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:21:57 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:34050 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763121Ab3DDUV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:21:56 -0400
Received: from localhost (pD9E97AF7.dip.t-dialin.net [::ffff:217.233.122.247])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Thu, 04 Apr 2013 22:21:55 +0200
  id 0000000000000022.00000000515DE0E3.00003AC3
Content-Disposition: inline
In-Reply-To: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220090>

git log -S doesn't respect --no-textconv:

    $ echo '*.txt diff=wrong' > .gitattributes
    $ git -c diff.wrong.textconv='xxx' log --no-textconv -Sfoo
    error: cannot run xxx: No such file or directory
    fatal: unable to read files to diff

Reported-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 diffcore-pickaxe.c     | 12 ++++++++----
 t/t4209-log-pickaxe.sh | 14 ++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 3124f49..26ddf00 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -86,8 +86,10 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 	if (diff_unmodified_pair(p))
 		return 0;
 
-	textconv_one = get_textconv(p->one);
-	textconv_two = get_textconv(p->two);
+	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
+		textconv_one = get_textconv(p->one);
+		textconv_two = get_textconv(p->two);
+	}
 
 	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
 	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
@@ -201,8 +203,10 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 	if (!o->pickaxe[0])
 		return 0;
 
-	textconv_one = get_textconv(p->one);
-	textconv_two = get_textconv(p->two);
+	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
+		textconv_one = get_textconv(p->one);
+		textconv_two = get_textconv(p->two);
+	}
 
 	/*
 	 * If we have an unmodified pair, we know that the count will be the
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
