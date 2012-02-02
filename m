From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Thu, 2 Feb 2012 14:16:29 -0600
Message-ID: <20120202201629.GA20200@burratino>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:17:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt35W-0002DV-Ot
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab2BBUQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 15:16:55 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52212 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab2BBUQw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 15:16:52 -0500
Received: by ghrr11 with SMTP id r11so1376301ghr.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 12:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4aYnSxjbLUdBYvDRf/Jt/uvQGsn6zykDQMbqPlsTeMY=;
        b=NuI9ZYFVtyyYvjLhom9uV02MudLdGFxHpB+XYdGxyFaj1E2KZXSO8eGh9obxBNNbGP
         HSs50NEJuzsq4FS7j1v+fZfQlj5LjAceKyvsWpvmH7hkE6TDSAdNM5GzCdSOfqFbT/1T
         D9u9YtASsDNuhk8/0CIAuaYyIIxsQWDqQIY0U=
Received: by 10.50.140.105 with SMTP id rf9mr9695451igb.24.1328213811759;
        Thu, 02 Feb 2012 12:16:51 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ng9sm5278110igc.3.2012.02.02.12.16.50
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 12:16:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189698>

Ben Walton wrote:

> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -8,10 +8,12 @@ test_expect_success 'setup helper scripts' '
>  	cat >dump <<-\EOF &&
>  	whoami=`echo $0 | sed s/.*git-credential-//`
>  	echo >&2 "$whoami: $*"
> +	OIFS=$IFS
>  	while IFS== read key value; do
>  		echo >&2 "$whoami: $key=$value"
>  		eval "$key=$value"
>  	done
> +	IFS=$OIFS

Oh, good catch.  Technically "read" is not a special builtin so POSIX shells
are not supposed to do this (and Jeff's patch definitely looks right), but in
any case temporary variable settings while running a builtin are close
enough to the assignment-during-special-builtin-or-function case to
make me shiver a little. ;-)

Would something like

	(
		IFS==
		while read key value
		do
			...
		done
	)

make sense?
