From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Thu, 22 Dec 2011 07:54:46 +0100
Message-ID: <4EF2D436.3080303@viscovery.net>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 22 07:54:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdcYL-0002yM-PL
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 07:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935Ab1LVGyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 01:54:53 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:22803 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab1LVGyw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 01:54:52 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RdcYB-0004tL-G5; Thu, 22 Dec 2011 07:54:47 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3AE351660F;
	Thu, 22 Dec 2011 07:54:47 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187598>

Am 12/22/2011 0:55, schrieb Junio C Hamano:
>  void advise(const char *advice, ...)
>  {
> +	struct strbuf buf = STRBUF_INIT;
>  	va_list params;
> +	const char *cp, *np;
>  
>  	va_start(params, advice);
> -	vreportf("hint: ", advice, params);
> +	strbuf_addf(&buf, advice, params);
>  	va_end(params);
> +
> +	for (cp = buf.buf; *cp; cp = np) {
> +		np = strchrnul(cp, '\n');
> +		fprintf(stderr, "%s%.*s\n", _("hint: "), (int)(np - cp), cp);
> +		if (*np)
> +			np++;
> +	}
> +	strbuf_release(&buf);
>  }

IMHO, this logic should be moved into vreportf(), and we get proper
prefixing of multi-line warning(), error(), and die() messages for free.

> +		advise(_("Fix them up in the work tree,\n"
> +			 "and then use 'git add/rm <file>' as\n"
> +			 "appropriate to mark resolution and make a commit,\n"
> +			 "or use 'git commit -a'."));

<rant>
Can people please pay attention how they break multi-line messages? In
this particular case, (1) even in a 80-columns terminal the lines are
spectacularly short, and (2) a break in the middle of a word group can
easily be avoided such that the result does not look ugly:

hint: Fix them up in the work tree, and then use 'git add/rm <file>'
hint: as appropriate to mark resolution and make a commit,
hint: or use 'git commit -a'.

And, no, "It would break the 80-column limit of source code" does not
count for user-visible messages.
</rant>

-- Hannes
