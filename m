From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 3/3] index-helper: take extra care with readlink
Date: Mon, 11 Apr 2016 17:53:05 -0400
Organization: Twitter
Message-ID: <1460411585.5540.21.camel@twopensource.com>
References: <570ADBCB.4040503@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 23:53:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apjli-0002bE-1s
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 23:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbcDKVxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 17:53:09 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:36368 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594AbcDKVxI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 17:53:08 -0400
Received: by mail-qg0-f45.google.com with SMTP id f52so157096419qga.3
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 14:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Q5Cc6ualOkctFS9DtMig5qARH2C6zIldukyZ5i4whQE=;
        b=UsCPdWqZQo6FbhDrLhk9RZ0Pl86CpcYi3H5HosskRfIWAoEzJkV7SXN82tNcv8S7Kx
         Fy6uWVPtTuSMTivwuY56CdSc14clSK/citj7kwCax9M341XgGe0AcuQSYp/0i6kBM3E9
         qVJ/2L68q9FgLj6dWN6aIj+br8DRmhHA1RyAjCi/+stAGqWxS5P+JsyMHjPL3LitC3Fh
         7lLWeYA2FD3hGQg9ipg3ut/P0B1lttvjamHWgKJVbXoShCA/omBVjKwLxocFwDoKJ6t+
         67bPvGTFtjICSCScOpsowvKU9FrFk9sc8B6Cj8VthRXolcyCRDf3SBoh//qtwyKna0yp
         YRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Q5Cc6ualOkctFS9DtMig5qARH2C6zIldukyZ5i4whQE=;
        b=GSSjV6OZwtnYnY/12Sk7OnOY4N+bM4l31r2zQ/vv6q0H+Qew4MeVTPLqYlAbM43OeK
         nwsmtUz60XFCJLuAYLciXVSkjBtRuZJRbitvboWYx+xIMuPuCvcsCWA8LnT6+1FFicFW
         9ZyZbm2go8M3twVEaZv5sBb+6Efat/ofgb6TcFdGHFtSgoYDS5ZcnlFs/GVZX0aOjZ55
         JqtEvncGTImoWOgSlwqA6PdVZt9Kcu33H9jAMm+wRQ8Xcg+71KjwyHbxrYQbZue1meJk
         pHuwMZdzvbNtuOcyNNErSDVPS3079MnkrMi6nMR571SerqxsNJW5PWvhlZR9dYU4yN8o
         c47w==
X-Gm-Message-State: AD7BkJKU4zPvvsCW3TC6zeQWNYVXXpOTUFC9WPJoLzEg2IpHBsmdDzemXeVZV5OofkB48g==
X-Received: by 10.140.33.229 with SMTP id j92mr31714707qgj.20.1460411587040;
        Mon, 11 Apr 2016 14:53:07 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 23sm2167737qkd.8.2016.04.11.14.53.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2016 14:53:05 -0700 (PDT)
In-Reply-To: <570ADBCB.4040503@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291235>

On Mon, 2016-04-11 at 00:03 +0100, Ramsay Jones wrote:
> It took me a few minutes to convince myself that, if index-helper is
> the only writer for the symlink, that the call to readlink would
> result in a properly NULL terminated string. This relies on the
> initialization of the address variable setting each byte of the
> 'struct sockaddr_un' to zero and the contents of the symlink being
> no more than 'sizeof(address.sun_path) - 1' bytes long.
> 
> In order to make the call easier to reason about, introduce a wrapper
> function, read_link(), which copes with overlong symlinks and ensures
> correct NULL termination.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  read-cache.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index c7053d8..39330a1 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1722,12 +1722,23 @@ static void post_read_index_from(struct
> index_state *istate)
>  	tweak_untracked_cache(istate);
>  }
>  
> +static int read_link(const char *path, char *buf, size_t bufsize)
> +{
> +	int len;
> +
> +	len = readlink(path, buf, bufsize);
> +	if (len < 0 || len >= bufsize)
> +		return -1;
> +	buf[len] = '\0';
> +	return 0;
> +}
> +
>  int connect_to_index_helper(void)
>  {
>  	struct sockaddr_un address = {0};
>  	int fd;
>  
> -	if (readlink(git_path("index-helper.path"),
> address.sun_path,
> +	if (read_link(git_path("index-helper.path"),
> address.sun_path,
>  		     sizeof(address.sun_path)) < 0)
>  		return -1;
>  


Will squash.
