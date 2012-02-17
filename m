From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] refresh_index: do not show unmerged path that is outside
 pathspec
Date: Fri, 17 Feb 2012 10:27:55 -0800
Message-ID: <7vsji9tivo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 19:28:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RySXO-0001Is-3t
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 19:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019Ab2BQS2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 13:28:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45818 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834Ab2BQS16 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 13:27:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B5F85E4A;
	Fri, 17 Feb 2012 13:27:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=c
	VT/WHUG1YdrFk4poLNWxNFH6cA=; b=tjWWp2KFvL0g2WQvvTs8vMBS4lx3fZPcS
	lRY6obkHbHx2C6Iolfb3v0fVX866AywqmHIhe+nRLic9RGyNFTsSW50NsYwTDgF6
	UOMewrU5QNc2VPkxyDFQreU4nckv/hqXKhwfwavWw4q+XPCHUTtgvfZoKpOI2BI6
	4zpCNObbdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=E50
	FsXCVJLtZGRmv0DewdKQmJm+3M3EOD6FVBF5HCLHc3dao7VylL1j7yNF8pQIZteJ
	GITcPU1tgqHznEum0C0Z2Uf4NGU+gw5WHH7S94SNioKNnNv42zGs96e451gimY+M
	8tZ1xWLcLpA7Uk+vfbQJ8WFc++2VuQsikRIX+/Xg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 509525E49;
	Fri, 17 Feb 2012 13:27:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B80CE5E48; Fri, 17 Feb 2012
 13:27:56 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CE5A518-5995-11E1-8AF2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190967>

When running "git add --refresh <pathspec>", we incorrectly showed the
path that is unmerged even if it is outside the specified pathspec, even
though we did honor pathspec and refreshed only the paths that matched.

Note that this cange does not affect "git update-index --refresh"; for
hysterical raisins, it does not take a pathspec (it takes real paths) and
more importantly itss command line options are parsed and executed one by
one as they are encountered, so "git update-index --refresh foo" means
"first refresh the index, and then update the entry 'foo' by hashing the
contents in file 'foo'", not "refresh only entry 'foo'".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I wondered if the "has_errors" that the caller can use to detect if
   there are not-yet-added paths should be covered by the if (!filtered)
   test as well.  No caller that passes pathpec seems to use the return
   value, so we probably should for the sake of consistency, but I didn't.

 read-cache.c   |   11 +++++++++--
 t/t3700-add.sh |   15 +++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a51bba1..274e54b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1120,11 +1120,16 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 		struct cache_entry *ce, *new;
 		int cache_errno = 0;
 		int changed = 0;
+		int filtered = 0;
 
 		ce = istate->cache[i];
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
 
+		if (pathspec &&
+		    !match_pathspec(pathspec, ce->name, strlen(ce->name), 0, seen))
+			filtered = 1;
+
 		if (ce_stage(ce)) {
 			while ((i < istate->cache_nr) &&
 			       ! strcmp(istate->cache[i]->name, ce->name))
@@ -1132,12 +1137,14 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			i--;
 			if (allow_unmerged)
 				continue;
-			show_file(unmerged_fmt, ce->name, in_porcelain, &first, header_msg);
+			if (!filtered)
+				show_file(unmerged_fmt, ce->name, in_porcelain,
+					  &first, header_msg);
 			has_errors = 1;
 			continue;
 		}
 
-		if (pathspec && !match_pathspec(pathspec, ce->name, strlen(ce->name), 0, seen))
+		if (filtered)
 			continue;
 
 		new = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 575d950..874b3a6 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -179,6 +179,21 @@ test_expect_success 'git add --refresh' '
 	test -z "`git diff-index HEAD -- foo`"
 '
 
+test_expect_success 'git add --refresh with pathspec' '
+	git reset --hard &&
+	echo >foo && echo >bar && echo >baz &&
+	git add foo bar baz && H=$(git rev-parse :foo) && git rm -f foo &&
+	echo "100644 $H 3	foo" | git update-index --index-info &&
+	test-chmtime -60 bar baz &&
+	>expect &&
+	git add --refresh bar >actual &&
+	test_cmp expect actual &&
+
+	git diff-files --name-only >actual &&
+	! grep bar actual&&
+	grep baz actual
+'
+
 test_expect_success POSIXPERM,SANITY 'git add should fail atomically upon an unreadable file' '
 	git reset --hard &&
 	date >foo1 &&
-- 
1.7.9.1.265.g25f75
