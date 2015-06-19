From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 04/19] fsck: Offer a function to demote fsck errors to warnings
Date: Fri, 19 Jun 2015 12:26:11 -0700
Message-ID: <xmqqzj3v7b58.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<44acafb2cf0a98e5ad75e3da24ba0e7453e6118f.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 21:26:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z61ve-0004iF-Uv
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 21:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbbFST0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 15:26:15 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34991 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbbFST0N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 15:26:13 -0400
Received: by igbzc4 with SMTP id zc4so21191632igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4/sJWWp9zI/NvZLllmo1fTsiB9Km0lFA2aDQIWjc7hk=;
        b=g0QMv9QlEMQq3Eq0zlVWloodxjjtiA7kNy8p+j1YZl5dVNduzm5PNGwE1zsYbF1boF
         t3vvWrUUtAN4hX0XtTUQ1Axk5jV0MEaNJeV5GQfn8oj14rNDfYJbV3Pbfzk0IN6jXYwX
         xcu+gLvawfT5PqWWrB5JbEmZZOhKfN6jyhFpa06nNuIXBqG2p74YFouiKAsCOT3HgqOr
         LYiYqu16N2TVKqB3j49dtFNOPrDuizz2ZXVvzUSxaf/KkUAYvI51/RrUA7iXkR5OHMD5
         VmWIkjPW87V/iWxgsTfSOIxmPJ9dmaLxaT0cQi0+uO2lMdNcmOebrNwP66ER4w/b+Xbo
         b9Yw==
X-Received: by 10.50.56.104 with SMTP id z8mr6705357igp.45.1434741973206;
        Fri, 19 Jun 2015 12:26:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id f15sm7631674iof.36.2015.06.19.12.26.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 12:26:12 -0700 (PDT)
In-Reply-To: <44acafb2cf0a98e5ad75e3da24ba0e7453e6118f.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:33:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272188>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/fsck.c b/fsck.c
> index da5717c..8c3caff 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -103,13 +103,85 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
>  {
>  	int msg_type;
>  
> -	msg_type = msg_id_info[msg_id].msg_type;
> -	if (options->strict && msg_type == FSCK_WARN)
> -		msg_type = FSCK_ERROR;
> +	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
> +
> +	if (options->msg_type)
> +		msg_type = options->msg_type[msg_id];
> +	else {
> +		msg_type = msg_id_info[msg_id].msg_type;
> +		if (options->strict && msg_type == FSCK_WARN)
> +			msg_type = FSCK_ERROR;
> +	}
>  
>  	return msg_type;
>  }

Nice.

> +static inline int substrcmp(const char *string, int len, const char *match)
> +{
> +	int match_len = strlen(match);
> +	if (match_len != len)
> +		return -1;
> +	return memcmp(string, match, len);
> +}

What this does looks suspiciously like starts_with(), but its name
"substrcmp()" does not give any hint that this is about the beginnig
part of "string"; if anything, it gives a wrong hint that it may be
any substring.  prefixcmp() might be a better name but that was the
old name for !starts_with() so we cannot use it here.  It is a
mouthful, but starts_with_counted() may be.

But the whole thing may be moot.

If we take the "why not upcase the end-user string upfront"
suggestion from the previous review, fsck_set_msg_types() would have
an upcased copy of the end-user string that it can muck with; it can
turn "badfoo=error,poorbar=..." into "BADFOO=error,POORBAR=..."
that is stored in its own writable memory (possibly a strbuf), and
at that point it can afford to NUL-terminate BADFOO=error after
finding where one specification ends with strcspn() before calling
fsck_set_msg_type(), which in turn calls parse_msg_type().

So all parse_msg_type() needs to do is just !strcmp().

> +
> +static int parse_msg_type(const char *str, int len)
> +{
> +	if (len < 0)
> +		len = strlen(str);
> +
> +	if (!substrcmp(str, len, "error"))
> +		return FSCK_ERROR;
> +	else if (!substrcmp(str, len, "warn"))
> +		return FSCK_WARN;

> +	else
> +		die("Unknown fsck message type: '%.*s'",
> +				len, str);
> +}
> +
> +void fsck_set_msg_type(struct fsck_options *options,
> +		const char *msg_id, int msg_id_len,
> +		const char *msg_type, int msg_type_len)
> +{
> +	int id = parse_msg_id(msg_id, msg_id_len), type;
> +
> +	if (id < 0)
> +		die("Unhandled message id: %.*s", msg_id_len, msg_id);
> +	type = parse_msg_type(msg_type, msg_type_len);
> +
> +	if (!options->msg_type) {
> +		int i;
> +		int *msg_type = xmalloc(sizeof(int) * FSCK_MSG_MAX);
> +		for (i = 0; i < FSCK_MSG_MAX; i++)
> +			msg_type[i] = fsck_msg_type(i, options);
> +		options->msg_type = msg_type;
> +	}
> +
> +	options->msg_type[id] = type;
> +}
> +
> +void fsck_set_msg_types(struct fsck_options *options, const char *values)
> +{
> +	while (*values) {
> +		int len = strcspn(values, " ,|"), equal;
> +
> +		if (!len) {
> +			values++;
> +			continue;
> +		}
> +
> +		for (equal = 0; equal < len; equal++)
> +			if (values[equal] == '=' || values[equal] == ':')
> +				break;
> +
> +		if (equal == len)
> +			die("Missing '=': '%.*s'", len, values);
> +
> +		fsck_set_msg_type(options, values, equal,
> +				values + equal + 1, len - equal - 1);
> +		values += len;
> +	}
> +}
> +
>  __attribute__((format (printf, 4, 5)))
>  static int report(struct fsck_options *options, struct object *object,
>  	enum fsck_msg_id id, const char *fmt, ...)
> @@ -599,6 +671,10 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
>  
>  int fsck_error_function(struct object *obj, int msg_type, const char *message)
>  {
> +	if (msg_type == FSCK_WARN) {
> +		warning("object %s: %s", sha1_to_hex(obj->sha1), message);
> +		return 0;
> +	}
>  	error("object %s: %s", sha1_to_hex(obj->sha1), message);
>  	return 1;
>  }
> diff --git a/fsck.h b/fsck.h
> index f6f268a..edb4540 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -6,6 +6,11 @@
>  
>  struct fsck_options;
>  
> +void fsck_set_msg_type(struct fsck_options *options,
> +		const char *msg_id, int msg_id_len,
> +		const char *msg_type, int msg_type_len);
> +void fsck_set_msg_types(struct fsck_options *options, const char *values);
> +
>  /*
>   * callback function for fsck_walk
>   * type is the expected type of the object or OBJ_ANY
> @@ -25,10 +30,11 @@ struct fsck_options {
>  	fsck_walk_func walk;
>  	fsck_error error_func;
>  	unsigned strict:1;
> +	int *msg_type;
>  };
>  
> -#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0 }
> -#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1 }
> +#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
> +#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL }
>  
>  /* descend in all linked child objects
>   * the return value is:
