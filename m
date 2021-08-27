Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C855C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C8F60E97
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhH0SbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 14:31:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:60818 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhH0SbG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 14:31:06 -0400
Received: (qmail 9084 invoked by uid 109); 27 Aug 2021 18:30:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Aug 2021 18:30:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15474 invoked by uid 111); 27 Aug 2021 18:30:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Aug 2021 14:30:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Aug 2021 14:30:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org
Subject: Re: git log --encoding=HTML is not supported
Message-ID: <YSkvNyR4uT52de13@coredump.intra.peff.net>
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
 <xmqqeeahjxj4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeeahjxj4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 09:31:59AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We feed the encoding "HTML" to iconv_open(), which of course has no idea
> > what that is. It's unfortunate, though, that we don't even print a
> > warning, and instead just quietly leave the text intact. I wonder if we
> > should do something like:
> [...]
> This addition sounds quite sensible to me.
> 
> "git log --encoding=bogus" would issue this warning for each and
> every commit and that may be a bit irritating, but being irritating
> may be a good characteristic for a warning message that is given to
> an easily correctable condition.
> 
> I originally thought that the warning would be lost to the pager,
> but apparently I forgot what I did eons ago at 61b80509 (sending
> errors to stdout under $PAGER, 2008-02-16) ;-).

Here it is polished into a real commit.

-- >8 --
Subject: [PATCH] logmsg_reencode(): warn when iconv() fails

If the user asks for a pretty-printed commit to be converted (either
explicitly with --encoding=foo, or implicitly because the commit is
non-utf8 and we want to convert it), we pass it through iconv(). If that
fails, we fall back to showing the input verbatim, but don't tell the
user that the output may be bogus.

Let's add a warning to do so, along with a mention in the documentation
for --encoding. Two things to note about the implementation:

  - we could produce the warning closer to the call to iconv() in
    reencode_string_len(), which would let us relay the value of errno.
    But this is not actually very helpful. reencode_string_len() does
    not know we are operating on a commit, and indeed does not know that
    the caller won't produce an error of its own. And the errno values
    from iconv() are seldom helpful (iconv_open() only ever produces
    EINVAL; perhaps EILSEQ from iconv() might be illuminating, but it
    can also return EINVAL for incomplete sequences).

  - if the reason for the failure is that the output charset is not
    supported, then the user will see this warning for every commit we
    try to display. That might be ugly and overwhelming, but on the
    other hand it is making it clear that every one of them has not been
    converted (and the likely outcome anyway is to re-try the command
    with a supported output encoding).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/pretty-options.txt | 4 +++-
 pretty.c                         | 6 +++++-
 t/t4210-log-i18n.sh              | 7 +++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 27ddaf84a1..42b227bc40 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -40,7 +40,9 @@ people using 80-column terminals.
 	defaults to UTF-8. Note that if an object claims to be encoded
 	in `X` and we are outputting in `X`, we will output the object
 	verbatim; this means that invalid sequences in the original
-	commit may be copied to the output.
+	commit may be copied to the output. Likewise, if iconv(3) fails
+	to convert the commit, we will output the original object
+	verbatim, along with a warning.
 
 --expand-tabs=<n>::
 --expand-tabs::
diff --git a/pretty.c b/pretty.c
index 9631529c10..73b5ead509 100644
--- a/pretty.c
+++ b/pretty.c
@@ -671,7 +671,11 @@ const char *repo_logmsg_reencode(struct repository *r,
 	 * If the re-encoding failed, out might be NULL here; in that
 	 * case we just return the commit message verbatim.
 	 */
-	return out ? out : msg;
+	if (!out) {
+		warning("unable to reencode commit to '%s'", output_encoding);
+		return msg;
+	}
+	return out;
 }
 
 static int mailmap_name(const char **email, size_t *email_len,
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index d2dfcf164e..0141f36e33 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -131,4 +131,11 @@ do
 	fi
 done
 
+test_expect_success 'log shows warning when conversion fails' '
+	enc=this-encoding-does-not-exist &&
+	git log -1 --encoding=$enc 2>err &&
+	echo "warning: unable to reencode commit to ${SQ}${enc}${SQ}" >expect &&
+	test_cmp expect err
+'
+
 test_done
-- 
2.33.0.396.g72f622fe47

