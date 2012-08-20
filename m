From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] fetch/push: allow refs/*:refs/*
Date: Mon, 20 Aug 2012 10:39:56 -0700
Message-ID: <1345484397-10958-2-git-send-email-gitster@pobox.com>
References: <1345484397-10958-1-git-send-email-gitster@pobox.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 19:40:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3VxZ-0001Gt-Ow
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 19:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab2HTRkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 13:40:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149Ab2HTRkE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 13:40:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 092278B3B;
	Mon, 20 Aug 2012 13:40:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KtX1
	QsWx0qZoWZJQDMDYz7Yh3+k=; b=EvfwK85KE09XmGeRLOXe+IjTbIRwQJ/mru/Z
	QaQ9NaQKPGKG+TvZ6VwWH/pj42aqvoiR+6dSCXoWy/HIfKfFZMvgYkm+hFyAtn2p
	9L2WqvhuEi/LStLaiAFCAc/4IRPwWIpzTXl4HO6OTf9Vx6BawWrLMUCIWNuaJUnI
	CCiWIN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	hrKQveT3RBi0TzW2Vsfk0OmGKNzbYDfiOHV/y6xURk80ST2t5Mc/nrHTz8U6UYtV
	tUXc24bc/qfYNi4DtrhXuuWqJghHXlYBNP+dMNY7Y3li8UBsT0cs9H2gR7UzmAjn
	YDDEcjvPDWqW8/QUICqlx9P1o6OifDXHMWPqXC6rp8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8B848B3A;
	Mon, 20 Aug 2012 13:40:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4252F8B38; Mon, 20 Aug 2012
 13:40:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.92.g7963261
In-Reply-To: <1345484397-10958-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 10CCDAEA-EAEE-11E1-AF0D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203861>

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
 builtin/fetch-pack.c   |  2 +-
 builtin/receive-pack.c |  2 +-
 connect.c              |  8 ++------
 remote.c               |  2 +-
 t/t5516-fetch-push.sh  | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 38 insertions(+), 9 deletions(-)

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
diff --git a/connect.c b/connect.c
index c8d0ea5..b30639c 100644
--- a/connect.c
+++ b/connect.c
@@ -17,20 +17,16 @@ static int check_ref(const char *name, int len, unsigned int flags)
 	if (len < 5 || memcmp(name, "refs/", 5))
 		return 0;
 
-	/* Skip the "refs/" part */
-	name += 5;
-	len -= 5;
-
 	/* REF_NORMAL means that we don't want the magic fake tag refs */
 	if ((flags & REF_NORMAL) && check_refname_format(name, 0))
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
-	if ((flags & REF_HEADS) && !memcmp(name, "heads/", 6))
+	if ((flags & REF_HEADS) && !memcmp(name, "refs/heads/", 11))
 		return 1;
 
 	/* REF_TAGS means that we want tags */
-	if ((flags & REF_TAGS) && !memcmp(name, "tags/", 5))
+	if ((flags & REF_TAGS) && !memcmp(name, "refs/tags/", 10))
 		return 1;
 
 	/* All type bits clear means that we are ok with anything */
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
index b69cf57..3fdfaea 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -929,6 +929,39 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 	)
 '
 
+test_expect_success 'push all hierarchies with stash' '
+	mk_empty &&
+	git stash clear &&
+	git reset --hard &&
+	echo >>path1 &&
+	git stash save "Tweak path1" &&
+	git push testrepo "refs/*:refs/*" &&
+	# without fix to connect.c::check_ref(), the second push
+	# would fail.
+	git push testrepo refs/stash &&
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
1.7.12.92.g7963261
