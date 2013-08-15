From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash takes excessively long when many untracked files present
Date: Thu, 15 Aug 2013 10:52:39 -0700
Message-ID: <7vr4durgd4.fsf@alter.siamese.dyndns.org>
References: <20130810214453.GA5719@jtriplet-mobl1>
	<loom.20130813T120243-481@post.gmane.org>
	<7v7gfpy0wy.fsf@alter.siamese.dyndns.org>
	<1fc732a7-6b63-4d75-960f-0b1c6cf9c70e@email.android.com>
	<7vmwolwk94.fsf@alter.siamese.dyndns.org>
	<7v61v9w9dy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Darander <anders.darander@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 15 19:53:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA1jS-00027b-JU
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 19:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721Ab3HORwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 13:52:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49385 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab3HORwp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 13:52:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E33E13977B;
	Thu, 15 Aug 2013 17:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jNq0iHC45Kk+DYfhNGDrzt0SHNE=; b=RbpbYf
	ieudJ2WxWAEYrgBw0JbbIQkf/zmANAdmVqjPqke0nUeKZf5azIGtAmm+oz4kAtBr
	hxVEImym3htmtZAfqWAEdQQE7MRdmXw/APbhSdPp0ZtyHlDbuHn59Nd5qfPZhGOB
	8rwrxMhK/1gp8MG8nnyswNltM811HfNbIAnxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oYAkdo8SZSY/kI08zgLQljFENaG/ewMU
	k5IQJKzQjK8s6JbROHpUPo0x1uS6vD46iWMVBSwaJ25/Xt04kMtQAUsOzIToFcv0
	5pOO75hrS5Pbx4GUiZfReM7fszXFJQwQwWdbu/0d5CVHA/5DiFwP2nd7mU+THtxY
	3hCCS/GMIK8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D66F93977A;
	Thu, 15 Aug 2013 17:52:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E35B39775;
	Thu, 15 Aug 2013 17:52:40 +0000 (UTC)
In-Reply-To: <7v61v9w9dy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 13 Aug 2013 14:47:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AFA1DB4-05D3-11E3-8367-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232356>

Junio C Hamano <gitster@pobox.com> writes:

> In any case, this is a regression introduced in 'master' since the
> last release, and the attempted fix was for an issue that has long
> been with us, so I'll revert a7365313 (git stash: avoid data loss
> when "git stash save" kills a directory, 2013-06-28) soon.  For
> today's -rc3, I'm already deep into the integration cycle, so it is
> too late to do the revert it and then redo everything.
>
> Then we will plan to re-apply the patch once "ls-files --killed"
> gets fixed not to waste too much cycles needlessly, after the coming
> release.

I've already reverted the problematic patch to "git stash" and it
will not be part of the upcoming release.

Here is a quick attempt to see if we can do better in "ls-files -k".

We have an existing test t3010.3 that tries all the combinations of
directory turning into a regular file, symlink, etc. and vice versa,
and it seems to pass.  The test has a directory path6 in the working
tree without any paths in it in the index, and the added bypass code
seems to correctly trigger and prevents us from digging into that
directory, so this patch may be sufficient to improve "ls-files -k".

By the way, regarding the reverted commit, I do not think it is
enough to ask "ls-files -k" to see if the state recorded in the
current index is sufficient.  Imagine your HEAD records "path" as a
file and then you did this:

    $ git reset --hard ;# "path" is now a regular file
    $ mv path path.bak
    $ mkdir path
    $ mv path.bak path/file
    $ git add -A ;# "path/file" in the index and in the working tree
    $ >path/cruft ;# "path/cruft" in the working tree

Then call "save_stash" without saving untracked.  The resulting
stash will save the contents of "path/file" but "path/cruft" is not
recorded anywhere, and then we would need to bring the state in the
working tree and the index back to the state recorded in HEAD, hence
"path" needs to be turned back to a directory.

But "ls-files -k" is asked to check with the index, which has the
path as a directory, so this case is missed.

So instead of

	test -n "$(git ls-files --killed | head -n 1)"

in Pasky's patch, which probably is a right thing to do if you are
running "git stash save --keep-index", you would need something like
this if you are not running with "--keep-index":

	test -n "$(
        	GIT_INDEX_FILE=tmp_index
                export GIT_INDEX_FILE
                git read-tree HEAD
                git ls-files -k
	)"

in order to make sure that the result of going back to the state in
the HEAD will not clobber leftover "path/cruft".

 builtin/ls-files.c | 2 ++
 dir.c              | 9 +++++++++
 dir.h              | 3 ++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 5cf3e31..8500446 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -219,6 +219,8 @@ static void show_files(struct dir_struct *dir)
 
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
+		if (!show_others)
+			dir->flags |= DIR_COLLECT_KILLED_ONLY;
 		fill_directory(dir, pathspec);
 		if (show_others)
 			show_other_files(dir);
diff --git a/dir.c b/dir.c
index 910bfcd..02939e2 100644
--- a/dir.c
+++ b/dir.c
@@ -1183,6 +1183,15 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	    cache_name_exists(path->buf, path->len, ignore_case))
 		return path_none;
 
+	/*
+	 * A directory can only contain killed files if the index
+	 * has a path that wants it to be a non-directory.
+	 */
+	if ((dir->flags & DIR_COLLECT_KILLED_ONLY) &&
+	    (dtype == DT_DIR) &&
+	    !cache_name_exists(path->buf, path->len, ignore_case))
+		return path_none;
+
 	exclude = is_excluded(dir, path->buf, &dtype);
 
 	/*
diff --git a/dir.h b/dir.h
index 3d6b80c..4677b86 100644
--- a/dir.h
+++ b/dir.h
@@ -80,7 +80,8 @@ struct dir_struct {
 		DIR_HIDE_EMPTY_DIRECTORIES = 1<<2,
 		DIR_NO_GITLINKS = 1<<3,
 		DIR_COLLECT_IGNORED = 1<<4,
-		DIR_SHOW_IGNORED_TOO = 1<<5
+		DIR_SHOW_IGNORED_TOO = 1<<5,
+		DIR_COLLECT_KILLED_ONLY = 1<<6
 	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
