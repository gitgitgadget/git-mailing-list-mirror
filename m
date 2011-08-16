From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] revert: plug memory leak in "cherry-pick root commit"
 codepath
Date: Tue, 16 Aug 2011 13:16:33 -0500
Message-ID: <20110816181633.GB10336@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-7-git-send-email-artagnon@gmail.com>
 <20110814131303.GF18466@elie.gateway.2wire.net>
 <CALkWK0=zqyvL8zo9wvBGUXyf3RWSZB7dY=WaC9TN6YXnThag0Q@mail.gmail.com>
 <20110814152204.GJ18466@elie.gateway.2wire.net>
 <7v39h1i6rr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 20:16:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtOBw-0006HR-5E
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 20:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab1HPSQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 14:16:39 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47099 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab1HPSQj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 14:16:39 -0400
Received: by gxk21 with SMTP id 21so142586gxk.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hbJN1BgC37qOYuITmtye9monh5suBYi9iFgayiz1GNA=;
        b=KiG5gVyp1bGb7HQJZLGXcDGBqj8Fk0n6F+IIKEdtqMxbHiCemM6dp9gtbg211aA2fM
         mVSRtoeXiSCWTw+U9yaH0ZDyHI0jXei3I4c7ciSHfCuIgC6hQ03lDcZ9hxgtsb+6/zV9
         zVAd1uhciNh5VMcGAIkRFMzoRD5uNnANAHjLg=
Received: by 10.90.40.6 with SMTP id n6mr11798agn.140.1313518598266;
        Tue, 16 Aug 2011 11:16:38 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-67-175.dsl.chcgil.ameritech.net [69.209.67.175])
        by mx.google.com with ESMTPS id l13sm219515anj.42.2011.08.16.11.16.35
        (version=SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 11:16:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v39h1i6rr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179465>

Junio C Hamano wrote:

> Thanks for noticing, but shouldn't we be just using
>
> 	lookup_tree((const unsigned char *)EMPTY_TREE_SHA1_BIN)
>
> or something, instead of hand-crafting a fake tree object?

Yes.  Ever since v1.5.5-rc0~180^2~1 (hard-code the empty tree object,
2008-02-13), there is no need to call pretend_sha1_file() again to
get a fake empty tree object, so this lookup_tree() should work
fine.

-- >8 --
Subject: revert: plug memory leak in "cherry-pick root commit" codepath

For each parentless commit it is asked to reuse, "git cherry-pick" and
"git revert" hand-craft a fake parent tree object on the heap to pass
to merge_trees().  Leaking such a small one-time allocation would not
be a big deal, but now that cherry-pick/revert can take multiple
commit arguments, it can start to add up.

The fix is simple: don't create a new fake empty tree at all, but rely
on the built-in one that has existed since 346245a1 (hard-code the
empty tree object, 2008-02-13).

While at it, add a test to make sure cherry-picking multiple
parentless commits continues to work.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c            |    7 +------
 t/t3503-cherry-pick-root.sh |   27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 853e9e40..a26a7c93 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -273,12 +273,7 @@ static void write_message(struct strbuf *msgbuf, const char *filename)
 
 static struct tree *empty_tree(void)
 {
-	struct tree *tree = xcalloc(1, sizeof(struct tree));
-
-	tree->object.parsed = 1;
-	tree->object.type = OBJ_TREE;
-	pretend_sha1_file(NULL, 0, OBJ_TREE, tree->object.sha1);
-	return tree;
+	return lookup_tree((const unsigned char *)EMPTY_TREE_SHA1_BIN);
 }
 
 static NORETURN void die_dirty_index(const char *me)
diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index b0faa299..472e5b80 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -16,15 +16,40 @@ test_expect_success setup '
 	echo second > file2 &&
 	git add file2 &&
 	test_tick &&
-	git commit -m "second"
+	git commit -m "second" &&
+
+	git symbolic-ref HEAD refs/heads/third &&
+	rm .git/index file2 &&
+	echo third > file3 &&
+	git add file3 &&
+	test_tick &&
+	git commit -m "third"
 
 '
 
 test_expect_success 'cherry-pick a root commit' '
 
+	git checkout second^0 &&
 	git cherry-pick master &&
 	test first = $(cat file1)
 
 '
 
+test_expect_success 'cherry-pick two root commits' '
+
+	echo first >expect.file1 &&
+	echo second >expect.file2 &&
+	echo third >expect.file3 &&
+
+	git checkout second^0 &&
+	git cherry-pick master third &&
+
+	test_cmp expect.file1 file1 &&
+	test_cmp expect.file2 file2 &&
+	test_cmp expect.file3 file3 &&
+	git rev-parse --verify HEAD^^ &&
+	test_must_fail git rev-parse --verify HEAD^^^
+
+'
+
 test_done
-- 
1.7.6
