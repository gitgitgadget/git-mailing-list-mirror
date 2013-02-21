From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Provide a mechanism to turn off symlink resolution in
 ceiling paths
Date: Thu, 21 Feb 2013 14:53:42 -0800
Message-ID: <7vk3q1th1l.fsf@alter.siamese.dyndns.org>
References: <1361351364-15479-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@MIT.EDU>,
	David Aguilar <davvid@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"Lars R. Damerow" <lars@pixar.com>, Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 21 23:54:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8f21-0006fR-C6
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 23:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759252Ab3BUWxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 17:53:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49296 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756329Ab3BUWxq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 17:53:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0648BFA5;
	Thu, 21 Feb 2013 17:53:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TKJBUGRZAWvHKybde7CMEzMce8A=; b=et3mCi
	4gAfCMooobAF79EPY2uWC+9iWi0LKZ0m2iHLbGIcUtAezdZ7mFqabi0Aai3I3HB+
	jxTvTVb+N7mNzfKdaIsTimq+L26FJfWOmASELLMt/jja5qW015mBQ/r00LZWYoac
	LYACc6tIXaxuVQsf11OWr9bfZQlzr3vKXR6r0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WChqfvnjjUMl7ujmNqxXwz0Rcn6j/hIY
	xRSJ3N99cZOUzsTWcEpw4MRmcAsCJgY0whcCK4I37Y/wrlCmSkoVizi+8ZSgKCB4
	Tt8V9ZZq30ILE9/lbDm+3G9SZ2BignFlEH9o+Q3xCU6PSMQiyrddHuJzbE7HuFMg
	2jDr49UZzf4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2687BFA3;
	Thu, 21 Feb 2013 17:53:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 096EEBF98; Thu, 21 Feb 2013
 17:53:44 -0500 (EST)
In-Reply-To: <1361351364-15479-1-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Wed, 20 Feb 2013 10:09:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BAC7244-7C79-11E2-933C-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216802>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Unfortunately I am swamped with other work right now so I don't have
> time to test the code and might not be able to respond promptly to
> feedback.

A note like the above is a good way to give a cue to others so that
we can work together to pick up, tie the loose ends and move us
closer to the goal, and is very much appreciated.

I think the patch makes sense; I expanded on the part that has
Anders's report in the log message and added a trivial test.

Testing and eyeballing by others would help very much.  We'd
obviously need our sign-off as well ;-)

Thanks.

-- >8 --
From: Michael Haggerty <mhagger@alum.mit.edu>
Date: Wed, 20 Feb 2013 10:09:24 +0100
Subject: [PATCH] Provide a mechanism to turn off symlink resolution in ceiling paths

Commit 1b77d83cab 'setup_git_directory_gently_1(): resolve symlinks
in ceiling paths' changed the setup code to resolve symlinks in the
entries in GIT_CEILING_DIRECTORIES.  Because those entries are
compared textually to the symlink-resolved current directory, an
entry in GIT_CEILING_DIRECTORIES that contained a symlink would have
no effect.  It was known that this could cause performance problems
if the symlink resolution *itself* touched slow filesystems, but it
was thought that such use cases would be unlikely.  The intention of
the earlier change was to deal with a case when the user has this:

	GIT_CEILING_DIRECTORIES=/home/gitster

but in reality, /home/gitster is a symbolic link to somewhere else,
e.g. /net/machine/home4/gitster. A textual comparison between the
specified value /home/gitster and the location getcwd(3) returns
would not help us, but readlink("/home/gitster") would still be
fast.

After this change was released, Anders Kaseorg <andersk@mit.edu>
reported:

> [...] my computer has been acting so slow when I’m not connected to
> the network.  I put various network filesystem paths in
> $GIT_CEILING_DIRECTORIES, such as
> /afs/athena.mit.edu/user/a/n/andersk (to avoid hitting its parents
> /afs/athena.mit.edu, /afs/athena.mit.edu/user/a, and
> /afs/athena.mit.edu/user/a/n which all live in different AFS
> volumes).  Now when I’m not connected to the network, every
> invocation of Git, including the __git_ps1 in my shell prompt, waits
> for AFS to timeout.

To allow users to work this around, give them a mechanism to turn
off symlink resolution in GIT_CEILING_DIRECTORIES entries.  All the
entries that follow an empty entry will not be checked for symbolic
links and used literally in comparison.  E.g. with these:

	GIT_CEILING_DIRECTORIES=:/foo/bar:/xyzzy or
	GIT_CEILING_DIRECTORIES=/foo/bar::/xyzzy

we will not readlink("/xyzzy"), and with the former, we will not
readlink("/foo/bar"), either.
---
 Documentation/git.txt   | 19 +++++++++++++------
 setup.c                 | 32 ++++++++++++++++++++++----------
 t/t1504-ceiling-dirs.sh | 17 +++++++++++++++++
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6710cb0..5c03616 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -653,12 +653,19 @@ git so take care if using Cogito etc.
 	The '--namespace' command-line option also sets this value.
 
 'GIT_CEILING_DIRECTORIES'::
-	This should be a colon-separated list of absolute paths.
-	If set, it is a list of directories that git should not chdir
-	up into while looking for a repository directory.
-	It will not exclude the current working directory or
-	a GIT_DIR set on the command line or in the environment.
-	(Useful for excluding slow-loading network directories.)
+	This should be a colon-separated list of absolute paths.  If
+	set, it is a list of directories that git should not chdir up
+	into while looking for a repository directory (useful for
+	excluding slow-loading network directories).  It will not
+	exclude the current working directory or a GIT_DIR set on the
+	command line or in the environment.  Normally, Git has to read
+	the entries in this list are read to resolve any symlinks that
+	might be present in order to compare them with the current
+	directory.  However, if even this access is slow, you
+	can add an empty entry to the list to tell Git that the
+	subsequent entries are not symlinks and needn't be resolved;
+	e.g.,
+	'GIT_CEILING_DIRECTORIES=/maybe/symlink::/very/slow/non/symlink'.
 
 'GIT_DISCOVERY_ACROSS_FILESYSTEM'::
 	When run in a directory that does not have ".git" repository
diff --git a/setup.c b/setup.c
index f108c4b..1b12017 100644
--- a/setup.c
+++ b/setup.c
@@ -624,22 +624,32 @@ static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_
 /*
  * A "string_list_each_func_t" function that canonicalizes an entry
  * from GIT_CEILING_DIRECTORIES using real_path_if_valid(), or
- * discards it if unusable.
+ * discards it if unusable.  The presence of an empty entry in
+ * GIT_CEILING_DIRECTORIES turns off canonicalization for all
+ * subsequent entries.
  */
 static int canonicalize_ceiling_entry(struct string_list_item *item,
-				      void *unused)
+				      void *cb_data)
 {
+	int *empty_entry_found = cb_data;
 	char *ceil = item->string;
-	const char *real_path;
 
-	if (!*ceil || !is_absolute_path(ceil))
+	if (!*ceil) {
+		*empty_entry_found = 1;
 		return 0;
-	real_path = real_path_if_valid(ceil);
-	if (!real_path)
+	} else if (!is_absolute_path(ceil)) {
 		return 0;
-	free(item->string);
-	item->string = xstrdup(real_path);
-	return 1;
+	} else if (*empty_entry_found) {
+		/* Keep entry but do not canonicalize it */
+		return 1;
+	} else {
+		const char *real_path = real_path_if_valid(ceil);
+		if (!real_path)
+			return 0;
+		free(item->string);
+		item->string = xstrdup(real_path);
+		return 1;
+	}
 }
 
 /*
@@ -679,9 +689,11 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 		return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
 
 	if (env_ceiling_dirs) {
+		int empty_entry_found = 0;
+
 		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
 		filter_string_list(&ceiling_dirs, 0,
-				   canonicalize_ceiling_entry, NULL);
+				   canonicalize_ceiling_entry, &empty_entry_found);
 		ceil_offset = longest_ancestor_length(cwd, &ceiling_dirs);
 		string_list_clear(&ceiling_dirs, 0);
 	}
diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index cce87a5..3d51615 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -44,6 +44,10 @@ test_prefix ceil_at_sub ""
 GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/"
 test_prefix ceil_at_sub_slash ""
 
+if test_have_prereq SYMLINKS
+then
+	ln -s sub top
+fi
 
 mkdir -p sub/dir || exit 1
 cd sub/dir || exit 1
@@ -68,6 +72,19 @@ test_fail subdir_ceil_at_sub
 GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/"
 test_fail subdir_ceil_at_sub_slash
 
+if test_have_prereq SYMLINKS
+then
+	GIT_CEILING_DIRECTORIES="$TRASH_ROOT/top"
+	test_fail subdir_ceil_at_top
+	GIT_CEILING_DIRECTORIES="$TRASH_ROOT/top/"
+	test_fail subdir_ceil_at_top_slash
+
+	GIT_CEILING_DIRECTORIES=":$TRASH_ROOT/top"
+	test_prefix subdir_ceil_at_top_no_resolve "sub/dir/"
+	GIT_CEILING_DIRECTORIES=":$TRASH_ROOT/top/"
+	test_prefix subdir_ceil_at_top_slash_no_resolve "sub/dir/"
+fi
+
 GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/dir"
 test_prefix subdir_ceil_at_subdir "sub/dir/"
 
-- 
1.8.2.rc0.152.g52dbac4
