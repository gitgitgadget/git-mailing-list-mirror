From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH 3/2] notes-merge: Don't remove .git/NOTES_MERGE_WORKTREE;
 it may be the user's cwd
Date: Thu, 15 Mar 2012 01:04:12 -0700
Message-ID: <7vzkbijnnn.fsf_-_@alter.siamese.dyndns.org>
References: <7vlin3qdpt.fsf@alter.siamese.dyndns.org>
 <1331769333-13890-1-git-send-email-johan@herland.net>
 <7vipi6l52w.fsf@alter.siamese.dyndns.org>
 <7v7gyml4g7.fsf@alter.siamese.dyndns.org>
 <CALKQrgfpM-y=9O=h33jxirVoOO8dHHO8tWCR9RatxTottpRXFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	david@tethera.net, pclouds@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 09:04:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S85fm-0004NI-2s
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 09:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906Ab2COIE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 04:04:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32956 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756213Ab2COIEP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 04:04:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56FC951C4;
	Thu, 15 Mar 2012 04:04:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wSVVnS7HTy+gsXZ3vW8/e/L4cNM=; b=lichrU
	HCeML2NpXoiecslYOIJ3UXsMxBFdYVuJknbrIkd52tNOBBHeZqdIe6o6nwgHYVNB
	4d6nEsAHwm7Lma/BPhaiBVP3K1dtnpycjfx7hgonBO7Vc25GiLBiaDg9SXGNhUah
	p6KmzOEyk+43tVcSIrr7X+Ro6K56Ixqjq+aN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BiEpU96qgTUiVYXGIuanVJ5Vysni7A51
	2px1vUaqpXk4YOSH4hG3dpo/S4HvUuIbK4KrVuUflnhl7rEgPhkH3LSzwpXIz8+O
	K5gDP8G/zpTr9DtUib/5aWnyJjknJceXW96JrqulWHvgf9t0ZwYi/I1FpKiElW8N
	D65ugOjhE8c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E53351C3;
	Thu, 15 Mar 2012 04:04:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9773551C2; Thu, 15 Mar 2012
 04:04:13 -0400 (EDT)
In-Reply-To: <CALKQrgfpM-y=9O=h33jxirVoOO8dHHO8tWCR9RatxTottpRXFA@mail.gmail.com> (Johan
 Herland's message of "Thu, 15 Mar 2012 08:39:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7420342A-6E75-11E1-B187-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193195>

Johan Herland <johan@herland.net> writes:

> On Thu, Mar 15, 2012 at 08:16, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> I actually suspect that the passing of "only_empty" in the original may be
>> a bug in a0f4afb (clean: require double -f options to nuke nested git
>> repository and work tree, 2009-06-30), and this patch might be a fix to
>> the bug, but I didn't think things through, and it is getting late, so...
>
> I noticed the same while looking at this function, and I think your
> analysis is correct. As it stands, REMOVE_DIR_KEEP_NESTED_GIT only
> applies to .git folders located directly in the toplevel dir, and not
> inside a subdirectory. That strikes me as odd given the name of the
> flag.

This ended up to be totally unrelated to what you wanted to achieve, but
here is a potential fix. I only tested this by running the usual tests and
additional tests in this patch; we know the coverage of "git clean" is
spotty and its implementation is lower quality than others, so please take
it with a large grain of salt.

The basic idea is to report from the lower level of recursion if it
decided to leave something in the directory back to the upper level,
and have the upper level refrain from removing itself (and when this
happens, that upper level in turn reports that it kept the directory
it is in charge of to its own caller), to avoid returning -1 from the
remove_dir_recursively() to the caller when we deliberately not run
rmdir() on a directory to prevent "git clean" from issuing a warning()
or exiting with an error.

-- >8 --
Subject: clean: preserve nested git worktree in subdirectories

remove_dir_recursively() had a check to avoid removing the directory it
was asked to remove without recursing into it and report success when the
directory is the top level of a working tree of a nested git repository,
to protext such a repository from "clean -f" (without double -f). If a
working tree of a nested git repository is in a subdirectory of a toplevel
project, however, this protection did not apply.

Pass REMOVE_DIR_KEEP_NESTED_GIT flag down to the recursive removal
codepath, and also teach the higher level not to remove the directory it
is asked to remove, when the recursed invocation did not remove the
directory it was asked to remove due to a nested git repository, as it is
not an error to leave the parent directories of such a nested repository.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c            |   21 ++++++++++++++++-----
 t/t7300-clean.sh |   27 ++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/dir.c b/dir.c
index 6432728..0e09556 100644
--- a/dir.c
+++ b/dir.c
@@ -1172,23 +1172,27 @@ int is_empty_dir(const char *path)
 	return ret;
 }
 
-int remove_dir_recursively(struct strbuf *path, int flag)
+static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 {
 	DIR *dir;
 	struct dirent *e;
-	int ret = 0, original_len = path->len, len;
+	int ret = 0, original_len = path->len, len, kept_down = 0;
 	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
 	int keep_toplevel = (flag & REMOVE_DIR_KEEP_TOPLEVEL);
 	unsigned char submodule_head[20];
 
 	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
-	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head))
+	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
 		/* Do not descend and nuke a nested git work tree. */
+		if (kept_up)
+			*kept_up = 1;
 		return 0;
+	}
 
 	flag &= ~REMOVE_DIR_KEEP_TOPLEVEL;
 	dir = opendir(path->buf);
 	if (!dir) {
+		/* an empty dir could be removed even if it is unreadble */
 		if (!keep_toplevel)
 			return rmdir(path->buf);
 		else
@@ -1208,7 +1212,7 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 		if (lstat(path->buf, &st))
 			; /* fall thru */
 		else if (S_ISDIR(st.st_mode)) {
-			if (!remove_dir_recursively(path, flag))
+			if (!remove_dir_recurse(path, flag, &kept_down))
 				continue; /* happy */
 		} else if (!only_empty && !unlink(path->buf))
 			continue; /* happy, too */
@@ -1220,11 +1224,18 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 	closedir(dir);
 
 	strbuf_setlen(path, original_len);
-	if (!ret && !keep_toplevel)
+	if (!ret && !keep_toplevel && !kept_down)
 		ret = rmdir(path->buf);
+	else if (kept_up)
+		*kept_up = 1;
 	return ret;
 }
 
+int remove_dir_recursively(struct strbuf *path, int flag)
+{
+	return remove_dir_recurse(path, flag, NULL);
+}
+
 void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 800b536..ccfb54d 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -399,8 +399,8 @@ test_expect_success SANITY 'removal failure' '
 '
 
 test_expect_success 'nested git work tree' '
-	rm -fr foo bar &&
-	mkdir foo bar &&
+	rm -fr foo bar baz &&
+	mkdir -p foo bar baz/boo &&
 	(
 		cd foo &&
 		git init &&
@@ -412,15 +412,24 @@ test_expect_success 'nested git work tree' '
 		cd bar &&
 		>goodbye.people
 	) &&
+	(
+		cd baz/boo &&
+		git init &&
+		>deeper.world
+		git add . &&
+		git commit -a -m deeply.nested
+	) &&
 	git clean -f -d &&
 	test -f foo/.git/index &&
 	test -f foo/hello.world &&
+	test -f baz/boo/.git/index &&
+	test -f baz/boo/deeper.world &&
 	! test -d bar
 '
 
 test_expect_success 'force removal of nested git work tree' '
-	rm -fr foo bar &&
-	mkdir foo bar &&
+	rm -fr foo bar baz &&
+	mkdir -p foo bar baz/boo &&
 	(
 		cd foo &&
 		git init &&
@@ -432,9 +441,17 @@ test_expect_success 'force removal of nested git work tree' '
 		cd bar &&
 		>goodbye.people
 	) &&
+	(
+		cd baz/boo &&
+		git init &&
+		>deeper.world
+		git add . &&
+		git commit -a -m deeply.nested
+	) &&
 	git clean -f -f -d &&
 	! test -d foo &&
-	! test -d bar
+	! test -d bar &&
+	! test -d baz
 '
 
 test_expect_success 'git clean -e' '
