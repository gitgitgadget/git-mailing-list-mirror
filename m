Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C93BC3DA7D
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 06:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiL0GLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 01:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiL0GLg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 01:11:36 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CFCB8C
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 22:11:33 -0800 (PST)
Received: (qmail 29173 invoked by uid 109); 27 Dec 2022 06:11:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Dec 2022 06:11:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4591 invoked by uid 111); 27 Dec 2022 06:11:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Dec 2022 01:11:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Dec 2022 01:11:31 -0500
From:   Jeff King <peff@peff.net>
To:     nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, nsengaw4c <nsengiyumvawilberforce@gmail.com>
Subject: Re: [PATCH] ref-filter: add new atom "signature" atom
Message-ID: <Y6qMk3e+FqEThL5f@coredump.intra.peff.net>
References: <pull.1452.git.1672102523902.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1452.git.1672102523902.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2022 at 12:55:23AM +0000, nsengaw4c via GitGitGadget wrote:

> This only works for commits. Add "signature" atom with `grade`,
> `signer`, `key`, `fingerprint`, `primarykeyfingerprint`, `trustlevel`
> as arguments. This code and it's documentation are inspired by
> how the %GG, %G?, %GS, %GK, %GF, %GP, and %GT pretty formats were
> implemented.

I don't have a real review for you, but rather two small requests since
I was working in this area recently.

> @@ -378,6 +383,30 @@ static int subject_atom_parser(struct ref_format *format, struct used_atom *atom
>  	return 0;
>  }
>  
> +static int signature_atom_parser(struct ref_format *format, struct used_atom *atom,
> +			       const char *arg, struct strbuf *err)

Can you squash in an annotation for the unused parameter, like this:

diff --git a/ref-filter.c b/ref-filter.c
index a4c3f89f64..3b3592acb2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -405,8 +405,9 @@ static int subject_atom_parser(struct ref_format *format UNUSED,
 	return 0;
 }
 
-static int signature_atom_parser(struct ref_format *format, struct used_atom *atom,
-			       const char *arg, struct strbuf *err)
+static int signature_atom_parser(struct ref_format *format UNUSED,
+				 struct used_atom *atom,
+				 const char *arg, struct strbuf *err)
 {
 	if (arg) {
 		if (!strcmp(arg, "signer"))

This will eventually be necessary once we turn on -Wunused-parameter.
I'm preparing a patch to convert all of the other parsers that need it,
and I don't want to create a dependency between the two patches (it's OK
for you to add the UNUSED now, it's just not enforced yet).

I can also circle back after your patch is merged and add it, but it's a
bit easier to do it up front.

> +{
> +	if (arg) {
> +		if (!strcmp(arg, "signer"))
> +			atom->u.signature.option = S_SIGNER;
> +		else if (!strcmp(arg, "grade"))
> +			atom->u.signature.option = S_GRADE;
> +		else if (!strcmp(arg, "key"))
> +			atom->u.signature.option = S_KEY;
> +		else if (!strcmp(arg, "fingerprint"))
> +			atom->u.signature.option = S_FINGERPRINT;
> +		else if (!strcmp(arg, "primarykeyfingerprint"))
> +			atom->u.signature.option = S_PRI_KEY_FP;
> +		else if (!strcmp(arg, "trustlevel"))
> +			atom->u.signature.option = S_TRUST_LEVEL;
> +		else
> +			return strbuf_addf_ret(err, -1, _("unknown %%(signature) argument: %s"), arg);
> +	}

The ref-filter code recently got a helper function to report this kind
of argument error consistently, via dda4fc1a84 (ref-filter: factor out
"unrecognized %(foo) arg" errors, 2022-12-14). If you rebase the patch
on the current master, you can just do:

  return err_bad_arg(err, "signature", arg);

which will make the error message match the others (which in turn saves
work for translators).

-Peff
