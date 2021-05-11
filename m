Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CF7C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A036186A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhEKVlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 17:41:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:51406 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKVlE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 17:41:04 -0400
Received: (qmail 24675 invoked by uid 109); 11 May 2021 21:39:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 21:39:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28578 invoked by uid 111); 11 May 2021 21:39:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 17:39:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 17:39:56 -0400
From:   Jeff King <peff@peff.net>
To:     Gregory Anders <greg@gpanders.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJr5rHnQOve1DD6+@coredump.intra.peff.net>
References: <YJrZ7Hho6jrVyM7f@coredump.intra.peff.net>
 <20210511204044.69047-1-greg@gpanders.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210511204044.69047-1-greg@gpanders.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 02:40:44PM -0600, Gregory Anders wrote:

> Presently, the smtpServer config option can use a sendmail-like program
> by providing an absolute path to the program as the value for this
> option. However, an absolute path is not always portable and it is often
> preferable to simply specify a program name and have `git-send-email`
> find that program on $PATH.
> 
> For example, if a user wishes to use msmtp to send emails, they might
> be able to simply use
> 
>     [sendemail]
>             smtpServer = !msmtp
> 
> instead of using the full path. This is particularly useful when a
> common git config file is used across multiple systems where the
> absolute path to a given program may differ.
> 
> To that end, this patch allows the smtpServer config option to be
> prefixed with a ! character that implements the above behavior; namely,
> the specified value (sans the ! character) is used as if the user had
> entered it directly on the command line.

Thanks, this justifies the change quite nicely, I think.

> See also https://lore.kernel.org/git/YJrH8uqzapnpNEsb@gpanders.com/.

IMHO this link could be dropped. I referenced it earlier in the thread
since there wasn't much context in your commit message. In general we
prefer to copy that context into the commit, so it doesn't depend on
having access to the list. And you already did that quite nicely, so the
link tells us nothing new. :)

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 93708aefea..418e66c703 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -212,12 +212,13 @@ a password is obtained using 'git-credential'.
>  --smtp-server=<host>::
>  	If set, specifies the outgoing SMTP server to use (e.g.
>  	`smtp.example.com` or a raw IP address).  Alternatively it can
> -	specify a full pathname of a sendmail-like program instead;
> -	the program must support the `-i` option.  Default value can
> -	be specified by the `sendemail.smtpServer` configuration
> -	option; the built-in default is to search for `sendmail` in
> -	`/usr/sbin`, `/usr/lib` and $PATH if such program is
> -	available, falling back to `localhost` otherwise.
> +	specify a sendmail-like program instead, either by a full
> +	path-name or by prefixing the program name with `!`.  The
> +	program must support the `-i` option.  Default value can be
> +	specified by the `sendemail.smtpServer` configuration option;
> +	the built-in default is to search for `sendmail` in `/usr/sbin`,
> +	`/usr/lib` and $PATH if such program is available, falling back
> +	to `localhost` otherwise.

Ah, thanks for remembering to update the documentation. This looks good.

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 65b3035371..14cc61ace7 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -2225,4 +2225,14 @@ test_expect_success $PREREQ 'test forbidSendmailVariables behavior override' '
>  		HEAD^
>  '
>  
> +test_expect_success $PREREQ 'test using a command for smtpServer with !' '
> +	clean_fake_sendmail &&
> +	PATH="$(pwd):$PATH" \
> +	git send-email \
> +		--from="Example <nobody@example.com>" \
> +		--to=nobody@example.com \
> +		--smtp-server="!fake.sendmail" \
> +		$patches 2>errors
> +'

How do we know that we successfully ran our fake.sendmail script? I
guess probably send-email would error out, but should we confirm that it
touched commandline1, etc?

It also seems to fail for me. I think $patches isn't valid at this point
in the script, as the patch files have been removed. Switching to just
HEAD~2 doesn't seem to work either, as earlier tests set up a hook which
rejects it. I think we could pass HEAD^ to send just one path, but I
thought it would be nice to confirm that sending multiple works (i.e.,
avoiding the bug we discussed earlier).

I think the existing hook tests are somewhat poor to leave this
confusing state. But the easiest thing to me is to just bump our test up
a bit, like:

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 14cc61ace7..31d25b32b5 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2148,6 +2148,18 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	test_cmp expected-list actual-list
 '
 
+test_expect_success $PREREQ 'test using a command for smtpServer with !' '
+	clean_fake_sendmail &&
+	PATH="$(pwd):$PATH" \
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="!fake.sendmail" \
+		HEAD~2 2>errors &&
+	test_path_is_file commandline1 &&
+	test_path_is_file commandline2
+'
+
 test_expect_success $PREREQ 'invoke hook' '
 	mkdir -p .git/hooks &&
 
@@ -2225,14 +2237,4 @@ test_expect_success $PREREQ 'test forbidSendmailVariables behavior override' '
 		HEAD^
 '
 
-test_expect_success $PREREQ 'test using a command for smtpServer with !' '
-	clean_fake_sendmail &&
-	PATH="$(pwd):$PATH" \
-	git send-email \
-		--from="Example <nobody@example.com>" \
-		--to=nobody@example.com \
-		--smtp-server="!fake.sendmail" \
-		$patches 2>errors
-'
-
 test_done
