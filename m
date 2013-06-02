From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] wildmatch: properly fold case everywhere
Date: Sun, 02 Jun 2013 14:53:16 -0700
Message-ID: <7vppw4mb77.fsf@alter.siamese.dyndns.org>
References: <1369903506-72731-1-git-send-email-n.oxyde@gmail.com>
	<1369909150-73114-1-git-send-email-n.oxyde@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
	<pclouds@gmail.com>
To: Anthony Ramine <n.oxyde@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 02 23:53:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjGDT-00010K-9d
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 23:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab3FBVxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 17:53:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754017Ab3FBVxT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 17:53:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F035624EE9;
	Sun,  2 Jun 2013 21:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sBruyx92Sdm7BzOWOmMwrLd0nZY=; b=X0oIJh
	DHwZ+ENcoB/EHxy+uYFUiLDaDqmEyrFdUTjKvDPmxXGROEIUJrRuCJLFg9x6SYux
	77npj6cdzrGfOkkxAaf3JLm1rhydPWzKtI1pMCg9qTIzg9CpDMmr98d2urWjsRWh
	VOtjSKHpybZRNeBGN3Y5Kk5i2gzx/ivVaAIwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dZT7N8O7cowpXdmkplPSvLv/6nsUgUoO
	PK2v0iW/q3F+8YsgrpLzVRGqw2GYa4KLzlkkfwRd3JFepqOhi8SUVBcAnBNYTIz4
	g4MyPTedUVhb0bpbRNeACEbA5HKoQvso/qisfUaWP4xTg7S0ywwY1BeEg+J0UeuB
	xFWlWZhSoLA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6BC524EE8;
	Sun,  2 Jun 2013 21:53:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30EF124EE4;
	Sun,  2 Jun 2013 21:53:18 +0000 (UTC)
In-Reply-To: <1369909150-73114-1-git-send-email-n.oxyde@gmail.com> (Anthony
	Ramine's message of "Thu, 30 May 2013 12:19:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D59D3632-CBCE-11E2-B218-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226184>

Anthony Ramine <n.oxyde@gmail.com> writes:

> ase folding is not done correctly when matching against the [:upper:]
> character class and uppercased character ranges (e.g. A-Z).
> Specifically, an uppercase letter fails to match against any of them
> when case folding is requested because plain characters in the pattern
> and the whole string are preemptively lowercased to handle the base case
> fast.
>
> That optimization is kept and ISLOWER() is used in the [:upper:] case
> when case folding is requested, while matching against a character range
> is retried with toupper() if the character was lowercase, as the bounds
> of the range itself cannot be modified (in a case-insensitive context,
> [A-_] is not equivalent to [a-_]).
>
> Signed-off-by: Anthony Ramine <n.oxyde@gmail.com>
> Reviewed-by: Duy Nguyen <pclouds@gmail.com>
> ---

Thanks.

>  t/t3070-wildmatch.sh | 55 ++++++++++++++++++++++++++++++++++++++++++++++------
>  wildmatch.c          |  7 +++++++
>  2 files changed, 56 insertions(+), 6 deletions(-)
>
> I added Duy as reviewer and fixed a typo in the commit message reported by
> Eric Sunshine.
>
> diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
> index 4c37057..38446a0 100755
> --- a/t/t3070-wildmatch.sh
> +++ b/t/t3070-wildmatch.sh
> @@ -6,20 +6,20 @@ test_description='wildmatch tests'
>  
>  match() {
>      if [ $1 = 1 ]; then
> -	test_expect_success "wildmatch:    match '$3' '$4'" "
> +	test_expect_success "wildmatch:     match '$3' '$4'" "
>  	    test-wildmatch wildmatch '$3' '$4'
>  	"
>      else
> -	test_expect_success "wildmatch: no match '$3' '$4'" "
> +	test_expect_success "wildmatch:  no match '$3' '$4'" "
>  	    ! test-wildmatch wildmatch '$3' '$4'
>  	"
>      fi
>      if [ $2 = 1 ]; then
> -	test_expect_success "fnmatch:      match '$3' '$4'" "
> +	test_expect_success "fnmatch:       match '$3' '$4'" "
>  	    test-wildmatch fnmatch '$3' '$4'
>  	"
>      elif [ $2 = 0 ]; then
> -	test_expect_success "fnmatch:   no match '$3' '$4'" "
> +	test_expect_success "fnmatch:    no match '$3' '$4'" "
>  	    ! test-wildmatch fnmatch '$3' '$4'
>  	"
>  #    else

Is the above about aligning $3/$4 across checks of different types
(i.e. purely cosmetic)?  I am not complaining; just making sure if
there is nothing deeper going on.

It is outside the scope of this change, but the shell style of this
script (most notably use of [] instead of test) needs to be fixed
someday, preferrably soon, including the commented out else clause
at the end of the hunk.

> @@ -235,4 +247,35 @@ pathmatch 1 abcXdefXghi '*X*i'
>  pathmatch 1 ab/cXd/efXg/hi '*/*X*/*/*i'
>  pathmatch 1 ab/cXd/efXg/hi '*Xg*i'
>  
> +# Case-sensitivy features
> +match 0 x 'a' '[A-Z]'
> +match 1 x 'A' '[A-Z]'
> +match 0 x 'A' '[a-z]'
> +match 1 x 'a' '[a-z]'
> +match 0 x 'a' '[[:upper:]]'
> +match 1 x 'A' '[[:upper:]]'
> +match 0 x 'A' '[[:lower:]]'
> +match 1 x 'a' '[[:lower:]]'
> +match 0 x 'A' '[B-Za]'
> +match 1 x 'a' '[B-Za]'
> +match 0 x 'A' '[B-a]'
> +match 1 x 'a' '[B-a]'
> +match 0 x 'z' '[Z-y]'
> +match 1 x 'Z' '[Z-y]'
> +
> +imatch 1 'a' '[A-Z]'

Do we want "# Case-insensitivity features" commment here as well?

> +imatch 1 'A' '[A-Z]'
> +imatch 1 'A' '[a-z]'
> +imatch 1 'a' '[a-z]'
> +imatch 1 'a' '[[:upper:]]'
> +imatch 1 'A' '[[:upper:]]'
> +imatch 1 'A' '[[:lower:]]'
> +imatch 1 'a' '[[:lower:]]'
> +imatch 1 'A' '[B-Za]'
> +imatch 1 'a' '[B-Za]'
> +imatch 1 'A' '[B-a]'
> +imatch 1 'a' '[B-a]'
> +imatch 1 'z' '[Z-y]'
> +imatch 1 'Z' '[Z-y]'

> +
>  test_done
> diff --git a/wildmatch.c b/wildmatch.c
> index 7192bdc..f91ba99 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -196,6 +196,11 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>  					}
>  					if (t_ch <= p_ch && t_ch >= prev_ch)
>  						matched = 1;
> +					else if ((flags & WM_CASEFOLD) && ISLOWER(t_ch)) {
> +						uchar t_ch_upper = toupper(t_ch);
> +						if (t_ch_upper <= p_ch && t_ch_upper >= prev_ch)
> +							matched = 1;
> +					}
>  					p_ch = 0; /* This makes "prev_ch" get set to 0. */

Hmm, this looks somewhat strange.

 * At the beginning of the outermost "per characters in the text"
   loop, we seem to downcase t_ch when WM_CASEFOLD is set.
 * Also at the same place, we also seem to downcase p_ch under the
   same condition.

which makes me wonder why the fix is not like this:

	+	if (flags & WM_CASEFOLD) {
        +		if (ISUPPER(p_ch))
        +			p_ch = tolower(p_ch);
        +		if (prev_ch && ISUPPER(prev_ch))
        +			prev_ch = tolower(prev_ch);
	+	}
		if (t_ch <= p_ch && t_ch >= prev_ch)
			matched = 1;
		p_ch = 0; /* This sets "prev_ch" to 0 */


Ahh, OK, the "seemingly strange" construct is about handling a range
like "[Z-y]"; we do not want to upcase or downcase the p_ch/prev_ch
make the range "[z-y]" (empty) which would exclude bytes like "^",
"_" or even "Z".

And it is also OK to downcase p_ch in a single-letter case, not the
characters in a range, at the beginning of the outermost loop,
because we always compare for equality against t_ch (which is
downcased) in that case.

> @@ -245,6 +250,8 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>  					} else if (CC_EQ(s,i, "upper")) {
>  						if (ISUPPER(t_ch))
>  							matched = 1;
> +						else if ((flags & WM_CASEFOLD) && ISLOWER(t_ch))
> +							matched = 1;

This also looks somewhat strange but correct in that t_ch is already
downcased so we do not need a corresponding change for CC_EQ("lower")
codepath.

Interesting.  Will apply.

Thanks.
