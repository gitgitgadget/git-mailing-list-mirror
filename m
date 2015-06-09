From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/19] pull: pass verbosity, --progress flags to fetch and merge
Date: Tue, 09 Jun 2015 16:36:45 -0700
Message-ID: <xmqqioawwj1u.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-7-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 01:36:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2T4f-0005la-Ez
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 01:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbbFIXgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 19:36:50 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36510 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbbFIXgs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 19:36:48 -0400
Received: by igbpi8 with SMTP id pi8so23308332igb.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 16:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0Pff3jYfPfv6NVmJFEplLfdI8pc7/ZHI2XzRsJiqaZg=;
        b=mJumK2wWT28ZpMAMdYLQm6ZdgnQ/ARAJs+2b0TLfIKq2RZKqpm/DtxDQWS8DB6OQrh
         JZj7bXzuqFxnonAAC4/mo70ir5U9R6Re5Awsg6ozT0EsvUDF2m+ncWGi+nuZkk8LCw9E
         PQ+u5YnZvtZPUb7Kx2DhgeMkgLPYcvfKlD+MDen5jUPNATM3+RLh3hfp+19U4Hcyl8GO
         8S6GvO5nK1Tui7XrtgsXG9VyaPtn9NvM4iT3pSSNxsprb32jFE6MKHn+7jzxm1cZnVH/
         kcae7fIwUHjS4dxMNVh49rmof9GIOIEKF3neDkJHtrjnCbZQIq0Mv5AapgDJJvjnXv29
         XMxw==
X-Received: by 10.107.130.101 with SMTP id e98mr357421iod.80.1433893007545;
        Tue, 09 Jun 2015 16:36:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id x3sm2206960igl.2.2015.06.09.16.36.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 16:36:46 -0700 (PDT)
In-Reply-To: <1433314143-4478-7-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Wed, 3 Jun 2015 14:48:50 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271243>

Paul Tan <pyokagan@gmail.com> writes:

> Re-implement support for this flag by introducing the option callback
> handler parse_opt_passthru(). This callback is used to pass the
> "--progress" or "--no-progress" command-line switch to git-fetch and
> git-merge.

Forgot to rephrase?  parse-opt-passthru() is a good name for "pass
the single string, last one wins", but is implemented in another
patch.

	Use parse_opt_passthru() implemented earlier to pass the
	"--[no-]progress" command line options to git-fetch and
	git-merge.

or something like that.

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 0ca23a3..c9c2cc0 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -16,11 +16,35 @@ static const char * const pull_usage[] = {
>  	NULL
>  };
>  
> +/* Shared options */
> +static int opt_verbosity;
> +static struct strbuf opt_progress = STRBUF_INIT;
> +
>  static struct option pull_options[] = {
> +	/* Shared options */
> +	OPT__VERBOSITY(&opt_verbosity),
> +	{ OPTION_CALLBACK, 0, "progress", &opt_progress, NULL,
> +	  N_("force progress reporting"),
> +	  PARSE_OPT_NOARG, parse_opt_pass_strbuf},
> +
>  	OPT_END()
>  };

Seeing this use case convinces me that the new parse-opt callback
parse-opt-pass-single-string-last-one-wins() in 01/19 should not be
strbuf based interface but should be (const char *) based one.

Other than that the change looks nicely done.  So far, the series
has been a very pleasant read up to this step.
