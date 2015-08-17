From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH] am --abort: merge ORIG_HEAD tree into index
Date: Mon, 17 Aug 2015 17:48:19 +0800
Message-ID: <20150817094819.GA10375@yoshi.chippynet.com>
References: <CA+55aFwDkQAS8ULiLt9N5NVOYJ242Nd2MOWeiRX8HrVHXf2zog@mail.gmail.com>
 <CA+55aFwwD=K-i9d40N5FtnTLT-ApZOzmgnXhnuA=C0zw2eBt3Q@mail.gmail.com>
 <03631611149f05dbcd862b4c1e8e9d6b@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 11:48:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRH1q-00009S-5L
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 11:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbbHQJs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 05:48:26 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:32905 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbHQJsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 05:48:25 -0400
Received: by pdrh1 with SMTP id h1so54717619pdr.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XsYA47AjSLX819efc++tGPHZLX6Uu7iB3N2pCaGmSVE=;
        b=pCoy+VrYcn92NfztkbQgoLKNQuwuO2YFSZnwsWmZjDvEu0liBwBcsf3v1fCECrp/za
         RKEA8C+Ef8Cu9nVrAwZyKbSA1kx/kWc+4nIgsP0BMvXagBtvA7byGSSgTA7fQpdn3AaZ
         8HWx0Q2cpZ8MmakE4ksxM2W6anUKfZdB1fU3cj7l3uY+3mPKZvSgOhl9LQL41VyrPoCo
         Yi3VbWlvbA8JBT70WEw7QEfI3mhDjRsh+TUIgMoVfddAj7QrN7lyF2PPiNKPFDY2adAH
         8RPKOg5LBE2ki/AOe5Tg4ZT+IfbZKTSsbEi6MoGS96gwy9rY7Ldc0NNq9DpWFuPkoYM1
         1ihA==
X-Received: by 10.70.130.109 with SMTP id od13mr990071pdb.165.1439804904807;
        Mon, 17 Aug 2015 02:48:24 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id t13sm9718418pdn.89.2015.08.17.02.48.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2015 02:48:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <03631611149f05dbcd862b4c1e8e9d6b@www.dscho.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276045>

On Mon, Aug 17, 2015 at 10:01:29AM +0200, Johannes Schindelin wrote:
> Hi Linus,
> 
> On 2015-08-17 01:33, Linus Torvalds wrote:
> > On Sun, Aug 16, 2015 at 12:46 PM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> Maybe it has always done this, and I just haven't noticed (I usually
> >> _just_ do the "git reset --hard" thing, don't ask me why I wanted to
> >> be doubly sure this time). But maybe it's an effect of the new
> >> built-in "am".
> > 
> > I bisected this. It's definitely used to work, and the regression is
> > from the new built-in am.
> 
> This patch is a reproducer:

Thanks Johannes for the test, and sorry all for the oversight. ><

It's true that we need to merge the ORIG_HEAD tree into the index
instead of overwriting it. Patch below.

Regards,
Paul

-- >8 --
Subject: [PATCH] am --abort: merge ORIG_HEAD tree into index

After running "git am --abort", and then running "git reset --hard",
files that were not modified would still be re-checked out.

This is because clean_index() in builtin/am.c mistakenly called the
read_tree() function, which overwrites all entries in the index,
including the stat info.

Fix this by using unpack_trees() instead to merge the tree into the
index, so that the stat info from the index is kept.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c        | 49 ++++++++++++++++++++++++++++++++++++-------------
 t/t4151-am-abort.sh | 12 ++++++++++++
 2 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1399c8d..6aaa85d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1940,15 +1940,48 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 }
 
 /**
+ * Merges a tree into the index. The index's stat info will take precedence
+ * over the merged tree's. Returns 0 on success, -1 on failure.
+ */
+static int merge_tree(struct tree *tree)
+{
+	struct lock_file *lock_file;
+	struct unpack_trees_options opts;
+	struct tree_desc t[2];
+
+	if (parse_tree(tree))
+		return -1;
+
+	lock_file = xcalloc(1, sizeof(struct lock_file));
+	hold_locked_index(lock_file, 1);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.merge = 1;
+	opts.fn = oneway_merge;
+	init_tree_desc(&t[0], tree->buffer, tree->size);
+
+	if (unpack_trees(1, t, &opts)) {
+		rollback_lock_file(lock_file);
+		return -1;
+	}
+
+	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+		die(_("unable to write new index file"));
+
+	return 0;
+}
+
+/**
  * Clean the index without touching entries that are not modified between
  * `head` and `remote`.
  */
 static int clean_index(const unsigned char *head, const unsigned char *remote)
 {
-	struct lock_file *lock_file;
 	struct tree *head_tree, *remote_tree, *index_tree;
 	unsigned char index[GIT_SHA1_RAWSZ];
-	struct pathspec pathspec;
 
 	head_tree = parse_tree_indirect(head);
 	if (!head_tree)
@@ -1973,18 +2006,8 @@ static int clean_index(const unsigned char *head, const unsigned char *remote)
 	if (fast_forward_to(index_tree, remote_tree, 0))
 		return -1;
 
-	memset(&pathspec, 0, sizeof(pathspec));
-
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-	hold_locked_index(lock_file, 1);
-
-	if (read_tree(remote_tree, 0, &pathspec)) {
-		rollback_lock_file(lock_file);
+	if (merge_tree(remote_tree))
 		return -1;
-	}
-
-	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
-		die(_("unable to write new index file"));
 
 	remove_branch_state();
 
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 05bdc3e..9c3bbd1 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -168,4 +168,16 @@ test_expect_success 'am --abort on unborn branch will keep local commits intact'
 	test_cmp expect actual
 '
 
+test_expect_success 'am --abort leaves index stat info alone' '
+	git checkout -f --orphan stat-info &&
+	git reset &&
+	test_commit should-be-untouched &&
+	test-chmtime =0 should-be-untouched.t &&
+	git update-index --refresh &&
+	git diff-files --exit-code --quiet &&
+	test_must_fail git am 0001-*.patch &&
+	git am --abort &&
+	git diff-files --exit-code --quiet
+'
+
 test_done
-- 
2.5.0.331.g11c07ce
