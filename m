Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDF7C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 10:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 683A761245
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 10:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhFPKZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 06:25:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:57340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232111AbhFPKZP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 06:25:15 -0400
Received: (qmail 12409 invoked by uid 109); 16 Jun 2021 10:23:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jun 2021 10:23:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25217 invoked by uid 111); 16 Jun 2021 10:23:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jun 2021 06:23:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Jun 2021 06:23:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Andrei Rybak <rybak.a.v@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] test-lib: fix "$remove_trash" regression and
 match_pattern_list() bugs
Message-ID: <YMnRC8v4RLDk2+K9@coredump.intra.peff.net>
References: <xmqqa6nqsd2i.fsf@gitster.g>
 <patch-1.1-436c723f4f8-20210616T082030Z-avarab@gmail.com>
 <YMm4F2uKZ4Dv3C4p@coredump.intra.peff.net>
 <xmqqeed2p3jx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqeed2p3jx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 06:22:10PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... Still, I kind of like the "set -f" version because it doesn't need
> > the extra directory which could cause problems with "ls-files -o", etc,
> > as you mentioned. You could also create the empty directory on the fly,
> > though if "set -f" works portably, that seems less complicated to me.
> 
> FWIW, I share that.

Here it is with some cosmetic cleanups and a commit message. I don't
mean to preempt further discussion if Ævar prefers another route, but I
want to make sure we didn't stall out.

I'm a little curious whether the bug could be triggered before the
recent move to running match_pattern_list outside of the trash directory
(i.e., whether there is some test that creates a sufficiently
confusing-looking file in the filesystem; t0000 would be a likely
candidate). But not curious enough to comb through the test suite
looking for candidates. :)

-- >8 --
Subject: [PATCH] test-lib: avoid accidental globbing in match_pattern_list()

We have a custom match_pattern_list() function which we use for matching
test names (like "t1234") against glob-like patterns (like "t1???") for
$GIT_SKIP_TESTS, --verbose-only, etc.

Those patterns may have multiple whitespace-separated elements (e.g.,
"t0* t1234 t5?78"). The callers of match_pattern_list thus pass the
strings unquoted, so that the shell does the usual field-splitting into
separate arguments.

But this also means the shell will do the usual globbing for each
argument, which can result in us seeing an expansion based on what's in
the filesystem, rather than the real pattern. For example, if I have the
path "t5000" in the filesystem, and you feed the pattern "t?0000", that
_should_ match the string "t0000", but it won't after the shell has
expanded it to "t5000".

This has been a bug ever since that function was introduced. But it
didn't usually trigger since we typically use the function inside the
trash directory, which has a very limited set of files that are unlikely
to match. It became a lot easier to trigger after edc23840b0 (test-lib:
bring $remove_trash out of retirement, 2021-05-10), because now we match
$GIT_SKIP_TESTS before even entering the trash directory. So the t5000
example above can be seen with:

  GIT_SKIP_TESTS=t?000 ./t0000-basic.sh

which should skip all tests but doesn't.

We can fix this by using "set -f" to ask the shell not to glob (which is
in POSIX, so should hopefully be portable enough). We only want to do
this in a subshell (to avoid polluting the rest of the script), which
means we need to get the whole string intact into the match_pattern_list
function by quoting it. Arguably this is a good idea anyway, since it
makes it much more obvious that we intend to split, and it's not simply
sloppy scripting.

Diagnosed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 54938c6427..a7badbf1dd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -732,14 +732,24 @@ match_pattern_list () {
 	arg="$1"
 	shift
 	test -z "$*" && return 1
-	for pattern_
-	do
-		case "$arg" in
-		$pattern_)
-			return 0
-		esac
-	done
-	return 1
+	# We need to use "$*" to get field-splitting, but we want to
+	# disable globbing, since we are matching against an arbitrary
+	# $arg, not what's in the filesystem. Using "set -f" accomplishes
+	# that, but we must do it in a subshell to avoid impacting the
+	# rest of the script. The exit value of the subshell becomes
+	# the function's return value.
+	(
+		set -f
+		for pattern_ in $*
+		do
+			case "$arg" in
+			$pattern_)
+				exit 0
+				;;
+			esac
+		done
+		exit 1
+	)
 }
 
 match_test_selector_list () {
@@ -848,7 +858,7 @@ maybe_teardown_verbose () {
 last_verbose=t
 maybe_setup_verbose () {
 	test -z "$verbose_only" && return
-	if match_pattern_list $test_count $verbose_only
+	if match_pattern_list $test_count "$verbose_only"
 	then
 		exec 4>&2 3>&1
 		# Emit a delimiting blank line when going from
@@ -878,7 +888,7 @@ maybe_setup_valgrind () {
 		return
 	fi
 	GIT_VALGRIND_ENABLED=
-	if match_pattern_list $test_count $valgrind_only
+	if match_pattern_list $test_count "$valgrind_only"
 	then
 		GIT_VALGRIND_ENABLED=t
 	fi
@@ -1006,7 +1016,7 @@ test_finish_ () {
 test_skip () {
 	to_skip=
 	skipped_reason=
-	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
+	if match_pattern_list $this_test.$test_count "$GIT_SKIP_TESTS"
 	then
 		to_skip=t
 		skipped_reason="GIT_SKIP_TESTS"
@@ -1346,7 +1356,7 @@ fi
 remove_trash=
 this_test=${0##*/}
 this_test=${this_test%%-*}
-if match_pattern_list "$this_test" $GIT_SKIP_TESTS
+if match_pattern_list "$this_test" "$GIT_SKIP_TESTS"
 then
 	say_color info >&3 "skipping test $this_test altogether"
 	skip_all="skip all tests in $this_test"
-- 
2.32.0.559.g998c91e3d7

