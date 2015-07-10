From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] ident: support per-path configs by matching the path against a pattern
Date: Fri, 10 Jul 2015 13:23:07 -0700
Message-ID: <xmqqtwtbkbis.fsf@gitster.dls.corp.google.com>
References: <0000014e7752e758-a0bf7acb-2d0f-4492-8004-8eeeb9b2f042-000000@eu-west-1.amazonses.com>
	<xmqqr3ogkpz5.fsf@gitster.dls.corp.google.com>
	<20150710154308.GA29395@peff.net> <20150710164652.GA30113@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 10 22:23:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDepI-000418-7E
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 22:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933107AbbGJUXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 16:23:12 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34991 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932963AbbGJUXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 16:23:09 -0400
Received: by igcqs7 with SMTP id qs7so20748926igc.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 13:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=R44G2EsxbCclreh0YYjWkDLqoQz+Px7JG6a314ZJO2Q=;
        b=it4XdE1PM7W+U40Yw6AlwShXruXIBJTRRHaBSS0/KFROs+JNaZnl1IINuoQ7/CUzVp
         Kr5ay9XU2XXHUrt3P/0upxckrW0ftXB4jUnsQ3dMdFxfRRpKR4pnVl3ksYmuHx1cVVRq
         1FNh5fpF4IPhWpeRxev+gprFPizquTd3BSOySbgYdTmDPIgYPaGyqSdD2deiGzLcNuNL
         0UclRKteqDi2RU70dooPX4o7aN5V5Q08N8kud1wkY6zukaA2Y2PWip6gFUJnsZUZXqnV
         ox1odtYPjrf2GGd3UK2Ad1Vwpf3Jy5NxyUgz2Md1wsxOJO8XZW2//9bL1y0UuDIJK2gh
         /cRQ==
X-Received: by 10.107.38.129 with SMTP id m123mr6048855iom.22.1436559789158;
        Fri, 10 Jul 2015 13:23:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6de3:8019:a2a4:79ec])
        by smtp.gmail.com with ESMTPSA id pg5sm287601igb.4.2015.07.10.13.23.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jul 2015 13:23:08 -0700 (PDT)
In-Reply-To: <20150710164652.GA30113@peff.net> (Jeff King's message of "Fri,
	10 Jul 2015 12:46:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273832>

Jeff King <peff@peff.net> writes:

> Here's a sketch if anybody is inclined to pick it up and run with it.
> Note that I did not think too hard about little things like the
> de-anchoring.
> ...
>  int git_config_include(const char *var, const char *value, void *data)
>  {
>  	struct config_include_data *inc = data;
> +	const char *cond, *key;
> +	int cond_len;
>  	int ret;
>  
>  	/*
> @@ -152,8 +188,12 @@ int git_config_include(const char *var, const char *value, void *data)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (!strcmp(var, "include.path"))
> -		ret = handle_path_include(value, inc);
> +	if (!parse_config_key(var, "include", &cond, &cond_len, &key) &&
> +	    include_condition_is_true(cond, cond_len)) {

I really like these two lines.

Whoever designed that parse_config_key() interface either is a
genious or had a foresight with a crystal ball, or perhaps both.

> +		if (!strcmp(key, "path"))
> +			ret = handle_path_include(value, inc);
> +		/* else we do not know about this type of include; ignore */
> +	}
>  	return ret;
>  }
>  
