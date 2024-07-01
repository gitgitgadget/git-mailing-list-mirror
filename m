Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D34F602
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871723; cv=none; b=Tak6DRylsl5vO0ojYmSj21DH6mNVejWVrzvmCzu0JwA2syZoScsPniL0K49Zm0MHp6uhipKRl+dwHRMW0WiUeogNCaqn+M3Xt3ecaErSkSbiVbV6tmIb5q0zPLARTERVSNTOQXmc/hju1bAXdpAluA0qfClkePDWkpNrFLA3bs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871723; c=relaxed/simple;
	bh=rk+cuOt1sJSzyU90xrceWmJ2Dr75T6Dxouq4nrwSA1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWwQTmZEQcYHTkn5ywdj4MTSs//2n7lZ1Be26xiGGOJw1F90x9nmYT/5tG3/KU9q/LTCqgNyivZ/D9kWeQeNCeCRwABA2auCBxooxqykqlMOdzhRovszsNtlPVrnYUhxrlrbYkpPuoQ0amEWOh4RTYWG0ANr1m712I3iLzxyo6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29145 invoked by uid 109); 1 Jul 2024 22:08:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 22:08:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18041 invoked by uid 111); 1 Jul 2024 22:08:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jul 2024 18:08:39 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Jul 2024 18:08:40 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 1/2] test-lib: allow test snippets as here-docs
Message-ID: <20240701220840.GA20631@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701220815.GA20293@coredump.intra.peff.net>

Most test snippets are wrapped in single quotes, like:

  test_expect_success 'some description' '
          do_something
  '

This sometimes makes the snippets awkward to write, because you can't
easily use single quotes within them. We sometimes work around this with
$SQ, or by loosening regexes to use "." instead of a literal quote, or
by using double quotes when we'd prefer to use single-quotes (and just
adding extra backslash-escapes to avoid interpolation).

This commit adds another option: feeding the snippet via the function's
stdin. This doesn't conflict with anything the snippet would want to do,
because we always redirect its stdin from /dev/null anyway (which we'll
continue to do).

A few notes on the implementation:

  - it would be nice to push this down into test_run_, but we can't, as
    test_expect_success and test_expect_failure want to see the actual
    script content to report it for verbose-mode. A helper function
    limits the amount of duplication in those callers here.

  - The helper function is a little awkward to call, as you feed it the
    name of the variable you want to set. The more natural thing in
    shell would be command substitution like:

      body=$(body_or_stdin "$2")

    but that loses trailing whitespace. There are tricks around this,
    like:

      body=$(body_or_stdin "$2"; printf .)
      body=${body%.}

    but we'd prefer to keep such tricks in the helper, not in each
    caller.

  - I implemented the helper using a sequence of "read" calls. Together
    with "-r" and unsetting the IFS, this preserves incoming whitespace.
    An alternative is to use "cat" (which then requires the gross "."
    trick above). But this saves us a process, which is probably a good
    thing. The "read" builtin does use more read() syscalls than
    necessary (one per byte), but that is almost certainly a win over a
    separate process.

    Both are probably slower than passing a single-quoted string, but
    the difference is lost in the noise for a script that I converted as
    an experiment.

  - I handle test_expect_success and test_expect_failure here. If we
    like this style, we could easily extend it to other spots (e.g.,
    lazy_prereq bodies) on top of this patch.

  - even though we are using "local", we have to be careful about our
    variable names. Within test_expect_success, any variable we declare
    with local will be seen as local by the test snippets themselves (so
    it wouldn't persist between tests like normal variables would).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/README                |  8 ++++++++
 t/test-lib-functions.sh | 32 +++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/t/README b/t/README
index d9e0e07506..dec644f997 100644
--- a/t/README
+++ b/t/README
@@ -906,6 +906,14 @@ see test-lib-functions.sh for the full list and their options.
 	    'git-write-tree should be able to write an empty tree.' \
 	    'tree=$(git-write-tree)'
 
+   If <script> is `-` (a single dash), then the script to run is read
+   from stdin. This lets you more easily use single quotes within the
+   script by using a here-doc. For example:
+
+	test_expect_success 'output contains expected string' - <<\EOT
+		grep "this string has 'quotes' in it" output
+	EOT
+
    If you supply three parameters the first will be taken to be a
    prerequisite; see the test_set_prereq and test_have_prereq
    documentation below:
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 427b375b39..803ed2df39 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -872,6 +872,24 @@ test_verify_prereq () {
 	BUG "'$test_prereq' does not look like a prereq"
 }
 
+# assign the variable named by "$1" with the contents of "$2";
+# if "$2" is "-", then read stdin into "$1" instead
+test_body_or_stdin () {
+	if test "$2" != "-"
+	then
+		eval "$1=\$2"
+		return
+	fi
+
+	# start with a newline, to match hanging newline from open-quote style
+	eval "$1=\$LF"
+	local test_line
+	while IFS= read -r test_line
+	do
+		eval "$1=\${$1}\${test_line}\${LF}"
+	done
+}
+
 test_expect_failure () {
 	test_start_ "$@"
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
@@ -881,9 +899,11 @@ test_expect_failure () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
+		local test_body
+		test_body_or_stdin test_body "$2"
 		test -n "$test_skip_test_preamble" ||
-		say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$1': $2"
-		if test_run_ "$2" expecting_failure
+		say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$1': $test_body"
+		if test_run_ "$test_body" expecting_failure
 		then
 			test_known_broken_ok_ "$1"
 		else
@@ -902,13 +922,15 @@ test_expect_success () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
+		local test_body
+		test_body_or_stdin test_body "$2"
 		test -n "$test_skip_test_preamble" ||
-		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $2"
-		if test_run_ "$2"
+		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $test_body"
+		if test_run_ "$test_body"
 		then
 			test_ok_ "$1"
 		else
-			test_failure_ "$@"
+			test_failure_ "$1" "$test_body"
 		fi
 	fi
 	test_finish_
-- 
2.45.2.1165.ga18b536d12

