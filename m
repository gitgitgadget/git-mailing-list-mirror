From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] add: fail "git add ignored-dir/file" without -f
Date: Sun, 28 Feb 2010 19:25:39 -0800
Message-ID: <7v8wachgek.fsf_-_@alter.siamese.dyndns.org>
References: <hll45t$50o$1@ger.gmane.org>
 <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com>
 <hll65c$87a$1@ger.gmane.org>
 <32541b131002182115t5501d0d1u19367a4d8e7627e4@mail.gmail.com>
 <20100219053431.GB22645@coredump.intra.peff.net>
 <20100219060249.GD22645@coredump.intra.peff.net>
 <20100219082445.GB13691@coredump.intra.peff.net>
 <7vhbp0ls26.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 01 04:26:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlwGg-00069d-F0
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 04:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab0CADZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 22:25:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab0CADZv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 22:25:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 902D29E4DA;
	Sun, 28 Feb 2010 22:25:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sj6AFYAgxySN7/PE5Hg1+6Zm5uY=; b=PZlGs3
	jz8PCdey+7Kfj3HbMv2O6vGrimO5K+Q54A9vUzso4dCAo5lmhgkV1KkblOlyfOSz
	x9XB5Nseh36RJllsTFK6xjKN3pWt71yk1yeDBk0vfpCbGyyuNfR9NBdSYphKRyFO
	LJ4Q6BpYnd+cVIWNHSE67R1WN1k0rUAct3Tbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BvnuNw0sZabIBxprJ3i+knHWAt8ZW2oH
	PudZ1Dvd2qnWUobAU47ccUJAcfstPco2nX+x95xB8UdYDby8Lg/bfgCUvO8RZ4qA
	iClUjOLeZ1b98Czr/Fhq6o+T1WptiVM2PPQHjwolL3VhYu96+rcIuqeIWp9+hLVj
	q2StgD0QWoY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CE459E4D8;
	Sun, 28 Feb 2010 22:25:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37F7B9E4D7; Sun, 28 Feb
 2010 22:25:41 -0500 (EST)
In-Reply-To: <7vhbp0ls26.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 28 Feb 2010 18\:00\:17 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2004D0AA-24E2-11DF-9695-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141295>

"git add <pathspec>" usually fails the request and gives an advice message
to use the -f option when <pathspec> exactly names an existing path in the
work tree.  However, we didn't issue the warning nor fail the request when
the <pathspec> matches an existing path but it is ignored because a higher
level directory is ignored as a whole.  In such a case, we do not even
descend into it (and we shouldn't).

This catches such a case and issues some warning.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is still provisional and I am not fully happy with it; it seems to
   pass the tests.  The error message is based on the full directory name
   we are culling, not on the actual pathspec the user gave us, as we do
   not have access to it.

 dir.c                  |   15 +++++-----
 t/t2204-add-ignored.sh |   70 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 7 deletions(-)
 create mode 100755 t/t2204-add-ignored.sh

diff --git a/dir.c b/dir.c
index 00d698d..af4ba92 100644
--- a/dir.c
+++ b/dir.c
@@ -413,13 +413,10 @@ static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathna
 	return dir->entries[dir->nr++] = dir_entry_new(pathname, len);
 }
 
-static struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
+static void dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (!cache_name_is_other(pathname, len))
-		return NULL;
-
 	ALLOC_GROW(dir->ignored, dir->ignored_nr+1, dir->ignored_alloc);
-	return dir->ignored[dir->ignored_nr++] = dir_entry_new(pathname, len);
+	dir->ignored[dir->ignored_nr++] = dir_entry_new(pathname, len);
 }
 
 enum exist_status {
@@ -638,7 +635,8 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 {
 	int exclude = excluded(dir, path, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
-	    && in_pathspec(path, *len, simplify))
+	    && in_pathspec(path, *len, simplify)
+	    && cache_name_is_other(path, *len))
 		dir_add_ignored(dir, path, *len);
 
 	/*
@@ -841,8 +839,11 @@ static int treat_leading_path(struct dir_struct *dir,
 			return 0;
 		blen = baselen;
 		if (treat_one_path(dir, pathbuf, &blen, simplify,
-				   DT_DIR, NULL) == path_ignored)
+				   DT_DIR, NULL) == path_ignored) {
+			if (dir->flags & DIR_COLLECT_IGNORED)
+				dir_add_ignored(dir, pathbuf, baselen);
 			return 0; /* do not recurse into it */
+		}
 		if (len <= baselen)
 			return 1; /* finished checking */
 	}
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
new file mode 100755
index 0000000..c1ce12b
--- /dev/null
+++ b/t/t2204-add-ignored.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description='giving ignored paths to git add'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir sub dir dir/sub &&
+	echo sub >.gitignore &&
+	echo ign >>.gitignore &&
+	for p in . sub dir dir/sub
+	do
+		>"$p/ign" &&
+		>"$p/file" || exit 1
+	done
+'
+
+for i in file dir/file dir 'd*'
+do
+	test_expect_success "no complaints for unignored $i" '
+		rm -f .git/index &&
+		git add "$i" &&
+		git ls-files "$i" >out &&
+		test -s out
+	'
+done
+
+for i in ign dir/ign dir/sub dir/sub/*ign sub/file sub sub/*
+do
+	test_expect_success "complaints for ignored $i" '
+		rm -f .git/index &&
+		test_must_fail git add "$i" 2>err &&
+		git ls-files "$i" >out &&
+		! test -s out &&
+		grep -e "Use -f if" err &&
+		cat err
+	'
+done
+
+for i in sub sub/*
+do
+	test_expect_success "complaints for ignored $i in dir" '
+		rm -f .git/index &&
+		(
+			cd dir &&
+			test_must_fail git add "$i" 2>err &&
+			git ls-files "$i" >out &&
+			! test -s out &&
+			grep -e "Use -f if" err &&
+			cat err
+		)
+	'
+done
+
+for i in ign file
+do
+	test_expect_success "complaints for ignored $i in sub" '
+		rm -f .git/index &&
+		(
+			cd sub &&
+			test_must_fail git add "$i" 2>err &&
+			git ls-files "$i" >out &&
+			! test -s out &&
+			grep -e "Use -f if" err &&
+			cat err
+		)
+	'
+done
+
+test_done
-- 
1.7.0.1.241.g6604f
