From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH/RFC] typechange tests for git apply (currently failing)
Date: Sun, 16 Jul 2006 23:21:39 -0700
Message-ID: <7vwtaciwek.fsf@assigned-by-dhcp.cox.net>
References: <1153046320538-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 08:23:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2MVj-0001bY-DS
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 08:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWGQGVm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 02:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWGQGVm
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 02:21:42 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:35526 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751156AbWGQGVl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jul 2006 02:21:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060717062140.WYPM12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Jul 2006 02:21:40 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <1153046320538-git-send-email-normalperson@yhbt.net> (Eric Wong's
	message of "Sun, 16 Jul 2006 03:38:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23965>

Eric Wong <normalperson@yhbt.net> writes:

> I've found that git apply is incapable of handling patches
> involving object type changes to the same path.

It's more of directory vs file conflicts -- and we do not track
directories.  Some are pure bugs and relatively simple to fix
(and important), some others I am not sure if they are worth
dealing with.

> +test_expect_success 'file renamed from foo to foo/baz' '
> +	git checkout -f initial &&
> +	git diff-tree -M -p HEAD foo-baz-renamed-from-foo > patch &&
> +	git apply --index < patch
> +	'

If you look at where it fails closely you would notice this
first fails during git-checkout (without failing, I should
add).  Try adding "git diff" immediately after "git checkout".

A fix for read-tree is in this message to fix this, but this has
only been very lightly tested, so please check it thoroughly.

After that is cleared, this and the next one uncover a few bugs
in "git apply".

> +test_expect_success 'file renamed from foo/baz to foo' '
> +	git checkout -f foo-baz-renamed-from-foo &&
> +	git diff-tree -M -p HEAD initial > patch &&
> +	git apply --index < patch
> +	'
> +test_debug 'cat patch'

one-way merge used in "git checkout -f" does not remove existing
directory when checking out a file.  "git reset --hard" used to
be more careful but recent rewrite made them more or less
equivalent, and now has the same problem.  This patch to read-tree
should fix it.

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 6df5d7c..122b6f1 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -507,7 +507,7 @@ static int merged_entry(struct cache_ent
 	}
 
 	merge->ce_flags &= ~htons(CE_STAGEMASK);
-	add_cache_entry(merge, ADD_CACHE_OK_TO_ADD);
+	add_cache_entry(merge, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 	return 1;
 }
 
@@ -518,7 +518,7 @@ static int deleted_entry(struct cache_en
 	else
 		verify_absent(ce->name, "removed");
 	ce->ce_mode = 0;
-	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD);
+	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 	invalidate_ce_path(ce);
 	return 1;
 }


Then apply, when applying to create a file where a directory
lies, or vice versa, was not careful and did not remove
conflicting one.  This patch makes the first few tests to work,
but it is not enough.

Currently, builtin-apply.c::write_out_one_result() says "remove
the old, write the new" for each "struct patch" (which
corresponds to "diff --git" line in your patch file).  I think
the loop write_out_results() should be modified to first remove
what we are going to remove in all patches, and then create what
we are going to create.

What causes the fourth test to fail is that you have foo/baz in
the working tree and the index, and the patch creates file foo
and removes file foo/baz.  The current loop to deal with one
patch at a time means we try to create file "foo" first, which
would not work without removing directory "foo" first.

diff --git a/builtin-apply.c b/builtin-apply.c
index c903146..9727442 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1732,9 +1732,14 @@ static int check_patch(struct patch *pat
 		if (check_index && cache_name_pos(new_name, strlen(new_name)) >= 0)
 			return error("%s: already exists in index", new_name);
 		if (!cached) {
-			if (!lstat(new_name, &st))
-				return error("%s: already exists in working directory", new_name);
-			if (errno != ENOENT)
+			struct stat nst;
+			if (!lstat(new_name, &nst)) {
+				if (S_ISDIR(nst.st_mode))
+					; /* ok */
+				else
+					return error("%s: already exists in working directory", new_name);
+			}
+			else if ((errno != ENOENT) && (errno != ENOTDIR))
 				return error("%s: %s", new_name, strerror(errno));
 		}
 		if (!patch->new_mode) {
@@ -2011,6 +2016,16 @@ static void create_one_file(char *path, 
 	}
 
 	if (errno == EEXIST) {
+		/* We may be trying to create a file where a directory
+		 * used to be.
+		 */
+		struct stat st;
+		errno = 0;
+		if (!lstat(path, &st) && S_ISDIR(st.st_mode) && !rmdir(path))
+			errno = EEXIST;
+	}
+
+	if (errno == EEXIST) {
 		unsigned int nr = getpid();
 
 		for (;;) {
