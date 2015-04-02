From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/4] cat-file: teach cat-file a '--literally' option
Date: Thu, 02 Apr 2015 12:08:41 -0700
Message-ID: <xmqqd23mjqkm.fsf@gitster.dls.corp.google.com>
References: <551D1F99.5040306@gmail.com>
	<1427972382-15477-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 21:08:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdkTy-0002F5-L5
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 21:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbbDBTIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 15:08:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58590 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752628AbbDBTIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 15:08:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA60C435A1;
	Thu,  2 Apr 2015 15:08:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CLrzk5hgi6EYcKIhTKylxrongCg=; b=fSWHuh
	ITp8gdcV14BwFUKMXXGX0hbF9CMRVCKH0n1aGOydbu9S7gRNTygRaemcu3Xz+b0J
	jy46EdbgC3n0DxzXiYwDpLMX+VLJA7dZE402GSjq36dW4xTivr7v79AdseT3tO9G
	YmrrT3sKPt0bGBTvDJwIu1NHXMHxSa/mPPHcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DsdRzPGSSCOP0m6w5xTUvKje3Al10/2L
	VVekHn3CP9Hutc5dSVKW5scam+696ZY/W2bDpy1S0ojiWvo5KB2GmxMxI0HlOasO
	N++lbv4or/v2zLtQFAcerrQaqdV4Eec5VK8WJqqqx2JXTmZz95sXw1wR5PRnrCCj
	GqAtmilttJU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C1ECB435A0;
	Thu,  2 Apr 2015 15:08:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 350C34359F;
	Thu,  2 Apr 2015 15:08:43 -0400 (EDT)
In-Reply-To: <1427972382-15477-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 2 Apr 2015 16:29:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE05DF3C-D96B-11E4-9F62-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266657>

Karthik Nayak <karthik.188@gmail.com> writes:

> Currently 'git cat-file' throws an error while trying to
> print the type or size of a broken/corrupt object which is
> created using 'git hash-object --literally'. This is
> because these objects are usually of unknown types.
>
> Teach git cat-file a '--literally' option where it prints
> the type or size of a broken/corrupt object without throwing
> an error.
>
> Modify '-t' and '-s' options to call sha1_object_info_extended()
> directly to support the '--literally' option.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco

s/$/.com/ perhaps?

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/cat-file.c | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index df99df4..91ceae0 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -9,13 +9,20 @@
>  #include "userdiff.h"
>  #include "streaming.h"
>  
> -static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
> +static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
> +			int literally)
>  {
>  	unsigned char sha1[20];
>  	enum object_type type;
>  	char *buf;
>  	unsigned long size;
>  	struct object_context obj_context;
> +	struct object_info oi = {NULL};
> +	struct strbuf sb = STRBUF_INIT;
> +	unsigned flags = LOOKUP_REPLACE_OBJECT;
> +
> +	if (literally)
> +		flags |= LOOKUP_LITERALLY;
>  
>  	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
>  		die("Not a valid object name %s", obj_name);
> @@ -23,16 +30,24 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  	buf = NULL;
>  	switch (opt) {
>  	case 't':
> -		type = sha1_object_info(sha1, NULL);
> -		if (type > 0) {
> -			printf("%s\n", typename(type));
> +		oi.typep = &type;
> +		oi.typename = &sb;
> +		if (sha1_object_info_extended(sha1, &oi, flags) < 0)
> +			die("git cat-file: could not get object info");
> +		if (type >= 0 && sb.len) {
> +			printf("%s\n", sb.buf);
> +			strbuf_release(&sb);
>  			return 0;
>  		}
>  		break;
>  
>  	case 's':
> -		type = sha1_object_info(sha1, &size);
> -		if (type > 0) {
> +		oi.typep = &type;
> +		oi.typename = &sb;
> +		oi.sizep = &size;
> +		if (sha1_object_info_extended(sha1, &oi, flags) < 0)
> +			die("git cat-file: could not get object info");
> +		if (type >= 0 && sb.len) {
>  			printf("%lu\n", size);
>  			return 0;
>  		}
> @@ -323,7 +338,7 @@ static int batch_objects(struct batch_options *opt)
>  }
>  
>  static const char * const cat_file_usage[] = {
> -	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
> +	N_("git cat-file (-t [--literally]|-s [--literally]|-e|-p|<type>|--textconv) <object>"),
>  	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
>  	NULL
>  };
> @@ -359,6 +374,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  	int opt = 0;
>  	const char *exp_type = NULL, *obj_name = NULL;
>  	struct batch_options batch = {0};
> +	int literally = 0;
>  
>  	const struct option options[] = {
>  		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
> @@ -369,6 +385,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
>  		OPT_SET_INT(0, "textconv", &opt,
>  			    N_("for blob objects, run textconv on object's content"), 'c'),
> +		OPT_BOOL( 0, "literally", &literally,
> +			  N_("get information about corrupt objects for debugging Git")),
>  		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
>  			N_("show info and content of objects fed from the standard input"),
>  			PARSE_OPT_OPTARG, batch_option_callback },
> @@ -380,7 +398,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  
>  	git_config(git_cat_file_config, NULL);
>  
> -	if (argc != 3 && argc != 2)
> +	if (argc < 2 || argc > 4)
>  		usage_with_options(cat_file_usage, options);
>  
>  	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
> @@ -405,5 +423,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  	if (batch.enabled)
>  		return batch_objects(&batch);
>  
> -	return cat_one_file(opt, exp_type, obj_name);
> +	if (literally && opt != 't' && opt != 's')
> +		die("git cat-file --literally: use with -s or -t");
> +	return cat_one_file(opt, exp_type, obj_name, literally);
>  }
