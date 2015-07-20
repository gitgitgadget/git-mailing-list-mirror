From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
Date: Mon, 20 Jul 2015 09:37:20 -0700
Message-ID: <xmqq1tg2zsxr.fsf@gitster.dls.corp.google.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437246749-14423-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 18:37:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHE4J-000756-58
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 18:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673AbbGTQhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 12:37:25 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34098 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756663AbbGTQhW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 12:37:22 -0400
Received: by pdbbh15 with SMTP id bh15so58579449pdb.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TpUrwDhexqWa/SHngB6+Jdwc6zEbo1K7ypHiZmBMyVU=;
        b=rO/XRtPPcamLKoznm4PUljzgnjYV1F9ZsYU+BG0HE1GNtsSGdVkbETbcOOgI6/w35w
         c6Oumj2nCpluMPRRztfPE1KYhLceZMmoECUfTI/CAxAGr5Gp2Qs7eoEy5FdJ1xZZcRtQ
         Hm/VN/UsxSoDl/37F+7jaTl9yCHXMdJWLwwQCt4FElAlDzo8/2kKPPaQLvJu2XgxP05B
         Yf4QsNBihfDmcM5uSnmKkR7229jSnYuLPGqgPTdBcZaW61AiBnJ/W1w4u1BTsYuZ4xDT
         TmHEkYE1GcAAgZXgBU7XiKe+wVD3Amn1xrSHAoi3Hs8Xzo/fadUV6UiTqtcAcIoxrCN9
         n/Xg==
X-Received: by 10.66.65.142 with SMTP id x14mr62017313pas.135.1437410242259;
        Mon, 20 Jul 2015 09:37:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4dc:19bb:f338:713b])
        by smtp.gmail.com with ESMTPSA id of5sm13162116pdb.52.2015.07.20.09.37.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 Jul 2015 09:37:21 -0700 (PDT)
In-Reply-To: <1437246749-14423-2-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 19 Jul 2015 00:42:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274330>

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -687,6 +690,17 @@ static void populate_value(struct ref_array_item *ref)
>  			else
>  				v->s = " ";
>  			continue;
> +		} else if (starts_with(name, "align:")) {
> +			const char *valp = NULL;
> +
> +			skip_prefix(name, "align:", &valp);
> +			if (!valp[0])
> +				die(_("No value given with 'align='"));
> +			strtoul_ui(valp, 10, &ref->align_value);
> +			if (ref->align_value < 1)
> +				die(_("Value should be greater than zero"));
> +			v->s = "";
> +			continue;
>  		} else
>  			continue;
>  
> @@ -1254,17 +1268,38 @@ static void emit(const char *cp, const char *ep)
>  	}
>  }
>  
> +static void assign_formating(struct ref_array_item *ref, int parsed_atom, struct atom_value *v)
> +{
> +	if (v->s[0] && ref->align_value) {
> +		unsigned int len = 0;
> +
> +		len = utf8_strwidth(v->s);
> +		if (ref->align_value > len) {
> +			struct strbuf buf = STRBUF_INIT;
> +			strbuf_addstr(&buf, v->s);
> +			if (!v->s[0])
> +				free((char *)v->s);
> +			strbuf_addchars(&buf, ' ', ref->align_value - len);
> +			v->s = strbuf_detach(&buf, NULL);
> +		}
> +		ref->align_value = 0;
> +	}
> +}

What is your plan for this function?  Is it envisioned that this
will gain more variations of formatting options over time?
Otherwise it seems misnamed (it is not "assign formatting" but
merely "pad to the right").

I also doubt that the logic is sane.  More specifically, what does
that "if (v->s[0])" buy you?

Your caller is iterating over the elements in a format string,
e.g. 'A %(align:20)%(foo) B %(bar) C', and its caller is iterating
over a list of refs, e.g. 'maint', 'master' branches.  With that
format string, as long as %(foo) does not expand to something that
exceeds 20 display places or so, I'd expect literal 'B' for all refs
to align, but I do not think this code gives me that; what happens
if '%(foo)' happens to be an empty string for 'maint' but is a
string, say 'x', for 'master'?
