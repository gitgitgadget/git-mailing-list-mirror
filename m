From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 1/2] refs.c: optimize check_refname_component()
Date: Sun, 01 Jun 2014 22:50:27 +0200
Message-ID: <538B9213.2020205@alum.mit.edu>
References: <1401599865-14117-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 22:50:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrCiB-0001Fv-6z
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 22:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbaFAUub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 16:50:31 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62520 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751847AbaFAUua (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jun 2014 16:50:30 -0400
X-AuditID: 12074413-f79bc6d000000b9e-22-538b92155bf4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id D3.5D.02974.5129B835; Sun,  1 Jun 2014 16:50:29 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E55.dip0.t-ipconnect.de [79.201.110.85])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s51KoR2v005258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 1 Jun 2014 16:50:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1401599865-14117-1-git-send-email-dturner@twitter.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqCs6qTvYYOJeXYsPV54zWszfdILR
	outKN5NFQ+8VZgcWj4uXlD0udj9h9ljw/D67x+dNcgEsUdw2SYklZcGZ6Xn6dgncGV23NrMV
	7JKv+HXvGFMD4w7xLkZODgkBE4kjV9+zQdhiEhfurQeyuTiEBC4zSkzbtZ8ZwjnHJNG0ZyU7
	SBWvgLbEksYLYDaLgKrEh8/zWUBsNgFdiUU9zUxdjBwcogJBEn/OKkKUC0qcnPmEBSQsIpAr
	8XxtMUiYWUBNovvkRLApwgJuEl8eL2cGsYUEnCXuTJ/GCGJzCrhInH20GGyihIC4RE9jEESr
	jsS7vgfMELa8xPa3c5gnMArOQrJsFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3S
	NdfLzSzRS00p3cQICXHhHYy7TsodYhTgYFTi4a1w6AoWYk0sK67MPcQoycGkJMq7uL87WIgv
	KT+lMiOxOCO+qDQntfgQowQHs5IIL0cPUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1
	tSC1CCYrw8GhJMGbOhGoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UvfHFwPgF
	SfEA7dUEaectLkjMBYpCtJ5iVJQS5707ASghAJLIKM2DGwtLXK8YxYG+FOa1BGnnASY9uO5X
	QIOZgAa/reoEGVySiJCSamBcMvXpzlPGS88u+C/IHvbK+Ml9ywyjrqpDpWzaikcDL7Y/ebSU
	TStGbmL4kSBV/w/NpVl7rrQVizAXOPns6I01f5K9IE+QUV9JTW3x8f3Prv6J/Lot 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250546>

Thanks for splitting this up into two patches.  See my comments below.

On 06/01/2014 07:17 AM, David Turner wrote:
> In a repository with many refs, check_refname_component can be a major
> contributor to the runtime of some git commands. One such command is
> 
> git rev-parse HEAD
> 
> Timings for one particular repo, with about 60k refs, almost all
> packed, are:
> 
> Old: 35 ms
> New: 29 ms
> 
> Many other commands which read refs are also sped up.
> 
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  refs.c | 68 ++++++++++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 41 insertions(+), 27 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 28d5eca..62e2301 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -5,9 +5,32 @@
>  #include "dir.h"
>  #include "string-list.h"
>  
> +/* How to handle various characters in refnames:

We format multiline comments with no text on the opening line:

/*
 * How to handle...
 * ... is derived.
 */

> + * 0: An acceptable character for refs
> + * 1: End-of-component
> + * 2: ., look for a following . to reject .. in refs
> + * 3: @, look for a following { to reject @{ in refs
> + * 9: A bad character, reject ref

This explanation does not agree with the code (or I'm not reading it
correctly).  For example, the character with disposition 3 is '{', not
'@', so ISTM the comment should be

     * 3: {, look for a preceding @ to reject @{ in refnames

BTW, is there a special reason that the values in your table jump from 3
to 9?  I imagine that compilers would use a jump table to implement the
"switch" statement where these values are used, and they might have a
slightly easier time if there are no "holes" between the legal values.

> + *
> + * See below for the list of illegal characters, from which
> + * this table is derived.
> + */
> +static unsigned char refname_disposition[] = {

I think you need to define the length explicitly to 256 here to cause
the entries for 0x80..0xff to be created and initialized to zeros.

The fact that you didn't notice this bug suggests that there might be no
tests involving refnames with non-ASCII characters, which would be
another nice thing to remedy while you are working in this area.

> +	1, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> +	9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> +	9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 2, 1,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 9,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 9, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 9, 9
> +};
> +
>  /*
> - * Make sure "ref" is something reasonable to have under ".git/refs/";
> - * We do not like it if:
> + * Try to read one refname component from the front of refname.
> + * Return the length of the component found, or -1 if the component is
> + * not legal.  It is legal if it is something reasonable to have under
> + * ".git/refs/"; We do not like it if:
>   *
>   * - any path component of it begins with ".", or
>   * - it has double dots "..", or
> @@ -15,24 +38,7 @@
>   * - it ends with a "/".
>   * - it ends with ".lock"
>   * - it contains a "\" (backslash)
> - */
>  

^^^ doesn't this leave a blank line inside the comment?

> -/* Return true iff ch is not allowed in reference names. */
> -static inline int bad_ref_char(int ch)
> -{
> -	if (((unsigned) ch) <= ' ' || ch == 0x7f ||
> -	    ch == '~' || ch == '^' || ch == ':' || ch == '\\')
> -		return 1;
> -	/* 2.13 Pattern Matching Notation */
> -	if (ch == '*' || ch == '?' || ch == '[') /* Unsupported */
> -		return 1;
> -	return 0;
> -}
> -
> -/*
> - * Try to read one refname component from the front of refname.  Return
> - * the length of the component found, or -1 if the component is not
> - * legal.
>   */
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
