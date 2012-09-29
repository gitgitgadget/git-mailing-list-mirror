From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Introduce new static function real_path_internal()
Date: Fri, 28 Sep 2012 22:40:42 -0700
Message-ID: <7vy5jtidyd.fsf@alter.siamese.dyndns.org>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
 <1348688090-13648-2-git-send-email-mhagger@alum.mit.edu>
 <7vk3vfp36g.fsf@alter.siamese.dyndns.org> <50667F7E.7040903@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 29 07:40:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THpnK-0004O5-FB
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 07:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab2I2Fkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 01:40:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58888 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968Ab2I2Fko (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 01:40:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5382F9335;
	Sat, 29 Sep 2012 01:40:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FUomP/juOGFgUJ2Nz7mCdFpQ7Sk=; b=jRRmuk
	BiGXF+gI31qUrW4kxbR1EmoaO/DD0g6fSgIvS9TDVyZVzGeRrxyWmF51KI3r9obL
	gAsMao8CJY9Z67/jtkvWmUISHz2h14RJIPF2ay3QzbhsSVeMfE3+45kE+A7DEGU3
	skW67u2eicqEt2wANfUJ6lAIQLZ8ILggqTNIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AyWAvfla5jNsNHshe+1N4eqyWXtQv9S0
	tuQM/T0H+FY1o811PI6nqXJaA3PeV/qLXRXJaKoUciOK9Ye7OJzZBVLf15evq7FS
	YHWrPtVSqBq73twCne3Cfu5wOtDwhDHVP/mWLvINZRA0gW7fQDCopFH2BNQm68Xp
	E4PSETsuwlk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41A319333;
	Sat, 29 Sep 2012 01:40:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97E319332; Sat, 29 Sep 2012
 01:40:43 -0400 (EDT)
In-Reply-To: <50667F7E.7040903@alum.mit.edu> (Michael Haggerty's message of
 "Sat, 29 Sep 2012 06:56:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35F4C124-09F8-11E2-BCF3-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206628>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> The patch makes sense, but while you are touching this code, I have
>> to wonder if there is an easy way to tell, before entering the loop,
>> if we have to chdir() around in the loop.  That would allow us to
>> hoist the getcwd() that is done only so that we can come back to
>> where we started outside the loop, making it clear why the call is
>> there, instead of cryptic "if (!*cwd &&" to ensure we do getcwd()
>> once and before doing any chdir().
>
> I don't see an easy way to predict, before entering the loop, whether
> chdir() will be needed.  For example, compare
>
>     touch filename
>     ln -s filename foo
>     ./test-path-utils real_path foo
>
> with
>
>     touch filename
>     ln -s $(pwd)/filename foo
>     ./test-path-utils real_path foo
>
> In the first case no chdir() is needed, whereas in the second case a
> chdir() is needed but only on the second loop iteration.

Thanks for an example, and it is perfectly OK if we really have to
have that "only fires once and only if needed" logic in the loop.

> All I can offer you is a palliative like the one below.

I think that is an improvement; or we could rename it not cwd[] but
some other name that includes the word "original" in it.

Thanks.

> Michael
>
> diff --git a/abspath.c b/abspath.c
> index 5748b91..40cdc46 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -35,7 +35,14 @@ static const char *real_path_internal(const char
> *path, int die_on_error)
>  {
>         static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf =
> bufs[1];
>         char *retval = NULL;
> +
> +       /*
> +        * If we have to temporarily chdir(), store the original CWD
> +        * here so that we can chdir() back to it at the end of the
> +        * function:
> +        */
>         char cwd[1024] = "";
> +
>         int buf_index = 1;
>
>         int depth = MAXDEPTH;
