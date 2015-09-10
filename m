From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v17 05/14] ref-filter: introduce match_atom_name()
Date: Thu, 10 Sep 2015 18:49:14 +0200
Message-ID: <vpqbndap6d1.fsf@scolette.imag.fr>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441900110-4015-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 18:49:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za52Z-0005Pz-FA
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 18:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbbIJQt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 12:49:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43615 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbbIJQtY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 12:49:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8AGnCIP032633
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 10 Sep 2015 18:49:12 +0200
Received: from scolette (scolette.imag.fr [129.88.43.86])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8AGnEKM025105;
	Thu, 10 Sep 2015 18:49:14 +0200
In-Reply-To: <1441900110-4015-6-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 10 Sep 2015 21:18:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 10 Sep 2015 18:49:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8AGnCIP032633
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442508552.92757@MfGRuYPB1l5DteizCVhOQQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277601>

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

The logic is still hard to follow. If I read correctly, this function
accepts "%(colorX)" the same ways as "%(color)" here. I first thought it
was a bug, but it doesn't seem to be since %(colorX) would have been
rejected earlier.

It would be a bug if colorX was actually a valid atom name though: you
would be returning 1 for match_atom_name(name, "color") when
name=="colorX". So, I would say this "we can accept one extra character
because some earlier code rejected it before" is too hard to follow for
reviwers and too fragile.

OTOH, you are now accepting %(atom:) as a synonym to %(atom), and it's
not clear whether this is a deliberate decition.

> +		return 1;
> +	}
> +	if (body[0] != ':')
> +		return 0; /* "atom_namefoo" is not "atom_name" or "atom_name:..." */
> +	*val = body + 1; /* "atom_name:val" */
> +	return 1;
> +}

Reversing the logic like this would be better IMHO:

static int match_atom_name(const char *name, const char *atom_name, const char **val)
{
        const char *body;
	if (!skip_prefix(name, atom_name, &body)) {
		/* doesn't even begin with "atom_name" */
		return 0;
	}
	if (!body[0]) {
		/* "atom_name" and no customization */
                *val = NULL;
                return 1;
	}
	if (body[0] != ':')
		/* "atom_namefoo" is not "atom_name" or "atom_name:..." */
		return 0;
	if (!body[1]) {
		/* "atom_name:" */
		*val = NULL;
		return 1;
	}
	/* "atom_name:... */
	*val = body + 1;
	return 1;
}

=> each case appears very clearly, and we check body[0] != ':' before
testing !body[1], so %(colorX) is rejected before noticing the '\0'
after the 'X'.

"atom_name:" appears explicitly. If we want to reject it, we know which
code to change.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
