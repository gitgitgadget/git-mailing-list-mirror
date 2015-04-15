From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Wed, 15 Apr 2015 13:20:36 -0700
Message-ID: <xmqqtwwhjg8b.fsf@gitster.dls.corp.google.com>
References: <552E9816.6040502@gmail.com>
	<1429117174-4968-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 22:20:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiTnh-00036w-0I
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 22:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbbDOUUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 16:20:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751932AbbDOUUj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 16:20:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07AF648F91;
	Wed, 15 Apr 2015 16:20:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=++/Ab5HXAgvBsFTyGa90uzvDr5Y=; b=qSvwJW
	VLWUnbb1JcIh2Rf6Ae7vpZGKTZi6aKVS+2fSlNXFlSnsy9A8f21ANglYxNNhDz/M
	TBZodFBjE7EkTZRNP9TkemzjkqCBpU7Zi3ql1ane2CVHBiwTFo8WIQoLmQAkmTDj
	nXRkHNqBzib1Ql5HDc6dBVeDiCwBgx0eRjD8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oT7M9J+CCnyj8gZWKBXo45FE2XTfq81b
	NRY0zdMcL1QpK1jX+QCEsJMr7a4ETss3saIeicXeYfS93KDD/x/fHQHg5rZyIlhb
	R8td/AOG583BXJnnPHjNtB2tjgKZZspNaYM1/XsAcbsiReahVvx75kTguH/M5hHR
	4hcdN83DI6M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 008CB48F90;
	Wed, 15 Apr 2015 16:20:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6AD2F48F8E;
	Wed, 15 Apr 2015 16:20:37 -0400 (EDT)
In-Reply-To: <1429117174-4968-1-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Wed, 15 Apr 2015 22:29:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0DF04F6-E3AC-11E4-9C9F-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267235>

Karthik Nayak <karthik.188@gmail.com> writes:

>  	case 's':
> -		type = sha1_object_info(sha1, &size);
> -		if (type > 0) {
> -			printf("%lu\n", size);
> -			return 0;
> -		}
> -		break;
> +		oi.sizep = &size;
> +		if ((type = sha1_object_info_extended(sha1, &oi, flags)) < 0)

Do you still need to assign to type here?

> +			die("git cat-file: could not get object info");
> +		printf("%lu\n", size);
> +		return 0;

> @@ -323,7 +332,7 @@ static int batch_objects(struct batch_options *opt)
>  }
>  
>  static const char * const cat_file_usage[] = {
> -	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
> +	N_("git cat-file (-t [--literally]|-s [--literally]|-e|-p|<type>|--textconv) <object>"),
>  	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
>  	NULL
>  };
> @@ -359,6 +368,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  	int opt = 0;
>  	const char *exp_type = NULL, *obj_name = NULL;
>  	struct batch_options batch = {0};
> +	int literally = 0;
>  
>  	const struct option options[] = {
>  		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
> @@ -369,6 +379,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
>  		OPT_SET_INT(0, "textconv", &opt,
>  			    N_("for blob objects, run textconv on object's content"), 'c'),
> +		OPT_BOOL( 0, "literally", &literally,
> +			  N_("allow -s and -t to work with broken/corrupt objects")),
>  		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
>  			N_("show info and content of objects fed from the standard input"),
>  			PARSE_OPT_OPTARG, batch_option_callback },
> @@ -380,7 +392,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  
>  	git_config(git_cat_file_config, NULL);
>  
> -	if (argc != 3 && argc != 2)
> +	if (argc < 2 || argc > 4)
>  		usage_with_options(cat_file_usage, options);

Hmm, why this change?

By allowing 4 args blindly like this, you will let something like
these to pass:

    $ git cat-file --textconv -t HEAD
    commit
    $ git cat-file -p -t HEAD
    commit
    $ git cat-file -s -t HEAD
    commit
    $ git cat-file -t -s HEAD
    879

It is fine if you are declaring that the last one wins when these
mutually-exclusive options are given. "git cat-file -e -s -t HEAD"
should also say "commit" if that is what you are doing, but instead
the code with this patch complains, which is bad.

It also is fine and is more in line with the spirit of the original
code if you keep the rule tight and only one of these mutually
exclusive options is allowed.

In either case, this check needs to be rethought.
