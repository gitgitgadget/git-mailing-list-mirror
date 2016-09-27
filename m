Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A9241F4F8
	for <e@80x24.org>; Tue, 27 Sep 2016 07:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932470AbcI0Hpv (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 03:45:51 -0400
Received: from a1i216.smtp2go.com ([43.228.184.216]:39574 "EHLO
        a1i216.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932455AbcI0Hpr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 03:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpcorp.com; s=a0-2; h=Feedback-ID:X-Smtpcorp-Track:Date:Subject:To:From:
        Reply-To:Message-ID:List-Unsubscribe;
        bh=mByiWOY8NHqEQLVLtdfjU7XHgM+aHmyRjNsJN2CyprI=; b=2GEvcsMXkkd3YAdpwQtvtfvi1l
        n/hPP4XbSJW0g1fafXu+xAe3b4t2g7Zry+LLZlWbOmLwuj+8fNOCUrAtFVf3UY2AEBJZPqRqPxwQu
        ErH6uolDfXDuvh1Fqq9a8p8jwozElXULR5pKf7agtu1UTC4sxXbyWCVjD4Jyoac0UJ7vX1YZE9fbC
        KBQdr800xAWWFr0IC2OMIUNkP83PQiuxkRLkH/KWO3phL5Ywb3mRzzCluD/kYCe/kPapbydX7wE39
        WHNMvQkTVf0JMMitB/PYLvJNIovq5iIuLLeLJWlQMH9/bn8CX1ZHckGF8nXnJas01L7Pql8f31ziU
        Wv9vO6oQ==;
Message-ID: <D5DC2D99E1F84C308DDB99096B0E3BCD@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     <santiago@nyu.edu>, <git@vger.kernel.org>
Cc:     <gitster@pobox.com>, <peff@peff.net>, <sunshine@sunshineco.com>,
        <walters@verbum.org>, "Santiago Torres" <santiago@nyu.edu>
References: <20160926224233.32702-1-santiago@nyu.edu> <20160926224233.32702-5-santiago@nyu.edu>
Subject: Re: [PATCH v2 4/5] builtin/verify-tag: add --format to verify-tag
Date:   Tue, 27 Sep 2016 08:44:57 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1Pon5C9EFLOyFh.6gOkaQ510
Feedback-ID: 66524m:66524aMf6O2Y:66524s8zHVxOmgQ:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: <santiago@nyu.edu>
> From: Santiago Torres <santiago@nyu.edu>
>
> Callers of verify-tag may want to cross-check the tagname from refs/tags
> with the tagname from the tag object header upon GPG verification. This
> is to avoid tag refs that point to an incorrect object.
>
> Add a --format parameter to git verify-tag to print the formatted tag
> object header in addition to or instead of the --verbose or --raw GPG
> verification output.
>
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
> builtin/verify-tag.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index de10198..a941053 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -12,12 +12,15 @@
> #include <signal.h>
> #include "parse-options.h"
> #include "gpg-interface.h"
> +#include "ref-filter.h"
>
> static const char * const verify_tag_usage[] = {
> - N_("git verify-tag [-v | --verbose] <tag>..."),
> + N_("git verify-tag [-v | --verbose] [--format=<format>] <tag>..."),

Does this require a corresponding documentation change? (also 5/5)

>  NULL
> };
>
> +static char *fmt_pretty;
> +
> static int git_verify_tag_config(const char *var, const char *value, void 
> *cb)
> {
>  int status = git_gpg_config(var, value, cb);
> @@ -33,6 +36,7 @@ int cmd_verify_tag(int argc, const char **argv, const 
> char *prefix)
>  const struct option verify_tag_options[] = {
>  OPT__VERBOSE(&verbose, N_("print tag contents")),
>  OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), 
> GPG_VERIFY_RAW),
> + OPT_STRING(  0 , "format", &fmt_pretty, N_("format"), N_("format to use 
> for the output")),
>  OPT_END()
>  };
>
> @@ -46,12 +50,17 @@ int cmd_verify_tag(int argc, const char **argv, const 
> char *prefix)
>  if (verbose)
>  flags |= GPG_VERIFY_VERBOSE;
>
> + if (fmt_pretty) {
> + verify_ref_format(fmt_pretty);
> + flags |= GPG_VERIFY_QUIET;
> + }
> +
>  while (i < argc) {
>  unsigned char sha1[20];
>  const char *name = argv[i++];
>  if (get_sha1(name, sha1))
>  had_error = !!error("tag '%s' not found.", name);
> - else if (verify_and_format_tag(sha1, name, NULL, flags))
> + else if (verify_and_format_tag(sha1, name, fmt_pretty, flags))
>  had_error = 1;
>  }
>  return had_error;
> -- 
> 2.10.0
>
--
Philip 

