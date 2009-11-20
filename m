From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv8 00/10] git notes
Date: Fri, 20 Nov 2009 02:46:02 -0800
Message-ID: <7vk4xl1nkl.fsf@alter.siamese.dyndns.org>
References: <1258681154-2167-1-git-send-email-johan@herland.net>
 <7vk4xl5y3z.fsf@alter.siamese.dyndns.org>
 <20091120192800.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	spearce@spearce.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 11:46:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBR0Q-0006oy-1Z
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 11:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbZKTKqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 05:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529AbZKTKqJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 05:46:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbZKTKqH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 05:46:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 51CA581F77;
	Fri, 20 Nov 2009 05:46:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=a3heOTg0dGU41kkY377lrzlUIis=; b=uZ/GRVqANISzOmtvStRPHNt
	Y3QV5cQS4GS7auvY8Ho5HLryse79WlbtOwRO72Nyjbjs0Ac035Fp4X4sOqog4azZ
	Ja/pVOuo5hwy/kpRmiLkfSXQJrN//8ChE1+6D3I4eVL/s9rf6Nh+/rM+f3cLz7bz
	461bppRZfeANEKiiFcWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=vkZogEF5BNs32e4aDazUUWB9hzhnwyu1NuDrSb7bNh1vNo6Ts
	yx3mDe8tirO4lTWG12KXoacmnwthCSlGVQQWPtF7vke3LwmqA8tb6mwATtditzWq
	QQ5J1cilSXNU1CegiTfh9BMwsT6WiAtI4Yw3vXopDJuXdoOkfe6X3/CgAE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1093E81F76;
	Fri, 20 Nov 2009 05:46:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7E4681F72; Fri, 20 Nov
 2009 05:46:03 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E97BDDFE-D5C1-11DE-B4A7-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133328>

Nanako Shiraishi <nanako3@lavabit.com> writes:

>> Step 0.  Apply as you specified on top of 'next'
>>
>>     $ git checkout next^0
>>     $ git am -s your-10-patches
>>     $ M=$(git describe)
>>
>> Step 1.  Rebase back to the bottom of the old series
>>
>>     $ git checkout next...jh/notes
>
> What do three-dots mean in this command?
>
>>     $ git rebase --onto HEAD next $M
>>     $ N=$(git describe)

Heh, good eyes.

I forgot that I had this toy hidden from the general public.

-- >8 --
Subject: [PATCH] "checkout A...B" switches to the merge base between A and B

When flipping commits around on topic branches, I often end up doing
this sequence:

 * Run "log --oneline next..jc/frotz" to find out the first commit
   on 'jc/frotz' branch not yet merged to 'next';

 * Run "checkout $that_commit^" to detach HEAD to the parent of it;

 * Rebuild the series on top of that commit; and

 * "show-branch jc/frotz HEAD" and "diff jc/frotz HEAD" to verify.

Introduce a new syntax to "git checkout" to name the commit to switch to,
to make the first two steps easier.  When the branch to switch to is
specified as A...B (you can omit either A or B but not both, and HEAD
is used instead of the omitted side), the merge base between these two
commits are computed, and if there is one unique one, we detach the HEAD
at that commit.

With this, I can say "checkout next...jc/frotz".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c       |    7 +++++--
 cache.h                  |    1 +
 sha1_name.c              |   42 ++++++++++++++++++++++++++++++++++++++++++
 t/t2012-checkout-last.sh |   27 ++++++++++++++++++++++++++-
 4 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 64f3a11..7167111 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -690,7 +690,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	 * case 3: git checkout <something> [<paths>]
 	 *
 	 *   With no paths, if <something> is a commit, that is to
-	 *   switch to the branch or detach HEAD at it.
+	 *   switch to the branch or detach HEAD at it.  As a special case,
+	 *   if <something> is A...B (missing A or B means HEAD but you can
+	 *   omit at most one side), and if there is a unique merge base
+	 *   between A and B, A...B names that merge base.
 	 *
 	 *   With no paths, if <something> is _not_ a commit, no -t nor -b
 	 *   was given, and there is a tracking branch whose name is
@@ -716,7 +719,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "-"))
 			arg = "@{-1}";
 
-		if (get_sha1(arg, rev)) {
+		if (get_sha1_mb(arg, rev)) {
 			if (has_dash_dash)          /* case (1) */
 				die("invalid reference: %s", arg);
 			if (!patch_mode &&
diff --git a/cache.h b/cache.h
index 71a731d..f8df15a 100644
--- a/cache.h
+++ b/cache.h
@@ -703,6 +703,7 @@ extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 extern int interpret_branch_name(const char *str, struct strbuf *);
+extern int get_sha1_mb(const char *str, unsigned char *sha1);
 
 extern int refname_match(const char *abbrev_name, const char *full_name, const char **rules);
 extern const char *ref_rev_parse_rules[];
diff --git a/sha1_name.c b/sha1_name.c
index 44bb62d..d5a240c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -794,6 +794,48 @@ release_return:
 	return retval;
 }
 
+int get_sha1_mb(const char *name, unsigned char *sha1)
+{
+	struct commit *one, *two;
+	struct commit_list *mbs;
+	unsigned char sha1_tmp[20];
+	const char *dots;
+	int st;
+
+	dots = strstr(name, "...");
+	if (!dots)
+		return get_sha1(name, sha1);
+	if (dots == name)
+		st = get_sha1("HEAD", sha1_tmp);
+	else {
+		struct strbuf sb;
+		strbuf_init(&sb, dots - name);
+		strbuf_add(&sb, name, dots - name);
+		st = get_sha1(sb.buf, sha1_tmp);
+		strbuf_release(&sb);
+	}
+	if (st)
+		return st;
+	one = lookup_commit_reference_gently(sha1_tmp, 0);
+	if (!one)
+		return -1;
+
+	if (get_sha1(dots[3] ? (dots + 3) : "HEAD", sha1_tmp))
+		return -1;
+	two = lookup_commit_reference_gently(sha1_tmp, 0);
+	if (!two)
+		return -1;
+	mbs = get_merge_bases(one, two, 1);
+	if (!mbs || mbs->next)
+		st = -1;
+	else {
+		st = 0;
+		hashcpy(sha1, mbs->item->object.sha1);
+	}
+	free_commit_list(mbs);
+	return st;
+}
+
 /*
  * This is like "get_sha1_basic()", except it allows "sha1 expressions",
  * notably "xyz^" for "parent of xyz"
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index 87b30a2..b44de9d 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='checkout can switch to last branch'
+test_description='checkout can switch to last branch and merge base'
 
 . ./test-lib.sh
 
@@ -91,4 +91,29 @@ test_expect_success 'switch to twelfth from the last' '
 	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch13"
 '
 
+test_expect_success 'merge base test setup' '
+	git checkout -b another other &&
+	echo "hello again" >>world &&
+	git add world &&
+	git commit -m third
+'
+
+test_expect_success 'another...master' '
+	git checkout another &&
+	git checkout another...master &&
+	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
+'
+
+test_expect_success '...master' '
+	git checkout another &&
+	git checkout ...master &&
+	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
+'
+
+test_expect_success 'master...' '
+	git checkout another &&
+	git checkout master... &&
+	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
+'
+
 test_done
-- 
1.6.5.3.342.g14bb9
