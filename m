From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] Patches created with 'diff.noprefix=true' don't 'git apply'.
Date: Tue, 06 May 2014 14:12:52 -0700
Message-ID: <xmqqbnvaehm3.fsf@gitster.dls.corp.google.com>
References: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
	<20140501024042.GX9218@google.com>
	<CAO8RVveV4SgXmJzWpYnyB3rnQALQkrrLNtLL5Ej5Y9Mjjekmmw@mail.gmail.com>
	<xmqqa9aug4my.fsf@gitster.dls.corp.google.com>
	<CAO8RVvfHVBG6QZ5M1DJK4kOX8GMDrvEw4_L=LsEc4G6E0pP7ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nathan Collins <nathan.collins@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 23:13:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whmfc-0007qk-Qh
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 23:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbaEFVM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 17:12:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50384 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbaEFVM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 17:12:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21CED15842;
	Tue,  6 May 2014 17:12:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z8t0FsyRdmdXT40DKVpdQQ8Isog=; b=BRiA60
	Tf89/82ivftJEcSW6S0nT3P7zMi1I6hOCX5SRWHw9WbHiScxU3ZflgYISOKambcS
	OlGJfckxVouNzqhFltJInFieytEE0Rgzfd0GbJMfHFmIs81KViLNrjAHujbcrWJZ
	bjlX/PBIhdUBMjY9APKav4M9W+MpjYhMek6Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iGcG++NxsC3wwQ4q0qiQVVw8SHl0+L1t
	3TyOmZqzjKyVdFY8dikjl/vzshMJ0BcDAF39PhxU3WH99g7Vf1JTYHPyJp/4j2bx
	MeTHtqqdk/EfAd4a2dklB+vNnuBD3ornvqCDUHFrI5cdDRk6jL8L84SlP2tCAT6d
	8+7PGK354lc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1545315841;
	Tue,  6 May 2014 17:12:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B19CC1583D;
	Tue,  6 May 2014 17:12:53 -0400 (EDT)
In-Reply-To: <CAO8RVvfHVBG6QZ5M1DJK4kOX8GMDrvEw4_L=LsEc4G6E0pP7ug@mail.gmail.com>
	(Nathan Collins's message of "Tue, 6 May 2014 12:36:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 302459E8-D563-11E3-9251-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248253>

Nathan Collins <nathan.collins@gmail.com> writes:

> But 'git apply' could be much more helpful than 'patch' even, since
> the presence or absence of the 'a/' and 'b/' prefixes in the patch,
> and the 'diff.noprefix' setting, give Git enough info to be very
> helpful to the user.

The prefix would be unreliable as the generator may be using the
mnemonicprefix option to use i/ and w/ prefixes.  Worse yet, the
configuration variables are for people who generated the diff you
are feeding "git apply", and there is nothing that tells "apply"
that the patch is generated with _your_ setting.

So that is not workable.

However, Before issuing this error message

>   git -c diff.noprefix=true diff HEAD~ | git apply --reverse
>   error: Data/Function/Decorator/Memoizer/Unsafe.hs: No such file or directory

we _could_ check that there is Data/ directory in the target tree
the patch is being applied and suggest to:

 * "use -p0", if noprefix, which I agree with Jonathan is an insane
   thing to use by default, is common enough; or

 * "use different setting for -p$n", if noprefix is not common.

in the error message.  Extra computation necessary to do so would
happen only in the error codepath, and we wouldn't mind spending
some cycles if they help the end user.
