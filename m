From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] refs: make rev-parse --quiet actually quiet
Date: Tue, 16 Sep 2014 11:26:06 -0700
Message-ID: <xmqqmw9z2zi9.fsf@gitster.dls.corp.google.com>
References: <1410837850-5169-1-git-send-email-davvid@gmail.com>
	<1410837850-5169-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Fabian Ruch <bafain@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 20:26:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTxSA-0001uX-M5
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 20:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbaIPS0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 14:26:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55629 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221AbaIPS0J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 14:26:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8047038A43;
	Tue, 16 Sep 2014 14:26:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WZ1NekAQi15EMUTTiTnrFOPQu1o=; b=Rtn5V/
	GrwV85eXfQ1J/6YofvB7s35SZ74ya2j348uXPlMafzszeK2nQVkJfU6rLAxBPNVv
	VKQRqpqA2/LxWFXdUqNgACVQrLkHGbAHdQQxZYbrk590qg01CyLs8U2m6KqfFeoY
	DiOurYqBwV9FH3/hE/ofh83dVaRci80V4gXY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bFTvgrAQixl2D5NdSa58FrlWQrOutI05
	mTFRNnGq3rZpluc3QbhHVC+PTdUy/T1oP4q157fFS/MZ9mMKBq7RdezBGBW495u+
	lfkiSxiqxBi8QpWlfqjlkG1IeIhsGTmPeQd+tkN54vZUVWnpKX5JCQDaBT6qtnRy
	ekpzalJTGPs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7352338A42;
	Tue, 16 Sep 2014 14:26:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D841138A41;
	Tue, 16 Sep 2014 14:26:07 -0400 (EDT)
In-Reply-To: <1410837850-5169-2-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Mon, 15 Sep 2014 20:24:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ED2CF224-3DCE-11E4-9672-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257137>

David Aguilar <davvid@gmail.com> writes:

> This patch now has the t1503 test case squashed into it.
> It was previously a separate patch, but it makes more sense
> for them to go together.

Yes.

> diff --git a/refs.c b/refs.c
> index 2ce5d69..447e339 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3108,7 +3108,7 @@ static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
>  	return 1;
>  }
>  
> -int read_ref_at(const char *refname, unsigned long at_time, int cnt,
> +int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time, int cnt,
>  		unsigned char *sha1, char **msg,
>  		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
>  {
> @@ -3126,8 +3126,12 @@ int read_ref_at(const char *refname, unsigned long at_time, int cnt,
>  
>  	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
>  
> -	if (!cb.reccnt)
> -		die("Log for %s is empty.", refname);
> +	if (!cb.reccnt) {
> +		if (flags & GET_SHA1_QUIETLY)
> +			exit(1);

Do we want 1 or 128 just like die()?

> +		else
> +			die("Log for %s is empty.", refname);
> +	}

Given that I see this behaviour:

    $ git rev-parse da/rev-parse-verify-quiet@{1}
    2892dfeec3f98f7e65a2746d271471d2c3c4af57
    $ git rev-parse da/rev-parse-verify-quiet@{10}
    fatal: Log for 'da/rev-parse-verify-quiet' only has 4 entries

and I do not see a change in this patch to touch "only has %d
entries" (found in sha1_name.c), I have to suspect that this change
is not sufficient to say "rev-parse --quiet will now be quiet".

    $ git rev-parse --quiet --verify da/rev-parse-verify-quiet@{10.years.ago}

may want to return the oldest-known value as it has always done
without giving a warning.

There probably are other cases that relate to reflogs, e.g.

    $ git rev-parse --quiet --verify @{-99999}

to ask the tip of the branch you were on 99999 "git checkout"s ago.
I think the last one does not have to be in the same commit as this
fix for "empty" and "you do not have that many" cases, though.

Thanks.
