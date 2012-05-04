From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fetch/push: allow refs/*:refs/*
Date: Fri, 04 May 2012 15:30:45 -0700
Message-ID: <7vwr4r8tpm.fsf@alter.siamese.dyndns.org>
References: <7vsjfj7des.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 00:30:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQR1a-0008PU-St
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 00:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760150Ab2EDWau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 18:30:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759924Ab2EDWat (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 18:30:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A876362C5;
	Fri,  4 May 2012 18:30:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=coqQZi0qpZz0cwbFkY38gAemrlA=; b=aQYZhi
	8wLU6PvqWxbhaAkbGAqn6qYSx5xvMvOO2uYj0wWuRTIiHCx6sh8exDEaOiIZeRTl
	yiepeQpan5ry8Vl5jKPlxW0cPluRgwFrfBIJLVJwZyDRLprW//PMQZfplCAucANf
	bxtHr6fRLGOla6OFrq4pINdsU/QxcaeKHPduk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T19LvntklEHNWFJCbvX734abQvCzrGn6
	bRu0YK0rvVV8V7nV83IFjPCtTr8dygrl2z/BLa89rpQx2n0r9s0fnkVDK4Q55Xj7
	JlFpaXJzRYi4ZuRohVkHHalQ7HX6yFkfbBELqdpMWvtPM1mdeUvtULKdsKY+xL/8
	pUP1uSMHI/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F37B62C4;
	Fri,  4 May 2012 18:30:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED17462C3; Fri,  4 May 2012
 18:30:46 -0400 (EDT)
In-Reply-To: <7vsjfj7des.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 01 May 2012 15:19:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB3B21DA-9638-11E1-B60E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197077>

There are a handful of places where we call check_refname_format() on a
substring after "refs/" of a refname we are going to use, and filter out a
valid match with "refs/stash" with such a pathspec.  Not sending a stash
may arguably be a feature (as stash is inherently a local workflow
element), but the code in the transport layer is oblivious to this
filtering performed by the lower layer of the code, and complains that the
other side did not send all the objects that needs to complete refs/stash
at the end, even though the code will not write refs/stash out anyway, and
making the whole command fail.

This is an attempt to "fix" it by using check_refname_format() on the
whole "refs/....." string and allowing refs/stash to be also copied.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * With this patch:

    $ git checkout HEAD^0 ;# make sure we are on detached HEAD
    $ git fetch $somewhere +refs/*:refs/*

   and

    victim$ git config receive.denyCurrentBranch warn
    master$ git push victim +refs/*:refs/*

   should work.

 builtin/fetch-pack.c   |  2 +-
 builtin/receive-pack.c |  2 +-
 remote.c               |  2 +-
 t/t5516-fetch-push.sh  | 30 ++++++++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 6207ecd..a3e3fa3 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -546,7 +546,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
 		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_refname_format(ref->name + 5, 0))
+		    check_refname_format(ref->name, 0))
 			; /* trash */
 		else if (args.fetch_all &&
 			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7ec68a1..1935b80 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -401,7 +401,7 @@ static const char *update(struct command *cmd)
 	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
-	if (prefixcmp(name, "refs/") || check_refname_format(name + 5, 0)) {
+	if (prefixcmp(name, "refs/") || check_refname_format(name, 0)) {
 		rp_error("refusing to create funny ref '%s' remotely", name);
 		return "funny refname";
 	}
diff --git a/remote.c b/remote.c
index e2ef991..eacd8ad 100644
--- a/remote.c
+++ b/remote.c
@@ -1595,7 +1595,7 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
 	int len;
 
 	/* we already know it starts with refs/ to get here */
-	if (check_refname_format(refname + 5, 0))
+	if (check_refname_format(refname, 0))
 		return 0;
 
 	len = strlen(refname) + 1;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b69cf57..1a45b19 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -929,6 +929,36 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 	)
 '
 
+test_expect_success 'push all hierarchies with stash' '
+	mk_empty &&
+	git stash clear &&
+	git reset --hard &&
+	echo >>path1 &&
+	git stash save "Tweak path1" &&
+	git push testrepo "refs/*:refs/*" &&
+	git ls-remote . >expect &&
+	git ls-remote testrepo >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'fetch all hierarchies with stash' '
+	mk_empty &&
+	git stash clear &&
+	git reset --hard &&
+	echo >>path1 &&
+	git stash save "Tweak path1" &&
+	(
+		cd testrepo &&
+		git commit --allow-empty -m initial &&
+		git checkout HEAD^0 &&
+		git fetch .. "+refs/*:refs/*" &&
+		git checkout master
+	) &&
+	git ls-remote . >expect &&
+	git ls-remote testrepo >actual &&
+	test_cmp actual expect
+'
+
 test_expect_success 'push --porcelain' '
 	mk_empty &&
 	echo >.git/foo  "To testrepo" &&
-- 
1.7.10.1.500.g37b1e9a
