From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] fast-import: add 'ls' command
Date: Fri, 11 Feb 2011 19:21:53 -0600
Message-ID: <20110212012153.GA24736@elie>
References: <20110211224339.GA9973@elie>
 <7vlj1mytjv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	vcs-fast-import-devs@lists.launchpad.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 02:22:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po4Be-0000bk-Gm
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 02:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757821Ab1BLBWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 20:22:03 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38527 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757026Ab1BLBWC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 20:22:02 -0500
Received: by gyb11 with SMTP id 11so1336848gyb.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 17:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=PPC0VAIjp8qlI7Li/BZEgh4636BrOmNo+4zzNMSbJDk=;
        b=UoXYTQslD+NTyMvcS593b45itGEQHFbLwRm5Ki3qBQDXNZb5GSHMMdala+stqPvPNN
         jKTkjuyZIYOSDU3wRIDt40az4l5ms553W8vruxBOaBgb1hoomMARwLvuFQeaYBx2OZhD
         wjJ16uQF1nr5pSku25g/rCq+vZo3fEydgRXqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fe5SaWanVM5xmEyR28c1BO/YbT4Kmw/+BKeOjbfYr/affKzPyYWRoXB3lnTQutQl5r
         yauqatpglLERXL0N0aqoQJfWShh3aygnTtw+0ilVmS+J4IyTYOxMc8oO8twnNR/8jlz0
         dT67tmWecyQeia0p8HAYZdeCJ2WfTyA8xuLZs=
Received: by 10.236.102.129 with SMTP id d1mr2202279yhg.50.1297473720528;
        Fri, 11 Feb 2011 17:22:00 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id x41sm919596yhc.39.2011.02.11.17.21.57
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 17:21:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vlj1mytjv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166586>

(+cc: vcs-fast-import-devs)

Junio C Hamano wrote:

>> There are two forms of the 'ls' command: the two-argument form prints
>> the entry at <path> for the tree underlying the tree, commit, or tag
>> named by <dataref>:
>>
>>       'ls' SP <dataref> SP <path> LF
[...]
> Is this really "ls"?
>
> Obviously, an extended SHA-1 that is accepted by the normal git does not
> have a notion of "marks", but modulo that, the first one looks to me very
> similar to "rev-parse <ref>:<path>" in spirit, which suggests that "the
> path in the current one" might be better spelled as "rev-parse :<path>" to
> make the syntax and the concept more consistent across parts of the
> system.  If it makes sense to allow arbitary <committish> (or <treeish>
> for that matter) for the <dataref> part of the parameter, this observation
> becomes even more true, no?

I suppose so.  It is inspired by "git ls-tree <ref> -- <path>", and
it is convenient that it prints the mode, too (otherwise how do we
tell a regular file from a symlink?).

>> Dirty hack: for now, git fast-import will treat missing paths as empty
>> subtrees and print them as
>>
>>  040000 tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904	path/to/nowhere
>>
>> to avoid confusing frontends that inserted such a path before.
>
> Sorry, but I am not quite sure what this paragraph is trying to say.

Where $empty is the empty tree, I might expect:

	M 040000 $emptytree some/subdirectory
	ls "some/subdirectory"

to result in

	040000 tree $empty	some/subdirectory

On the other hand, I also would expect

	D some/subdirectory
	ls "some/subdirectory"

to result in

	missing some/subdirectory

Since git fast-import (like git itself) does not track empty
subdirectories, the state being reported in both these cases is the
same.  How can it tell the difference between the two?  So the patch
arbitrarily uses the former behavior (reporting nonexistent dirents as
though they were the empty subtree), which seems to work well in
practice.

It is probably be less confusing to use "missing" and let frontends
handle that rather shielding the frontend from reality.  Like so:

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-fast-import.txt |    7 +----
 fast-import.c                     |   32 ++++++++++++--------------
 t/t9300-fast-import.sh            |   44 ++++++++++--------------------------
 3 files changed, 29 insertions(+), 54 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 495e01f..e1b7a0f 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -967,16 +967,13 @@ Output uses the same format as `git ls-tree <tree> {litdd} <path>`:
 The <dataref> represents the blob, tree, or commit object at <path>
 and can be used in later 'cat-blob', 'filemodify', or 'ls' commands.
 
-Git repositories do not distinguish between missing paths and empty
-subtrees.  If a path is not found, 'git fast-import' will report it as
-an empty tree.  Backends that do have a notion of empty trees may write
+If there is no file or subtree at that path, 'git fast-import' will
+instead report
 
 ====
 	missing SP <path> LF
 ====
 
-for paths that do not correspond to a blob or subtree.
-
 `feature`
 ~~~~~~~~~
 Require that fast-import supports the specified feature, or abort if
diff --git a/fast-import.c b/fast-import.c
index cef2b8c..6c37b84 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2931,12 +2931,20 @@ static void print_ls(int mode, const unsigned char *sha1, const char *path)
 		S_ISDIR(mode) ? tree_type :
 		blob_type;
 
-	/* mode SP type SP object_name TAB path LF */
-	strbuf_reset(&line);
-	strbuf_addf(&line, "%06o %s %s\t",
-			mode, type, sha1_to_hex(sha1));
-	quote_c_style(path, &line, NULL, 0);
-	strbuf_addch(&line, '\n');
+	if (!mode) {
+		/* missing SP path LF */
+		strbuf_reset(&line);
+		strbuf_addstr(&line, "missing ");
+		quote_c_style(path, &line, NULL, 0);
+		strbuf_addch(&line, '\n');
+	} else {
+		/* mode SP type SP object_name TAB path LF */
+		strbuf_reset(&line);
+		strbuf_addf(&line, "%06o %s %s\t",
+				mode, type, sha1_to_hex(sha1));
+		quote_c_style(path, &line, NULL, 0);
+		strbuf_addch(&line, '\n');
+	}
 	cat_blob_write(line.buf, line.len);
 }
 
@@ -2978,17 +2986,7 @@ static void parse_ls(struct branch *b)
 	if (S_ISDIR(leaf.versions[1].mode))
 		store_tree(&leaf);
 
-	if (!leaf.versions[1].mode) {
-		/*
-		 * Missing path?  Must be an empty subtree!
-		 *
-		 * When git learns to track empty directories, we can report
-		 * this by saying 'missing "path/to/directory"' instead.
-		 */
-		print_ls(S_IFDIR, (const unsigned char *) EMPTY_TREE_SHA1_BIN, p);
-	} else {
-		print_ls(leaf.versions[1].mode, leaf.versions[1].sha1, p);
-	}
+	print_ls(leaf.versions[1].mode, leaf.versions[1].sha1, p);
 	if (!b || root != &b->branch_tree)
 		release_tree_entry(root);
 }
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index f70d2a9..6b1ba6c 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -934,25 +934,22 @@ test_expect_success PIPE 'N: read and copy directory' '
 	compare_diff_raw expect actual
 '
 
-test_expect_success PIPE 'N: read and copy "empty" directory' '
+test_expect_success PIPE 'N: empty directory reads as missing' '
 	cat <<-\EOF >expect &&
 	OBJNAME
-	:000000 100644 OBJNAME OBJNAME A	greeting
-	OBJNAME
-	:100644 000000 OBJNAME OBJNAME D	unrelated
-	OBJNAME
 	:000000 100644 OBJNAME OBJNAME A	unrelated
 	EOF
-	git update-ref -d refs/heads/copy-empty &&
+	echo "missing src" >expect.response &&
+	git update-ref -d refs/heads/read-empty &&
 	rm -f backflow &&
 	mkfifo backflow &&
 	(
 		exec <backflow &&
 		cat <<-EOF &&
-		commit refs/heads/copy-empty
+		commit refs/heads/read-empty
 		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 		data <<COMMIT
-		copy "empty" (missing) directory
+		read "empty" (missing) directory
 		COMMIT
 
 		M 100644 inline src/greeting
@@ -965,33 +962,16 @@ test_expect_success PIPE 'N: read and copy "empty" directory' '
 		D src/greeting
 		ls "src"
 		EOF
-		read mode type tree filename &&
-		sed -e "s/X\$//" <<-EOF
-		M $mode $tree dst1
-		M $mode $tree dst2
-
-		commit refs/heads/copy-empty
-		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-		data <<COMMIT
-		copy empty directory to root
-		COMMIT
-
-		M $mode $tree X
-
-		commit refs/heads/copy-empty
-		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-		data <<COMMIT
-		add another file
-		COMMIT
-
-		M 100644 inline greeting
-		data <<BLOB
-		hello
-		BLOB
+		read -r line &&
+		printf "%s\n" "$line" >response &&
+		cat <<-\EOF
+		D dst1
+		D dst2
 		EOF
 	) |
 	git fast-import --cat-blob-fd=3 3>backflow &&
-	git rev-list copy-empty |
+	test_cmp expect.response response &&
+	git rev-list read-empty |
 	git diff-tree -r --root --stdin |
 	sed "s/$_x40/OBJNAME/g" >actual &&
 	test_cmp expect actual
-- 
1.7.4
