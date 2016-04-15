From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/21] bisect: introduce distance_direction()
Date: Fri, 15 Apr 2016 15:10:39 -0700
Message-ID: <xmqqbn5a8qw0.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-16-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:10:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBwy-0003SU-7p
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbcDOWKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:10:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52909 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751386AbcDOWKr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:10:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 89A5D13FC5;
	Fri, 15 Apr 2016 18:10:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=naJLdo0SFRmRg8eXVUQvtXqBUTU=; b=MmzzP6
	rbPol4x+INSG2ZR9sI2AY1ESgd5MjwqrT8mL9lWIjV6HeG54nFWZGznTe3vbrUvg
	7u/M0ipCRL5gX8M5l+peohbi+KwaWxHmboVW1GWUkQ9onnaZDEoWWm8WPpn7lS1I
	CN1f7TW/E+zB3V6cj6+56cKCIWz4fnBQIcnAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yDK2fajgAJCW19sZoQR5phHqh9i7kZhT
	kS93CrQHmNy7EpbpcRyg6/3PheRjvWLGyQYLbHL6m+KVNz6bSMUC6NhBFlQemqJn
	Am3alnim/Nca8A/JDP7x4JuXaskgFYdKkZxlRPRbvIWuTIq6DkYv0nz7VR1Z8fr3
	4zlXSD1XUE0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8235713FC4;
	Fri, 15 Apr 2016 18:10:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E7EE213FC3;
	Fri, 15 Apr 2016 18:10:40 -0400 (EDT)
In-Reply-To: <1460294354-7031-16-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E40EDDD4-0356-11E6-80BF-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291680>

Stephan Beyer <s-beyer@gmx.net> writes:

> We introduce the concept of rising and falling distances
> (in addition to a halfway distance).
> This will be useful in subsequent commits.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>  bisect.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index cfd406c..f737ce7 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -46,6 +46,28 @@ static inline int get_distance(struct commit *commit, int total)
>  	return distance;
>  }
>  
> +/*
> + * Return -1 if the distance is falling.
> + * (A falling distance means that the distance of the
> + *  given commit is larger than the distance of its
> + *  child commits.)
> + * Return 0 if the distance is halfway.
> + * Return 1 if the distance is rising.
> + */
> +static inline int distance_direction(struct commit *commit, int total)
> +{
> +	int doubled_diff = 2 * node_data(commit)->weight - total;
> +	if (doubled_diff < -1)
> +		return 1;
> +	if (doubled_diff > 1)
> +		return -1;
> +	/*
> +	 * 2 and 3 are halfway of 5.
> +	 * 3 is halfway of 6 but 2 and 4 are not.
> +	 */
> +	return 0;
> +}

Nice.  This makes it clear that to arrive at a half-way point, it is
pointless to dig a commit to its parents if the direction says it
will only take us further away from the half-way point.

>  static int count_distance(struct commit *elem)
>  {
>  	int nr = 0;
> @@ -92,16 +114,7 @@ static inline int halfway(struct commit *commit, int nr)
>  	 */
>  	if (commit->object.flags & TREESAME)
>  		return 0;
> -	/*
> -	 * 2 and 3 are halfway of 5.
> -	 * 3 is halfway of 6 but 2 and 4 are not.
> -	 */
> -	switch (2 * node_data(commit)->weight - nr) {
> -	case -1: case 0: case 1:
> -		return 1;
> -	default:
> -		return 0;
> -	}
> +	return !distance_direction(commit, nr);
>  }
>  
>  #if !DEBUG_BISECT
