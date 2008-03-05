From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on
 maxsize reached
Date: Wed, 05 Mar 2008 16:22:11 +0100
Message-ID: <47CEBAA3.5060109@viscovery.net>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <200803051455.57148.michal.rokos@nextsoft.cz> <47CEAE20.1030707@viscovery.net> <200803051600.06605.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Wed Mar 05 16:23:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWvSg-0001gA-OT
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 16:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857AbYCEPWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 10:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbYCEPWP
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 10:22:15 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:7975 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbYCEPWO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 10:22:14 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JWvQy-00013x-BL; Wed, 05 Mar 2008 16:21:33 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4D1386EF; Wed,  5 Mar 2008 16:22:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200803051600.06605.michal.rokos@nextsoft.cz>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76229>

Michal Rokos schrieb:
> Thank you for your comments; is this better?

Better, but still not there. See below. The configure test looks fine, but
I can't test it.

Finally, please make this a proper patch with Signed-off-by for Junio to
pick up.

> +#undef vsnprintf
> +int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
> +{
> +	char *s;
> +
> +	int ret = vsnprintf(str, maxsize, format, ap);
> +	if (ret != -1 )
> +		return ret;
> +
> +	s = NULL;
> +

What if maxsize == 0? Insert here:

	if (maxsize < 250)
		maxsize = 250;

> +	while (ret == -1) {
> +		maxsize *= 4;
> +		str = realloc(s, maxsize);
> +		if (! str) {
> +			free(s);
> +			return -1;
> +		}

ret == -1 at this time, so:

		if (!str)
			break;

Hm?

> +		s = str;
> +		ret = vsnprintf(str, maxsize, format, ap);
> +	}
> +	free(s);
> +	return ret;
> +}

-- Hannes

