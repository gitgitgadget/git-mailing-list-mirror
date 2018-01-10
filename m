Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C7E1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 19:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeAJTx0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 14:53:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:40474 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751238AbeAJTxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 14:53:25 -0500
Received: (qmail 18726 invoked by uid 109); 10 Jan 2018 19:53:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Jan 2018 19:53:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18094 invoked by uid 111); 10 Jan 2018 19:53:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Jan 2018 14:53:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jan 2018 14:53:23 -0500
Date:   Wed, 10 Jan 2018 14:53:23 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t3900: add some more quotes
Message-ID: <20180110195323.GA26186@sigill.intra.peff.net>
References: <20180110095832.22077-1-dev+git@drbeat.li>
 <6b32292b-0f71-7cf8-2069-41766d440b58@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b32292b-0f71-7cf8-2069-41766d440b58@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 08:02:09PM +0100, Johannes Sixt wrote:

> > diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
> > index 9e4e694d9..dc00db87b 100755
> > --- a/t/t3900-i18n-commit.sh
> > +++ b/t/t3900-i18n-commit.sh
> > @@ -40,7 +40,7 @@ test_expect_success 'UTF-16 refused because of NULs' '
> >   '
> >   test_expect_success 'UTF-8 invalid characters refused' '
> > -	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
> > +	test_when_finished "rm -f \"$HOME/stderr\" \"$HOME/invalid\"" &&
> 
> Should that not better be
> 
> 	test_when_finished "rm -f \"\$HOME/stderr\" \"\$HOME/invalid\""
> 
> i.e., delay the expansion of $HOME to protect against double-quotes in the
> path?

Yeah. One of the reasons for both of the errors in this thread is the
nested double-quoting. Using single quotes is awkward because we're
already using them to delimit the whole snippet.  I've often wondered if
our tests would be more readable taking the snippet over stdin.
Something like:

diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 9e4e694d93..09ad4d8878 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -39,14 +39,14 @@ test_expect_success 'UTF-16 refused because of NULs' '
 	test_must_fail git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
 '
 
-test_expect_success 'UTF-8 invalid characters refused' '
-	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
+test_expect_success 'UTF-8 invalid characters refused' - <<\EOT
+	test_when_finished 'rm -f "$HOME/stderr $HOME/invalid"' &&
 	echo "UTF-8 characters" >F &&
 	printf "Commit message\n\nInvalid surrogate:\355\240\200\n" \
 		>"$HOME/invalid" &&
 	git commit -a -F "$HOME/invalid" 2>"$HOME"/stderr &&
 	test_i18ngrep "did not conform" "$HOME"/stderr
-'
+EOT
 
 test_expect_success 'UTF-8 overlong sequences rejected' '
 	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1701fe2a06..be8a47d304 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -391,11 +391,32 @@ test_verify_prereq () {
 	error "bug in the test script: '$test_prereq' does not look like a prereq"
 }
 
+# Read from stdin into the variable given in $1.
+test_read_to_eof () {
+	# Bash's "read" is sufficiently flexible that we can skip the extra
+	# process.
+	if test -n "$BASH_VERSION"
+	then
+		# 64k should be enough for anyone...
+		read -N 65536 -r "$1"
+	else
+		# command substitution eats trailing whitespace, so we add
+		# and then remove a non-whitespace character.
+		eval "$1=\$(cat; printf x)"
+		eval "$1=\${$1%x}"
+	fi
+}
+
 test_expect_failure () {
 	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 or 3 parameters to test-expect-failure"
+	if test "$2" = "-"
+	then
+		test_read_to_eof test_block
+		set -- "$1" "$test_block"
+	fi
 	test_verify_prereq
 	export test_prereq
 	if ! test_skip "$@"
@@ -416,6 +437,11 @@ test_expect_success () {
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
+	if test "$2" = "-"
+	then
+		test_read_to_eof test_block
+		set -- "$1" "$test_block"
+	fi
 	test_verify_prereq
 	export test_prereq
 	if ! test_skip "$@"
