From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] remote-curl: verify smart-http metadata lines
Date: Sun, 17 Feb 2013 02:49:39 -0800
Message-ID: <20130217104939.GE6759@elie.Belkin>
References: <20130216064455.GA27063@sigill.intra.peff.net>
 <20130216064707.GB22626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 17 11:50:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U71ox-0007DP-G2
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 11:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab3BQKtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 05:49:46 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:50657 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab3BQKtp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 05:49:45 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so2387721pab.32
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 02:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JB/gh8mVHVh1T5sR5gV50I9f5E6Kem6WZF2z977EpdU=;
        b=x6eo/KRDdQhtqq1L3oMbqrp0PeTAeQu3d60g/WbYuNy0R2ICTbVg2Oi61RQMbw/oRL
         g+wnmE03YVhu2VwXDsj48adU0eDOtDiRhjHOcfaRLmCa/baNk0sidwSzf1ab//V/F3P+
         EXPMH9rxPVeQcmNX7jY2Fx/R5KGKlPhUUxiOuoHLAhLwxLnO7OwfUNsLp1rQlRx4byHz
         7Ff1O1jwWroZlR5iPGLKPAQTXbo7E0mTEVnwM5wBXdJ8uUp8bbfWXhkf/2SUXhHBXElK
         zLlP3kZJSKSgai7+OahPBVxdif80cHhvOLJX95d5iVDkLCc97OWJIuhK0f4fhSbjehCt
         8weg==
X-Received: by 10.68.189.71 with SMTP id gg7mr21095661pbc.15.1361098185208;
        Sun, 17 Feb 2013 02:49:45 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ol7sm10815786pbb.14.2013.02.17.02.49.43
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Feb 2013 02:49:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130216064707.GB22626@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216388>

Jeff King wrote:

> --- a/remote-curl.c
> +++ b/remote-curl.c
[...]
> @@ -155,11 +166,13 @@ static struct discovery* discover_refs(const char *service)
[...]
> -		strbuf_reset(&buffer);
> -		while (packet_get_line(&buffer, &last->buf, &last->len) > 0)
> -			strbuf_reset(&buffer);
> +		if (read_packets_until_flush(&last->buf, &last->len) < 0)

Style nit: this made me wonder "What would it mean if
read_packets_until_flush() > 0?"  Since the convention for this
function is "0 for success", I would personally find

		if (read_packets_until_flush(...))
			handle error;

easier to read.

> +			die("smart-http metadata lines are invalid at %s",
> +			    refs_url);

Especially given that other clients would be likely to run into
trouble in the same situation, as long as this cooks in "next" for a
suitable amount of time to catch bad servers, it looks like a good
idea.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
