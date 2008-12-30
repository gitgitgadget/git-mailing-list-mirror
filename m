From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Apply -p<value> on git-diffs that create/delete files
Date: Tue, 30 Dec 2008 01:03:18 -0800
Message-ID: <7v7i5i3ui1.fsf@gitster.siamese.dyndns.org>
References: <20081230011545.GA81224@bowser.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Ruder <andy@aeruder.net>
X-From: git-owner@vger.kernel.org Tue Dec 30 10:05:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHaWy-0005bq-RT
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 10:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbYL3JDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 04:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbYL3JDb
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 04:03:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbYL3JD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 04:03:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 07CC48BE0D;
	Tue, 30 Dec 2008 04:03:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AB7D38BE0C; Tue,
 30 Dec 2008 04:03:20 -0500 (EST)
In-Reply-To: <20081230011545.GA81224@bowser.Belkin> (Andrew Ruder's message
 of "Mon, 29 Dec 2008 18:15:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B8FB4AAA-D650-11DD-A3A6-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104171>

Andrew Ruder <andy@aeruder.net> writes:

> diff --git a/builtin-apply.c b/builtin-apply.c
> index 07244b0..584a910 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -656,137 +660,57 @@ static const char *stop_at_slash(const char *line, int llen)
>  }
>  
>  /*
> - * This is to extract the same name that appears on "diff --git"
> - * line.  We do not find and return anything if it is a rename
> - * patch, and it is OK because we will find the name elsewhere.
> + * This is to extract the same name that appears on "diff --git" line.
> + * The name that is returned also has the root applied to it and the
> + * p_value applied.  We do not find and return anything if it is a
> + * rename patch, and it is OK because we will find the name elsewhere.
>   * We need to reliably find name only when it is mode-change only,
> - * creation or deletion of an empty file.  In any of these cases,
> - * both sides are the same name under a/ and b/ respectively.
> + * creation or deletion of an empty file.  In any of these cases, both
> + * sides are the same name under a/ and b/ respectively.
>   */

This is a very good description of what the fix should do.

> +static char *git_header_name(char *line)
> ...
> -	/*
> -	 * Accept a name only if it shows up twice, exactly the same
> -	 * form.
> -	 */
> -	for (len = 0 ; ; len++) {
> -		switch (name[len]) {
> -		default:
> -			continue;
> -		case '\n':
> -			return NULL;
> -		case '\t': case ' ':
> -			second = name+len;
> -			for (;;) {
> -				char c = *second++;
> -				if (c == '\n')
> -					return NULL;
> -				if (c == '/')
> -					break;
> -			}
> -			if (second[len] == '\n' && !memcmp(name, second, len)) {
> -				return xmemdupz(name, len);
> -			}
> -		}
> -	}

You lost the above logic, and instead call find_name() with TERM_SPACE |
TERM_TAB to find the end of the first name and you expect it uniquely will
find it.  It unfortunately won't.  Consider this patch:

        diff --git a/b is file b/b is file
        index e69de29..ce01362 100644
        --- a/b is file	
        +++ b/b is file	
        @@ -0,0 +1 @@
        +hello

Your version finds "b" as the first name, skips to "is file b/b is file"
and assume that is the second name, and your new code later mistakenly
declares it as a rename and returns NULL.

> +	/* First we see if they match, if they do, we are done. */
> +	if (strcmp(first, second)) {
> +		const char *first_slash, *second_slash;
> +		/* If they don't, we check that we don't have a a/<match> b/<match>, if we
> + 		 * do we return one of those so the error messages go through correctly
> +		 * later on */
> +		first_slash = stop_at_slash(first, strlen(first));
> +		second_slash = stop_at_slash(second, strlen(second));
>  
> +		/* If this fails, it must be a rename, just return NULL */
> +		if (!first_slash || !second_slash || strcmp(first_slash, second_slash))
> +			goto error2;
>  	}

It should of course return "b is file"; the complex backgracking you
removed is all about handling this case correctly.

>  builtin-apply.c       |  203 +++++++++++++++----------------------------------
>  t/t4120-apply-popt.sh |    5 +-
>  2 files changed, 64 insertions(+), 144 deletions(-)

I really wished that this reduction of lines resulted in a code with less
bug, though.
