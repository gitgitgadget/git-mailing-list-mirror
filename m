From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 6/6] update-index: migrate to parse-options API
Date: Tue, 30 Nov 2010 00:13:40 -0800
Message-ID: <4CF4B234.9060206@gmail.com>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com> <1287544320-8499-4-git-send-email-pclouds@gmail.com> <20101022063837.GA6081@burratino> <20101022064258.GB6081@burratino> <7v8w1qnkr1.fsf@alter.siamese.dyndns.org> <20101024072032.GA23455@burratino> <20101024081316.GA29630@burratino> <20101130025223.GA5326@burratino> <20101130031549.GG5326@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 09:13:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNLLX-0006M6-Hd
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 09:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585Ab0K3INt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 03:13:49 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36938 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab0K3INt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 03:13:49 -0500
Received: by mail-gx0-f174.google.com with SMTP id 3so177036gxk.19
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 00:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=3rDSA2ZK1a1T2ASu7zsNrgmT2BuqXBP9Uz4F1DV9ou8=;
        b=QnVDThk6EoO1SUkQxZ4iPYMICK6y69cxPD1ZHb7a4pmxfe+dPpKrj+moITJtBTgjdr
         RmXwntkMYKYgfD63zJfuLqRKrk94eBo6pm4ZNXfgjPPGL0RhdoJoQfDgTZE/g5LDLKaC
         zdutOsQlOiuNkb+a3sI+J8H6uFTulsK0ifgS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=p9GyQNoBM+6rPLfH9qRDo8bfCosBcW3efWpk0a5foVwyyjL5HtZ/Wr4c4hy+m7iEId
         j4MWHtp9qzznmfFJdD1q1CkMtlkz/AsrxKO2Mm42FdqYTeEUHxd1G1dxI5QubdkrKwth
         zlcwDTb4ePx0UOMuXy2VfPau9prCUuzy+uOws=
Received: by 10.151.26.14 with SMTP id d14mr12088844ybj.228.1291104828532;
        Tue, 30 Nov 2010 00:13:48 -0800 (PST)
Received: from [192.168.1.104] ([75.85.182.25])
        by mx.google.com with ESMTPS id i70sm3822690yha.22.2010.11.30.00.13.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Nov 2010 00:13:47 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101108 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <20101130031549.GG5326@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162477>

On 11/29/10 19:15, Jonathan Nieder wrote:
> +		{OPTION_LOWLEVEL_CALLBACK, 0, "cacheinfo", NULL,
> +			"<mode> <object> <path>",
> +			"add the specified entry to the index",
> +			PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
> +			(parse_opt_cb *) cacheinfo_callback},

Doesn't this take arguments and thus shouldn't be marked
PARSE_OPT_NOARG? Confused.

> @@ -602,151 +799,48 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  	if (entries < 0)
>  		die("cache corrupted");
>  
> -	for (i = 1 ; i < argc; i++) {
> -		const char *path = argv[i];
> -		const char *p;
> +	/*
> +	 * Custom copy of parse_options() because we want to handle
> +	 * filename arguments as they come.
> +	 */
> +	parse_options_start(&ctx, argc, argv, prefix,
> +			    PARSE_OPT_STOP_AT_NON_OPTION);

This will need to take options too, sorry.
