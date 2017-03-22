Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236D520323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbdCVWWk (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:22:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:49805 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752005AbdCVWWi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:22:38 -0400
Received: (qmail 30712 invoked by uid 109); 22 Mar 2017 22:22:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 22:22:35 +0000
Received: (qmail 575 invoked by uid 111); 22 Mar 2017 22:22:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 18:22:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 18:22:30 -0400
Date:   Wed, 22 Mar 2017 18:22:30 -0400
From:   Jeff King <peff@peff.net>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
Message-ID: <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-4-gitster@pobox.com>
 <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
 <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
 <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 06:15:57PM -0400, Santiago Torres wrote:

> > > Like 2/3, this one also produces test failures for me. It looks like
> > > "verify-tag" does not show a tag which has been forged. I'm not sure if
> > > that's intentional (and the test is wrong) or a bug.  +cc Santiago
> > 
> > It appears that the test expected a broken one to be shown, and my
> > reading of its log message is that the change expected --format= to
> > be used with %G? so that scripts can tell between pass and fail?  
> > 
> > So if I have to judge, the code becoming silent for a tag that does
> > not pass verification is not doing what the commit wanted it to do.
> > 
> 
> Yes, considering the test name is:
> 
>     "verifying a forged tag with --format fail and format accordingly" 
> 
> It feels as if the behavior of verify-tag/tag -v is not the one
> intended. I could add two patches on top of those two commits.

I worked up the patch to do that (see below), but I got stumped trying
to write the commit message. Perhaps that is what the test intended, but
I don't think tag's --format understands "%G" codes at all. So you
cannot tell from the output if a tag was valid or not; you have to check
the exit code separately.

And if you do something like:

  git tag -v --format='%(tag)' foo bar |
  while read tag
  do
     ...
  done

you cannot tell at all which ones are bogus. Whereas with the current
behavior, the bogus ones are quietly omitted. Which can also be
confusing, but I'd think would generally err on the side of caution.

-Peff

---
diff --git a/builtin/tag.c b/builtin/tag.c
index fbb85ba3d..37e768db4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -107,19 +107,19 @@ static int verify_tag(const char *name, const char *ref,
 		      const unsigned char *sha1, const void *cb_data)
 {
 	int flags;
+	int ret;
 	const char *fmt_pretty = cb_data;
 	flags = GPG_VERIFY_VERBOSE;
 
 	if (fmt_pretty)
 		flags = GPG_VERIFY_OMIT_STATUS;
 
-	if (gpg_verify_tag(sha1, name, flags))
-		return -1;
+	ret = gpg_verify_tag(sha1, name, flags);
 
 	if (fmt_pretty)
 		pretty_print_ref(name, sha1, fmt_pretty);
 
-	return 0;
+	return ret;
 }
 
 static int do_sign(struct strbuf *buffer)
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 5199553d9..cb1024ef4 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -62,10 +62,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (gpg_verify_tag(sha1, name, flags)) {
+		if (gpg_verify_tag(sha1, name, flags))
 			had_error = 1;
-			continue;
-		}
 
 		if (fmt_pretty)
 			pretty_print_ref(name, sha1, fmt_pretty);
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b53a2e5e4..633b08956 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -848,17 +848,17 @@ test_expect_success GPG 'verifying a forged tag should fail' '
 '
 
 test_expect_success 'verifying a proper tag with --format pass and format accordingly' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : signed-tag
-	EOF &&
+	EOF
 	git tag -v --format="tagname : %(tag)" "signed-tag" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : forged-tag
-	EOF &&
+	EOF
 	test_must_fail git tag -v --format="tagname : %(tag)" "forged-tag" >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index d62ccbb98..ce37fd986 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -126,17 +126,17 @@ test_expect_success GPG 'verify multiple tags' '
 '
 
 test_expect_success 'verifying tag with --format' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : fourth-signed
-	EOF &&
+	EOF
 	git verify-tag --format="tagname : %(tag)" "fourth-signed" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : 7th forged-signed
-	EOF &&
+	EOF
 	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
 	test_cmp expect actual-forged
 '
