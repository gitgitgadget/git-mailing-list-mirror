From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] grep --no-index: allow use of "git grep" outside a git
 repository
Date: Fri, 15 Jan 2010 12:52:40 -0800
Message-ID: <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org>
References: <201001131713.05505.agruen@suse.de>
 <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
 <20100115223259.6117@nanako3.lavabit.com>
 <7vska71br0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 21:52:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtA4-0006Ra-KG
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 21:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268Ab0AOUwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 15:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094Ab0AOUws
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 15:52:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59036 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab0AOUws (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 15:52:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 80EB691152;
	Fri, 15 Jan 2010 15:52:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1a0RRC7tuxL2MLaY3n/evPXXdvA=; b=unBcR5
	ryCuidbx7YP0oGxJwGb8HynnEZnd7+3IJbzNhVN1huZ9fuDszdXEQrd/Y0QJWiSd
	uLp+yNGd4upZ94njcYdsNkDCIfSDGeQGaO0c0Ayk1nbP/N19WXjllrHhhaxcb6bm
	ctx6Y4n4My9PMEWQ6EvdcwNmlmNqelFdRxxTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tc4b0QgJA6g9YpgzLv4+5vmuKpdL53ZI
	gmkPCgoZVoAK4vmQk/EDZ48zPTqCCuQ5ppd78kUYaCEP1a088n7gGzT54xFYeuZY
	bjFo9ASyXfUh5hxc0TlTiW/V8V6bdXmbbnoCG40neT1C9WLGVjHIZnGQxmM0hyIc
	YwxRStjU/ao=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C55091151;
	Fri, 15 Jan 2010 15:52:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7004791150; Fri, 15 Jan
 2010 15:52:42 -0500 (EST)
In-Reply-To: <7vska71br0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 15 Jan 2010 10\:09\:07 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE82621E-0217-11DF-BFEB-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137116>

Just like some people wanted diff features that are not found in
other people's diff implementations outside of a git repository
and added --no-index mode to the command, this adds --no-index mode
to the "git grep" command.

Also, inside a git repository, --no-index mode allows you to grep
in untracked (but not ignored) files.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is much easier than "git diff --no-index" because it does not have
   to worry about corner cases like "git diff --no-index file1 file2".

 builtin-grep.c  |   26 ++++++++++++++++++++++++++
 t/t7002-grep.sh |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 229555d..1283373 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -14,6 +14,7 @@
 #include "userdiff.h"
 #include "grep.h"
 #include "quote.h"
+#include "dir.h"
 
 static char const * const grep_usage[] = {
 	"git grep [options] [-e] <pattern> [<rev>...] [[--] path...]",
@@ -320,6 +321,21 @@ static int grep_object(struct grep_opt *opt, const char **paths,
 	die("unable to grep from object of type %s", typename(obj->type));
 }
 
+static int grep_directory(struct grep_opt *opt, const char **paths)
+{
+	struct dir_struct dir;
+	int i, hit = 0;
+
+	memset(&dir, 0, sizeof(dir));
+	setup_standard_excludes(&dir);
+
+	fill_directory(&dir, paths);
+	for (i = 0; i < dir.nr; i++)
+		hit |= grep_file(opt, dir.entries[i]->name);
+	free_grep_patterns(opt);
+	return hit;
+}
+
 static int context_callback(const struct option *opt, const char *arg,
 			    int unset)
 {
@@ -418,6 +434,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
 			"search in index instead of in the work tree"),
+		OPT_BOOLEAN(0, "index", &use_index,
+			"--no-index finds in contents not managed by git"),
 		OPT_GROUP(""),
 		OPT_BOOLEAN('v', "invert-match", &opt.invert,
 			"show non-matching lines"),
@@ -591,6 +609,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		paths[1] = NULL;
 	}
 
+	if (!use_index) {
+		if (cached)
+			die("--cached cannot be used with --no-index.");
+		if (list.nr)
+			die("--no-index cannot be used with revs.");
+		return !grep_directory(&opt, paths);
+	}
+
 	if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index c369cdb..7eceb08 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -426,4 +426,56 @@ test_expect_success 'grep -Fi' '
 	test_cmp expected actual
 '
 
+test_expect_success 'outside of git repository' '
+	rm -fr non &&
+	mkdir -p non/git/sub &&
+	echo hello >non/git/file1 &&
+	echo world >non/git/sub/file2 &&
+	echo ".*o*" >non/git/.gitignore &&
+	{
+		echo file1:hello &&
+		echo sub/file2:world
+	} >non/expect.full &&
+	echo file2:world >non/expect.sub
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non/git" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git grep o &&
+		git grep --no-index o >../actual.full &&
+		test_cmp ../expect.full ../actual.full
+		cd sub &&
+		test_must_fail git grep o &&
+		git grep --no-index o >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub
+	)
+'
+
+test_expect_success 'inside git repository but with --no-index' '
+	rm -fr is &&
+	mkdir -p is/git/sub &&
+	echo hello >is/git/file1 &&
+	echo world >is/git/sub/file2 &&
+	echo ".*o*" >is/git/.gitignore &&
+	{
+		echo file1:hello &&
+		echo sub/file2:world
+	} >is/expect.full &&
+	: >is/expect.empty &&
+	echo file2:world >is/expect.sub
+	(
+		cd is/git &&
+		git init &&
+		test_must_fail git grep o >../actual.full &&
+		test_cmp ../expect.empty ../actual.full &&
+		git grep --no-index o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+		cd sub &&
+		test_must_fail git grep o >../../actual.sub &&
+		test_cmp ../../expect.empty ../../actual.sub &&
+		git grep --no-index o >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub
+	)
+'
+
 test_done
-- 
1.6.6.324.g20f8f4
