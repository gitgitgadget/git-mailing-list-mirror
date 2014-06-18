From: Fabian Ruch <bafain@gmail.com>
Subject: [RFC] rebase --root: Empty root commit is replaced with sentinel
Date: Wed, 18 Jun 2014 14:10:00 +0200
Message-ID: <53A18198.7070301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Webb <chris@arachsys.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 14:10:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxEgv-0003vb-05
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 14:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966175AbaFRMKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 08:10:06 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34916 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966020AbaFRMKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 08:10:05 -0400
Received: by mail-wg0-f41.google.com with SMTP id a1so744437wgh.12
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 05:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=W3dZKU+g78PHSrs8EegGo6o8+aoEkPhdCDvQvcr3PNo=;
        b=ZCf8yA4czPh2H3nzwjzW9YCnl//na4o/26h+zpdPpj4XbTZnnyjC9vS6I8zE9ByrS2
         9XL8041YrrUl5bGCHb78zUE+mVd7zKZ1Z0p/167/wl/FeDV07vn8AbrBe4f4RF/700OF
         KMRPWCa9ZkrSP6OhZiwh9ybEqIx55ka2w7LYcqOe/rMKEiVgT6LVAdDf+KKH+RfpWAUY
         QL67w9tDui3yQkoMpgNu8fk1PrB5619N3UqNltGki37esaTfjzCmrx4nHOJ9D51Fszkq
         eyVt9/wMefm5RoovcAcfXfjWKyTNHcWOK68QbvjqA/M4uP+Ccj9v4oB++4uCfshO1mKN
         3K4Q==
X-Received: by 10.180.24.2 with SMTP id q2mr4514301wif.22.1403093403233;
        Wed, 18 Jun 2014 05:10:03 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id i4sm4232557eeo.44.2014.06.18.05.10.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 05:10:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251981>

`rebase` supports the option `--root` both with and without `--onto`.
The case where `--onto` is not specified is handled by creating a
sentinel commit and squashing the root commit into it. The sentinel
commit refers to the empty tree and does not have a log message
associated with it. Its purpose is that `rebase` can rely on having a
rebase base even without `--onto`.

The combination of `--root` and no `--onto` implies an interactive
rebase. When `--preserve-merges` is not specified on the `rebase`
command line, `rebase--interactive` uses `--cherry-pick` with
git-rev-list to put the initial to-do list together. If the root commit
is empty, it is treated as a cherry-pick of the sentinel commit and
omitted from the todo-list. This is unexpected because the user does not
know of the sentinel commit.

Add a test case. Create an empty root commit, run `rebase --root` and
check that it is still there. If the branch consists of the root commit
only, the bug described above causes the resulting history to consist of
the sentinel commit only. If the root commit has children, the resulting
history contains neither the root nor the sentinel commit. This
behaviour is the same with `--keep-empty`.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---

Notes:
    Hi,
    
    This is not a fix yet.
    
    We are currently special casing in `do_pick` and whether the current
    head is the sentinel commit is not a special case that would fit into
    `do_pick`'s interface description. What if we added the feature of
    creating root commits to `do_pick`, using `commit-tree` just like when
    creating the sentinel commit? We would have to add another special case
    (`test -z "$onto"`) to where the to-do list is put together in
    `rebase--interactive`. An empty `$onto` would imply
    
        git rev-list $orig_head
    
    to form the to-do list. The rebase comment in the commit message editor
    would have to become something similar to
    
        Rebase $shortrevisions as new history
    
    , which might be even less confusing than mentioning the hash of the
    sentinel commit.
    
       Fabian

 t/t3412-rebase-root.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 0b52105..a4fe3c7 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -278,4 +278,31 @@ test_expect_success 'rebase -i -p --root with conflict (second part)' '
 	test_cmp expect-conflict-p out
 '
 
+test_expect_success 'rebase --root recreates empty root commit' '
+	echo Initial >expected.msg &&
+	# commit the empty tree, no parents
+	empty_tree=$(git hash-object -t tree /dev/null) &&
+	empty_root_commit=$(git commit-tree $empty_tree -F expected.msg) &&
+	git checkout -b empty-root-commit-only $empty_root_commit &&
+	# implies interactive
+	git rebase --keep-empty --root &&
+	git show --pretty=format:%s HEAD >actual.msg &&
+	test_cmp actual.msg expected.msg
+'
+
+test_expect_success 'rebase --root recreates empty root commit (subsequent commits)' '
+	echo Initial >expected.msg &&
+	# commit the empty tree, no parents
+	empty_tree=$(git hash-object -t tree /dev/null) &&
+	empty_root_commit=$(git commit-tree $empty_tree -F expected.msg) &&
+	git checkout -b empty-root-commit $empty_root_commit &&
+	>file &&
+	git add file &&
+	git commit -m file &&
+	# implies interactive
+	git rebase --keep-empty --root &&
+	git show --pretty=format:%s HEAD^ >actual.msg &&
+	test_cmp actual.msg expected.msg
+'
+
 test_done
-- 
2.0.0
