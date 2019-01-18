Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB751F453
	for <e@80x24.org>; Fri, 18 Jan 2019 10:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfARKpU (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 05:45:20 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43686 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfARKpU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 05:45:20 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 85E571F453;
        Fri, 18 Jan 2019 10:45:19 +0000 (UTC)
Date:   Fri, 18 Jan 2019 10:45:19 +0000
From:   Eric Wong <e@80x24.org>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org
Subject: Re: cat-file ambiguity prints "dangling"
Message-ID: <20190118104519.fqpzirux5qulkcwa@dcvr>
References: <20190118033845.s2vlrb3wd3m2jfzu@dcvr>
 <a7307f431e2231dd420a0190a22aa38094cd593f.camel@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7307f431e2231dd420a0190a22aa38094cd593f.camel@novalis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <novalis@novalis.org> wrote:
> It appears that get_oid_with_context calls into get_short_oid for that
> case, and get_short_oid returns SHORT_NAME_AMBIGUOUS, which is -2.  We
> treat that as DANGLING_SYMLINK, which also seems to have the value -2. 
> So, it's an ambiguity in ambiguity resolution.
> 
> Fix attached.  

Thanks for the quick response.  Unfortunately, the patch makes
the situation worse for me...

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 2ca56fd086..f2344b199f 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -380,7 +380,7 @@ static void batch_one_object(const char *obj_name,
>  {
>  	struct object_context ctx;
>  	int flags = opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0;
> -	enum follow_symlinks_result result;
> +	enum get_oid_result result;
>  
>  	result = get_oid_with_context(obj_name, flags, &data->oid, &ctx);
>  	if (result != FOUND) {
> @@ -388,6 +388,9 @@ static void batch_one_object(const char *obj_name,
>  		case MISSING_OBJECT:
>  			printf("%s missing\n", obj_name);
>  			break;
> +		case SHORT_NAME_AMBIGUOUS:
> +			/* We've already printed the ambiguous message */
> +			break;

Because the message about ambiguity only goes to stderr.
Something needs to go to stdout, or else the reader process
would hang forever.

I've already updated my code[1] to work around "dangling",
but maybe printing "ambiguous" similar to the "missing" message
would be appropriate?  Something like:

		case SHORT_NAME_AMBIGUOUS:
			printf("%s ambiguous\n", obj_name);
			break;

(Along with a manpage update)


[1] new stuff for public-inbox on the way :>
