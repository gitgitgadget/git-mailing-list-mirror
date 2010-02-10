From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 8/6] receive-pack: Send internal errors over side-band
 #2
Date: Wed, 10 Feb 2010 08:13:53 +0100
Message-ID: <4B725CB1.1080908@viscovery.net>
References: <1265767290-25863-1-git-send-email-spearce@spearce.org> <1265767290-25863-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 08:16:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf6oW-0007WI-F8
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 08:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866Ab0BJHN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 02:13:57 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30863 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab0BJHN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 02:13:57 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nf6lm-00068w-5N; Wed, 10 Feb 2010 08:13:54 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D37DD1660F;
	Wed, 10 Feb 2010 08:13:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1265767290-25863-2-git-send-email-spearce@spearce.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139496>

Shawn O. Pearce schrieb:
> +static void rp_error(const char *err, ...) __attribute__((format (printf, 1, 2)));
> +static void rp_warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
> +
> +static void report_message(const char *prefix, const char *err, va_list params)
> +{
> +	int sz = strlen(prefix);
> +	char msg[4096];
> +
> +	strncpy(msg, prefix, sz);
> +	sz += vsnprintf(msg + sz, sizeof(msg) - (sz + 1), err, params);
> +	msg[sz++] = '\n';

This writes beyond the buffer if it is too small because the return value
tells how many characters *would* have been written if it were
sufficiently large, no?

> +
> +	if (use_sideband)
> +		send_sideband(1, 2, msg, sz, use_sideband);
> +	else
> +		xwrite(2, msg, sz);
> +}
> +
> +static void rp_warning(const char *err, ...)
> ...
> +static void rp_error(const char *err, ...)
> ...

Looks like we need set_report_routine().

Or did you replace only selected error() and warning() calls by rp_error()
and rp_warning()?

-- Hannes
