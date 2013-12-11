From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] cat-file: handle --batch format with missing
 type/size
Date: Wed, 11 Dec 2013 12:42:00 -0800
Message-ID: <20131211204200.GN2311@google.com>
References: <20131211115458.GA10561@sigill.intra.peff.net>
 <20131211115844.GB10594@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Bronson <naesten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 11 21:42:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vqqbk-0005Gh-Iw
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 21:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab3LKUmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 15:42:09 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:53323 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab3LKUmH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 15:42:07 -0500
Received: by mail-yh0-f43.google.com with SMTP id a41so5516752yho.16
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 12:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=C0ifyUDgilIBhqRNsP07UggrYUSd6FHngqnHN8Pmm64=;
        b=AWxUfpFeziqcFEGzGODHMdDDktTAjrtlq9zjO6J7HMUtPSn2QLIsfQ3J+52voCpo/w
         oDN1wzCUeUzs4cMEA+hcOVEXjg3Tc+kpj713KOkHt17qWhQU+VHJ+TTsqZ1aodN/KpPb
         7QbMuiFfBmbmT+0MxH8gIzkC4HVVPSDg4AuWWuTx4IkRjXn5QMOpLwOuuJGSZWtSd5oc
         HDyDMfQnmWSPyA3YF5Zs6bmV7rput7zIk5CqGYUXqK+hF8HMp4A+PdOuAtiEEej8TzT4
         jDCWtWTQsUiVN6rq4+wtO0v05vc3jOYnONlA37KvZ5yW8ee/A26Poy8JIVDylZjulSRO
         OPiA==
X-Received: by 10.236.150.45 with SMTP id y33mr3039237yhj.124.1386794523694;
        Wed, 11 Dec 2013 12:42:03 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id f78sm30203639yhp.12.2013.12.11.12.42.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 11 Dec 2013 12:42:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131211115844.GB10594@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239211>

Jeff King wrote:

> We could do the same for the type. However, besides our
> consistency check, we also care about the type in deciding
> whether to stream or not. We therefore make sure to always
> trigger a type lookup when we are printing, so that

This "We make sure" is the behavior after this patch, not before,
right?

[...]
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -211,7 +211,7 @@ static void print_object_or_die(int fd, struct expand_data *data)
>  			die("object %s disappeared", sha1_to_hex(sha1));
>  		if (type != data->type)
>  			die("object %s changed type!?", sha1_to_hex(sha1));

Maybe an assert(data.info.typep) or similar would make this more
locally readable.

[...]
> @@ -276,6 +276,13 @@ static int batch_objects(struct batch_options *opt)
>  	data.mark_query = 0;
>  
> +	/*
> +	 * If we are printing out the object, then always fill in the type,
> +	 * since we will want to decide whether or not to stream.
> +	 */
> +	if (opt->print_contents)
> +		data.info.typep = &data.type;

Oof.  I guess this means that the optimization from 98e2092b wasn't being
applied by 'git cat-file --batch' with format specifiers that don't
include %(objecttype), but no one would have noticed because of the
"changed type" thing. :)

> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -85,6 +85,28 @@ $content"
>  		git cat-file --batch-check="%(objecttype) %(rest)" >actual &&
>  	test_cmp expect actual
>      '
> +
> +    test -z "$content" ||
> +    test_expect_success "--batch without type ($type)" '
> +	{
> +		echo "$size" &&
> +		maybe_remove_timestamp "$content" $no_ts
> +	} >expect &&
> +	echo $sha1 | git cat-file --batch="%(objectsize)" >actual.full &&
> +	maybe_remove_timestamp "$(cat actual.full)" $no_ts >actual &&
> +	test_cmp expect actual
> +    '
> +
> +    test -z "$content" ||
> +    test_expect_success "--batch without size ($type)" '
> +	{
> +		echo "$type" &&
> +		maybe_remove_timestamp "$content" $no_ts
> +	} >expect &&
> +	echo $sha1 | git cat-file --batch="%(objecttype)" >actual.full &&
> +	maybe_remove_timestamp "$(cat actual.full)" $no_ts >actual &&
> +	test_cmp expect actual
> +    '
>  }

Looks good.

(not about this patch) I suspect a test_cmp_ignore_timestamp helper
could simplify these tests somewhat. :)

For what it's worth, with or without commit message changes or the
check that data->type is initialized,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
