From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH/RFC] grep: Add --directories option.
Date: Fri, 10 Jul 2009 01:02:22 -0700
Message-ID: <4A56F58E.1080907@gmail.com>
References: <1247167228-2466-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?TWljaGHFgiBLaWVkcm93aWN6?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 10:02:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPB3z-0000Aa-CW
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 10:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbZGJIC1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 04:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbZGJIC1
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 04:02:27 -0400
Received: from mail-px0-f193.google.com ([209.85.216.193]:43246 "EHLO
	mail-px0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbZGJIC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 04:02:26 -0400
Received: by pxi31 with SMTP id 31so511664pxi.33
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=0fVXCupqYvzk6o372IXtkuptojNtrS0SQEhnE6aE9G4=;
        b=GjjAgW3Szt6a88KBoBURG90bB3xfEB+PdtvZ8axzv08tShqMtsqM/Sn0Izs0wP6ser
         /bYCED2NDMQ6aLvs2vDEv2Q9o3xSaZO6bxZzb8zzxx/WyQ9CrKY+MoN9OmYEq3p4EBzO
         7p/Cn5e+XbmnXQV0zCMRI2DtBjo7N1pYLsSco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=rO69FQuGPTLBQGfM45/6/Xg3U8xr9ttDPSuM5Xd/IMKsjJCgAutijOa0qOPbO6550o
         AwJUOPSm2m3Qi8KR2dpnbw72C2B08CAWs5gdSQjxD6pNrYqProUQeOvX5a97E+Q+8nFJ
         K//o22b7lFXaW+p3+Vfk4cC7ZPQYQ32tPyRYE=
Received: by 10.142.135.16 with SMTP id i16mr643770wfd.189.1247212945051;
        Fri, 10 Jul 2009 01:02:25 -0700 (PDT)
Received: from ?10.10.0.4? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id 32sm1606378wfa.13.2009.07.10.01.02.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Jul 2009 01:02:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090629)
In-Reply-To: <1247167228-2466-1-git-send-email-michal.kiedrowicz@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123043>

Micha=C5=82 Kiedrowicz wrote:
> @@ -648,10 +658,32 @@ static int help_callback(const struct option *o=
pt, const char *arg, int unset)
>  	return -1;
>  }
> =20
> +static int directories_callback(const struct option *opt,
> +				const char *arg, int unset)
> +{
> +	int *recurse =3D opt->value;
> +
> +	if (!arg)
> +		return error("switch `d' requires a value");

This isn't needed because OPT_CALLBACK requires an argument always be g=
iven.

> +
> +	if (!strcmp(arg, "recurse")) {
> +		*recurse =3D 1;
> +		return 0;
> +	} else if (!strcmp(arg, "skip")) {
> +		*recurse =3D 0;
> +		return 0;
> +	}
> +
> +	fprintf(stderr, "Invalid action `%s'.\n", arg);
> +	fprintf(stderr, "Available actions are: recurse skip.\n");
> +	return -1;
> +}
> +

I think I would drop the two fprintf's here and just return an error()
saying invalid action. This will in turn cause the usage message to sho=
w
up, where you can show the two possible actions.

> @@ -674,6 +706,9 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
>  		OPT_SET_INT('I', NULL, &opt.binary,
>  			"don't match patterns in binary files",
>  			GREP_BINARY_NOMATCH),
> +		OPT_CALLBACK('d', "directories", &recurse, "action",
> +			"action to perform when input file is a directory",
> +			directories_callback),
>  		OPT_GROUP(""),
>  		OPT_BIT('E', "extended-regexp", &opt.regflags,
>  			"use extended POSIX regular expressions", REG_EXTENDED),

Do you want to allow "--no-directories", I would suggest setting the
PARSE_OPT_NONEG flag to avoid this. Maybe you want to replace "action"
with "recurse|skip" too.
