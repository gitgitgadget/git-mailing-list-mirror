From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] xread(): Fix read error when filtering >= 2GB on Mac OS X
Date: Sat, 17 Aug 2013 11:57:59 -0700
Message-ID: <20130817185759.GA2904@elie.Belkin>
References: <1376743205-12618-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Aug 17 20:58:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAlhe-0006Sp-1P
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 20:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171Ab3HQS6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 14:58:07 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41408 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab3HQS6G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Aug 2013 14:58:06 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so3461510pdj.17
        for <git@vger.kernel.org>; Sat, 17 Aug 2013 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jUbtIl7Ayjrw6+jEXYrPIV1FMn3YvZj358cO2zyIQmo=;
        b=q0u7QRWPs79zK0BAPVr+mpo2i0AmTwRrAnqhKe+QbUQPAzgYqDPbo1QzxtFKUNDdZb
         iN2jfEgLK++rVRLuFjWCKnsOz9VB5ImUfNCivWvpq0vq3lwYRdI1JqJRbMQu01YK//BV
         9xHDaIgVgmg39Z3Ue8psIkv40X/H3H1u0kpsOBmYwuDMTd0vROe5/Tk9uHwWOzXbCCuW
         kPeoE4k61cfrrGt5MI/0LX77kDZVvsbvdjgiW16urCoy/nHPTxE8q/Rjv9T1HEclQ6gc
         ML+nn1wkiHTIOhMHYV4qECFbNDSdx+cneZE0ka+QmU+SH9KNNECrCBwwjAZzb3XOAh43
         kBrA==
X-Received: by 10.66.252.129 with SMTP id zs1mr4190156pac.113.1376765886324;
        Sat, 17 Aug 2013 11:58:06 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id xe9sm5398154pab.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 17 Aug 2013 11:58:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1376743205-12618-1-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232467>

Hi,

Steffen Prohaska wrote:

> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -139,6 +139,14 @@ ssize_t xread(int fd, void *buf, size_t len)
>  {
>  	ssize_t nr;
>  	while (1) {
> +#ifdef __APPLE__
> +		const size_t twoGB = (1l << 31);
> +		/* len >= 2GB immediately fails on Mac OS X with EINVAL when
> +		 * reading from pipe. */
> +		if (len >= twoGB) {
> +			len = twoGB - 1;
> +		}
> +#endif
>  		nr = read(fd, buf, len);

See 6c642a87 (compat: large write(2) fails on Mac OS X/XNU,
2013-05-10) for a cleaner way to do this.

Hope that helps,
Jonathan
