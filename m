From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 13/16] ref-filter: allow porcelain to translate messages in the output
Date: Wed, 30 Mar 2016 14:58:21 -0700
Message-ID: <xmqqa8lfsk5e.fsf@gitster.mtv.corp.google.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
	<1459330800-12525-14-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 23:58:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alO8H-0007gK-FT
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 23:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbcC3V6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 17:58:25 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752250AbcC3V6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 17:58:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B0065132D;
	Wed, 30 Mar 2016 17:58:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v9T9451ulHr7AhMQOTm3cSvO1ak=; b=llxm20
	+cNOO0UshhwCzuQURNotHSzOidnQ+HpRjKYASFBN8T0ePQ4S0TSfziGugUQ+5Rni
	C8qZbepns9T3ZVxr5ca/B7rHhpP34o9rAfKbrmvTegHBeq/IPN7exGcmC2SKE6Ke
	Rn+84a7KFZoiQBnY5pUprIZA2bzPiTqrTfh6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fbFC2ciTv9WNxKbraTG6QS1AuAIBgNqQ
	L+j+iwxiYgJhS+bGaIxTf5kLgfC3zvXIZPs8jfG3nme2JKjvtC8nQtBdvd3H2xIl
	xZM68X6rLVpP2P2Q1pb1OsSB77JtEOcUt1b8lC6eDzNN1qJmaxID2p7WN05p6M7T
	8x1NmmA3H2E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 024755132C;
	Wed, 30 Mar 2016 17:58:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 731965132B;
	Wed, 30 Mar 2016 17:58:22 -0400 (EDT)
In-Reply-To: <1459330800-12525-14-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 30 Mar 2016 15:09:57 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8547E11A-F6C2-11E5-AAD4-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290350>

Karthik Nayak <karthik.188@gmail.com> writes:

> +static struct ref_msg {
> +	const char *gone;
> +	const char *ahead;
> +	const char *behind;
> +	const char *ahead_behind;
> +} msgs = {
> +	"gone",
> +	"ahead %d",
> +	"behind %d",
> +	"ahead %d, behind %d"
> +};
> +
> +void setup_ref_filter_porcelain_msg(void)
> +{
> +	msgs.gone = _("gone");
> +	msgs.ahead = _("ahead %d");
> +	msgs.behind = _("behind %d");
> +	msgs.ahead_behind = _("ahead %d, behind %d");
> +}

I do not think this patch is wrong, but I wonder if it would be
sufficient to have a single bit in file-scope static variable and
flip it in setup_ref_filter_porcelain_msg().  I.e.

	static int use_porcelain_msg; /* false by default */

        void setup_ref_filter_porcelain_msg(void)
        {
        	use_porcelain_msg = 1;
	}        

        static const char *P_(const char *msg)
        {
                return use_porcelain_msg ? _(msg) : msg;
	}

and then mark the message up perhaps like so:

	-	*s = xstrdup("gone");
        +	*s = xstrdup(P_("gone"));

which may make things much simpler.

We'd need to update Makefile to recognize X_() as another keyword;
I'd think something like this should do:

         XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
        -        --keyword=_ --keyword=N_ --keyword="Q_:1,2"
	+        --keyword=_ --keyword=N_ --keyword=P_ --keyword="Q_:1,2"


>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>  
>  struct align {
> @@ -1097,15 +1117,15 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>  	else if (atom->u.remote_ref.option == RR_TRACK) {
>  		if (stat_tracking_info(branch, &num_ours,
>  				       &num_theirs, NULL)) {
> -			*s = xstrdup("gone");
> +			*s = xstrdup(msgs.gone);
>  		} else if (!num_ours && !num_theirs)
>  			*s = "";
>  		else if (!num_ours)
> -			*s = xstrfmt("behind %d", num_theirs);
> +			*s = xstrfmt(msgs.behind, num_theirs);
>  		else if (!num_theirs)
> -			*s = xstrfmt("ahead %d", num_ours);
> +			*s = xstrfmt(msgs.ahead, num_ours);
>  		else
> -			*s = xstrfmt("ahead %d, behind %d",
> +			*s = xstrfmt(msgs.ahead_behind,
>  				     num_ours, num_theirs);
>  		if (!atom->u.remote_ref.nobracket && *s[0]) {
>  			const char *to_free = *s;
> diff --git a/ref-filter.h b/ref-filter.h
> index 0014b92..da17145 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -111,5 +111,7 @@ struct ref_sorting *ref_default_sorting(void);
>  int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
>  /*  Get the current HEAD's description */
>  char *get_head_description(void);
> +/*  Set up translated strings in the output. */
> +void setup_ref_filter_porcelain_msg(void);
>  
>  #endif /*  REF_FILTER_H  */
