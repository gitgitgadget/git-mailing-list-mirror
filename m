Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED3FC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1429D611C9
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhEKS6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:58:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:51050 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232177AbhEKS6c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:58:32 -0400
Received: (qmail 24125 invoked by uid 109); 11 May 2021 18:57:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 18:57:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26827 invoked by uid 111); 11 May 2021 18:57:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 14:57:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 14:57:25 -0400
From:   Jeff King <peff@peff.net>
To:     Gregory Anders <greg@gpanders.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJrTlXzuuMoxeJay@coredump.intra.peff.net>
References: <20210511183703.9488-1-greg@gpanders.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210511183703.9488-1-greg@gpanders.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 12:37:03PM -0600, Gregory Anders wrote:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 175da07d94..dbc5a2f51c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1492,7 +1492,11 @@ sub send_message {
>  
>  	if ($dry_run) {
>  		# We don't want to send the email.
> -	} elsif (file_name_is_absolute($smtp_server)) {
> +	} elsif (file_name_is_absolute($smtp_server) || $smtp_server =~ /^!/) {
> +		if ($smtp_server =~ s/^!//) {
> +			my $smtp_server = map {"$_/$smtp_server"} split /:/, $ENV{PATH};
> +		}
> +

I don't think the new "if" block is doing what you expect:

  - the result of "map" is a list, but you are assigning it to a scalar
    (so you'll end up with the size of the list, which is really just
    counting the number of elements in your $PATH). If you want to
    search for a match in the PATH, you'd need to do something like:

      for my $candidate (map { "$_/$smtp_server" } split /:/, $ENV{PATH}) {
              if (-x $candidate) {
	              $smtp_server = $candidate;
	              last;
	      }
      }

     But see below.

  - the bogus code in the conditional ends up doing nothing, since you
    declare a new lexical version of $smtp_server (with "my"), shadowing
    the outer variable.

So why does it work at all? Because the "s/^!//" in the "if" statement
actually mutates $smtp_server to remove the "!". And then feeding that
name into exec() below will do a lookup in PATH itself.

So a shorter version of the same thing is just:

  ...
  } elsif (file_name_is_absolute($smtp_server) || $smtp_server =~ s/^!//) {
  ...

which detects and mutates $smtp_server in the first place.

However, it's probably not a good idea to change that variable, as it
loses information. If we call into send_message() a second time, we
won't realize we're supposed to respect "!".

So perhaps something like (totally untested):

diff --git a/git-send-email.perl b/git-send-email.perl
index 175da07d94..022dcf0999 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1492,11 +1492,14 @@ sub send_message {
 
 	if ($dry_run) {
 		# We don't want to send the email.
-	} elsif (file_name_is_absolute($smtp_server)) {
+	} elsif (file_name_is_absolute($smtp_server) || $smtp_server =~ /^!/) {
+		my $prog = $smtp_server;
+		$prog =~ s/^!//;
+
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
-			exec($smtp_server, @sendmail_parameters) or die $!;
+			exec($prog, @sendmail_parameters) or die $!;
 		}
 		print $sm "$header\n$message";
 		close $sm or die $!;

-Peff
