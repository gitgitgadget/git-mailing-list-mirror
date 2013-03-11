From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC/PATCH] submodule: allow common rewind when merging submodules
Date: Mon, 11 Mar 2013 21:30:22 +0100
Message-ID: <20130311203021.GA21951@sandbox-ub.fritz.box>
References: <op.ws2l3rgnrbppqq@cicero.linkoping.osa>
 <20130306181156.GA4114@sandbox-ub>
 <op.wtklj7e9rbppqq@cicero.linkoping.osa>
 <20130307185906.GA9661@sandbox-ub.fritz.box>
 <513B7554.4020700@web.de>
 <20130310170953.GA1248@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Bratell <bratell@opera.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 21:31:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF9N4-0008K5-CZ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 21:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab3CKUab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 16:30:31 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:36401 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313Ab3CKUab (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 16:30:31 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UF9MV-0007qP-6e; Mon, 11 Mar 2013 21:30:23 +0100
Content-Disposition: inline
In-Reply-To: <20130310170953.GA1248@sandbox-ub.fritz.box>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217906>

Allow merge of two commits that are contained in each other and do the
same rewind. The rewind is calculated using the commit recorded in the
merge base of the superproject.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

On Sun, Mar 10, 2013 at 06:09:53PM +0100, Heiko Voigt wrote:
> On Sat, Mar 09, 2013 at 06:45:56PM +0100, Jens Lehmann wrote:
> > I agree that rewinds are a very good reason not merge two branches using
> > a fast-forward strategy, but I believe Daniel's use case is a (and maybe
> > the only) valid exception to that rule: both branches contain *exactly*
> > the same rewind. In that case I don't see any problem to just do a fast
> > forward to S21, as both agree on the commits to rewind.
> 
> That is different than using the merge base of the two commits needing
> merge. I agree that rewinding to exactly the same commits is probably a
> valid exception. Will have a look into extending the submodule merge
> strategy to include this case.

So here is the patch that implements this case. I am still a little bit
unsure about the user experience.

I had to extend the merge test setup to include a loose commit h because
otherwise we get a different merge case.

E.g. if you have this in the subproject

	a---b---d
	 \     /
          --c-+----h

And the superproject records

	BASE(b)---A(d)
	 \
	  ---B(c)

When you merge A and B the change from b to d can either be represented
as a forward change or as a rewind to a and then adding c, d. Since we
calculate the rewind using merge bases we find a forward change here. So
here we fail to merge as before.

If the superproject records

	BASE(b)---A(h)
	 \
	  ---B(c)

We will now find a rewind to a for both sides and merge cleanly since b
is not contained in h.

So the problem with the user experience here is:

Imagine a project does this kind of rewind because a bug is discovered
in b and then adds some other things using commits like c, h and so on. Then
there are more commits after b which will eventually fix it. Now the
project merges the b line into the h line in the submodule and can get a
merge conflict in the superproject like explained in the first case.

This might feel strange to them since the step to h (moving b -> c)
resolved cleanly but then a merge which *looks like* it just involves a
fast-forward in the submodule will fail.

Anyway its nothing technically wrong with our merge strategy just that
we can not decide which way the user went and so the merge fails.

One step I have in mind but not yet taken: If I see this correctly we
could simplify the code by just doing the is_common_rewind() check and
drop the commits_follow_merge_base() check since it is already contained
in the former.

The testsuite passes with this commit. You can also find this on github:

https://github.com/hvoigt/git/commits/hv/submodule-merge-bases-series1

Cheers Heiko

 submodule.c                | 42 +++++++++++++++++++++++++++++++++++++++---
 t/t7405-submodule-merge.sh | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 9ba1496..e24d630 100644
--- a/submodule.c
+++ b/submodule.c
@@ -911,6 +911,44 @@ static void print_commit(struct commit *commit)
 #define MERGE_WARNING(path, msg) \
 	warning("Failed to merge submodule %s (%s)", path, msg);
 
+static int is_common_rewind(struct commit *base, struct commit *a, struct commit *b)
+{
+	struct commit_list *merge_bases_a, *merge_bases_b;
+	int result;
+
+	/* find single rewind commit for a */
+	merge_bases_a = get_merge_bases(a, base, 1);
+	if (!merge_bases_a || commit_list_count(merge_bases_a) != 1)
+		return 0;
+
+	/* find single rewind commit for b */
+	merge_bases_b = get_merge_bases(b, base, 1);
+	if (!merge_bases_b || commit_list_count(merge_bases_b) != 1)
+		return 0;
+
+	/* see if we rewind to the same commit */
+	result = !hashcmp(merge_bases_a->item->object.sha1,
+			  merge_bases_b->item->object.sha1);
+	free_commit_list(merge_bases_a);
+	free_commit_list(merge_bases_b);
+
+	return result;
+}
+
+static int commits_follow_merge_base(struct commit *commit_base,
+		struct commit *commit_a, struct commit *commit_b)
+{
+	/* check whether both changes are forward */
+	if (in_merge_bases(commit_base, commit_a) &&
+	    in_merge_bases(commit_base, commit_b))
+		return 1;
+
+	if (is_common_rewind(commit_base, commit_a, commit_b))
+		return 1;
+
+	return 0;
+}
+
 int merge_submodule(unsigned char result[20], const char *path,
 		    const unsigned char base[20], const unsigned char a[20],
 		    const unsigned char b[20], int search)
@@ -944,9 +982,7 @@ int merge_submodule(unsigned char result[20], const char *path,
 		return 0;
 	}
 
-	/* check whether both changes are forward */
-	if (!in_merge_bases(commit_base, commit_a) ||
-	    !in_merge_bases(commit_base, commit_b)) {
+	if (!commits_follow_merge_base(commit_base, commit_a, commit_b)) {
 		MERGE_WARNING(path, "commits don't follow merge-base");
 		return 0;
 	}
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 0d5b42a..66520c6 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -60,7 +60,7 @@ test_expect_success setup '
 #           /   \
 #  init -- a     d
 #    \      \   /
-#     g       c
+#     g       c---h
 #
 # a in the main repository records to sub-a in the submodule and
 # analogous b and c. d should be automatically found by merging c into
@@ -109,7 +109,17 @@ test_expect_success 'setup for merge search' '
 	(cd sub &&
 	 git checkout -b sub-g sub-c) &&
 	git add sub &&
-	git commit -a -m "g")
+	git commit -a -m "g" &&
+
+	git checkout -b h c &&
+	(cd sub &&
+	 git checkout -b sub-h sub-c &&
+	 echo "file-h" >file-h &&
+	 git add file-h &&
+	 git commit -m "sub-h") &&
+	git add sub &&
+	git commit -a -m "h"
+	)
 '
 
 test_expect_success 'merge with one side as a fast-forward of the other' '
@@ -146,6 +156,31 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 	git reset --hard)
 '
 
+test_expect_success 'merging should succeed with common rewind' '
+	(cd merge-search &&
+		git checkout -b common-rewind-base init &&
+		(cd sub &&
+			git checkout sub-b
+		) &&
+		git add sub &&
+		git commit -m "common-rewind-base" &&
+		git checkout -b common-rewind-a common-rewind-base &&
+		(cd sub &&
+			git checkout sub-c
+		) &&
+		git add sub &&
+		git commit -m "common-rewind-a" &&
+		git checkout -b common-rewind-b common-rewind-base &&
+		(cd sub &&
+			git checkout sub-h
+		) &&
+		git add sub &&
+		git commit -m "common-rewind-b" &&
+		git checkout -b common-rewind-merge common-rewind-a &&
+		git merge common-rewind-b
+	)
+'
+
 # in a situation like this
 #
 # submodule tree:
-- 
1.8.2.rc2.5.gab0ecbc
