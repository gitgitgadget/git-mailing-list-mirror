From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/19] parse-options-cb: implement parse_opt_pass_argv_array()
Date: Tue, 09 Jun 2015 16:16:45 -0700
Message-ID: <xmqqr3pkwjz6.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 01:16:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2SlJ-0004yw-ND
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 01:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbbFIXQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 19:16:48 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37729 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbbFIXQr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 19:16:47 -0400
Received: by igbsb11 with SMTP id sb11so21732119igb.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 16:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ajmB7RGShmSvQSgr/VUSMLm/HjcU/cIWTmZf6/tw9Pc=;
        b=gWC2+xaPLAgGMoPcMsXpRHT5P4R2awozqS8hvcaMx6thwQIvG+flKXM+rM0B1KeJgt
         zsBnzlk6GqJ/L43NOTaIHb92GcpsFmstIs8LBZqGKX7Qelnu6JuqBD9NcAGsgvMeYkzV
         RRnxKDd9cuMTzbcuQE8HmYU5Ts6+W5+aP8ckORIV5lwuQ/xTJ4ey+w5pWqEfCQstdp4i
         mRTpS7cnKzG8f1cbXGTM6n5khdRjpGx9vWjOxFfZ7e/FDSfSe3mO9hLNarA/mSY5m79H
         z1RZKNCY9MIdLcL2WiGV7kDS15PIzr1fhze4ad4uRT4quDcskE5q4GLwo2KX6p1nAqhj
         b07A==
X-Received: by 10.107.135.162 with SMTP id r34mr266613ioi.13.1433891807142;
        Tue, 09 Jun 2015 16:16:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id eg3sm2155290igb.0.2015.06.09.16.16.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 16:16:46 -0700 (PDT)
In-Reply-To: <1433314143-4478-3-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Wed, 3 Jun 2015 14:48:46 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271240>

Paul Tan <pyokagan@gmail.com> writes:

> Certain git commands, such as git-pull, are simply wrappers around other
> git commands like git-fetch, git-merge and git-rebase. As such, these
> wrapper commands will typically need to "pass through" command-line
> options of the commands they wrap.
>
> Implement the parse_opt_pass_argv_array() parse-options callback, which
> will reconstruct all the provided command-line options into an
> argv_array, such that it can be passed to another git command. This is
> useful for passing command-line options that can be specified multiple
> times.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     v2
>     
>     * This function is a requirement for the rewrite of git-am to handle
>       passing git-apply's options to git-apply. Since it would be
>       implemented anyway I thought it would be good if git-pull could take
>       advantage of it as well to handle --strategy and --strategy-option.
>
>  parse-options-cb.c | 32 ++++++++++++++++++++++++++++++++
>  parse-options.h    |  1 +
>  2 files changed, 33 insertions(+)
>
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index 5b1dbcf..7330506 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -4,6 +4,7 @@
>  #include "commit.h"
>  #include "color.h"
>  #include "string-list.h"
> +#include "argv-array.h"
>  
>  /*----- some often used options -----*/
>  
> @@ -163,3 +164,34 @@ int parse_opt_pass_strbuf(const struct option *opt, const char *arg, int unset)
>  
>  	return 0;
>  }
> +
> +/**
> + * For an option opt, recreate the command-line option, appending it to
> + * opt->value which must be a argv_array. This is useful when we need to pass
> + * the command-line option, which can be specified multiple times, to another
> + * command.
> + */

Almost the same comment as 01/19 applies to this comment.

I think it makes good sense to have two variants, one that lets the
last one win and pass only that last one (i.e. 01/19) and the other
that accumulates them into an argv_array (i.e. this one).  But it
feels iffy, given that the "acculate" version essentially creates an
array of (char *), to make "the last one wins, leaving a single
string" to use strbuf.  I'd find it much more understandable if 01/19
took (char **) as opt->value instead of a strbuf.

In any case, these two need to be added as a related pair to the API
documentation.

Thanks.

> +int parse_opt_pass_argv_array(const struct option *opt, const char *arg, int unset)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	struct argv_array *opt_value = opt->value;
> +
> +	if (opt->long_name) {
> +		strbuf_addstr(&sb, unset ? "--no-" : "--");
> +		strbuf_addstr(&sb, opt->long_name);
> +		if (arg) {
> +			strbuf_addch(&sb, '=');
> +			strbuf_addstr(&sb, arg);
> +		}
> +	} else if (opt->short_name && !unset) {
> +		strbuf_addch(&sb, '-');
> +		strbuf_addch(&sb, opt->short_name);
> +		if (arg)
> +			strbuf_addstr(&sb, arg);
> +	} else
> +		return -1;
> +
> +	argv_array_push(opt_value, sb.buf);
> +	strbuf_release(&sb);
> +	return 0;
> +}
> diff --git a/parse-options.h b/parse-options.h
> index 1d21398..b663f87 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -225,6 +225,7 @@ extern int parse_opt_tertiary(const struct option *, const char *, int);
>  extern int parse_opt_string_list(const struct option *, const char *, int);
>  extern int parse_opt_noop_cb(const struct option *, const char *, int);
>  extern int parse_opt_pass_strbuf(const struct option *, const char *, int);
> +extern int parse_opt_pass_argv_array(const struct option *, const char *, int);
>  
>  #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
>  #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
