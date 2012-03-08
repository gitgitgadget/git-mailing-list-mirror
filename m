From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] fast-import: be saner with temporary trees
Date: Thu, 8 Mar 2012 13:12:00 -0600
Message-ID: <20120308191200.GA17903@burratino>
References: <1313489337-2523-1-git-send-email-divanorama@gmail.com>
 <1313489337-2523-2-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 20:12:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5il9-0007Oj-Jk
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 20:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757707Ab2CHTMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 14:12:13 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:49379 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756530Ab2CHTML (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 14:12:11 -0500
Received: by obbuo6 with SMTP id uo6so1025641obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 11:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bNqPsRhrje3w9dKuSm+5SlDHRz39Rg22iU0dnDZuot4=;
        b=uwNDhBqTbxoIAfe7TDEUE8+ev4hcK2M0/NWZz997twor5LVKpW+VUBBHbPc6HLFvAf
         kir64F0I3E8FrbymyUTF2BX5nVZ//un3QqTS9eSDNpB12EiiVh1miaAqGmxCMOArCIUM
         VA0oT9/PlXqmp2K7ZBI6Y130L1PNSosEzw3/3VlmwV7Qzps38rKgzFISB7qRxYbzc0tJ
         xFBiwDKKv0YX7L/7TPHTcS75HXI83Qye8nYNYM685smHNeOxEZQzKKC+JM1KjGdsJQ7Y
         rgMShO8VermAS2D9BBSB4tjaywBTq+ayaLtgbyvGH+iGYCXZgfzxyjVAToArA8psw2I2
         fwWw==
Received: by 10.182.155.68 with SMTP id vu4mr2802763obb.61.1331233930453;
        Thu, 08 Mar 2012 11:12:10 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id x9sm1366098oea.7.2012.03.08.11.12.09
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 11:12:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1313489337-2523-2-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192633>

Hi,

Dmitry Ivankov wrote:

> new_tree_entry/release_tree_entry manage a stack of tree_entry structs
> to use as temporaries. Initializing them is the responsibility of the
> caller,
[...]
> Do initialize entry->versions[0]. As of now, ls command can not list
> the topmost tree so this change is just to avoid surprises in case
> things will change around ls or tree_content_get.
>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
[...]
> +++ b/fast-import.c
> @@ -2951,6 +2951,9 @@ static void parse_ls(struct branch *b)
>  	} else {
>  		struct object_entry *e = parse_treeish_dataref(&p);
>  		root = new_tree_entry();
> +		hashclr(root->versions[0].sha1);
> +		root->versions[0].mode = 0;
> +		root->versions[1].mode = S_IFDIR;
>  		hashcpy(root->versions[1].sha1, e->idx.sha1);

I don't remember what this patch was about or why I acked it, which is
a bad sign.  (If the above explanation doesn't make me want to ack it
again, how is it going to help someone in the future understand the
harm in reverting this patch if some other bug bisects to it?)

I think part of the problem is that the explanation seems to be
phrased in terms of implementation details (root->versions[0] fields,
calling store_tree, initializing entry->versions[0]) instead of the
higher-level logic that these implement.

It sounds ("avoid surprises") like this is meant to avoid scary
behavior from the programmer's perspective, so: what are the symptoms
without this patch, and why is this a good way to eliminate them?

On the other hand, if we squash this in with David's [1], it starts
to make perfect sense.  The explanation can say:

	There is a pathological Subversion operation that svn-fe handles
	incorrectly due to an unexpected response from fast-import:

	  svn cp $SVN_ROOT $SVN_ROOT/subdirectory

	When the following command is sent to fast-import:

	 'ls' SP ':1' SP LF

	The expected output is:

	 '040000' SP 'tree' SP <dataref> HT LF

	The actual output is:

	 'missing' SP LF

	This is because tree_content_get() is called but expects a non-empty
	path. Instead, copy the root entry and force the mode to S_IFDIR.

	In the 'ls <dataref> ""' case, this requires some care, because
	parse_ls currently uses an uninitialized temporary tree entry
	from the new_tree_entry/release_tree_entry stack in a quick and
	dirty way without initializing its fields well enough for
	functions like store_tree that might calculate its tree name.

Sensible?  Alternatively, we could rush in David's [1] with the
tweak below to dodge the 'ls <dataref> ""' case, and include your fix
as part of a patch that just addresses that case.

Thanks very much for the patch and the reminder.

Sincerely,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/192517/focus=192520
---
 fast-import.c          |    2 +-
 t/t9300-fast-import.sh |   66 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 8dbfd4cc..2748ced2 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3019,7 +3019,7 @@ static void parse_ls(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p = uq.buf;
 	}
-	if (*p) {
+	if (*p || root != &b->branch_tree) {
 		tree_content_get(root, p, &leaf);
 	} else {
 		leaf = *root;
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2558a2ed..2f411fbb 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1400,8 +1400,72 @@ test_expect_success \
 	 test_cmp expect.qux actual.qux &&
 	 test_cmp expect.qux actual.quux'
 
+test_expect_success 'N: root of unborn branch reads as present and empty' '
+	empty_tree=$(git mktree </dev/null) &&
+	echo "040000 tree $empty_tree	" >expect &&
+	git fast-import --cat-blob-fd=3 3>actual <<-EOF &&
+	commit refs/heads/N-empty
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	read empty root directory via ls
+	COMMIT
+
+	ls ""
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'N: empty root reads as present and empty' '
+	empty_tree=$(git mktree </dev/null) &&
+	echo "040000 tree $empty_tree	" >expect &&
+	echo empty >msg &&
+	cmit=$(git commit-tree "$empty_tree" -p refs/heads/branch^0 <msg) &&
+	git fast-import --cat-blob-fd=3 3>actual <<-EOF &&
+	commit refs/heads/N-empty-existing
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	read empty root directory via ls
+	COMMIT
+
+	ls ""
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'N: "ls" command can read subdir of named tree' '
+	branch_cmit=$(git rev-parse --verify refs/heads/branch^0) &&
+	subdir_tree=$(git rev-parse $branch_cmit:newdir) &&
+	echo "040000 tree $subdir_tree	newdir" >expect &&
+	git fast-import --cat-blob-fd=3 3>actual <<-EOF &&
+	commit refs/heads/N-subdir-of-named-tree
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	read from commit with ls
+	COMMIT
+
+	ls $branch_cmit "newdir"
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_failure 'N: "ls" command can read root of named commit' '
+	branch_cmit=$(git rev-parse --verify refs/heads/branch^0) &&
+	branch_tree=$(git rev-parse --verify $branch_cmit:) &&
+	echo "040000 tree $branch_tree	" >expect &&
+	git fast-import --cat-blob-fd=3 3>actual <<-EOF &&
+	commit refs/heads/N-root-of-named-tree
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	read root of commit with ls
+	COMMIT
+
+	ls $branch_cmit ""
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success PIPE 'N: read and copy root' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/file2/newf
 	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/file2/oldf
 	:100755 100755 85df50785d62d3b05ab03d9cbf7e4a0b49449730 85df50785d62d3b05ab03d9cbf7e4a0b49449730 C100	file4	file3/file4
-- 
1.7.9.2
