From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] date: make "local" orthogonal to date format
Date: Wed, 02 Sep 2015 10:36:35 -0700
Message-ID: <xmqq7fo8oh98.fsf@gitster.mtv.corp.google.com>
References: <20150901083731.GE30659@serenity.lan>
	<cover.1441144343.git.john@keeping.me.uk>
	<35b1313d4eb084ddc2bd70510d56e11a1d84e993.1441144343.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Karthik Nayak <karthik.188@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 02 19:36:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXBxj-0000uT-DI
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 19:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbbIBRgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 13:36:38 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35897 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbbIBRgh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 13:36:37 -0400
Received: by pacwi10 with SMTP id wi10so18105049pac.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 10:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=3CJ9BfstNVywTEMRSTsVYE6Ur+YB9WVga+47ihiDO8w=;
        b=vXvuyVq5ciZPPqFa/lQdr9tqkpL6IVG96mdzOpjg+sdZ1S9jbH3IB5e7zAVkkKSFfi
         DF5qeIDqnxEL1DkSZTzTyEPzpfqaIWfl0uJxJ8mbsJyI0rQOxj6OTM7R9l4QC3l7a+tN
         Ijkfa2103XQHU0nGVagTDE80iivitGV/e2gXSPQQnZCnBrhrsDr2d6CuLLgu/gwo0+te
         oe3SbcebXxmNY+JfsW0MIzYcQ89lMtdX62PZt2bYt+zqsYm/0TIk6ExQPO24A/j+T5xX
         4OnNwz9idr77zA83qrB4860Akvdkh7yPTjrnxHUtHdjPje1ZjXHVOCe5gma/CUV0GCz1
         sTkQ==
X-Received: by 10.66.62.163 with SMTP id z3mr57796237par.12.1441215396882;
        Wed, 02 Sep 2015 10:36:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id pf4sm22378826pdb.37.2015.09.02.10.36.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 10:36:36 -0700 (PDT)
In-Reply-To: <35b1313d4eb084ddc2bd70510d56e11a1d84e993.1441144343.git.john@keeping.me.uk>
	(John Keeping's message of "Tue, 1 Sep 2015 22:55:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277110>

John Keeping <john@keeping.me.uk> writes:

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index a9b808f..5d28133 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -702,12 +702,16 @@ include::pretty-options.txt[]
>  --date=(relative|local|default|iso|iso-strict|rfc|short|raw)::
>  	Only takes effect for dates shown in human-readable format, such
>  	as when using `--pretty`. `log.date` config variable sets a default
> -	value for the log command's `--date` option.
> +	value for the log command's `--date` option. By default, dates
> +	are shown in the original time zone (either committer's or
> +	author's). If `-local` is appended to the format (e.g.,
> +	`iso-local`), the user's local time zone is used instead.
>  +
>  `--date=relative` shows dates relative to the current time,
> -e.g. ``2 hours ago''.
> +e.g. ``2 hours ago''. The `-local` option cannot be used with
> +`--raw` or `--relative`.
>  +
> -`--date=local` shows timestamps in user's local time zone.
> +`--date=local` is an alias for `--date=default-local`.
>  +

This can also affect for-each-ref's "%(authordate:short)" and
friends.  We have this rather unfortunately detailed description:

    As a special case for the date-type fields, you may specify a format for
    the date by adding one of `:default`, `:relative`, `:short`, `:local`,
    `:iso8601`, `:rfc2822` or `:raw` to the end of the fieldname; e.g.
    `%(taggerdate:relative)`.

We would probably want to make this more vague by replacing "adding
one of..." with "adding ':' followed by date format name (see the
values the --date option to linkgit::git-rev-list[1] takes)" or
something like that.
