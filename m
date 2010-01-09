From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-files: fix overeager pathspec optimization
Date: Fri, 08 Jan 2010 16:54:34 -0800
Message-ID: <7v8wc8kshh.fsf@alter.siamese.dyndns.org>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
 <20100108164132.GA6171@coredump.intra.peff.net>
 <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7v8wc8jw3k.fsf@alter.siamese.dyndns.org>
 <7vvdfcfjxo.fsf@alter.siamese.dyndns.org>
 <7veim0w68q.fsf_-_@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081520240.7821@localhost.localdomain>
 <7v3a2gnnv2.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081619570.7821@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 01:54:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTPbU-0005ga-Nr
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 01:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab0AIAyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 19:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638Ab0AIAyv
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 19:54:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab0AIAyu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 19:54:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A74348FB91;
	Fri,  8 Jan 2010 19:54:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ulHl3kKpimEyGlH0hze5X4GZln8=; b=fdquyQ
	P5Qx8nezmm46bB3GkELctuS91L+YcVFB0xgyGTcZpPcmL1ihXIYWV51BdVwpmaAs
	3K0cEvPjL/vVzPvOfD81HB0G3fwW66BZ9fXAfAeI3h3lJAYvo2FzJVRsqT+X2NIZ
	aaOr3LuYXpxU2ScgRpNAwOhNbiLtW7mzGg6+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a4WvJEw6x/TLgQMtGxpmMkuHCrn5Um6s
	N/OymldmzM+Pk0jtC70V4wY5vgWMND6TJOJgGGfMTgS/8f1EdwR36dzKenHO9tFo
	O+4t5zvPEb9J21OQh7zK7xcpOhaJ9sZyQK/0RY/1B7GxtSbxEr85ThA4kRwqEyWA
	vcFRqwgfwdo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 42DDF8FB8B;
	Fri,  8 Jan 2010 19:54:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD3008FB82; Fri,  8 Jan
 2010 19:54:35 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001081619570.7821@localhost.localdomain>
 (Linus Torvalds's message of "Fri\, 8 Jan 2010 16\:24\:21 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 92F5667A-FCB9-11DE-B7B7-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136503>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I have this memory that _used_ to have a per-filename flag in "git add" 
> that checked if that particular filename component was used or not. But 
> now it just looks at 'dir->ignored_nr' and 'dir->ignored[]'.

Yes, and the previous patch wasn't adding what is ignored to the array, so
here is a re-roll to fix that in addition to the fix to "should the loop
start from checking an empty path?" issue you noticed.

But I am starting to wonder if we might be better off restructuring
read_directory_recursive().  Currently it assumes that the path it was
given _must_ be of interest (i.e. not ignored) and runs excluded() on
subdirectories it finds to make that same decision before recursing into
them or skipping them.  It might make more sense if it first checked if
the path given by the caller should be ignored and act accordingly. If it
is to be ignored, perhaps it will simply return without doing anything
(normal case), or it will return but adds the path to ignored[]
(DIR_COLLECT_IGNORED case), or it will recurse into itself but tell it
that everything it finds is to be ignored.  I dunno...

-- >8 --
Subject: [PATCH (v3)] ls-files: fix overeager pathspec optimization

Given pathspecs that share a common prefix, ls-files optimized its call
into recursive directory reader by starting at the common prefix
directory.

If you have a directory "t" with an untracked file "t/junk" in it, but the
top-level .gitignore file told us to ignore "t/", this resulted in:

    $ git ls-files -o --exclude-standard
    $ git ls-files -o --exclude-standard t/
    t/junk
    $ git ls-files -o --exclude-standard t/junk
    t/junk
    $ cd t && git ls-files -o --exclude-standard
    junk

We could argue that you are overriding the ignore file by giving a
patchspec that matches or being in that directory, but it is somewhat
unexpected.  Worse yet, these behave differently:

    $ git ls-files -o --exclude-standard t/ .
    $ git ls-files -o --exclude-standard t/
    t/junk

This patch changes the optimization so that it notices when the common
prefix directory that it starts reading from is an ignored one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c                              |   36 +++++++++++++++++++++++++++++++++
 t/t3001-ls-files-others-exclude.sh |   39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index d0999ba..e8be909 100644
--- a/dir.c
+++ b/dir.c
@@ -778,6 +778,39 @@ static void free_simplify(struct path_simplify *simplify)
 	free(simplify);
 }
 
+static int has_leading_ignored_dir(struct dir_struct *dir,
+				   const char *path_, int len,
+				   const struct path_simplify *simplify)
+{
+	int dtype = DT_DIR;
+	char path[PATH_MAX], *cp = path;
+
+	memcpy(path, path_, len);
+	while (1) {
+		char *next = memchr(cp, '/', path + len - cp);
+		int exclude;
+
+		/*
+		 * NOTE! NOTE! NOTE!: we might want to actually lstat(2)
+		 * path[] to make sure it is a directory.
+		 */
+		if (next)
+			*next = '\0';
+		exclude = excluded(dir, path, &dtype);
+		if (next)
+			*next = '/';
+		if (exclude) {
+			if (dir->flags & DIR_COLLECT_IGNORED)
+				dir_add_ignored(dir, path, len);
+			return 1;
+		}
+		if (!next)
+			break;
+		cp = next + 1;
+	}
+	return 0;
+}
+
 int read_directory(struct dir_struct *dir, const char *path, int len, const char **pathspec)
 {
 	struct path_simplify *simplify;
@@ -786,6 +819,9 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const char
 		return dir->nr;
 
 	simplify = create_simplify(pathspec);
+	if (has_leading_ignored_dir(dir, path, len, simplify))
+		return dir->nr;
+
 	read_directory_recursive(dir, path, len, 0, simplify);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index c65bca8..9e71260 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -153,4 +153,43 @@ test_expect_success 'negated exclude matches can override previous ones' '
 	grep "^a.1" output
 '
 
+test_expect_success 'subdirectory ignore (setup)' '
+	mkdir -p top/l1/l2 &&
+	(
+		cd top &&
+		git init &&
+		echo /.gitignore >.gitignore &&
+		echo l1 >>.gitignore &&
+		echo l2 >l1/.gitignore &&
+		>l1/l2/l1
+	)
+'
+
+test_expect_success 'subdirectory ignore (toplevel)' '
+	(
+		cd top &&
+		git ls-files -o --exclude-standard
+	) >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'subdirectory ignore (l1/l2)' '
+	(
+		cd top/l1/l2 &&
+		git ls-files -o --exclude-standard
+	) >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'subdirectory ignore (l1)' '
+	(
+		cd top/l1 &&
+		git ls-files -o --exclude-standard
+	) >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.6.6.209.g52296.dirty
