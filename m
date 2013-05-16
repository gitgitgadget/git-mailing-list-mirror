From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] strbuf_branchname(): do not double-expand @{-1}~22
Date: Wed, 15 May 2013 17:29:51 -0700
Message-ID: <7vfvxnahs0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 02:30:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucm51-0003Cx-HO
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 02:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab3EPA3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 20:29:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51886 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753084Ab3EPA3y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 20:29:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18677F4D1;
	Thu, 16 May 2013 00:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	sto72D2d04+LXSGzwp8X9+4yuA=; b=FeafOqjF29Bqj5DueuT9VVprvgbGFFCFJ
	7mRGRaCcjxX1wE5ndpC8qAanL8LOSWWu/wMTJ3GLHEZiJW8+s94eklVe8+F7tK7E
	KR2RPkjbuHyC+mWvh7+L+7hxyuNgu93GqKyVqAY+evORhK5q1klqyWfcuFM+dzQt
	MBhwYy9Swk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=Fp8bVDK0hi7GmTWejb76pBvRHCW7i7A8C4WB5wWO30YhzeEB/6IMxsMu
	VzOqq1JFxsT/n9H3Rmk7U2QERNudkfifruJgngjMcWr0DwMyUZPSOe/wlb+3GceG
	tHULbiRYE3tq+wrcH1Net0i5pd0SlZSTcg/dA4btXkH2T7wuitw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BECCF4D0;
	Thu, 16 May 2013 00:29:54 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6557FF4CB;
	Thu, 16 May 2013 00:29:53 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA2A178E-BDBF-11E2-AB3B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224462>

If you were on 'frotz' branch before you checked out your current
branch, "git merge @{-1}~22" means the same as "git merge frotz~22".

The strbuf_branchname() function, when interpret_branch_name() gives
up resolving "@{-1}~22" fully, returns "frotz" and tells the caller
that it only resolved "@{-1}" part of the input, mistakes this as a
total failure, and appends the whole thing to the result, yielding
"frotz@{-1}~22", which does not make any sense.

Inspect the return valud from interpret_branch_name() a bit more
carefully.  When it errored out without consuming anything, we will
get -1 and we should return the whole thing.  Otherwise, we should
append the remainder (i.e. "~22" in the earlier example) to the
partially resolved name (i.e. "frotz").

The test suite adds enough number of checkout to make @{-12} in the
last test in t0100 that tried to check "we haven't flipped branches
that many times" error case; raise the number to a hundred.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The original code in a552de75eb01 (strbuf_branchname(): a wrapper
   for branch name shorthands, 2009-03-21) did not have this problem
   only because interpret_branch_name() did not return a partial
   success, but in today's code after d46a8301930a (fix parsing of
   @{-1}@{u} combination, 2010-01-28), it should pay attention to
   the condition.

   There might be other callers of interpret_branch_name() that
   still assume there is no partial success; I didn't check.

 sha1_name.c         |  8 ++++++--
 t/t0100-previous.sh | 15 +++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..371a49d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1055,9 +1055,13 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 int strbuf_branchname(struct strbuf *sb, const char *name)
 {
 	int len = strlen(name);
-	if (interpret_branch_name(name, sb) == len)
+	int used = interpret_branch_name(name, sb);
+
+	if (used == len)
 		return 0;
-	strbuf_add(sb, name, len);
+	if (used < 0)
+		used = 0;
+	strbuf_add(sb, name + used, len - used);
 	return len;
 }
 
diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index 315b9b3..e0a6940 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -27,6 +27,7 @@ test_expect_success 'merge @{-1}' '
 	test_commit B &&
 	git checkout A &&
 	test_commit C &&
+	test_commit D &&
 	git branch -f master B &&
 	git branch -f other &&
 	git checkout other &&
@@ -35,14 +36,24 @@ test_expect_success 'merge @{-1}' '
 	git cat-file commit HEAD | grep "Merge branch '\''other'\''"
 '
 
-test_expect_success 'merge @{-1} when there is not enough switches yet' '
+test_expect_success 'merge @{-1}~1' '
+	git checkout master &&
+	git reset --hard B &&
+	git checkout other &&
+	git checkout master &&
+	git merge @{-1}~1 &&
+	git cat-file commit HEAD >actual &&
+	grep "Merge branch '\''other'\''" actual
+'
+
+test_expect_success 'merge @{-100} before checking out that many branches yet' '
 	git reflog expire --expire=now &&
 	git checkout -f master &&
 	git reset --hard B &&
 	git branch -f other C &&
 	git checkout other &&
 	git checkout master &&
-	test_must_fail git merge @{-12}
+	test_must_fail git merge @{-100}
 '
 
 test_done
-- 
1.8.3-rc2-210-gbc3cf50
