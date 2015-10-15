From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] stripspace: Implement --count-lines option
Date: Thu, 15 Oct 2015 10:58:26 -0700
Message-ID: <xmqqoag0ggjh.fsf@gitster.mtv.corp.google.com>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
	<1444911524-14504-3-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 15 19:58:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmmna-0004TD-KO
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 19:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbbJOR6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 13:58:36 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34023 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbbJOR6e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 13:58:34 -0400
Received: by payp3 with SMTP id p3so46358770pay.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 10:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0sqZTMQYF/6lTPeZf+XNgJulRbGxvamyvuWVURPQoTY=;
        b=L/NHn1erFivrmRQDiISuvovTpMEQMhffWoYvvd7ui256+/OSlVcGVuQCx+4RV9ZqrT
         aVdLBopJOYBNTeLR/irWEyMcbs941eT5UZpXceKRnpgD+aEphhF2UIvXRyaFmN1z3iYS
         XZB3uoYIFzTCZvt84wNNfEphPa25wpclH6HyQgpUI7D+IbiUrvl6+ZHfK914AXu/nF03
         1nZIPipNR1kRZd3IXnbd9tnd/m2bYgK2b4jbgM2MhFB6RQvh6IzpiqKKglLYKlky3feR
         i2SOhVDwOW8tijjuyjpQHymcK0sSkhKJa9noySd2K6SEoDwMwxXZ04ozUe7k0dy3wUtN
         gtSw==
X-Received: by 10.66.216.39 with SMTP id on7mr11291081pac.73.1444931914184;
        Thu, 15 Oct 2015 10:58:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id gv1sm16596040pbc.38.2015.10.15.10.58.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 10:58:27 -0700 (PDT)
In-Reply-To: <1444911524-14504-3-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Thu, 15 Oct 2015 14:18:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279676>

Tobias Klauser <tklauser@distanz.ch> writes:

> diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
> index 60328d5..411e17c 100644
> --- a/Documentation/git-stripspace.txt
> +++ b/Documentation/git-stripspace.txt
> @@ -9,7 +9,7 @@ git-stripspace - Remove unnecessary whitespace
>  SYNOPSIS
>  --------
>  [verse]
> -'git stripspace' [-s | --strip-comments] < input
> +'git stripspace' [-s | --strip-comments] [-C | --count-lines] < input
>  'git stripspace' [-c | --comment-lines] < input
>  
>  DESCRIPTION
> @@ -44,6 +44,11 @@ OPTIONS
>  	be terminated with a newline. On empty lines, only the comment character
>  	will be prepended.
>  
> +-C::
> +--count-lines::
> +	Output the number of resulting lines after stripping. This is equivalent
> +	to calling 'git stripspace | wc -l'.

I agree with Matthieu that squatting on a short-and-sweet -C is
unwanted here.

> diff --git a/builtin/stripspace.c b/builtin/stripspace.c
> index f677093..7882edd 100644
> --- a/builtin/stripspace.c
> +++ b/builtin/stripspace.c
> @@ -1,5 +1,6 @@
>  #include "builtin.h"
>  #include "cache.h"
> +#include "parse-options.h"
>  #include "strbuf.h"
>  
>  static void comment_lines(struct strbuf *buf)
> @@ -12,45 +13,51 @@ static void comment_lines(struct strbuf *buf)
>  	free(msg);
>  }
>  
> -static const char *usage_msg = "\n"
> -"  git stripspace [-s | --strip-comments] < input\n"
> -"  git stripspace [-c | --comment-lines] < input";
> +static const char * const usage_msg[] = {
> +	N_("git stripspace [-s | --strip-comments] [-C | --count-lines] < input"),
> +	N_("git stripspace [-c | --comment-lines] < input"),
> +	NULL
> +};
>  
>  int cmd_stripspace(int argc, const char **argv, const char *prefix)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	int strip_comments = 0;
> -	enum { INVAL = 0, STRIP_SPACE = 1, COMMENT_LINES = 2 } mode = STRIP_SPACE;
> -
> -	if (argc == 2) {
> -		if (!strcmp(argv[1], "-s") ||
> -		    !strcmp(argv[1], "--strip-comments")) {
> -			strip_comments = 1;
> -		} else if (!strcmp(argv[1], "-c") ||
> -			   !strcmp(argv[1], "--comment-lines")) {
> -			mode = COMMENT_LINES;
> -		} else {
> -			mode = INVAL;
> -		}
> -	} else if (argc > 1) {
> -		mode = INVAL;
> -	}
> +	int comment_mode = 0, count_lines = 0, strip_comments = 0;
> +	size_t lines = 0;
> +
> +	const struct option options[] = {
> +		OPT_BOOL('s', "strip-comments", &strip_comments,
> +			 N_("skip and remove all lines starting with comment character")),
> +		OPT_BOOL('c', "comment-lines", &comment_mode,
> +			 N_("prepend comment character and blank to each line")),
> +		OPT_BOOL('C', "count-lines", &count_lines, N_("print line count")),
> +		OPT_END()
> +	};

I think -s and -c are incompatible, so OPT_CMDMODE() might be a
better fit for them if you are going to switch the command line
parser to use parse-options.

Which makes me strongly suspect that this should be done in at least
two separate steps.  (1) Use parse-options to parse command line
without adding the counting at all, followed by (2) Add counting.

> +	if (!count_lines)
> +		write_or_die(1, buf.buf, buf.len);
> +	else {
> +		struct strbuf tmp = STRBUF_INIT;
> +		strbuf_addf(&tmp, "%zu\n", lines);
> +		write_or_die(1, tmp.buf, tmp.len);
> +	}

So this is your output code, which gives only the number of lines
without the cleaned up result.

> @@ -797,15 +799,19 @@ void strbuf_stripspace(struct strbuf *sb, int skip_comments)
>  
>  		/* Not just an empty line? */
>  		if (newlen) {
> -			if (empties > 0 && j > 0)
> +			if (empties > 0 && j > 0) {
>  				sb->buf[j++] = '\n';
> +				lines++;
> +			}
>  			empties = 0;
>  			memmove(sb->buf + j, sb->buf + i, newlen);
>  			sb->buf[newlen + j++] = '\n';
> +			lines++;
>  		} else {
>  			empties++;
>  		}
>  	}

I cannot say that the above is one of the better possible
implementations of this feature I would think of.

 (1) If this is performance sensitive, then you do not want to do
     memmove() etc. to actually touch the contents of the *sb and
     only increment lines++, because you are not going to show that
     in the output anyway.

 (2) If this feature is not performance sensitive, then the best
     implementation would be not to touch strbuf_stripspace() at all
     to realize this change, and count the number of '\n' in the
     cmd_stripspace() just before you use printf("%d\n", lines).
     That is best from maintainability's point-of-view, because it
     makes it infinitely less error-prone for future changes of
     strbuf_stripspace() to forget incrementing lines++ when it adds
     a newline to the output.

 (3) If you are going to still munge *sb, even if you are not going
     to show it at the end, perhaps because that would make it
     easier to keep track of where the code is scanning to find when
     you need to increment lines++, then at least the patch should
     devise a mechanism to make it less likely that the future
     changes to strbuf_stripspace() would make 'lines' and the
     number of '\n' in the *sb out-of-sync (hint: perhaps a macro
     called APPEND_LF(sb, line) or something).  It is easy to append
     '\n' to sb->buf without incrementing lines++ as the code stands
     with this patch applied---the patch makes the code less
     maintainable.

My gut feeling is that you should do (2), which is the cleanest from
the maintainability's point-of-view.
