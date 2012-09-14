From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/6] t7810-grep: test multiple --author with --all-match
Date: Fri, 14 Sep 2012 10:14:14 +0200
Message-ID: <5052E756.2040605@drmicha.warpmail.net>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org> <cover.1347544259.git.git@drmicha.warpmail.net> <8fd93bb87098298677426735dd354fa4f64abc17.1347544259.git.git@drmicha.warpmail.net> <7vmx0t7iq0.fsf@alter.siamese.dyndns.org> <7vwqzx4i9i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 10:14:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCR2t-000214-Ej
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 10:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab2INIOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 04:14:30 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59169 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755628Ab2INIOQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 04:14:16 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9BBE5206C4;
	Fri, 14 Sep 2012 04:14:15 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 14 Sep 2012 04:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=CtgkW7414nvEKtflMHCBlW
	TNlDA=; b=AQjKTDKH4qIG85WSRQf0kuGx5UCFi0mU146/rATxaRYA+OIf7sF3mC
	d3OUQIWZSwerD5qCSbArM9w8fB+Fk+kN0S6OprtUHMjJb0RV4m8pFLqNAPgBQDhY
	e8FGN/HvKiwbbZ843icX5GTMKj9KVuRicxTM52CuvCqaqGmE3tvNs=
X-Sasl-enc: Qdnz95Hxi5PNOXoBIQP2bc0qO0/D8r04IiGKJ+ZXOraw 1347610455
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 20B878E03D2;
	Fri, 14 Sep 2012 04:14:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vwqzx4i9i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205464>

Junio C Hamano venit, vidit, dixit 14.09.2012 01:26:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> One possible improvement we can make is to parse the command line in
>> the last example with "--all-match" to
>>
>>     [all-match]
>>     (or
>>      pattern_body<body>commit
>>      (or
>>       pattern_body<body>tag
>>       (or
>>        pattern_head<head 1>Linus
>>        (or
>>         pattern_head<head 0>Junio
>>         true
>>        )
>>       )
>>      )
>>     )
>>
>> so that the backbone becomes
>>
>>  - Mentions commit,
>>  - Mentions tag,
>>  - Committed by Linus,
>>  - Authored by Junio
>>
>> to require that both commit and tag are mentioned in the message.
> 
> And this is an attempt to do exactly that.  Earlier, when we have
> both header expression (which by the way has to be an OR node by
> construction) and pattern expression (which could be anything), we
> created a top-level OR node (again, look at this as if you are
> reading LISP),
> 
>            OR
>         /        \
>        /          \
>    pattern            OR
>      / \           /     \
>     .....    committer    OR
>                          /   \ 
>                      author   TRUE
> 
> in other words, the three elements on the top-level backbone are
> "pattern", "committer" and "author"; when there are more than one
> elements in the "pattern", the top-level node of it is OR, so that
> node is inspected by "all-match", hence the result ends up ignoring
> the "--all-match" given from the command line.
> 
> This patch turns it into
> 
> 	     OR
>           /      \
>          /         \
>         /              OR
>     committer        /    \
>                  author    \
>                            pattern
> 
> when "--all-match" was given from the command line, so that the
> "committer", "author" and elements on the top-level backbone in
> "pattern" form the top-level backbone of the resulting expression to
> be inspected by the "all-match" logic.
> 
> Does this pass the expect-failure test in your [PATCH 5/6]?

Just a quick heads up:

I merged 38ed8ef (log --grep/--author: honor --all-match honored for
multiple --grep patterns, 2012-09-13) from pu into my test branch,
and this fixes what I had marked as known failure there. Thanks!

[I still have to figure out the logic, but begin to understand that
"(OR...) and "(AND...)" are linewise, and all-match is a bufferwise AND
or something. Now, what is "*or*" ...]

>  grep.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git c/grep.c w/grep.c
> index be15c47..925aa92 100644
> --- c/grep.c
> +++ w/grep.c
> @@ -476,6 +476,22 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
>  	return header_expr;
>  }
>  
> +static struct grep_expr *grep_splice_or(struct grep_expr *x, struct grep_expr *y)
> +{
> +	struct grep_expr *z = x;
> +
> +	while (x) {
> +		assert(x->node == GREP_NODE_OR);
> +		if (x->u.binary.right &&
> +		    x->u.binary.right->node == GREP_NODE_TRUE) {
> +			x->u.binary.right = y;
> +			break;
> +		}
> +		x = x->u.binary.right;
> +	}
> +	return z;
> +}
> +
>  static void compile_grep_patterns_real(struct grep_opt *opt)
>  {
>  	struct grep_pat *p;
> @@ -510,6 +526,9 @@ static void compile_grep_patterns_real(struct grep_opt *opt)
>  
>  	if (!opt->pattern_expression)
>  		opt->pattern_expression = header_expr;
> +	else if (opt->all_match)
> +		opt->pattern_expression = grep_splice_or(header_expr,
> +							 opt->pattern_expression);
>  	else
>  		opt->pattern_expression = grep_or_expr(opt->pattern_expression,
>  						       header_expr);
> 
