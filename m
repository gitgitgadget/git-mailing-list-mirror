From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_name: try to use same abbrev length when
 core.abbrevguard is specified
Date: Wed, 09 Mar 2011 11:12:00 -0800
Message-ID: <7vipvsaz27.fsf@alter.siamese.dyndns.org>
References: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 20:12:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxOny-0004B7-W3
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 20:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977Ab1CITMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 14:12:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab1CITMM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 14:12:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29C3E3365;
	Wed,  9 Mar 2011 14:13:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MRiBIhKzq0wkmbLrxdHx88uNsx8=; b=QPx227
	pyCI9Xtn0UlLRKRHPRGufOHvLuXwDlS9qVSyjuHDbhcsM7xlKWU4gwl4KHvVJzok
	BylsQ4LkWDhT4vWb/n36rdfTa+U+85rOR2htkEmmDkw5DND37x4EJvcPYQgKgSeF
	P92euEFY9XlIX89qyNoqVbAfYRiw95zK3d7PA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NLO7ilKmuyayczDL4/eAglz9aIMazo41
	JQ+V+H0JU6kT2BQOYlnpxZ+kVq4nkd84H4I3yAJwsDWsa2ngvKPugrEheYtUrTFD
	quEDWT8IlBknA+6DVAwvNqAwGnM0lT2CkCmioyNi3Xtz0/p/zmX1rGOhZJKXBP4t
	axekI/JytD4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0750C3363;
	Wed,  9 Mar 2011 14:13:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C83013361; Wed,  9 Mar 2011
 14:13:30 -0500 (EST)
In-Reply-To: <1299581951-4670-1-git-send-email-namhyung@gmail.com> (Namhyung
 Kim's message of "Tue, 8 Mar 2011 19:59:10 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5477D98E-4A81-11E0-8F35-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168744>

Namhyung Kim <namhyung@gmail.com> writes:

> If find_unique_abbrev() finds a ambiguous SHA1 name, it tries
> to find again with increased length. In this case, result hex
> strings could have different lengths even though the
> core.abbrevguard config option is specified. But if the option
> is specified and increased length (delta) is less than its
> value, the result could be adjusted to the same length.

I am not sure if I can understand what problem you are trying to solve
from the above description.

The function is given "len" from the caller to specify the minimum length
of the output the caller expects (i.e. even if 4 hexdigits is enough to
identify the given commit in a small project, the caller can say it wants
to see at least 7 hexdigits).  The loop without your patch finds the
shortest prefix whose length is at least that given length that uniquely
identifies the given object (or the shortest prefix that doesn't identify
any existing object if the given sha1 does not exist in the repository).
And then ensures the returned value is longer by the guard as an extra
safety measure, so that later when the project grows, the disambiguation
we find today has a better chance to survive.

With this patch, the loop decreases the length of the guard when "len"
given by the caller is insufficient to ensure uniqueness, which does not
sound right.

Suppose the given object has ambiguous other objects and you need 8
hexdigits at least to make it unique in today's history.  The caller gives
you len of 7, and the guard is set to 3.

With the original code, the loop starts with 7, finds that it is not
long enough to disambiguate, increments and retries, finds that 8 is the
shortest prefix, and then adds the guard and returns 11 hexdigits.

With your patch, the loop starts with 7 with extra set to 3, finds that 7
is not long enough and decrements extra to 2, finds that 8 is the shortest
prefix, and then returns only 10 hexdigits.

Which feels like totally going against the reason why we added the guard.

What am I missing?

>  sha1_name.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 709ff2e..6bb8942 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -197,6 +197,7 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
>  {
>  	int status, exists;
>  	static char hex[41];
> +	int extra_len = unique_abbrev_extra_length;
>  
>  	exists = has_sha1_file(sha1);
>  	memcpy(hex, sha1_to_hex(sha1), 40);
> @@ -208,12 +209,14 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
>  		if (exists
>  		    ? !status
>  		    : status == SHORT_NAME_NOT_FOUND) {
> -			int cut_at = len + unique_abbrev_extra_length;
> +			int cut_at = len + extra_len;
>  			cut_at = (cut_at < 40) ? cut_at : 40;
>  			hex[cut_at] = 0;
>  			return hex;
>  		}
>  		len++;
> +		if (extra_len > 0)
> +			extra_len--;
>  	}
>  	return hex;
>  }
