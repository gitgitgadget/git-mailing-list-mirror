From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git bisect start fails when stale bisect data is left
 behind
Date: Tue, 06 Sep 2011 09:38:55 -0700
Message-ID: <7vehztaan4.fsf@alter.siamese.dyndns.org>
References: <CAC6WLetwT9UvBY_=Nf38hhkyU1mhmdWHWqscf3ebba1WRGS1LQ@mail.gmail.com>
 <CAP8UFD1h059dOyjszcP-qFauyho78c0RHBMQsGOPFgzZtp+7vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Kaasinen <joel@zenrobotics.com>, git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 18:39:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0yfy-0002IE-OF
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 18:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab1IFQjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 12:39:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811Ab1IFQi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 12:38:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CABB4581;
	Tue,  6 Sep 2011 12:38:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aCTGL9JNW8SF25ozX3poVw1jxAA=; b=XYzsu2
	/OJUJ4YHb6tBUVLTjUeH94dUpDuaEcQZhd3cE71TpCC3QqVH864y3t4MWY3nCVlR
	A+k8jN16b9eaz/OYkFgeVcSjmDVjXw9Le77PWLPGUdGIm1AeYIogxXTxlbKz6BwQ
	dCXOwbmuEHPpzL6ddHMkXoOanv8BiWqWjwUtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ggfyEqoZFjxTKWCXDQsl/nRqDPuHzy0m
	2Wn3wPF/r/OLybQlDFnZyMuMqR9E9Dy1KB3cyx8CqU1wXseG7dhwsJh9NQUJmA26
	yi9ANOxwS67ea+yxcjYKafM+IGMlFDLcWyVkhQjJelQmu8AXWOS3H+z2vG6EHYZw
	yFnmmmBIqko=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02F874580;
	Tue,  6 Sep 2011 12:38:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C82B457F; Tue,  6 Sep 2011
 12:38:57 -0400 (EDT)
In-Reply-To: <CAP8UFD1h059dOyjszcP-qFauyho78c0RHBMQsGOPFgzZtp+7vg@mail.gmail.com>
 (Christian Couder's message of "Tue, 6 Sep 2011 09:48:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7616958-D8A6-11E0-A556-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180814>

Christian Couder <christian.couder@gmail.com> writes:

>> How to reproduce:
>> $ echo foo > .git/BISECT_START
>> $ git bisect start HEAD HEAD^
>>
>> Fails with "fatal: invalid reference:" on git 1.7.6.
>
> Yeah, it looks like a very old behavior.
> I'd suggest a simple improvement in the error message like this:
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index c21e33c..bd7155b 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -67,7 +67,8 @@ bisect_start() {
>         then
>                 # Reset to the rev from where we started.
>                 start_head=$(cat "$GIT_DIR/BISECT_START")
> -               git checkout "$start_head" -- || exit
> +               git checkout "$start_head" -- ||
> +               die "Could not checkout previous start point
> '$start_head'. Try 'git bisect reset <branch>' first."

I do not necessarily think this is a bug to begin with --- the user had a
bad state, and bisect stopped without doing further damage.

The real question is what the sensible suggestion/advice the new message
should give. It would have to involve bisect reset in the end to get rid
of the stale bisect state, but wouldn't the user potentially lose some
other state if s/he blindly followed the die message's suggestion and ran
"bisect reset"?
