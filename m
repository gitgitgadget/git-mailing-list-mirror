From: Simon Ruderich <simon@ruderich.org>
Subject: [PATCH v3 3/3] diffcore-pickaxe: respect --no-textconv
Date: Fri, 5 Apr 2013 15:16:30 +0200
Message-ID: <20130405131630.GA23017@ruderich.org>
References: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
 <7d36738417942b594c185953115a244ad6f3c7a0.1365105971.git.simon@ruderich.org>
 <vpq7gkhqvbu.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:11:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWHk-0002u6-DY
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161655Ab3DENQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 09:16:39 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:33845 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab3DENQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 09:16:38 -0400
Received: from localhost (pD9E96A4A.dip.t-dialin.net [::ffff:217.233.106.74])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Fri, 05 Apr 2013 15:16:31 +0200
  id 0000000000000023.00000000515ECEAF.000061AF
Content-Disposition: inline
In-Reply-To: <vpq7gkhqvbu.fsf@grenoble-inp.fr>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220194>

git log -S doesn't respect --no-textconv:

    $ echo '*.txt diff=wrong' > .gitattributes
    $ git -c diff.wrong.textconv='xxx' log --no-textconv -Sfoo
    error: cannot run xxx: No such file or directory
    fatal: unable to read files to diff

Reported-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
On Fri, Apr 05, 2013 at 09:40:21AM +0200, Matthieu Moy wrote:
> While we're there, we could test -G --no-textconv too.

Hello Matthieu,

Good idea, I've added it.

Regards
Simon

 diffcore-pickaxe.c     | 12 ++++++++----
 t/t4209-log-pickaxe.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

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
index eed7273..38fb80f 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -80,6 +80,20 @@ test_expect_success 'log -G -i (match)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log -G --textconv (missing textconv tool)' '
+	echo "* diff=test" >.gitattributes &&
+	test_must_fail git -c diff.test.textconv=missing log -Gfoo &&
+	rm .gitattributes
+'
+
+test_expect_success 'log -G --no-textconv (missing textconv tool)' '
+	echo "* diff=test" >.gitattributes &&
+	git -c diff.test.textconv=missing log -Gfoo --no-textconv >actual &&
+	>expect &&
+	test_cmp expect actual &&
+	rm .gitattributes
+'
+
 test_expect_success 'log -S (nomatch)' '
 	git log -Spicked --format=%H >actual &&
 	>expect &&
@@ -116,4 +130,18 @@ test_expect_success 'log -S -i (nomatch)' '
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
