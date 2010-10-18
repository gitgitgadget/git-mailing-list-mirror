From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] fast-import: tighten M 040000 syntax
Date: Sun, 17 Oct 2010 20:08:53 -0500
Message-ID: <20101018010853.GC25524@burratino>
References: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
 <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
 <20101011063429.GA32034@burratino>
 <20101018010005.GA25524@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 03:12:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7eHG-0005QS-G2
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 03:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab0JRBMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 21:12:30 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63348 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab0JRBMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 21:12:30 -0400
Received: by ywi6 with SMTP id 6so111556ywi.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 18:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jY93My3ILb2wt0u5zu5ogpEe/MIk079wh+4Iuwuk0x8=;
        b=VwXUw/oQ9kmXg2KWhmwDL5uxzVQGFCo2Cp+q0OyKDJX8guHuYMOZMDEjFPYZ0yD7wR
         zwCORpWLEqIPxd4saZwLVghigNh32ISmprTfy0C2Vk/Ist0NwBdCCMvP951EYS1cwrgt
         2BH9b9KEulnIef0I157Jv8gzRmM+pBtKcUXRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oRisjq+cq4X+PIHVmQ4wmWKLWeFl3aVNlD/W1lCBafaaQukYvenLx1RdBj+oWF3ni5
         QBuJexLmPdDQbA1k0NYc5Cy7WzygvV/b18xHbuG9t1yxywr81MA2+jSIbUxL20RFhsOw
         Yvn6B4NHeZdd+02o9OCdg2xQkxjbg5uKLTrQo=
Received: by 10.150.178.18 with SMTP id a18mr5688374ybf.449.1287364349229;
        Sun, 17 Oct 2010 18:12:29 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q36sm4824758ybk.6.2010.10.17.18.12.27
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 18:12:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018010005.GA25524@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159222>

When tree_content_set() is asked to modify the path "foo/bar/",
it first recurses like so:

	tree_content_set(root, "foo/bar/", sha1, S_IFDIR) ->
	 tree_content_set(root:foo, "bar/", ...) ->
	  tree_content_set(root:foo/bar, "", ...)

And as a side-effect of 2794ad5 (fast-import: Allow filemodify to set
the root, 2010-10-10), this last call is accepted and changes
the tree entry for root:foo/bar to refer to the specified tree.

That seems safe enough but let's reject the new syntax (we never meant
to support it) and make it harder for frontends to introduce pointless
incompatibilities with git fast-import 1.7.3.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c          |   34 +++++++++++++++++++++++++---------
 t/t9300-fast-import.sh |   30 ++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index aaf47c5..cb947c1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1437,6 +1437,20 @@ static void store_tree(struct tree_entry *root)
 	t->entry_count -= del;
 }
 
+static void tree_content_replace(
+	struct tree_entry *root,
+	const unsigned char *sha1,
+	const uint16_t mode,
+	struct tree_content *newtree)
+{
+	if (!S_ISDIR(mode))
+		die("Root cannot be a non-directory");
+	hashcpy(root->versions[1].sha1, sha1);
+	if (root->tree)
+		release_tree_content_recursive(root->tree);
+	root->tree = newtree;
+}
+
 static int tree_content_set(
 	struct tree_entry *root,
 	const char *p,
@@ -1454,15 +1468,6 @@ static int tree_content_set(
 		n = slash1 - p;
 	else
 		n = strlen(p);
-	if (!slash1 && !n) {
-		if (!S_ISDIR(mode))
-			die("Root cannot be a non-directory");
-		hashcpy(root->versions[1].sha1, sha1);
-		if (root->tree)
-			release_tree_content_recursive(root->tree);
-		root->tree = subtree;
-		return 1;
-	}
 	if (!n)
 		die("Empty path component found in input");
 	if (!slash1 && !S_ISDIR(mode) && subtree)
@@ -2230,6 +2235,10 @@ static void file_change_m(struct branch *b)
 				command_buf.buf);
 	}
 
+	if (!*p) {
+		tree_content_replace(&b->branch_tree, sha1, mode, NULL);
+		return;
+	}
 	tree_content_set(&b->branch_tree, p, sha1, mode, NULL);
 }
 
@@ -2288,6 +2297,13 @@ static void file_change_cr(struct branch *b, int rename)
 		tree_content_get(&b->branch_tree, s, &leaf);
 	if (!leaf.versions[1].mode)
 		die("Path %s not in branch", s);
+	if (!*d) {	/* C "path/to/subdir" "" */
+		tree_content_replace(&b->branch_tree,
+			leaf.versions[1].sha1,
+			leaf.versions[1].mode,
+			leaf.tree);
+		return;
+	}
 	tree_content_set(&b->branch_tree, d,
 		leaf.versions[1].sha1,
 		leaf.versions[1].mode,
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 1df11ad..ce09457 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -929,6 +929,20 @@ test_expect_success \
 	 compare_diff_raw expect actual'
 
 test_expect_success \
+	'N: reject foo/ syntax' \
+	'subdir=$(git rev-parse refs/heads/branch^0:file2) &&
+	 test_must_fail git fast-import <<-INPUT_END
+	commit refs/heads/N5B
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	copy with invalid syntax
+	COMMIT
+
+	from refs/heads/branch^0
+	M 040000 $subdir file3/
+	INPUT_END'
+
+test_expect_success \
 	'N: copy to root by id and modify' \
 	'echo "hello, world" >expect.foo &&
 	 echo hello >expect.bar &&
@@ -965,6 +979,22 @@ test_expect_success \
 	 test_cmp expect.foo actual.foo &&
 	 test_cmp expect.bar actual.bar'
 
+test_expect_success \
+	'N: extract subtree' \
+	'branch=$(git rev-parse --verify refs/heads/branch^{tree}) &&
+	 cat >input <<-INPUT_END &&
+	commit refs/heads/N9
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	extract subtree branch:newdir
+	COMMIT
+
+	M 040000 $branch ""
+	R "newdir" ""
+	INPUT_END
+	 git fast-import <input &&
+	 git diff --exit-code branch:newdir N9'
+
 ###
 ### series O
 ###
-- 
1.7.2.3
