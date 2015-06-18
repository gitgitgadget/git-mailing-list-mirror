From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v3 05/31] am: split out mbox/maildir patches with git-mailsplit
Date: Thu, 18 Jun 2015 13:52:30 -0700
Message-ID: <xmqq381oeo35.fsf@gitster.dls.corp.google.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-6-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:52:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5gne-0008KX-ML
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752236AbbFRUwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:52:34 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34127 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbbFRUwd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:52:33 -0400
Received: by igboe5 with SMTP id oe5so1115270igb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=J79b5546k3e8RBKFSV7uIi9+VRK6evB8apVc2t8V7i0=;
        b=1HrgonpL8avgEnIeMqjEKyCZB7aHdAgAbZ40AicvZqUjwFFWOL3/9NnUL8L5yJ5zUp
         pOKMGnOCMGbOTl1S5LqgGTVpPpt0I1SdVEVFaEMVAwuCnHLx7GrDxdE+XHhzl9R7CbH+
         k7+ILlMrTRazEky3o3sNrFrWjrLgEMAfR7CdvH2Mt4PFc46nBO1RS8kTSWypyoa6f5lA
         o4LGZ/XrvEhXZcpuXdLbr9DSJjxoC3FQ6XcV25WSVwM7tt6DiwcN4arT2rCWB2DFO49n
         VI0jQVesYVwqg/kU3p9GSulGany3Z9OQDUtSCP4aUzhDoPDOZPsXaxwEZKd20MY9KKZJ
         TG3g==
X-Received: by 10.107.33.9 with SMTP id h9mr17887863ioh.1.1434660752998;
        Thu, 18 Jun 2015 13:52:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id t7sm276857ign.8.2015.06.18.13.52.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 13:52:31 -0700 (PDT)
In-Reply-To: <1434626743-8552-6-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Thu, 18 Jun 2015 19:25:17 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272072>

Paul Tan <pyokagan@gmail.com> writes:

> @@ -111,13 +122,69 @@ static void am_destroy(const struct am_state *state)
>  }
>  
>  /**
> + * Splits out individual patches from `paths`, where each path is either a mbox
> + * file or a Maildir. Return 0 on success, -1 on failure.
> + */

"Splits" and then "Return"?  Be consistent.

> +static int split_patches_mbox(struct am_state *state, struct string_list *paths)
> +{
> ...
> +}

Looks straightforward ;-)

> +/**
> + * parse_options() callback that validates and sets opt->value to the
> + * PATCH_FORMAT_* enum value corresponding to `arg`.
> + */
> +static int parse_opt_patchformat(const struct option *opt, const char *arg, int unset)
> +{
> +	int *opt_value = opt->value;
> +
> +	if (!strcmp(arg, "mbox"))
> +		*opt_value = PATCH_FORMAT_MBOX;
> +	else
> +		return -1;
> +	return 0;
> +}
> +
>  static struct am_state state;
> +static int opt_patch_format;
>  
>  static const char * const am_usage[] = {
>  	N_("git am [options] [(<mbox>|<Maildir>)...]"),
> @@ -156,6 +239,8 @@ static const char * const am_usage[] = {
>  };
>  
>  static struct option am_options[] = {
> +	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
> +		N_("format the patch(es) are in"), parse_opt_patchformat),
>  	OPT_END()
>  };

Looking good ;-).

Just FYI, you do not have to make am_options[], and the variables
that are referenced from there, e.g. opt_patch_format, etc., global
variables (instead you can have them all in the function scope of
cmd_am()).
