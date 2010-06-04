From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] optimize path_relative()
Date: Fri, 4 Jun 2010 09:50:34 +0200
Message-ID: <20100604075034.GB5117@localhost>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
 <20100603133631.GA31565@localhost>
 <7vocfr7oe6.fsf@alter.siamese.dyndns.org>
 <20100604074442.GA5117@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 09:51:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKRgc-0007jh-Bb
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 09:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab0FDHvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 03:51:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58474 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab0FDHvU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 03:51:20 -0400
Received: by fxm8 with SMTP id 8so577805fxm.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 00:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=l7hLh+Qy98dX7K6Hv2crsj3RFj3hrItvdouM2TOcid4=;
        b=FAQ2dTRamy36hNyCJ6VqsNp7LZ0wJvHxYZAsQe7/zJNxvtc/PSR/E/TuY4t4rYJlo2
         Akos90AP6h2bXTPUU7SBKvEsoFXsecWeiMSEEqXZ4+4bMqmwIMnwNG3myA76ssnlqVZW
         QcnnbWD2U356jfNdCzuVADlfI4lhgPUzSSatc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=KKUFUmJkLHmlEM6sCn4jBxmcbHoyaCZTE5LJsoFOtMFgCxfrZUQ0ah2AWP4Dd6ateQ
         JFtjlY8ei4bfUg10+cv6Z2K0BrW0CprGYsc0fhE1D6tM1gbrDNMNdOiIplOd19ujT/mE
         nyEAjagid+Mr2cTgG95kTFKTzedUjAXk5F+yo=
Received: by 10.223.161.211 with SMTP id s19mr4031512fax.47.1275637878480;
        Fri, 04 Jun 2010 00:51:18 -0700 (PDT)
Received: from darc.lan (p549A7CEC.dip.t-dialin.net [84.154.124.236])
        by mx.google.com with ESMTPS id g10sm4095644fai.0.2010.06.04.00.51.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 00:51:17 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OKRfm-0001P7-Uc; Fri, 04 Jun 2010 09:50:34 +0200
Content-Disposition: inline
In-Reply-To: <20100604074442.GA5117@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148383>

On Fri, Jun 04, 2010 at 09:44:43AM +0200, Clemens Buchacher wrote:

> +static const char *path_relative(const char *in, int len,
> +				 struct strbuf *sb, const char *prefix,
> +				 int prefix_len)
>  {
> +	int off, i;
> +
>  	if (len < 0)
>  		len = strlen(in);
>  	if (prefix && prefix_len < 0)
>  		prefix_len = strlen(prefix);
>  
> -	strbuf_setlen(out, 0);
> -	strbuf_grow(out, len);
> +	off = 0;
> +	i = 0;
> +	while (i < prefix_len && i < len && prefix[i] == in[i]) {
> +		if (prefix[i] == '/')
> +			off = i + 1;
> +		i++;
> +	}
> +	in += off;
> +	len -= off;
>  
> -	if (prefix_len > 0) {
> -		int off = 0, i = 0;
> -		while (i < prefix_len && i < len && prefix[i] == in[i]) {
> -			if (prefix[i] == '/')
> -				off = i + 1;
> -			i++;
> -		}
> -		in += off;
> -		len -= off;
> +	if (i == prefix_len)
> +		return in;
>  
> -		while (i < prefix_len) {
> -			if (prefix[i] == '/')
> -				strbuf_addstr(out, "../");
> -			i++;
> -		}
> +	strbuf_reset(sb);
> +	strbuf_grow(sb, len);
> +
> +	while (i < prefix_len) {
> +		if (prefix[i] == '/')
> +			strbuf_addstr(sb, "../");
> +		i++;
>  	}

By the way, I noticed that we rely on the fact that a non-empty
prefix ends with '/'. Is that ok?

> -	strbuf_add(out, in, len);
> +	strbuf_add(sb, in, len);
>  
> -	return out->buf;
> +	return sb->buf;
>  }
