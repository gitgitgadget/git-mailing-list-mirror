From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/17] refs DWIMmery: use the same rule for both "git
 fetch" and others
Date: Tue,  8 Nov 2011 17:01:51 -0800
Message-ID: <1320800523-5407-6-git-send-email-gitster@pobox.com>
References: <1320800523-5407-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:03:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNwZN-0004Cq-P5
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 02:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563Ab1KIBC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 20:02:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36388 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab1KIBCT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 20:02:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB4B35B6D
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=NfQ1
	nvVRgiy5EeohwDUkvwRXCLQ=; b=LggYBQ00FscvJNkZPmuJXLhhI2xq2BMjJ+PQ
	J0XCyYKIW55/xcql/z6sB3Wkbxglras/Mo2qh8ust+PA+xi/sju/7UElXyz75ssQ
	9BVCUeupaTPyJRQA/WhsHQhJhnS0XSqZPWMgoyOcro30TtCly8ngItDEJhawSyQI
	57RMq8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=G3Cbnz
	dClKCHF29eV8O5s2OXcQYteIEty4qjCEUbASwBVpF92HVmMwQc6Ozyp/4n5JVM74
	sDKzN2z8BWw0u8bGsKouVrqMHRMDIEygUk1QA6hNtRDY+hLEQ6EgLEm58G++KpJA
	bw9Y4rTR1aZzrkcQqIy0mphRI6P8q354SWKyY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B323F5B6C
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B5445B66 for
 <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:18 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320800523-5407-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 787BAA24-0A6E-11E1-93A9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185140>

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
1.7.8.rc1.82.g90e080
