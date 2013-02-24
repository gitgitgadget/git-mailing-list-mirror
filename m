From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: Fix rename pretty-print when suffix and prefix
 overlap
Date: Sun, 24 Feb 2013 01:15:50 -0800
Message-ID: <7vzjyu3we1.fsf@alter.siamese.dyndns.org>
References: <1361638125-11245-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 10:16:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Xgy-0000ID-5U
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 10:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab3BXJPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 04:15:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755448Ab3BXJPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 04:15:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C675A412;
	Sun, 24 Feb 2013 04:15:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Vi1rUp3NbiGoJjWqWA3CTFV/O9g=; b=nfTnbRbiBUvYmtbuFbEB
	4U4NimoOVy3yKcdPtYlQ68p80b4gRyS9ubYAeLikkdh32LwwjqHfzsEnHnlT5/cU
	aZzuu5HTHVw1HYXfiOE7gidYpxyoJVPAOP7gPrQnQENrHQo4lX+CUJtDPAOIcSy6
	S4ATXQO7XeUdZGdTANyNt+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=phEVGRqsah7TpiZdrK7gxeSExayrWNq2h9V+QWnMR0IwxM
	VRQWLVZTc2zpjd/xWzTHaP1uJY1OX/xKMh0FPyxBMMFYcRLvSNvJee+iDBfzPji8
	B1kBInE34AHGfeK0KLknWZrKayI7B6OgSQrGBHPhP63uyBqsyqB1Kwfv1uzic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20A15A40F;
	Sun, 24 Feb 2013 04:15:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79E37A40D; Sun, 24 Feb 2013
 04:15:51 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8C93C6C-7E62-11E2-8395-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216985>

Antoine Pelisse <apelisse@gmail.com> writes:

> When considering a rename for two files that have a suffix and a prefix
> that can overlap, a confusing line is shown. As an example, renaming
> "a/b/b/c" to "a/b/c" shows "a/b/{ => }/b/c".

This would be vastly more readable if it had "It should show XXX
instead" somewhere in the description, perhaps at the end of this
sentence.  It can also be after "thus the { => }" below, but I think
giving the expected output earlier would be more appropriate.

> Currently, what we do is calculate the common prefix ("a/b/"), and the
> common suffix ("/b/c"), but the same "/b/" is actually counted both in
> prefix and suffix. Then when calculating the size of the non-common part,
> we end-up with a negative value which is reset to 0, thus the "{ => }".

In this example, the common prefix would be "a/b/" and the common
suffix that does not overlap with the prefix part would be "/c", so
I am imagining that "a/b/{ => b}/c" would be the desired output?

This is a really old thinko (dating back to June 2005).  I'll queue
the patch on maint-1.7.6 (because 1.7.6.6 is slightly more than one
year old while 1.7.5.4 is a lot older) to allow distros that issue
incremental fixes on top of ancient versions of Git to pick up the
fix if they wanted to.  Perhaps we would want to add a few tests?

Thanks.

>
> Do not allow the common suffix to overlap the common prefix and stop
> when reaching a "/" that would be in both.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
>  diff.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index 156fec4..80f4752 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1290,7 +1290,16 @@ static char *pprint_rename(const char *a, const char *b)
>  	old = a + len_a;
>  	new = b + len_b;
>  	sfx_length = 0;
> -	while (a <= old && b <= new && *old == *new) {
> +	/*
> +	 * Note:
> +	 * if pfx_length is 0, old/new will never reach a - 1 because it
> +	 * would mean the whole string is common suffix. But then, the
> +	 * whole string would also be a common prefix, and we would not
> +	 * have pfx_length equals 0.
> +	 */
> +	while (a + pfx_length - 1 <= old &&
> +	       b + pfx_length - 1 <= new &&
> +	       *old == *new) {
>  		if (*old == '/')
>  			sfx_length = len_a - (old - a);
>  		old--;
> --
> 1.7.9.5
