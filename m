From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/10] refs DWIMmery: use the same rule for both "git fetch"
 and others
Date: Fri,  4 Nov 2011 23:01:36 -0700
Message-ID: <1320472900-6601-7-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 07:02:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMZKo-0005jr-9L
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 07:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab1KEGCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 02:02:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58446 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311Ab1KEGBz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 02:01:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11B783C25
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=NI8e
	QQuQAgNM6xr/c1ssiOikdHA=; b=B2P7ac2DD41TzBdb28XFeDiIHiHKfxYvdMfE
	4zzaJcqcx7gKugHCEMTMyi3dR5nKl43uyiBXPq7iHl+drlXMuihfGsHpLUotD6IW
	KHBAVWvndqGYePS06cIaEiaoC6fJWVcbg7/+YhywcNgRNkQC5GG9sJBG1DfrRfP0
	4x/y6YA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Q9PDeL
	2dr79TbS37A1hBDEiGzqsyemyw/kza8q0yO2+zjQbjEmqZ6mIiPjEXAmhwX2S0AH
	ixDB0q6u47ojBvtAFMTVU6Ijr/WwZ11cFiwHVOchMIZTe3Anuzg0YckHJtYYnidd
	zv3dbnXcAvQAclea5f+uktnjePlLjUor3igaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 090963C24
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45F113C23 for
 <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:54 -0400 (EDT)
X-Mailer: git-send-email 1.7.8.rc0.108.g71b5ec
In-Reply-To: <1320472900-6601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A96D0464-0773-11E1-B85B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184830>

"git log frotz" can DWIM to "refs/remotes/frotz/HEAD", but in the remote
access context, "git fetch frotz" to fetch what the other side happened to
have fetched from what it calls 'frotz' (which may not have any relation
to what we consider is 'frotz') the last time would not make much sense,
so the fetch rules table did not include "refs/remotes/%.*s/HEAD".

When the user really wants to, "git fetch $there remotes/frotz/HEAD" would
let her do so anyway, so this is not about safety or security; it merely
is about confusion avoidance and discouraging meaningless usage.

Specifically, it is _not_ about ambiguity avoidance. A name that would
become ambiguous if we use the same rules table for both fetch and local
rev-parse would be ambiguous locally at the remote side.

So for the same reason as we added rule to allow "git fetch $there v1.0"
instead of "git fetch $there tags/v1.0" in the previous commit, here is a
bit longer rope for the users, which incidentally simplifies our code.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a stronger version of [4/10]

 cache.h          |    2 +-
 refs.c           |    8 --------
 t/t5510-fetch.sh |    5 ++---
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index be07ec7..26322dd 100644
--- a/cache.h
+++ b/cache.h
@@ -873,7 +873,7 @@ extern int get_sha1_mb(const char *str, unsigned char *sha1);
 
 extern int refname_match(const char *abbrev_name, const char *full_name, const char **rules);
 extern const char *ref_rev_parse_rules[];
-extern const char *ref_fetch_rules[];
+#define ref_fetch_rules ref_rev_parse_rules
 
 extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 extern int validate_headref(const char *ref);
diff --git a/refs.c b/refs.c
index ff20eeb..026c7ea 100644
--- a/refs.c
+++ b/refs.c
@@ -995,14 +995,6 @@ const char *ref_rev_parse_rules[] = {
 	NULL
 };
 
-const char *ref_fetch_rules[] = {
-	"%.*s",
-	"refs/%.*s",
-	"refs/tags/%.*s",
-	"refs/heads/%.*s",
-	NULL
-};
-
 int refname_match(const char *abbrev_name, const char *full_name, const char **rules)
 {
 	const char **p;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 7e433b1..251d138 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -116,7 +116,7 @@ test_expect_success 'fetch must not resolve short tag name' '
 
 '
 
-test_expect_success 'fetch must not resolve short remote name' '
+test_expect_success 'fetch can now resolve short remote name' '
 
 	cd "$D" &&
 	git update-ref refs/remotes/six/HEAD HEAD &&
@@ -125,8 +125,7 @@ test_expect_success 'fetch must not resolve short remote name' '
 	cd six &&
 	git init &&
 
-	test_must_fail git fetch .. six:six
-
+	git fetch .. six:six
 '
 
 test_expect_success 'create bundle 1' '
-- 
1.7.8.rc0.108.g71b5ec
