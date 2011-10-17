From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] resolve_gitlink_packed_ref(): fix mismerge
Date: Mon, 17 Oct 2011 11:43:30 -0700
Message-ID: <7vbotfmpbh.fsf_-_@alter.siamese.dyndns.org>
References: <4E9B1E32.7030101@gmail.com>
 <7vfwispi8u.fsf@alter.siamese.dyndns.org> <4E9B8719.1090203@gmail.com>
 <4E9BA39B.709@alum.mit.edu> <4E9BFE66.5070906@gmail.com>
 <4E9C2F3C.7080405@alum.mit.edu> <7v4nz7o7mg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 17 20:43:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFsA0-0006pq-A6
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 20:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab1JQSne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 14:43:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab1JQSnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 14:43:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B9A7568C;
	Mon, 17 Oct 2011 14:43:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rbd+qtsvep2D+2D8DIYxG0l2AAA=; b=fvyWai
	xtB38ZLGjmjntjBKF4n1IUlEG9aX+9hmWBRHap2J4KzsZpKnbItUAt16K7EkiYXV
	M2WcL8p69fjOVrk+eNw5gBNDxmIBnwZ7mwTgpmRbJCN+4glYW/Uzt1k0yVtzT51T
	b+3XKuL+rbUtufSjkqw8nQCBdySnmRWNKi1gM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XwTAlY+ceePiNGpaNOmKDWGTMjKrpjbj
	TjRK6R/Z9B+YU23Iovls8aFm2tOTzZHrHlq7amCjOQFvcJ6YuLM4BiqBUYWjs6Nk
	K257/7cc5me5Sx/aZq6EE2/gSIoCtcIJYU3xaN6mcUU+DuZxQhjbzyfwnp+ReqJJ
	SaomyWHApHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42748568B;
	Mon, 17 Oct 2011 14:43:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CDFD568A; Mon, 17 Oct 2011
 14:43:31 -0400 (EDT)
In-Reply-To: <7v4nz7o7mg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 17 Oct 2011 10:22:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9536880-F8EF-11E0-9F8A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183804>

2c5c66b (Merge branch 'jp/get-ref-dir-unsorted', 2011-10-10) merged a
topic that forked from the mainline before a new helper function
get_packed_refs() refactored code to read packed-refs file. The merge made
the call to the helper function with an incorrect argument. The parameter
to the function has to be a path to the submodule.

Fix the mismerge.

Helped-by: Mark Levedahl <mlevedahl@gmail.com>
Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Junio C Hamano <gitster@pobox.com> writes:

  > Michael Haggerty <mhagger@alum.mit.edu> writes:
  > ...
  >> The problem is that the parameter "name" is not NUL-terminated.  The old
  >> code turned it into a (NUL-terminated) filename via
  >>
  >>     strcpy(name + pathlen, "packed-refs");
  >>
  >> but the new code passes it (unterminated) to get_packed_refs()

  Let's do this on the 'master' front while mh/refs-api and mh/refs-api-2
  (the new 14 patch series) are cooking in the 'next' branch. The added
  test does not pass until the second-to-last patch in your new series.

  I made trial merges of this with mh/refs-api and mh/refs-api-2 and both
  were trivial to resolve (merge with mh/refs-api will keep the fix, and
  merge with mh/refs-api-2 can be made by dropping this change), so this is
  purely as interim fix plus---the value of the patch lies primarily in the
  test for regression avoidance.

 refs.c                     |   12 +++++++++++-
 t/t3000-ls-files-others.sh |   19 +++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 9911c97..cab4394 100644
--- a/refs.c
+++ b/refs.c
@@ -393,12 +393,22 @@ static struct ref_array *get_loose_refs(const char *submodule)
 #define MAXDEPTH 5
 #define MAXREFLEN (1024)
 
+/*
+ * Called by resolve_gitlink_ref_recursive() after it failed to read
+ * from "name", which is "module/.git/<refname>". Find <refname> in
+ * the packed-refs file for the submodule.
+ */
 static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refname, unsigned char *result)
 {
 	int retval = -1;
 	struct ref_entry *ref;
-	struct ref_array *array = get_packed_refs(name);
+	struct ref_array *array;
 
+	/* being defensive: resolve_gitlink_ref() did this for us */
+	if (pathlen < 6 || memcmp(name + pathlen - 6, "/.git/", 6))
+		die("Oops");
+	name[pathlen - 6] = '\0'; /* make it path to the submodule */
+	array = get_packed_refs(name);
 	ref = search_ref_array(array, refname);
 	if (ref != NULL) {
 		memcpy(result, ref->sha1, 20);
diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 2eec011..e9160df 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -65,4 +65,23 @@ test_expect_success '--no-empty-directory hides empty directory' '
 	test_cmp expected3 output
 '
 
+test_expect_success SYMLINKS 'ls-files --others with symlinked submodule' '
+	git init super &&
+	git init sub &&
+	(
+		cd sub &&
+		>a &&
+		git add a &&
+		git commit -m sub &&
+		git pack-refs --all
+	) &&
+	(
+		cd super &&
+		"$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" ../sub sub
+		git ls-files --others --exclude-standard >../actual
+	) &&
+	echo sub/ >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.7.370.gefe43
