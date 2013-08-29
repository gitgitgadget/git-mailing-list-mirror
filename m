From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 3/4] get rid of "git submodule summary --for-status"
Date: Thu, 29 Aug 2013 23:05:52 +0200
Message-ID: <vpqr4dcnr67.fsf@anie.imag.fr>
References: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377781536-31955-4-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqsixs2run.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 23:06:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF9Pz-0000P4-2T
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 23:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab3H2VGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 17:06:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42884 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905Ab3H2VGK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 17:06:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7TL5nth029276
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 23:05:49 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VF9Pc-0003xG-IM; Thu, 29 Aug 2013 23:05:52 +0200
In-Reply-To: <xmqqsixs2run.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 29 Aug 2013 12:56:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Aug 2013 23:05:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TL5nth029276
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378415154.76309@p8RMvt82Tn1zW6SFh5fA6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233362>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> +	/* prepend header, only if there's an actual output */
>> +	if (len) {
>> +		if (uncommitted)
>> +			strbuf_addstr(&summary, _("Submodules changed but not updated:"));
>> +		else
>> +			strbuf_addstr(&summary, _("Submodule changes to be committed:"));
>> +		strbuf_addstr(&summary, "\n\n");
>> +	}
>> +	strbuf_addbuf(&summary, &cmd_stdout);
>> +	strbuf_release(&cmd_stdout);
>> +
>> +	summary_content = strbuf_detach(&summary, &len);
>> +	strbuf_add_commented_lines(&summary, summary_content, len);
>> +	free(summary_content);
>> +
>> +	summary_content = strbuf_detach(&summary, &len);
>> +	fprintf(s->fp, summary_content);
>> +	free(summary_content);
>
> This "fprintf()" looks bogus to me.

Oops, indeed. I forgot the "%s".

> How about adding this on top?

Your solution is better, yes.

>  wt-status.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index d91661d..1f17652 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -710,9 +710,8 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
>  	strbuf_add_commented_lines(&summary, summary_content, len);
>  	free(summary_content);
>  
> -	summary_content = strbuf_detach(&summary, &len);
> -	fprintf(s->fp, summary_content);
> -	free(summary_content);
> +	fputs(summary.buf, s->fp);
> +	strbuf_release(&summary);
>  }
>  
>  static void wt_status_print_other(struct wt_status *s,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
