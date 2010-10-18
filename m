From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] fast-import: filemodify after M 040000 <tree> "" crashes
Date: Sun, 17 Oct 2010 20:03:38 -0500
Message-ID: <20101018010338.GB25524@burratino>
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
X-From: git-owner@vger.kernel.org Mon Oct 18 03:07:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7eCB-0003QM-EB
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 03:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003Ab0JRBHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 21:07:16 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53682 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab0JRBHP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 21:07:15 -0400
Received: by gyg13 with SMTP id 13so117020gyg.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 18:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fxGe/oLIgzCh2UhIHbthjz51JFLX7wY8L7KWbs2RVW4=;
        b=uRAEvXayQnFrNTgIkofvOZsdcxxk6I2zpUButN8NcH3TexQMarBZI7I4kiibcgNRuo
         jrOaK2RzUuVegD5kQl0uyWKcx9gvbETtr/9ydF93zWTtYKOgP0blnZHOCjRvmMJp/Wih
         CXTV+c4F6GJBR8MtPjwxnXsjzAp8jPre2SpaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uA7fw9d0LwyvVfy1lS/ZC2AP7hvllAnRowNJrn/dPpoJnMqLkXHm3bPBOJkEZpdHrE
         N+bw04ShBypou5UO6Mb/op/wDnvFNFcxEkgyrJ19nGD+ziKk7qc2ZEEssZcc66jbjDDi
         vL6f8E6243lgP7LrrBAAksafyzX+Zqb632JHQ=
Received: by 10.150.177.17 with SMTP id z17mr5732483ybe.170.1287364034228;
        Sun, 17 Oct 2010 18:07:14 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id k2sm649096ybj.8.2010.10.17.18.07.12
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 18:07:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018010005.GA25524@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159221>

Until M 040000 <tree> "" syntax was introduced in commit 2794ad5
(fast-import: Allow filemodify to set the root, 2010-10-10), it
was impossible for the root entry to refer to an unloaded tree.
Update various functions to take that possibility into account.
Otherwise

	M 040000 <tree> ""
	M 100644 :1 "foo"

and similar commands (using D, C, or R after resetting the root
tree) segfault.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c          |   20 ++++++++++++++++----
 t/t9300-fast-import.sh |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 8f68a89..aaf47c5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1444,7 +1444,7 @@ static int tree_content_set(
 	const uint16_t mode,
 	struct tree_content *subtree)
 {
-	struct tree_content *t = root->tree;
+	struct tree_content *t;
 	const char *slash1;
 	unsigned int i, n;
 	struct tree_entry *e;
@@ -1468,6 +1468,9 @@ static int tree_content_set(
 	if (!slash1 && !S_ISDIR(mode) && subtree)
 		die("Non-directories cannot have subtrees");
 
+	if (!root->tree)
+		load_tree(root);
+	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
@@ -1523,7 +1526,7 @@ static int tree_content_remove(
 	const char *p,
 	struct tree_entry *backup_leaf)
 {
-	struct tree_content *t = root->tree;
+	struct tree_content *t;
 	const char *slash1;
 	unsigned int i, n;
 	struct tree_entry *e;
@@ -1534,6 +1537,9 @@ static int tree_content_remove(
 	else
 		n = strlen(p);
 
+	if (!root->tree)
+		load_tree(root);
+	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
@@ -1581,7 +1587,7 @@ static int tree_content_get(
 	const char *p,
 	struct tree_entry *leaf)
 {
-	struct tree_content *t = root->tree;
+	struct tree_content *t;
 	const char *slash1;
 	unsigned int i, n;
 	struct tree_entry *e;
@@ -1592,6 +1598,9 @@ static int tree_content_get(
 	else
 		n = strlen(p);
 
+	if (!root->tree)
+		load_tree(root);
+	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
@@ -2056,13 +2065,16 @@ static uintmax_t do_change_note_fanout(
 		char *fullpath, unsigned int fullpath_len,
 		unsigned char fanout)
 {
-	struct tree_content *t = root->tree;
+	struct tree_content *t;
 	struct tree_entry *e, leaf;
 	unsigned int i, tmp_hex_sha1_len, tmp_fullpath_len;
 	uintmax_t num_notes = 0;
 	unsigned char sha1[20];
 	char realpath[60];
 
+	if (!root->tree);
+		load_tree(root);
+	t = root->tree;
 	for (i = 0; t && i < t->entry_count; i++) {
 		e = t->entries[i];
 		tmp_hex_sha1_len = hex_sha1_len + e->name->str_len;
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 3c0cf05..de95a6e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -928,6 +928,43 @@ test_expect_success \
 	 git diff-tree -C --find-copies-harder -r N5^^ N5 >actual &&
 	 compare_diff_raw expect actual'
 
+test_expect_success \
+	'N: copy to root by id and modify' \
+	'echo "hello, world" >expect.foo &&
+	 echo hello >expect.bar &&
+	 git fast-import <<-SETUP_END &&
+	commit refs/heads/N7
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	hello, tree
+	COMMIT
+
+	deleteall
+	M 644 inline foo/bar
+	data <<EOF
+	hello
+	EOF
+	SETUP_END
+
+	 tree=$(git rev-parse --verify N7:) &&
+	 git fast-import <<-INPUT_END &&
+	commit refs/heads/N8
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	copy to root by id and modify
+	COMMIT
+
+	M 040000 $tree ""
+	M 644 inline foo/foo
+	data <<EOF
+	hello, world
+	EOF
+	INPUT_END
+	 git show N8:foo/foo >actual.foo &&
+	 git show N8:foo/bar >actual.bar &&
+	 test_cmp expect.foo actual.foo &&
+	 test_cmp expect.bar actual.bar'
+
 ###
 ### series O
 ###
-- 
1.7.2.3
