From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [WIP/RFH/RFD/PATCH] grep: allow to use textconv filters
Date: Tue, 05 Feb 2013 17:21:18 +0100
Message-ID: <5111317E.8060906@drmicha.warpmail.net>
References: <2c0641ea4df6a872a4466efe0c0124f304f44c3e.1359991521.git.git@drmicha.warpmail.net> <20130205111353.GD24973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 17:21:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2lHO-0002Pb-HY
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 17:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168Ab3BEQVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 11:21:25 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48633 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756159Ab3BEQVY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 11:21:24 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 48F9220B2D;
	Tue,  5 Feb 2013 11:21:23 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 05 Feb 2013 11:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=AYYFbA6iJoirLSeQiLXXNF
	Vjinw=; b=TWCs3QN13WjCyZjF4O67sK/wStm3gt1rZ9wE0xgc5ySq53gl1uJUtJ
	ptyQIymMNeYnRbtg5B3TBdgsDA1rTIHbuvsnP9uIMYbgeJWMu2ktkssmZk6mVSAu
	i5WDXygaf8nbV+PrKhhQPJI/fKDmUiIilnL5d34DxspNc7qobtIUw=
X-Sasl-enc: 0R1zrri1/DPPvn9yMvtf+pzI3Ht9EQ4HosuwLzfV5WJL 1360081282
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 87F408E0939;
	Tue,  5 Feb 2013 11:21:22 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20130205111353.GD24973@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215517>

Jeff King venit, vidit, dixit 05.02.2013 12:13:
> On Mon, Feb 04, 2013 at 04:27:31PM +0100, Michael J Gruber wrote:
> 
>> Recently and not so recently, we made sure that log/grep type operations
>> use textconv filters when a userfacing diff would do the same:
>>
>> ef90ab6 (pickaxe: use textconv for -S counting, 2012-10-28)
>> b1c2f57 (diff_grep: use textconv buffers for add/deleted files, 2012-10-28)
>> 0508fe5 (combine-diff: respect textconv attributes, 2011-05-23)
>>
>> "git grep" currently does not use textconv filters at all, that is
>> neither for displaying the match and context nor for the actual grepping.
>>
>> Introduce a binary mode "--textconv" (in addition to "--text" and "-I")
>> which makes git grep use any configured textconv filters for grepping
>> and output purposes.
> 
> Sounds like a reasonable goal.
> 
>>     The difficulty is in getting the different cases (blob/sha1 vs.
>>     worktree) right, and in making the changes minimally invasive. It seems
>>     that some more refactoring could help: "git show --textconv" does not
>>     use textconv filters when used on blobs either. (It does for diffs, of
>>     course.) Most existing helper functions are tailored for diffs.
> 
> I think "git show" with blobs originally did not because we have no
> filename with which to look up the attributes. IIRC, the patches to
> support "cat-file --textconv" taught get_sha1_with_context to report the
> path at which we found a blob. I suspect it is mostly a matter of
> plumbing that information from the revision parser through to
> show_blob_object.
> 
>>     Nota bene: --textconv does not affect "diff --stat" either...
> 
> Yeah, though I wonder if it should be on by default. The diffstat for a
> binary file, unlike the diff, is already useful. The diffstat of the
> textconv'd data may _also_ be useful, of course.
> 
>> @@ -659,6 +659,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>  		OPT_SET_INT('I', NULL, &opt.binary,
>>  			N_("don't match patterns in binary files"),
>>  			GREP_BINARY_NOMATCH),
>> +		OPT_SET_INT(0, "textconv", &opt.binary,
>> +			N_("process binary files with textconv filters"),
>> +			GREP_BINARY_TEXTCONV),
> 
> Is this really a new form of GREP_BINARY_*? What happens when a file
> does not have a textconv filter?
> 
> I would expect this to be more like diff's "--textconv" flag, which is
> really "allow textconv to be respected". Then you could do:
> 
>   git grep -I --textconv foo
> 
> to grep in the text version of files which support it, and ignore the
> rest.
> 
>> -static int grep_source_load(struct grep_source *gs);
>> -static int grep_source_is_binary(struct grep_source *gs);
>> +static int grep_source_load(struct grep_source *gs, struct grep_opt *opt);
>> +static int grep_source_is_binary(struct grep_source *gs, struct grep_opt *opt);
> 
> Hmm. grep_source_load is more or less the analogue of
> diff_populate_filespec, which does not know about textconv at all. So I
> feel like this might be going in at the wrong layer...
> 
>> @@ -1354,14 +1356,15 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>>  
>>  	switch (opt->binary) {
>>  	case GREP_BINARY_DEFAULT:
>> -		if (grep_source_is_binary(gs))
>> +		if (grep_source_is_binary(gs, opt))
>>  			binary_match_only = 1;
>>  		break;
>>  	case GREP_BINARY_NOMATCH:
>> -		if (grep_source_is_binary(gs))
>> +		if (grep_source_is_binary(gs, opt))
>>  			return 0; /* Assume unmatch */
>>  		break;
> 
> The is_binary function learned about "opt" so that it could pass it to
> grep_source_load, which might do the textconv for us. But we _know_ that
> we will not here, because we see that we have other GREP_BINARY flags.
> 
> And when we do have _TEXTCONV:
> 
>>  	case GREP_BINARY_TEXT:
>> +	case GREP_BINARY_TEXTCONV:
>>  		break;
> 
> We do not call is_binary. :)
> 
>> -static int grep_source_load_sha1(struct grep_source *gs)
>> +static int grep_source_load_sha1(struct grep_source *gs, struct grep_opt *opt)
>>  {
>>  	enum object_type type;
>> -
>>  	grep_read_lock();
>> -	gs->buf = read_sha1_file(gs->identifier, &type, &gs->size);
>> +	if (opt->binary == GREP_BINARY_TEXTCONV) {
>> +		struct diff_filespec *df = alloc_filespec(gs->name);
>> +		gs->size = fill_textconv(gs->driver, df, &gs->buf);
>> +		free_filespec(df);
>> +	} else {
>> +		gs->buf = read_sha1_file(gs->identifier, &type, &gs->size);
>> +	}
> 
> So here we do the textconv for the sha1 case. But what about file
> sources?
> 
> This is why I think the layer is wrong; you want the fill_textconv
> function to call your abstract _load function (in the diff_filespec
> world, it is diff_filespec_populate, but it is the moral equivalent).
> And you want it to hold off as long as possible in case we can pull the
> value from cache, or feed the working tree version of a file straight to
> the filter.
> 
>> -void grep_source_load_driver(struct grep_source *gs)
>> +void grep_source_load_driver(struct grep_source *gs, struct grep_opt *opt)
>>  {
>>  	if (gs->driver)
>>  		return;
>>  
>> -	grep_attr_lock();
>> +	grep_attr_lock(); //TODO
>> +	printf("Looking up userdiff driver for: %s", gs->path);
>>  	if (gs->path)
>>  		gs->driver = userdiff_find_by_path(gs->path);
>>  	if (!gs->driver)
>>  		gs->driver = userdiff_find_by_name("default");
>> +	if (opt->binary == GREP_BINARY_TEXTCONV)
>> +		gs->driver = userdiff_get_textconv(gs->driver);
>>  	grep_attr_unlock();
>>  }
> 
> This is wrong. The point of userdiff_get_textconv is that it will return
> NULL when we are not doing textconv for this path. So you can use it
> like:
> 
>   struct userdiff_driver *textconv = userdiff_get_textconv(gs->driver);
> 
>   if (textconv) {
>           /* ok, we are doing textconv. Call our fill_textconv
>            * equivalent. */
>   }
>   else {
>           /* nope, plain old file. */
>   }
> 
> But by assigning it on top of gs->driver, you're going to end up with a
> NULL driver sometimes. And the post-condition of the load_driver
> function is that gs->driver always points to a valid driver (even if it
> is the default one). I wouldn't be surprised if this causes segfaults.
> 
> 
> So I would do it more like the patch below. Only lightly tested by me.
> There are some refactoring opportunities if you want to bring
> grep_source and diff_filespec closer together.
> 
> ---
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 8025964..915c8ef 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -659,6 +659,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		OPT_SET_INT('I', NULL, &opt.binary,
>  			N_("don't match patterns in binary files"),
>  			GREP_BINARY_NOMATCH),
> +		OPT_BOOL(0, "textconv", &opt.allow_textconv,
> +			 N_("process binary files with textconv filters")),
>  		{ OPTION_INTEGER, 0, "max-depth", &opt.max_depth, N_("depth"),
>  			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
>  			NULL, 1 },
> diff --git a/grep.c b/grep.c
> index 4bd1b8b..3880d64 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -2,6 +2,8 @@
>  #include "grep.h"
>  #include "userdiff.h"
>  #include "xdiff-interface.h"
> +#include "diff.h"
> +#include "diffcore.h"
>  
>  static int grep_source_load(struct grep_source *gs);
>  static int grep_source_is_binary(struct grep_source *gs);
> @@ -1321,6 +1323,58 @@ static void std_output(struct grep_opt *opt, const void *buf, size_t size)
>  	fwrite(buf, size, 1, stdout);
>  }
>  
> +static int fill_textconv_grep(struct userdiff_driver *driver,
> +			      struct grep_source *gs)
> +{
> +	struct diff_filespec *df;
> +	char *buf;
> +	size_t size;
> +
> +	if (!driver || !driver->textconv)
> +		return grep_source_load(gs);
> +
> +	/*
> +	 * The textconv interface is intimately tied to diff_filespecs, so we
> +	 * have to pretend to be one. If we could unify the grep_source
> +	 * and diff_filespec structs, this mess could just go away.
> +	 */
> +	df = alloc_filespec(gs->path);
> +	switch (gs->type) {
> +	case GREP_SOURCE_SHA1:
> +		fill_filespec(df, gs->identifier, 1, 0100644);
> +		break;
> +	case GREP_SOURCE_FILE:
> +		fill_filespec(df, null_sha1, 0, 0100644);
> +		break;
> +	default:
> +		die("BUG: attempt to textconv something without a path?");
> +	}
> +
> +	/*
> +	 * fill_textconv is not remotely thread-safe; it may load objects
> +	 * behind the scenes, and it modifies the global diff tempfile
> +	 * structure.
> +	 */
> +	grep_read_lock();
> +	size = fill_textconv(driver, df, &buf);
> +	grep_read_unlock();
> +	free_filespec(df);
> +
> +	/*
> +	 * The normal fill_textconv usage by the diff machinery would just keep
> +	 * the textconv'd buf separate from the diff_filespec. But much of the
> +	 * grep code passes around a grep_source and assumes that its "buf"
> +	 * pointer is the beginning of the thing we are searching. So let's
> +	 * install our textconv'd version into the grep_source, taking care not
> +	 * to leak any existing buffer.
> +	 */
> +	grep_source_clear_data(gs);
> +	gs->buf = buf;
> +	gs->size = size;
> +
> +	return 0;
> +}
> +
>  static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int collect_hits)
>  {
>  	char *bol;
> @@ -1331,6 +1385,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>  	unsigned count = 0;
>  	int try_lookahead = 0;
>  	int show_function = 0;
> +	struct userdiff_driver *textconv = NULL;
>  	enum grep_context ctx = GREP_CONTEXT_HEAD;
>  	xdemitconf_t xecfg;
>  
> @@ -1352,19 +1407,36 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>  	}
>  	opt->last_shown = 0;
>  
> -	switch (opt->binary) {
> -	case GREP_BINARY_DEFAULT:
> -		if (grep_source_is_binary(gs))
> -			binary_match_only = 1;
> -		break;
> -	case GREP_BINARY_NOMATCH:
> -		if (grep_source_is_binary(gs))
> -			return 0; /* Assume unmatch */
> -		break;
> -	case GREP_BINARY_TEXT:
> -		break;
> -	default:
> -		die("bug: unknown binary handling mode");
> +	if (opt->allow_textconv) {
> +		grep_source_load_driver(gs);
> +		/*
> +		 * We might set up the shared textconv cache data here, which
> +		 * is not thread-safe.
> +		 */
> +		grep_attr_lock();
> +		textconv = userdiff_get_textconv(gs->driver);
> +		grep_attr_unlock();
> +	}
> +
> +	/*
> +	 * We know the result of a textconv is text, so we only have to care
> +	 * about binary handling if we are not using it.
> +	 */
> +	if (!textconv) {
> +		switch (opt->binary) {
> +		case GREP_BINARY_DEFAULT:
> +			if (grep_source_is_binary(gs))
> +				binary_match_only = 1;
> +			break;
> +		case GREP_BINARY_NOMATCH:
> +			if (grep_source_is_binary(gs))
> +				return 0; /* Assume unmatch */
> +			break;
> +		case GREP_BINARY_TEXT:
> +			break;
> +		default:
> +			die("bug: unknown binary handling mode");
> +		}
>  	}
>  
>  	memset(&xecfg, 0, sizeof(xecfg));
> @@ -1372,7 +1444,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>  
>  	try_lookahead = should_lookahead(opt);
>  
> -	if (grep_source_load(gs) < 0)
> +	if (fill_textconv_grep(textconv, gs) < 0)
>  		return 0;
>  
>  	bol = gs->buf;
> diff --git a/grep.h b/grep.h
> index 8fc854f..94a7ac2 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -106,6 +106,7 @@ struct grep_opt {
>  #define GREP_BINARY_NOMATCH	1
>  #define GREP_BINARY_TEXT	2
>  	int binary;
> +	int allow_textconv;
>  	int extended;
>  	int use_reflog_filter;
>  	int pcre;
> 

Thanks Jeff, that helps a lot! It covers "grep expr" and "grep expr rev
-- path" just fine. I'll look into "grep expr rev:path" which does not
work yet because of an empty driver.

I also have "show --textconv" covered and a suggestion for "cat-file
--textconv" (to work without a textconv filter).

Expect a mini-series soon :)

Michael
