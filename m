Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9DCA7C
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vnZlpo3e"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8260B7
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:23:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 174D71BA726;
	Tue, 31 Oct 2023 01:23:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=6V9COkapZp8goIoBxSvsxjmwf
	qebkpnhkiVNzv+mbCA=; b=vnZlpo3eyGEmrq7dL1sNyJ8uhS18z2BGLBlIMYvAu
	izKrXmsDDTMZtn4FCynPjWO12fXZ7ooZmK+IXopkKnfzODc7GoANyPyDfkh4NTmd
	KXuwn2HT/UnZZZB1fzgLItLXpni8+RbIeRNZkj9xXUYyuESez3ZVfC9xjG1R0mFU
	oU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 101981BA725;
	Tue, 31 Oct 2023 01:23:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 781C21BA724;
	Tue, 31 Oct 2023 01:23:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] test framework: further deprecate test_i18ngrep
Date: Tue, 31 Oct 2023 14:23:29 +0900
Message-ID: <20231031052330.3762989-2-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-530-g692be87cbb
In-Reply-To: <20231031052330.3762989-1-gitster@pobox.com>
References: <881c7fea-47bb-45a9-b6e3-314f9ed9e0cd@gmail.com>
 <20231031052330.3762989-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 A3229EB8-77AD-11EE-BB0C-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

As an attempt to come up with a useful mechanism to ensure that
certain messages are left untranslated [*], we earlier wrote
GIT_TEST_GETTEXT_POISON off as a failed experiment.

But the output from the test helper was easier to use while
debugging failed tests, compared to the same test writtein with the
plain-vanilla "grep".  Especially when a test that expects a certain
string to appear in the output (e.g. "this test must fail with this
message") fails, "grep message output" would just silently fail and
in a &&-chained sequence of commands, it is hard to tell which step
failed.  test_i18ngrep explicitly said "we wanted to see a line that
match this pattern but did not see a hit in this file".

What we have as test_i18ngrep in our tree still retains this verbose
output (even though we got rid of the "poison" support).  Let's
rename it to test_grep (because it is no longer about i18n at all)
and then make test_i18ngrep a thin wrapper around it.  Existing
callers of test_i18ngrep can be mechanically rewritten to instead
use test_grep over time, but it does not have to be done in this
commit.

[Footnote]

 * The idea was that human-facing messages are often translated, but
   there are messages that should never be translated.  We use
   "grep" only for the latter kind of messages, and then run tests
   in "poison" mode that spew garbage for translatable messages.  If
   such a test run fails, it means these messages tested with "grep"
   were marked for translation by mistake.  test_i18ngrep was to be
   used for other messages that are to be translated, and was to
   always "succeed" when runing under the "poison" mode.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib-functions.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2f8868caa1..c50bc18861 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1208,14 +1208,16 @@ test_cmp_bin () {
 	cmp "$@"
 }
=20
-# Wrapper for grep which used to be used for
-# GIT_TEST_GETTEXT_POISON=3Dfalse. Only here as a shim for other
-# in-flight changes. Should not be used and will be removed soon.
+# Deprecated - do not use this in new code
 test_i18ngrep () {
+	test_grep "$@"
+}
+
+test_grep () {
 	eval "last_arg=3D\${$#}"
=20
 	test -f "$last_arg" ||
-	BUG "test_i18ngrep requires a file to read as the last parameter"
+	BUG "test_grep requires a file to read as the last parameter"
=20
 	if test $# -lt 2 ||
 	   { test "x!" =3D "x$1" && test $# -lt 3 ; }
--=20
2.42.0-530-g692be87cbb

