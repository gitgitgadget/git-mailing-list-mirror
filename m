Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C310625
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773544492; cv=none; b=HvVRSejzDGttugW+2PMG+ccHbUwdV/OjnARK2YbR9utiYNOIU/9p+E5Vetlcq/QEzJAuV76p8oSCfU4+PUi9fVTgE1FFUA7Y7NrcfkzCyFoG+OxvLiin86vkmxO0TzG9MkWctntywivcChzMwwEgqHUXxpLwa06u6vU3XnkUFu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773544492; c=relaxed/simple;
	bh=wjUeTeAT8lOwHa5WJy+OjbfCi1CFHYiBN85wcdZjAdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gshOETDrIOByn7lZBYfw8U5spsr2KgaHbfW05HVpUXdXR8/jplddWS5/6zIRlyU8Qt5xOCLrIuYUyRZhjSwoupsuC6/L95DnWRQDSRUwG4HN7usp19t+zXCTmLAQBuvC8fYTUjCM9tRguBKMxtR1SHr39ly9dEYq1sRSHMq962w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ha0qJ7eI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ha0qJ7eI"
Received: (qmail 123534 invoked by uid 106); 15 Mar 2026 03:14:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wjUeTeAT8lOwHa5WJy+OjbfCi1CFHYiBN85wcdZjAdQ=; b=ha0qJ7eIW1JgPNU5IGzk+RCbyYK4lBUIsGDj5IyfliKN1fVt1KL7TqvQ9mNDqdT1ayI7MNNADRaBJE00EYqYFAZ+99/FJGYkCvEhjU70GAZ8c1eAgcxNbshjGWmD2lopBk3rAxhqipokjDUY8G+KUshfPnMEH4syM2dzsLk0RqkSvZJRFfNzUGdDlMgyiVCbBAc5QGNd+o2w0A9xFcoqkPRrFnADfphc9VUI7Xga+4TrEzzU1uG+Ti2ACdJcjkGXPDdysJ+B7lGRYiIpfK4gCNbo8AxyHu5Rtf6WBEEODJx5Y1syp+FSuowjRljzQTcAkxNKaACnpqKYc4sf2pUnog==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Mar 2026 03:14:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 554771 invoked by uid 111); 15 Mar 2026 03:14:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Mar 2026 23:14:51 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 14 Mar 2026 23:14:47 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: Unexpected exit code for --help with rev-parse --parseopt
Message-ID: <20260315031447.GB926820@coredump.intra.peff.net>
References: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>

On Sun, Mar 15, 2026 at 12:52:22AM +0000, brian m. carlson wrote:

> I use git rev-parse --parseopt to parse command-line options in various
> script.  I've noticed that it exits 129 if the options are invalid,
> which is fine, but that it also exits 129 if --help or -h are given,
> which is not.
> 
> The standard philosophy is that if the user explicitly asked for help,
> then help output should be printed to standard output (since that's what
> the user asked for) and it should exit 0, since the program fulfilled
> the user's request successfully.  If the help output is provided because
> the user provided an invalid option or argument, then the output should
> Go to standard error (since it's an error message) and the program
> should exit unsuccessfully (since it did not fulfill the user's request
> successfully).

I agree with this philosophy in general, but there's catch here with
"rev-parse --parseopt", because it's running as a separate program. It
needs to signal to the calling program that "-h" was seen, the program
should not proceed normally (because rev-parse already dumped help
output).

So if your proposal is to just exit with code 0 from rev-parse, I don't
think that works.

My first instinct is that it would have to exit with some other
well-known code, the callers would recognize that, and then exit
themselves (with code 0).

But there's a little more to the story. The output of --parseopt is meant
to be eval'd by the shell. And so when it works, we get a "set" command:

  $ git rev-parse --parseopt <input -- --output=foo
  set -- -o 'foo' --

And when there's an error, it dumps the usage text straight to stderr
and exits 129:

  $ git rev-parse --parseopt <input -- --foo
  error: unknown option `foo'
  usage: foo-cmd [<options>] <args>...
  
      Do stuff.
  
      -h, --help            show this help
      -o, --[no-]output ... output to this file
      -d, --[no-]dir ...    specify dependencies relative to this directory

But when the user asks for "-h", we get a here-doc! Like this:

  $ git rev-parse --parseopt <input -- -h
  cat <<\EOF
  usage: foo-cmd [<options>] <args>...
  
      Do stuff.
  
      -h, --help            show this help
      -o, --[no-]output ... output to this file
      -d, --[no-]dir ...    specify dependencies relative to this directory
  
  EOF

So the calling program runs that cat command. And I think what you
really want is to tack "exit 0" onto the end of that output, which would
tell the callers to exit. Something like this:

diff --git a/parse-options.c b/parse-options.c
index a676da86f5..b990f38419 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1473,8 +1473,10 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 	}
 	fputc('\n', outfile);
 
-	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
+	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL) {
 		fputs("EOF\n", outfile);
+		fputs("exit 0\n", outfile);
+	}
 
 	return PARSE_OPT_HELP;
 }

And then you don't even need to change the exit code of rev-parse itself
(since we'd never hit the "exit $?" that the caller tacks on in case of
failure). Though I think it might be reasonable to switch it to 0
anyway.

-Peff
