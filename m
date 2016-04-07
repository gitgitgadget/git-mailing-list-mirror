From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] builtin/interpret-trailers: suppress blank line
Date: Thu, 07 Apr 2016 10:00:37 -0700
Message-ID: <xmqqmvp51hhm.fsf@gitster.mtv.corp.google.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
	<1460042563-32741-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 19:00:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoDIX-0003Ce-Qx
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 19:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831AbcDGRAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 13:00:42 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756453AbcDGRAl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 13:00:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD9A652346;
	Thu,  7 Apr 2016 13:00:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2yUOqirSpNeLY9A6x/hVQzUx+Hg=; b=poN7al
	qvm+bBu6G+ECa2cF/ZKLoT6PtGgQN++HyaYHWJYoaPOxmODEgfW/nbOHzBr+TdpO
	WRnpOKdDQ37xZTiuR3gXWRlhdDjeYObUM7fOxvvmyy3D/PQtvmIYNlFUAhiyjCXm
	hvzNCf0HuNMQLLGFonDSQJnEQg+E8FRs0aJFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b07c4nJ4hgqfK5VyL++c39sfuRu+JNsQ
	U2oYO8IiiwrdR9lF8btp/uZ8mySUgLraLf3bWlsub3GCht+ENvtUV061U1efxu6c
	iz/Q76LfkPf6vAuwaIjjpW0NM0/Ct2lRQmDwzzy/lY+Ns97hm+Oi+sbgvvR57rqG
	0B1vlWBVh9I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 98E0B52344;
	Thu,  7 Apr 2016 13:00:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EA78C52342;
	Thu,  7 Apr 2016 13:00:38 -0400 (EDT)
In-Reply-To: <1460042563-32741-3-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 7 Apr 2016 18:23:10 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 411ABBFE-FCE2-11E5-B3BC-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290927>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> it's sometimes useful to be able to pass output message of
> git-mailinfo through git-interpret-trailers,
> but that creates problems since that does not
> include the subject and an empty line after that,
> making interpret-trailers add an empty line.
>
> Add a flag to bypass adding the blank line.

I think I understand what you are trying to do, but using output
that comes from 'mailinfo' alone as the input to anything (including
interpret-trailers) does not make much sense.

If you use the mailinfo output in the way it is expected to be used,
i.e. take the subject from the "info" that goes to its standard
output and append the "msg" with a blank between them, and feed the
result to interpret-trailers, do you still need this step in your
series?

>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  trailer.h                    |  2 +-
>  builtin/interpret-trailers.c |  9 +++++++--
>  trailer.c                    | 10 +++++++---
>  3 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/trailer.h b/trailer.h
> index 36b40b8..afcf680 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -2,6 +2,6 @@
>  #define TRAILER_H
>  
>  void process_trailers(const char *file, int in_place, int trim_empty,
> -		      struct string_list *trailers);
> +		      int suppress_blank_line, struct string_list *trailers);
>  
>  #endif /* TRAILER_H */
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 18cf640..4a92788 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -18,11 +18,14 @@ static const char * const git_interpret_trailers_usage[] = {
>  
>  int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
>  {
> +	int suppress_blank_line = 0;
>  	int in_place = 0;
>  	int trim_empty = 0;
>  	struct string_list trailers = STRING_LIST_INIT_DUP;
>  
>  	struct option options[] = {
> +		OPT_BOOL(0, "suppress-blank-line", &suppress_blank_line,
> +			 N_("suppress prefixing tailer(s) with a blank line ")),
>  		OPT_BOOL(0, "in-place", &in_place, N_("edit files in place")),
>  		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
>  		OPT_STRING_LIST('t', "trailer", &trailers, N_("trailer"),
> @@ -36,11 +39,13 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
>  	if (argc) {
>  		int i;
>  		for (i = 0; i < argc; i++)
> -			process_trailers(argv[i], in_place, trim_empty, &trailers);
> +			process_trailers(argv[i], in_place, trim_empty,
> +					 suppress_blank_line, &trailers);
>  	} else {
>  		if (in_place)
>  			die(_("no input file given for in-place editing"));
> -		process_trailers(NULL, in_place, trim_empty, &trailers);
> +		process_trailers(NULL, in_place, trim_empty,
> +				 suppress_blank_line, &trailers);
>  	}
>  
>  	string_list_clear(&trailers, 0);
> diff --git a/trailer.c b/trailer.c
> index 8e48a5c..8e5be91 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -805,6 +805,7 @@ static void print_lines(FILE *outfile, struct strbuf **lines, int start, int end
>  
>  static int process_input_file(FILE *outfile,
>  			      struct strbuf **lines,
> +			      int suppress_blank_line,
>  			      struct trailer_item **in_tok_first,
>  			      struct trailer_item **in_tok_last)
>  {
> @@ -822,7 +823,8 @@ static int process_input_file(FILE *outfile,
>  	/* Print lines before the trailers as is */
>  	print_lines(outfile, lines, 0, trailer_start);
>  
> -	if (!has_blank_line_before(lines, trailer_start - 1))
> +	if (!suppress_blank_line &&
> +	    !has_blank_line_before(lines, trailer_start - 1))
>  		fprintf(outfile, "\n");
>  
>  	/* Parse trailer lines */
> @@ -875,7 +877,8 @@ static FILE *create_in_place_tempfile(const char *file)
>  	return outfile;
>  }
>  
> -void process_trailers(const char *file, int in_place, int trim_empty, struct string_list *trailers)
> +void process_trailers(const char *file, int in_place, int trim_empty,
> +		      int suppress_blank_line, struct string_list *trailers)
>  {
>  	struct trailer_item *in_tok_first = NULL;
>  	struct trailer_item *in_tok_last = NULL;
> @@ -894,7 +897,8 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
>  		outfile = create_in_place_tempfile(file);
>  
>  	/* Print the lines before the trailers */
> -	trailer_end = process_input_file(outfile, lines, &in_tok_first, &in_tok_last);
> +	trailer_end = process_input_file(outfile, lines, suppress_blank_line,
> +					 &in_tok_first, &in_tok_last);
>  
>  	arg_tok_first = process_command_line_args(trailers);
