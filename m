From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status_printf_ln: Suppress false positive warnings of empty format string.
Date: Fri, 19 Jul 2013 09:01:28 -0700
Message-ID: <7v7ggmy1wn.fsf@alter.siamese.dyndns.org>
References: <1374242889-14239-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 18:01:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0D7h-0007ZP-8G
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 18:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828Ab3GSQBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 12:01:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab3GSQBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 12:01:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35E392E84B;
	Fri, 19 Jul 2013 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mhd8LdhGWXNF+UbkQX9J/5wuKsc=; b=bnAJAN
	S8AlYDryzLyWL8cagiMFUW2wctCm/dY8FWJDq9OrKvk2qbeuhUc50OciN4DPavgA
	xo9KbxyXndV2Hc5n3N3oRLcXUrLXr155LZHwQd0AbcahDTgd9vsZs5tAfrX7z7lV
	pkZQTOB+c2Y7FjLFHqycX0ilS6/hWFqbsypbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dZ1kUupFc6xaZCDEpynSnkgbYs1rmb+6
	4Lu6SOP6q9bf5rC4PUZUTvDvyNmIgbdXBp3JIQ5eIPdbhbEQg3VAjIhudipm8Fur
	1FUom7SuAwQJpy19B7Vmdnp5sQcjmSTgJcdhxNiyEJGCFsHkviOhVRHJmVQ9DYfq
	qNrvBwPLHGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28BB92E849;
	Fri, 19 Jul 2013 16:01:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 570BA2E82F;
	Fri, 19 Jul 2013 16:01:30 +0000 (UTC)
In-Reply-To: <1374242889-14239-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Fri, 19 Jul 2013 16:08:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79C62B56-F08C-11E2-B05C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230820>

Stefan Beller <stefanbeller@googlemail.com> writes:

> This is a response to 8dd0ee823f1829a3aa228c3c73e31de5c89b5317.
>
> Instead of having an empty string as format for the printf like function
> status_printf_ln, we could insert an empty string into the format
> parameter.
>
> A similar fixup commit is found in linux (2e4c332913b5), but there
> the empty string is replaced by a string containing one whitespace.
>
> To determine, which approach is better I setup 2 test programs, which
> either have a whitespace format (" ") or the empty string ("%s", ""),
> looking like:
> -
> 	#include <stdlib.h>
> 	#include <stdio.h>
> 	int main (int argc, char** argv) {
> 		long i;
> 		for (i = 0; i < 1024*1024*1024; ++i)
> 			printf(" ");
> 	}
> -
> Checking the required time of the programs, while redirecting the actual
> output (the billion white spaces compared to nothing) to /dev/null
> indicates that the approach used in this patch is faster regardless
> of the optimization level of gcc.
>
> Also this patch doesn't change output, which favors this approach over
> the whitespace approach.

Even if the " " variant is faster, it does not matter if its output
is incorrect ;-)

> The only thing left to discuss, whether this patch is worth it, as it
> only suppresses false positive warnings from gcc, but makes the
> code slightly harder to read.

I think we discussed this already?  The conclusion was it is silly
for GCC to warn on -Wformat-zero-length for user-defined function in
the first place, IIRC.  func(other, args, fmt,...), when invoked as
func(other, args, ""), may very well do something useful regardless
of the formatting part based on other args.

For that matter, I personally think -Wformat-zero-length warning for
standard ones, like

	printf("");

is silly, too.  It is not like

	printf("", extra, arg);

is not caught as an error.

So we can just add -Wno-format-zero-length after -Wall and be done
with it?

>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  builtin/commit.c |  2 +-
>  wt-status.c      | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 65cf2a7..34bc274 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -773,7 +773,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  				committer_ident.buf);
>  
>  		if (ident_shown)
> -			status_printf_ln(s, GIT_COLOR_NORMAL, "");
> +			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
>  
>  		saved_color_setting = s->use_color;
>  		s->use_color = 0;
> diff --git a/wt-status.c b/wt-status.c
> index cb24f1f..912ed88 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -179,7 +179,7 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
>  	} else {
>  		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
>  	}
> -	status_printf_ln(s, c, "");
> +	status_printf_ln(s, c, "%s", "");
>  }
>  
>  static void wt_status_print_cached_header(struct wt_status *s)
> @@ -195,7 +195,7 @@ static void wt_status_print_cached_header(struct wt_status *s)
>  		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
>  	else
>  		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
> -	status_printf_ln(s, c, "");
> +	status_printf_ln(s, c, "%s", "");
>  }
>  
>  static void wt_status_print_dirty_header(struct wt_status *s,
> @@ -214,7 +214,7 @@ static void wt_status_print_dirty_header(struct wt_status *s,
>  	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
>  	if (has_dirty_submodules)
>  		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
> -	status_printf_ln(s, c, "");
> +	status_printf_ln(s, c, "%s", "");
>  }
>  
>  static void wt_status_print_other_header(struct wt_status *s,
> @@ -226,12 +226,12 @@ static void wt_status_print_other_header(struct wt_status *s,
>  	if (!advice_status_hints)
>  		return;
>  	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
> -	status_printf_ln(s, c, "");
> +	status_printf_ln(s, c, "%s", "");
>  }
>  
>  static void wt_status_print_trailer(struct wt_status *s)
>  {
> -	status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
> +	status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
>  }
>  
>  #define quote_path quote_path_relative
> @@ -1192,7 +1192,7 @@ void wt_status_print(struct wt_status *s)
>  				on_what = _("Not currently on any branch.");
>  			}
>  		}
> -		status_printf(s, color(WT_STATUS_HEADER, s), "");
> +		status_printf(s, color(WT_STATUS_HEADER, s), "%s", "");
>  		status_printf_more(s, branch_status_color, "%s", on_what);
>  		status_printf_more(s, branch_color, "%s\n", branch_name);
>  		if (!s->is_initial)
> @@ -1205,9 +1205,9 @@ void wt_status_print(struct wt_status *s)
>  	free(state.detached_from);
>  
>  	if (s->is_initial) {
> -		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
> +		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
>  		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
> -		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
> +		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
>  	}
>  
>  	wt_status_print_updated(s);
> @@ -1224,7 +1224,7 @@ void wt_status_print(struct wt_status *s)
>  		if (s->show_ignored_files)
>  			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f");
>  		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
> -			status_printf_ln(s, GIT_COLOR_NORMAL, "");
> +			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
>  			status_printf_ln(s, GIT_COLOR_NORMAL,
>  					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
>  					   "may speed it up, but you have to be careful not to forget to add\n"
