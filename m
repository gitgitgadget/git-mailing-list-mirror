From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/10] ref-filter: add support to sort by version
Date: Sat, 25 Jul 2015 15:40:52 -0700
Message-ID: <xmqqd1zfkgi3.fsf@gitster.dls.corp.google.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
	<1437764685-8633-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 00:41:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJ87p-0005Kh-Cb
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 00:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbbGYWk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2015 18:40:56 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33741 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938AbbGYWk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2015 18:40:56 -0400
Received: by padck2 with SMTP id ck2so31429768pad.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 15:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qmC6zeKubYdVcUweStQt6Lf+KWBk3y9gd4JTRjV9bUM=;
        b=iqBm4Pwvw622t2pk17fGTU5oyyEm1vxrXksNo2rip4RGspGWhJtPrWpEPyFpsORLPx
         oJrwQtLaI3ccwdWnep7RB8+RjxsJSM2ZsCPVIEUF4REi8D5YphX/pnhvETbX7eJlmxs+
         Wchyn1xIcoohUWK+dV+QHJI3ScJfgVJeBgna9iTERID/s5kC6reAJMCHU83W25WPjGCl
         nVwkDMYLL4Z5JjIuJpuANAMNf36uDoG1cgm8km6qnHZYURewiXvbeb18i33v3C1vHg53
         DES+4t2PcSgahkkQmCV+LsHwdxLR6GBdJrV599gcOYBE+FJG0d5rU6b5sODMq3QvLLQk
         S67A==
X-Received: by 10.66.119.136 with SMTP id ku8mr47778538pab.26.1437864055514;
        Sat, 25 Jul 2015 15:40:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f068:7766:ecc2:8f58])
        by smtp.gmail.com with ESMTPSA id j4sm21597259pdg.64.2015.07.25.15.40.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 25 Jul 2015 15:40:54 -0700 (PDT)
In-Reply-To: <1437764685-8633-6-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sat, 25 Jul 2015 00:34:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274621>

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -1180,19 +1181,17 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>  
>  	get_ref_atom_value(&state, a, s->atom, &va);
>  	get_ref_atom_value(&state, b, s->atom, &vb);
> -	switch (cmp_type) {
> -	case FIELD_STR:
> +	if (s->version)
> +		cmp = versioncmp(va->s, vb->s);
> +	else if (cmp_type == FIELD_STR)
>  		cmp = strcmp(va->s, vb->s);
> -		break;
> -	default:
> -		if (va->ul < vb->ul)
> -			cmp = -1;
> -		else if (va->ul == vb->ul)
> -			cmp = 0;
> -		else
> -			cmp = 1;
> -		break;
> -	}
> +	else if (va->ul < vb->ul)
> +		cmp = -1;
> +	else if (va->ul == vb->ul)
> +		cmp = 0;
> +	else
> +		cmp = 1;
> +

So there are generally three kinds of comparison possible:

    - if it is to be compared as versions, do versioncmp
    - if it is to be compared as strings, do strcmp
    - if it is to be compared as numbers, do <=> but because
      we are writing in C, not in Perl, do so as if/else/else

Having understood that, the above is not really easy to read and
extend.  We should structure the above more like this:

	if (s->version)
        	... versioncmp
	else if (... FIELD_STR)
        	... strcmp
	else {
		if (a < b)
                	...
		else if (a == b)
                	...
		else
                	...
        }

so that it would be obvious how this code need to be updated
when we need to add yet another kind of comparison.

Without looking at the callers, s->version looks like a misdesign
that should be updated to use the same cmp_type mechanism?  That
would lead to even more obvious construct that is easy to enhance,
i.e.

	switch (cmp_type) {
        case CMP_VERSION:
        	...
	case CMP_STRING:
        	...
	case CMP_NUMBER:
        	...
        }
        
I dunno.

Other than that (and the structure of that "format-state" stuff we
discussed separately), the series was a pleasant read.

Thanks.
