From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] clone: abort if no dir name could be guessed
Date: Wed, 05 Aug 2015 10:44:22 -0700
Message-ID: <xmqqvbct3a15.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438769179-5943-1-git-send-email-ps@pks.im>
	<1438769179-5943-4-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
	pclouds@gmail.com
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:44:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN2js-0000xy-EG
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 19:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbbHERoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 13:44:24 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33707 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbbHERoX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 13:44:23 -0400
Received: by pabyb7 with SMTP id yb7so9361592pab.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rlwduFUytVcI7oUKLjWCLh4PoLnijjXHsFAphX5LHmc=;
        b=0AZFgfUn6Ly0vsuBZ6mmWKjiahlJVnVIpFLN6hWAgWYQhZlaMWzLPg/Yx1MddVuqxh
         WwHHcrs3q7mMaaFZMb/KoIXwGWvghxw9jJIfkp2vwOhH4/lILJNYfDFJBN4rwl5KyD16
         aNCqugCfmVOi1k+gKu28ZmmZfoZGw+E7r9J13itB/0jhSoxjKVtRcLpyJUUmXDLEgUmY
         QyRx5IMgR1xeVlqvQpUiMjP5jLndwmt9t0XVmj3tsOm8Vvn3IDgkKgQ//YUnGD3+/1EM
         PMEPaDtPtck3OItOpwzjckKSMDgbgZfFVqGO6tLTuevIAsUcIsalgJIx8847f17/dMlg
         zjUQ==
X-Received: by 10.68.168.161 with SMTP id zx1mr21802390pbb.35.1438796663473;
        Wed, 05 Aug 2015 10:44:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id tz1sm3583153pbc.50.2015.08.05.10.44.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 10:44:22 -0700 (PDT)
In-Reply-To: <1438769179-5943-4-git-send-email-ps@pks.im> (Patrick
	Steinhardt's message of "Wed, 5 Aug 2015 12:06:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275382>

Patrick Steinhardt <ps@pks.im> writes:

> Due to various components of the URI being stripped off it may
> happen that we fail to guess a directory name. We currently error
> out with a message that it is impossible to create the working
> tree '' in such cases. Instead, error out early with a sensible
> error message hinting that a directory name should be specified
> manually on the command line.

Sounds like a sensible thing to do.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 7d93e13..5834978 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -214,6 +214,10 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
>  	len = end - start;
>  	strip_suffix_mem(start, &len, is_bundle ? ".bundle" : ".git");
>  
> +	if (!len || (len == 1 && *start == '/'))
> +	    die("No directory name could be guessed.\n"
> +		"Please specify a directory on the command line");
> +
>  	if (is_bare)
>  		dir = xstrfmt("%.*s.git", (int)len, start);
>  	else
