From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 6/8] am: extract patch, message and authorship with git-mailinfo
Date: Wed, 27 May 2015 13:44:26 -0700
Message-ID: <xmqqtwuxkaxh.fsf@gitster.dls.corp.google.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
	<1432733618-25629-7-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 22:44:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxiBm-0003wV-9I
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbbE0Uo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:44:29 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34324 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbE0Uo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:44:28 -0400
Received: by ieczm2 with SMTP id zm2so23276387iec.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 13:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kdcjn+KKu0jZALVgeZXuqBSuiKdkWfUUfU6D+dVEkyQ=;
        b=L1UYgc7KqqHJ2UYbtu/DfFKzZDrllca7RGW/MEYGaTfT9t3+TpziGTB0UFqhr00ey+
         t1jUMyqVgFYiy/yu3g5ZHTQrjSZNkw39rlf/yOTc7A3MExjOhaYfx0a/POZbJmbLrCC1
         b2acIcc3dK+Dj5VvtjqPQ6DF4yyCHf0y33cTZBlIpVoFP95WN5SVZLwgJxpDKuvIF2om
         TaLXnWWNDjAJ1OaOsA8M5GQkYjBO0eCPIoCtDFO9aUfJdnqCtcE7vDrPfKAK7TlES2ks
         dwgl35mLCLdS/Ww1uC0AORXPG9zn/ceiJeplgJpV8T/2u/hYJ7x305VBkFjrrRTDop+d
         kMog==
X-Received: by 10.43.146.67 with SMTP id jx3mr5620379icc.63.1432759468055;
        Wed, 27 May 2015 13:44:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id l1sm78670ioe.32.2015.05.27.13.44.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 13:44:27 -0700 (PDT)
In-Reply-To: <1432733618-25629-7-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 27 May 2015 21:33:36 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270089>

Paul Tan <pyokagan@gmail.com> writes:

> @@ -17,6 +34,10 @@ struct am_state {
>  	struct strbuf dir;            /* state directory path */
>  	int cur;                      /* current patch number */
>  	int last;                     /* last patch number */
> +	struct strbuf msg;            /* commit message */
> +	struct strbuf author_name;    /* commit author's name */
> +	struct strbuf author_email;   /* commit author's email */
> +	struct strbuf author_date;    /* commit author's date */
>  	int prec;                     /* number of digits in patch filename */
>  };

I always get suspicious when structure fields are overly commented,
wondering if it is a sign of naming fields poorly.  All of the above
fields look quite self-explanatory and I am not sure if it is worth
having these comments, spending efforts to type SP many times to
align them and all.

By the way, the overall structure of the series look sensible.

> +static int read_author_script(struct am_state *state)
> +{
> +	char *value;
> +	struct strbuf sb = STRBUF_INIT;
> +	const char *filename = am_path(state, "author-script");
> +	FILE *fp = fopen(filename, "r");
> +	if (!fp) {
> +		if (errno == ENOENT)
> +			return 0;
> +		die(_("could not open '%s' for reading"), filename);

Hmph, do we want to report with die_errno()?

> +	}
> +
> +	if (strbuf_getline(&sb, fp, '\n'))
> +		return -1;
> +	if (!skip_prefix(sb.buf, "GIT_AUTHOR_NAME=", (const char**) &value))

This cast is unfortunate; can't "value" be of "const char *" type?
