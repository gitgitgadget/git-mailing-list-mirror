From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] trailer: add a trailer.trimEmpty config option
Date: Sat, 07 Feb 2015 12:20:32 -0800
Message-ID: <xmqq386hcw33.fsf@gitster.dls.corp.google.com>
References: <20150207131112.394.30858.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 07 21:20:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKBry-0001sQ-9h
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 21:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbbBGUUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 15:20:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755873AbbBGUUg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 15:20:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 74BCD34236;
	Sat,  7 Feb 2015 15:20:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dO4RGU3edszc8i222cTzfL64C+Q=; b=sb7uy+
	5TWUH/F1Xmn33Ap24A/XNN7WXGyoEkFexqwc4lEEmFga/lIpvEp67Nt3Io3Hly8z
	Yg9qlerGpPVum5sRagRHJBdzN3SuosW00+byHGesqqgfZW9PnM2+XvujEQnWUrpo
	Go0T8/JZhH7CnnXPzOl6vOsBiRQ7iQZt6kopI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VioFvtYkD1EzU2lj2D18R7Yz257kQm+q
	0BAlOy9+bN71xssqzCXdQe8aYBHmKNs01grXsJTOuzHQZ+R/ll7iNjoA/Dwi/9Jy
	KxIYqmWhyWB9Tp4sXYSKsKgLdckoWMyMT8urbKLoNnJo5JPqGOtV+ai39VQtgXLO
	Q0GgiVpTY9M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68FC934235;
	Sat,  7 Feb 2015 15:20:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1E2F34230;
	Sat,  7 Feb 2015 15:20:33 -0500 (EST)
In-Reply-To: <20150207131112.394.30858.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 07 Feb 2015 14:11:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C4FAF1F8-AF06-11E4-B215-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263454>

Christian Couder <chriscool@tuxfamily.org> writes:

> This way people who always want trimed trailers
> don't need to specify it on the command line.

I sense that print_all() that cares about trimming illustrate a
design mistake in the original code structure.  Why isn't the entire
program structured like this instead?

    - read input and split that into three parts:

	struct {
		struct strbuf messsage_proper;

		struct trailers {
			int nr, alloc;
	                struct strbuf *array_of_trailers[];
		} trailers;

		struct strbuf lines_after_trailers;
	};

    - do "trailer stuff" by calling a central helper that does
      "trailer stuff" a pointer to the middle, trailers, struct.

      - when the trailer becomes a reusable subsystem, this central
        helper will become the primary entry point to the API.

      - "trailer stuff" will include adding new ones, removing
        existing ones, and rewriting lines.  What you do in the
        current process_command_line_args() and
        process_trailers_lists() [*1*] would come here.

    - write out the result, given the outermost struct.  This will
      become another entry point in the API.

Structured that way, callers will supply that outermost structure,
and can trust that the trailers subsystem will not molest
message_proper or lines_after_trailers part.  They can even process
the parts that the trailer subsystem would not touch, e.g. running
stripspace to the text in message_proper.

Viewed that way, it would be clear that "strip empty ones" should be
a new feature in the "trailer stuff", not just "filter out only
during the output phase".  Having it in the output phase does not
feel that the labor/responsibility is split in the right way.

Another problem I have with "filter out during the output phase"
comes from the semantics/correctness in the resulting code, and I
suspect that it would need to be done a lot earlier, before you
allow the logic such as "if I have X, do this, but if there is no X,
do this other thing".  If you have an X that is empty in the input,
trimming that before such logic kicks in and trimming that in the
final output phase would give different results, and I think the
latter would give a less intuitive result.

As this is the second time I have to point out that the data
structure used by the current code to hold the trailers and other
stuff to work on smells fishy, I would seriously consider cleaning
up the existing code to make it easier to allow us to later create
a reusable API and "trailer subsystem" out of it, before piling new
features on top of it, if I were you.

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/interpret-trailers.c |  2 +-
>  trailer.c                    | 13 ++++++++++---
>  trailer.h                    |  2 +-
>  3 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 46838d2..1adf814 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -18,7 +18,7 @@ static const char * const git_interpret_trailers_usage[] = {
>  
>  int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
>  {
> -	int trim_empty = 0;
> +	int trim_empty = -1;
>  	struct string_list trailers = STRING_LIST_INIT_DUP;
>  
>  	struct option options[] = {
> diff --git a/trailer.c b/trailer.c
> index 623adeb..7614182 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -36,6 +36,8 @@ static struct trailer_item *first_conf_item;
>  
>  static char *separators = ":";
>  
> +static int trim_empty;
> +
>  #define TRAILER_ARG_STRING "$ARG"
>  
>  static int after_or_end(enum action_where where)
> @@ -120,7 +122,7 @@ static void print_tok_val(const char *tok, const char *val)
>  		printf("%s%c %s\n", tok, separators[0], val);
>  }
>  
> -static void print_all(struct trailer_item *first, int trim_empty)
> +static void print_all(struct trailer_item *first)
>  {
>  	struct trailer_item *item;
>  	for (item = first; item; item = item->next) {
> @@ -509,6 +511,8 @@ static int git_trailer_default_config(const char *conf_key, const char *value, v
>  					value, conf_key);
>  		} else if (!strcmp(trailer_item, "separators")) {
>  			separators = xstrdup(value);
> +		} else if (!strcmp(trailer_item, "trimempty")) {
> +			trim_empty = git_config_bool(conf_key, value);
>  		}
>  	}
>  	return 0;
> @@ -842,7 +846,7 @@ static void free_all(struct trailer_item **first)
>  	}
>  }
>  
> -void process_trailers(const char *file, int trim_empty, struct string_list *trailers)
> +void process_trailers(const char *file, int trim, struct string_list *trailers)
>  {
>  	struct trailer_item *in_tok_first = NULL;
>  	struct trailer_item *in_tok_last = NULL;
> @@ -854,6 +858,9 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
>  	git_config(git_trailer_default_config, NULL);
>  	git_config(git_trailer_config, NULL);
>  
> +	if (trim > -1)
> +		trim_empty = trim;
> +
>  	lines = read_input_file(file);
>  
>  	/* Print the lines before the trailers */
> @@ -863,7 +870,7 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
>  
>  	process_trailers_lists(&in_tok_first, &in_tok_last, &arg_tok_first);
>  
> -	print_all(in_tok_first, trim_empty);
> +	print_all(in_tok_first);
>  
>  	free_all(&in_tok_first);
>  
> diff --git a/trailer.h b/trailer.h
> index 8eb25d5..4f481d0 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -1,6 +1,6 @@
>  #ifndef TRAILER_H
>  #define TRAILER_H
>  
> -void process_trailers(const char *file, int trim_empty, struct string_list *trailers);
> +void process_trailers(const char *file, int trim, struct string_list *trailers);
>  
>  #endif /* TRAILER_H */
