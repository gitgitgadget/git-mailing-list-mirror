From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: fix ls command with empty path
Date: Thu, 8 Mar 2012 01:09:51 -0600
Message-ID: <20120308070951.GA2181@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 08:10:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5XUI-0002Tr-Jk
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 08:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590Ab2CHHKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 02:10:03 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:54110 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751086Ab2CHHKC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 02:10:02 -0500
Received: by obbuo6 with SMTP id uo6so284125obb.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 23:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0S7+yqC4sV0JpRoGtubnhdnNFo5Gn4lqGm1Q17OZlA0=;
        b=u0mf2ESp3zzTcUk27Q9HDHvA30GIUpnknCt/nfETPTjmwQzvZDCsQqbhzbNzVzrX0E
         WI4Fguw8u7uAfnN3ThJRGTm0w3grM9YjbgdfwQvEvQYpSChM/7dv6ws7ewAO4QnqA6ir
         ztDfVYrrxjyVIMVgBQ0ufD5valKdIcTc06v9WWCnNrejZkkkGhCZkWm8XGKTQ5E9EKbk
         4golGkv5taeyRbGnww1JFa9JB0ulQAwUMt7pBX8RnGz8DCmPYpfuxt60pg4IEarZ2fsf
         jHX8uFTJRVcs9We68rIV3oYhEKZIZqJHfytDqz8Gkq5hLR9EsW+q7R18iAwqTQ6ukbks
         sgCw==
Received: by 10.60.5.231 with SMTP id v7mr2330592oev.50.1331190601296;
        Wed, 07 Mar 2012 23:10:01 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id y7sm521382oee.11.2012.03.07.23.10.00
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 23:10:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1331184656-98629-1-git-send-email-davidbarr@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192529>

(+cc: Sverre)
David Barr wrote:

> When the following command is sent to fast-import:
>
>  'ls' SP ':1' SP LF
>
> The expected output is:
>
>  '040000' SP 'tree' SP <dataref> HT LF
>
> The actual output is:
>
>  'missing' SP LF
>
> This is because tree_content_get() is called but expects a non-empty
> path. Instead, copy the root entry and force the mode to S_IFDIR.
>
> Reported-by: Andrew Sayers <andrew-git@pileofstuff.org>
> Signed-off-by: David Barr <davidbarr@google.com>

For what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks very much for taking care of it.

> [Subject: fast-import: fix ls command with empty path]

I would s/fix/accept/ to be more precise about the nature of the
breakage.  (In other words: rather than mishandling ls with an empty
path, fast-import was not handling it at all.)

[...]
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -3019,7 +3019,12 @@ static void parse_ls(struct branch *b)
>  			die("Garbage after path in: %s", command_buf.buf);
>  		p = uq.buf;
>  	}
> -	tree_content_get(root, p, &leaf);
> +	if (*p) {
> +		tree_content_get(root, p, &leaf);
> +	} else {
> +		leaf = *root;
> +		leaf.versions[1].mode = S_IFDIR;
> +	}

If this special case were implemented in tree_content_get(), we would
get support for paths with a trailing '/' (allows useless
incompatibility, bad) and support for requests like

	C "" some/subdir

(good).  What do you think?

-- >8 --
Subject: fast-import: allow filecopy to copy from root

Some subversion users apparently use "svn copy $SVN_ROOT
$SVN_ROOT/subdirectory" from time to time.  svn-fe handles this fine
already since it translates the subversion copy instruction to

	ls ""
	M 040000 <returned tree name> subdirectory

We can easily imagine an alternate importer that would write

	C "" subdirectory

instead, so handle that, too.

A naive implementation would also mean gaining support for copies
where the source has a trailing '/', as in

	C onedir/ anotherdir

but in the spirit of 34215783 (fast-import: tighten M 040000 syntax,
2010-10-17), this patch is careful to reject that syntax to avoid
making it too easy for frontends to introduce unnecessary
incompatibilities with git fast-import 1.7.8 and older and other
fast-import consumers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c          |   32 ++++++++++++++-----------
 t/t9300-fast-import.sh |   62 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 15 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 8dbfd4cc..5ce61bca 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1636,6 +1636,10 @@ static int tree_content_get(
 	unsigned int i, n;
 	struct tree_entry *e;
 
+	if (!*p) {
+		e = root;
+		goto last_component;
+	}
 	slash1 = strchr(p, '/');
 	if (slash1)
 		n = slash1 - p;
@@ -1648,14 +1652,10 @@ static int tree_content_get(
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
-			if (!slash1) {
-				memcpy(leaf, e, sizeof(*leaf));
-				if (e->tree && is_null_sha1(e->versions[1].sha1))
-					leaf->tree = dup_tree_content(e->tree);
-				else
-					leaf->tree = NULL;
-				return 1;
-			}
+			if (!slash1)
+				goto last_component;
+			if (!slash1[1])	/* paths with trailing '/' do not match */
+				return 0;
 			if (!S_ISDIR(e->versions[1].mode))
 				return 0;
 			if (!e->tree)
@@ -1664,6 +1664,14 @@ static int tree_content_get(
 		}
 	}
 	return 0;
+
+last_component:
+	memcpy(leaf, e, sizeof(*leaf));
+	if (e->tree && is_null_sha1(e->versions[1].sha1))
+		leaf->tree = dup_tree_content(e->tree);
+	else
+		leaf->tree = NULL;
+	return 1;
 }
 
 static int update_branch(struct branch *b)
@@ -3005,6 +3013,7 @@ static void parse_ls(struct branch *b)
 		struct object_entry *e = parse_treeish_dataref(&p);
 		root = new_tree_entry();
 		hashcpy(root->versions[1].sha1, e->idx.sha1);
+		root->versions[1].mode = S_IFDIR;
 		load_tree(root);
 		if (*p++ != ' ')
 			die("Missing space after tree-ish: %s", command_buf.buf);
@@ -3019,12 +3028,7 @@ static void parse_ls(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p = uq.buf;
 	}
-	if (*p) {
-		tree_content_get(root, p, &leaf);
-	} else {
-		leaf = *root;
-		leaf.versions[1].mode = S_IFDIR;
-	}
+	tree_content_get(root, p, &leaf);
 	/*
 	 * A directory in preparation would have a sha1 of zero
 	 * until it is saved.  Save, for simplicity.
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2558a2ed..5316b73c 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1047,6 +1047,66 @@ test_expect_success \
 	 git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
 	 compare_diff_raw expect actual'
 
+test_tick
+cat >input <<INPUT_END
+commit refs/heads/N-root-to-subdir
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+copy to subdir
+COMMIT
+
+from refs/heads/branch^0
+C "" subdir
+
+INPUT_END
+
+cat >expect <<\EOF
+:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	subdir/file2/newf
+:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	subdir/file2/oldf
+:100755 100755 85df50785d62d3b05ab03d9cbf7e4a0b49449730 85df50785d62d3b05ab03d9cbf7e4a0b49449730 C100	file4	subdir/file4
+:100755 100755 e74b7d465e52746be2b4bae983670711e6e66657 e74b7d465e52746be2b4bae983670711e6e66657 C100	newdir/exec.sh	subdir/newdir/exec.sh
+:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	subdir/newdir/interesting
+EOF
+test_expect_success \
+	'N: copy with empty source path' \
+	'git fast-import <input &&
+	 git diff-tree -C -C -r --no-commit-id N-root-to-subdir >actual &&
+	 compare_diff_raw expect actual'
+
+test_tick
+cat >input <<INPUT_END
+commit refs/heads/N-unquoted-root-to-subdir
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+increase nesting
+COMMIT
+
+from refs/heads/branch^0
+C  subdir
+
+INPUT_END
+test_expect_success \
+	'N: copy with unquoted empty source path' \
+	'git fast-import <input &&
+	 git diff --exit-code N-root-to-subdir N-unquoted-root-to-subdir'
+
+test_tick
+cat >input <<INPUT_END
+commit refs/heads/N-trailing-slash-in-src
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+copy newdir to newerdir
+COMMIT
+
+from refs/heads/branch^0
+C newdir/ newerdir
+
+INPUT_END
+test_expect_success \
+	'N: reject foo/ as source path' \
+	'# fatal: path not in branch
+	 test_must_fail git fast-import <input'
+
 cat >input <<INPUT_END
 commit refs/heads/N2
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -1293,7 +1353,7 @@ test_expect_success \
 	 compare_diff_raw expect actual'
 
 test_expect_success \
-	'N: reject foo/ syntax' \
+	'N: filemodify: reject foo/ syntax' \
 	'subdir=$(git rev-parse refs/heads/branch^0:file2) &&
 	 test_must_fail git fast-import <<-INPUT_END
 	commit refs/heads/N5B
-- 
1.7.9.2
