From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v17 05/14] ref-filter: introduce match_atom_name()
Date: Thu, 10 Sep 2015 09:56:25 -0700
Message-ID: <xmqq37ym5i2u.fsf@gitster.mtv.corp.google.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441900110-4015-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 18:56:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za59E-0003vP-MT
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 18:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbbIJQ43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 12:56:29 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33975 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbbIJQ41 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 12:56:27 -0400
Received: by padhy16 with SMTP id hy16so47979186pad.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NO//Wv+Lpu4Ine9sFvWvsQX/qniAa8QG8KJG0dm6OiI=;
        b=n8jSNCmsPO8i0jLQMyl0EKEsJI7z/iMn32YW1LUFaPrHnrGzpxwIfSI7Clwv+ZJ1JH
         xXvjpDXtFYS0r4lJSruUODrdSOaJtANG9bLPImxCpCG4ujLNyHGWWNVnzChRs0JLFfus
         OVdAi6SIRoz/Tk3t725dHjq2oLGVVyBpTU3+Ekz79ukOo+i7O4glgLQFNxRCiFVam/U7
         sFCRhhFnvaASnEacQKndNYCU3W4By1GRzZRCnSX6bn9E7wDApSnKKqd7pcFVft3ihGQK
         C0ymDr7TlAG8oBtnEYN4NBo1hpD4O/A322yt79AAlsxuN2n44TdDB8yBPIUHX7OAESov
         c9EA==
X-Received: by 10.66.253.2 with SMTP id zw2mr21328825pac.104.1441904187024;
        Thu, 10 Sep 2015 09:56:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id ey3sm13025804pbd.28.2015.09.10.09.56.26
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 10 Sep 2015 09:56:26 -0700 (PDT)
In-Reply-To: <1441900110-4015-6-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 10 Sep 2015 21:18:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277603>

Karthik Nayak <karthik.188@gmail.com> writes:

> Introduce match_atom_name() which helps in checking if a particular
> atom is the atom we're looking for and if it has a value attached to
> it or not.
>
> Use it instead of starts_with() for checking the value of %(color:...)
> atom. Write a test for the same.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Thanks-to: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ref-filter.c                   | 23 +++++++++++++++++++++--
>  t/t6302-for-each-ref-filter.sh |  4 ++++
>  2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index a993216..70d36fe 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -189,6 +189,22 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
>  	*stack = prev;
>  }
>  
> +static int match_atom_name(const char *name, const char *atom_name, const char **val)
> +{
> +	const char *body;
> +
> +	if (!skip_prefix(name, atom_name, &body))
> +		return 0; /* doesn't even begin with "atom_name" */
> +	if (!body[0] || !body[1]) {
> +		*val = NULL; /* %(atom_name) and no customization */

Why do we check body[1] here?  I do not understand why you are not
checking !body[0] alone nothing else in this if condition.

For (atom_name="align", name="aligna"), should the function say that
"%(aligna)" is an "%(align)" with no customization?

> +		return 1;
> +	}
> +	if (body[0] != ':')
> +		return 0; /* "atom_namefoo" is not "atom_name" or "atom_name:..." */
> +	*val = body + 1; /* "atom_name:val" */
> +	return 1;
> +}
> +
>  /*
>   * In a format string, find the next occurrence of %(atom).
>   */
> @@ -687,6 +703,7 @@ static void populate_value(struct ref_array_item *ref)
>  		int deref = 0;
>  		const char *refname;
>  		const char *formatp;
> +		const char *valp;
>  		struct branch *branch = NULL;
>  
>  		v->handler = append_atom;
> @@ -721,10 +738,12 @@ static void populate_value(struct ref_array_item *ref)
>  			refname = branch_get_push(branch, NULL);
>  			if (!refname)
>  				continue;
> -		} else if (starts_with(name, "color:")) {
> +		} else if (match_atom_name(name, "color", &valp)) {

Why use the helper only for this one?  Aren't existing calls to
starts_with() in the same if/else if/... cascade all potential bugs
that the new helper function is meant to help fixing?  For example,
the very fist one in the cascade:

	if (starts_with(name, "refname"))
        	refname = ref->refname;

is correct *ONLY* when name is "refname" or "refname:" followed by
something, and it should skip "refnamex" when such a new atom is
added to valid_atom[] list, i.e. a bug waiting to happen.  I think
the new helper is designed to prevent such a bug from happening.

>  			char color[COLOR_MAXLEN] = "";
>  
> -			if (color_parse(name + 6, color) < 0)
> +			if (!valp)
> +				die(_("expected format: %%(color:<color>)"));
> +			if (color_parse(valp, color) < 0)
>  				die(_("unable to parse format"));
>  			v->s = xstrdup(color);
>  			continue;
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 505a360..c4f0378 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -81,4 +81,8 @@ test_expect_success 'filtering with --contains' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '%(color) must fail' '
> +	test_must_fail git for-each-ref --format="%(color)%(refname)"
> +'
> +
>  test_done
