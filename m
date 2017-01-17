Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1665B20756
	for <e@80x24.org>; Tue, 17 Jan 2017 17:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751031AbdAQR0c (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 12:26:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:40276 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbdAQRZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 12:25:40 -0500
Received: (qmail 12744 invoked by uid 109); 17 Jan 2017 17:25:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 17:25:33 +0000
Received: (qmail 19272 invoked by uid 111); 17 Jan 2017 17:26:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 12:26:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 12:25:31 -0500
Date:   Tue, 17 Jan 2017 12:25:31 -0500
From:   Jeff King <peff@peff.net>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v5 3/7] tag: add format specifier to gpg_verify_tag
Message-ID: <20170117172531.bahjekbj3om43gtq@sigill.intra.peff.net>
References: <20170115184705.10376-1-santiago@nyu.edu>
 <20170115184705.10376-4-santiago@nyu.edu>
 <20170117152455.k6zkeclsyawzpl2n@sigill.intra.peff.net>
 <20170117153019.gujiruwghkwfklgv@sigill.intra.peff.net>
 <20170117165724.2hbyfdzrhrmro54b@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170117165724.2hbyfdzrhrmro54b@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 11:57:25AM -0500, Santiago Torres wrote:

> > Having read through the rest of the series, it looks like you'd
> > sometimes have to do:
> 
> IIRC, we did this to make the diff "simpler". It also feeds odd that the
> call chain is the following:
> 
>     verify_and_format_tag()
>     gpg_verify_tag()
>     run_gpg_verification()
> 
> I'm afraid that adding yet another wrapper would further convolute the
> call chain. If you think this is not an issue, I could easily do it. Do
> you have any suggested name for the wrapper?

Actually, looking at the callsites, I think they are fine to just call
pretty_print_ref() themselves, and I don't think it actually matters if
it happens before or after the verification.

So I think you could just throw out patch 3 entirely and squash these
hunks into patches 4 and 5:

diff --git a/builtin/tag.c b/builtin/tag.c
index 9da11e0c2..fab9fa8f9 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -111,10 +111,12 @@ static int verify_tag(const char *name, const char *ref,
 	char *fmt_pretty = cb_data;
 	flags = GPG_VERIFY_VERBOSE;
 
-	if (fmt_pretty)
+	if (fmt_pretty) {
 		flags = GPG_VERIFY_QUIET;
+		pretty_print_ref(name, sha1, fmt_pretty);
+	}
 
-	return verify_and_format_tag(sha1, ref, fmt_pretty, flags);
+	return gpg_verify_tag(sha1, ref, flags);
 }
 
 static int do_sign(struct strbuf *buffer)
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 212449f47..114df1c52 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -58,9 +58,15 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	while (i < argc) {
 		unsigned char sha1[20];
 		const char *name = argv[i++];
-		if (get_sha1(name, sha1))
+
+		if (get_sha1(name, sha1)) {
 			had_error = !!error("tag '%s' not found.", name);
-		else if (verify_and_format_tag(sha1, name, fmt_pretty, flags))
+			continue;
+		}
+
+		if (fmt_pretty)
+			pretty_print_ref(name, sha1, fmt_pretty);
+		if (gpg_verify_tag(sha1, name, flags))
 			had_error = 1;
 	}
 	return had_error;

You could make the diff in the second one simpler by skipping the
"continue" and just doing the whole thing in an "else" block. But IMHO
the continue-on-error makes the logic more clear.

-Peff
