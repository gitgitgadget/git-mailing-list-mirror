From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fetch: Strip usernames from url's before storing them
Date: Wed, 15 Apr 2009 15:18:16 +0200
Message-ID: <49E5DE98.1080600@viscovery.net>
References: <1239797816-24582-1-git-send-email-ae@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Apr 15 15:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu51z-0003tM-PH
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 15:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759354AbZDONSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 09:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759073AbZDONSY
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 09:18:24 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42458 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbZDONSX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 09:18:23 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lu50K-00038B-N9; Wed, 15 Apr 2009 15:18:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 70777795; Wed, 15 Apr 2009 15:18:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1239797816-24582-1-git-send-email-ae@op5.se>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116610>

Andreas Ericsson schrieb:
> +/*
> + * strip username information from the url
> + * This will allocate a new string, or return its argument
> + * if no stripping is necessary.
> + *
> + * The url's we want to catch are the following:
> + *   ssh://[user@]host.xz[:port]/path/to/repo.git/
> + *   [user@]host.xz:/path/to/repo.git/
> + *   http[s]://[user[:password]@]host.xz/path/to/repo.git
> + *
> + * Although git doesn't currently support giving the password
> + * to http url's on the command-line, it's easier to catch
> + * that case too than it is to cater for it specially.
> + */
> +static char *anonymize_url(const char *url)
> +{
> +	char *anon_url;
> +	const char *at_sign = strchr(url, '@');
> +	size_t prefix_len = 0;
> +
> +	if (!at_sign)

	if (!at_sign || has_dos_drive_prefix(url))

or even better move this function to transport.c and use is_local().

> +		return strdup(url);
> +
> +	if (!prefixcmp(url, "ssh://"))
> +		prefix_len = strlen("ssh://");
> +	else if (!prefixcmp(url, "http://"))
> +		prefix_len = strlen("http://");
> +	else if (!prefixcmp(url, "https://"))
> +		prefix_len = strlen("https://");
> +	else if (!strchr(at_sign + 1, ':'))
> +		return strdup(url);
> +
> +	anon_url = xcalloc(1, 1 + prefix_len +
> +			   ((unsigned long)at_sign - (unsigned long)url));
> +	if (prefix_len)
> +		memcpy(anon_url, url, prefix_len);
> +	memcpy(anon_url + prefix_len, at_sign + 1, strlen(at_sign + 1));
> +
> +	return anon_url;
> +}

-- Hannes
