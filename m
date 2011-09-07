From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git bisect start fails when stale bisect data is left
 behind
Date: Wed, 07 Sep 2011 03:51:22 -0700
Message-ID: <7vaaag62xh.fsf@alter.siamese.dyndns.org>
References: <CAC6WLetwT9UvBY_=Nf38hhkyU1mhmdWHWqscf3ebba1WRGS1LQ@mail.gmail.com>
 <CAP8UFD1h059dOyjszcP-qFauyho78c0RHBMQsGOPFgzZtp+7vg@mail.gmail.com>
 <7vehztaan4.fsf@alter.siamese.dyndns.org>
 <CAC6WLetO-KKkHmPHJ64rt6+BMbhUHUtNfxF3GK4obMUAuE9XXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
To: Joel Kaasinen <joel@zenrobotics.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 18:06:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1KeJ-0001oa-2J
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab1IGQGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:06:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40313 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752982Ab1IGQGj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 12:06:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BBE75644;
	Wed,  7 Sep 2011 06:51:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bGfloista5S/CcxzZQzDg2KSFGw=; b=AxHbWD
	C5+HYZ7DY3XUpXCZi0bHXgwuvDa2SJZkec0HD1umuIVhkGNHpYZF1c3+m2WlVU0R
	FT8zZ7g2k56z7DvLjTiGtU7bq58G35SHRzDW4yMS+tX8/24b1xZEzEMxZUce/c+c
	cEbTf8jlDvXfuvGjwH8m+ZwGghMaT+/seRq7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MCL+F9G6UtYZTqzJY9UhdO4fAVh0IKp/
	r9RTTaLFlLxEUjL00r1nToLwXPIkhck2/ngG0IFMQfFMvc+CRa3EkzZ3xM0RN89V
	OJpcPrLU5DDhyIFK2lK4TES7mrvks9TRYSlrPPivDG5os28RZab/7dAjhoe1nzuu
	MIR8Y0ejAmY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 813225643;
	Wed,  7 Sep 2011 06:51:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FB7A5641; Wed,  7 Sep 2011
 06:51:23 -0400 (EDT)
In-Reply-To: <CAC6WLetO-KKkHmPHJ64rt6+BMbhUHUtNfxF3GK4obMUAuE9XXQ@mail.gmail.com> (Joel
 Kaasinen's message of "Wed, 7 Sep 2011 09:28:16 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 543FE1EE-D93F-11E0-BFB8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180856>

Joel Kaasinen <joel@zenrobotics.com> writes:

> On Tue, Sep 6, 2011 at 19:38, Junio C Hamano <gitster@pobox.com> wrote:
>> I do not necessarily think this is a bug to begin with --- the user had a
>> bad state, and bisect stopped without doing further damage.
>
> Oh, actually my git-bisect man page says:
>
> """
>    Bisect reset
>        After a bisect session, to clean up the bisection state and return to
>        the original HEAD, issue the following command:
>
>            $ git bisect reset
>
>        By default, this will return your tree to the commit that was checked
>        out before git bisect start. (A new git bisect start will also do that,
>        as it cleans up the old bisection state.)
> """
>
> The parenthetical sentence seems to imply that a bisect start cleans
> out the old state. The problem is that the cleaning fails when the
> state is bad. (Try e.g. "git bisect start; git bisect start a b" where
> a and b are valid refs.)
>
> It's pretty much the same to me how this gets resolved. I'm fine with
> a more verbose error message from bisect start.

I do not think anybody minds "a more verbose" message. I do mind if the
suggestion the message makes were "wrong". That is what I was questioning.
