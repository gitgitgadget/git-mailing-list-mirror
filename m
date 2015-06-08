From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/9] tag: libify parse_opt_points_at()
Date: Mon, 08 Jun 2015 12:00:55 -0700
Message-ID: <xmqq4mmiauu0.fsf@gitster.dls.corp.google.com>
References: <5573520A.90603@gmail.com>
	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 21:01:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z22IB-0001Mq-B6
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 21:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbbFHTA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 15:00:59 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36220 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbbFHTA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 15:00:57 -0400
Received: by igbpi8 with SMTP id pi8so69074499igb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HDx2nKfcv0U9fc8XcIvpBhs1DR3MA9TF5XCVkZibPdg=;
        b=M7sy7XnciBnNZDP4qi/Dri8c5k0uaahHwcdqp/1f80NVtXmU/CYxz347YQ+nvGbnPR
         3QL1T6a7Xm0B4v/FPrPzkrOxoOrP6uTfgLrS+Dd7pPRXVfFyEVwnbDV+sAAv+d92oyd9
         255anQ9ORvrSwvSoVk348fo8Z4v8SpJoquT6vzWCtOR/wWXyKgx38iURnr7bBoIUBey+
         qanhc6c1pv/QweWPQvg8MkKwYwTJZDtfuJMOrvrGdDR3ZvvLcDig6aUKzgyyIMvIE+95
         BXJkvOAkMT6YK2ZYQgM85keJ3pXAQXwvfzjUaGLplEgyYWyzStoyCYQKdY8P3MwhrjYo
         V07g==
X-Received: by 10.107.161.6 with SMTP id k6mr22774341ioe.41.1433790057082;
        Mon, 08 Jun 2015 12:00:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id g3sm925414igi.10.2015.06.08.12.00.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 12:00:56 -0700 (PDT)
In-Reply-To: <1433621052-5588-1-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 7 Jun 2015 01:34:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271112>

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index be8c413..a4d294d 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -4,6 +4,7 @@
>  #include "commit.h"
>  #include "color.h"
>  #include "string-list.h"
> +#include "sha1-array.h"
>  ...
> +int parse_opt_points_at(const struct option *opt, const char *arg, int unset)
> +{
> +	unsigned char sha1[20];
> +
> +	if (unset) {
> +		sha1_array_clear(opt->value);
> +		return 0;
> +	}
> +	if (!arg)
> +		return -1;
> +	if (get_sha1(arg, sha1))
> +		return error(_("malformed object name '%s'"), arg);
> +	sha1_array_append(opt->value, sha1);
> +	return 0;
> +}
> +

This feels way too specialized to live as part of parse_options
infrastructure.

The existing caller(s) may want to use this callback for parsing
"points-at" option they have, but is that the only plausible use of
this callback?  It looks to be usable by any future caller that
wants to take and accumulate any object names into an sha1-array, so
perhaps rename it to be a bit more generic to represent its nature
better?

	parse_opt_object_name()

or something?

I also wonder if we can (and want to) refactor the users of
with-commit callback.  Have them use this to obtain an sha1-array
and then convert what they received into a commit-list themselves.

>  int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
>  {
>  	int *target = opt->value;
> diff --git a/parse-options.h b/parse-options.h
> index c71e9da..3ae16a1 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -220,6 +220,7 @@ extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
>  extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
>  extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
>  extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
> +extern int parse_opt_points_at(const struct option *, const char *, int);
>  extern int parse_opt_with_commit(const struct option *, const char *, int);
>  extern int parse_opt_tertiary(const struct option *, const char *, int);
>  extern int parse_opt_string_list(const struct option *, const char *, int);
