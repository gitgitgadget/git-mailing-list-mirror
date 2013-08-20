From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] teach git-config to output large integers
Date: Tue, 20 Aug 2013 15:57:45 -0700
Message-ID: <20130820225745.GL4110@google.com>
References: <20130820223953.GA3429@sigill.intra.peff.net>
 <20130820224710.GB24766@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 21 00:57:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBus4-00050u-VQ
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 00:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab3HTW5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 18:57:49 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:58794 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab3HTW5s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 18:57:48 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so1018008pdj.6
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 15:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=en5zQr1etV4CJDJswLp1vQdSf7uPbEStEqL4/Uy1Qrc=;
        b=QGSyXfkXdNuwLnjr3dNZ2IsYpnuOLdnD3k27GwFAl3uuXfmXoiOmvBFY4nPaCBGWoO
         WR99TVM7r12fg8BT0hCBsGGqBza6EueckICCd1JiAFpCY8jxygnQp7nzo8Ua9R7f6kAV
         VdMBY39N3WE7F7dkMYjK+RT7uQGcMNTr6xJmF6jdFlXxsVpEVnT6zm8whAX314+3xSp0
         +fAUpa5Y0yf//eNFV85lJzfPhvXq3YnczGecsAkb8saefbcIcFtS3Q2xj/gToYhVyXLN
         SNSuuTS1nDAAk1E0hQmFelfjnTqjE1+qA9TjesIc4azSe8vWKspp3fkpba7QQfDEV4A3
         hQkA==
X-Received: by 10.67.22.106 with SMTP id hr10mr3914967pad.155.1377039468359;
        Tue, 20 Aug 2013 15:57:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id il4sm4340347pbb.36.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 15:57:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130820224710.GB24766@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232665>

Jeff King wrote:

> I kind of hate the name "--ulong". I wanted to call it "--size" or
> something and abstract away the actual platform representation, and just
> make it "big enough for file sizes".

Yes, something like --size would be more pleasant.

It could still use unsigned long internally.  My only worry about
--size is that it does not make it clear we are talking about file
sizes and not in-memory sizes (size_t), and I'm not too worried about
that.

[...]
> --- a/builtin/config.c
> +++ b/builtin/config.c
[...]
> @@ -268,6 +272,10 @@ static char *normalize_value(const char *key, const char *value)
>  			int v = git_config_int(key, value);
>  			sprintf(normalized, "%d", v);
>  		}
> +		else if (types == TYPE_ULONG)
> +			sprintf(normalized, "%lu",
> +				git_config_ulong(key, value));
> +
>  		else if (types == TYPE_BOOL)

Style: uncuddled "else", stray blank line.  (The former was already
there, but it still stands out.)  I think

		if (types == TYPE_INT) {
			...
		} else if (types == TYPE_ULONG) {
			...
		} else if (types == TYPE_BOOL) {
			...
		} else if (types == TYPE_BOOL_OR_INT) {
			...
		} else {
			...
		}

would be easiest to read.

Thanks for taking this on.

Sincerely,
Jonathan
