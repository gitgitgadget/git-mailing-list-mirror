From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] get rid of "git submodule summary --for-status"
Date: Thu, 29 Aug 2013 12:56:48 -0700
Message-ID: <xmqqsixs2run.fsf@gitster.dls.corp.google.com>
References: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377781536-31955-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 29 21:56:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF8Kt-00062u-Rb
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 21:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756157Ab3H2T4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 15:56:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755714Ab3H2T4v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 15:56:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A69733D730;
	Thu, 29 Aug 2013 19:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AkZdm2oOOhSM0lMiaTVcmctZx3s=; b=FEaWFf
	YIs8wfFDYpYghPCu6FJSB9nQroEnUoRt2wnoov25tgXmDqFN7yFsmEBGjYSaT8OJ
	iuewn6jj80ZarePPqhrbZhsLJRWedja3HJfd8GHekREf9itjT2j3fGWZezj7bV9z
	IZ7aZC8IjFZNB5imTYpxoWN15Ofh/Wfrov0OA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hluKuacfq/KJujPjxH2YqHV59Gnq/xkY
	U2vhWU9WI9HofyWdqMJsliQEWurPJGOt/0La7B1u+vPyFl/IyyXjPVPPxsZXlKmy
	G9Lg1cs7L+64ZVASoLS2Cgpqta5Me05JUcC3MW308F/B3P0hRuoCDvzk0FMlhV4a
	sKLPnDeB+bw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D3E83D72F;
	Thu, 29 Aug 2013 19:56:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB0913D72B;
	Thu, 29 Aug 2013 19:56:49 +0000 (UTC)
In-Reply-To: <1377781536-31955-4-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 29 Aug 2013 15:05:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 24A70496-10E5-11E3-A9C5-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233351>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +	/* prepend header, only if there's an actual output */
> +	if (len) {
> +		if (uncommitted)
> +			strbuf_addstr(&summary, _("Submodules changed but not updated:"));
> +		else
> +			strbuf_addstr(&summary, _("Submodule changes to be committed:"));
> +		strbuf_addstr(&summary, "\n\n");
> +	}
> +	strbuf_addbuf(&summary, &cmd_stdout);
> +	strbuf_release(&cmd_stdout);
> +
> +	summary_content = strbuf_detach(&summary, &len);
> +	strbuf_add_commented_lines(&summary, summary_content, len);
> +	free(summary_content);
> +
> +	summary_content = strbuf_detach(&summary, &len);
> +	fprintf(s->fp, summary_content);
> +	free(summary_content);

This "fprintf()" looks bogus to me.  How about adding this on top?

 wt-status.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index d91661d..1f17652 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -710,9 +710,8 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	strbuf_add_commented_lines(&summary, summary_content, len);
 	free(summary_content);
 
-	summary_content = strbuf_detach(&summary, &len);
-	fprintf(s->fp, summary_content);
-	free(summary_content);
+	fputs(summary.buf, s->fp);
+	strbuf_release(&summary);
 }
 
 static void wt_status_print_other(struct wt_status *s,
