From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rebase performance
Date: Wed, 24 Feb 2016 19:02:00 -0800
Message-ID: <xmqqvb5dpk5z.fsf@gitster.mtv.corp.google.com>
References: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
	<CACsJy8DZOv2Z2hiUmRKHr_GCjsyVz9kQEE8a1F=h6Ku0Dr9g_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 04:24:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYmXN-0005Dp-5K
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 04:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758231AbcBYDYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 22:24:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759527AbcBYDCD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 22:02:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 742F947E86;
	Wed, 24 Feb 2016 22:02:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=//qgagjpVGA412D/TkEC+exVFbs=; b=QFveat
	zUuDJAOiIjF9O2qMYTDG94AeY7EuzWI9gYNUqPI7SeKLSpkSagHNVQYsI/mnxhRH
	uCiYxOzj2A6KIWQOc6BgJvDontpYLKyDDF26oo0MCVaBQKBLqeq8NJXjJ87/j21e
	NqmEUNNzXWJBsDyAGEOsieAW7+GGByg8t4Rss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E4R6AK8t7EPRBfAztQSp454JDdA6u3UP
	W3LzsR87MLCGBLY0Ja/RLKRjPoBgDcIqR2sJ7SOw0N1Ix1xRzsHDslG7oDbGnwmg
	W/FRqxJFgbdVv7uxQ8nTE39Ylveggzp+8aMXdhvEWTUY+Bp36oB1G1azYz5MbHAe
	ua83bS1OVM4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C00D47E85;
	Wed, 24 Feb 2016 22:02:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CBE5F47E83;
	Wed, 24 Feb 2016 22:02:01 -0500 (EST)
In-Reply-To: <CACsJy8DZOv2Z2hiUmRKHr_GCjsyVz9kQEE8a1F=h6Ku0Dr9g_w@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 25 Feb 2016 07:50:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2474D4C2-DB6C-11E5-AE5E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287329>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Feb 25, 2016 at 5:09 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Another possibility would be to libify the "git apply" functionality
>> and then to use the libified "git apply" in run_apply() instead of
>> launching a separate "git apply" process. One benefit from this is
>> that we could probably get rid of the read_cache_from() call at the
>> end of run_apply() and this would likely further speed up things. Also
>> avoiding to launch separate processes might be a win especially on
>> Windows.
>
> The amount of global variables in apply.c is just scary. Libification
> will need some cleanup first (i'm not against it though).

The global variables do not scare me.  You can just throw them into
a single "apply_state" structure and pass it around the callchain
just fine--the helper functions in the file all take only a small
number of parameters, and a new parameter that is a pointer to the
state structure that consistently comes at the beginning would not
make things harder to read or maintain.

What does scare me (and what you should be scared) more is the way
the current code handles erroneous input.  It was one of the
programs written in early days with "just do one thing well and
exit, the larger program structure will be scripted around us"
mentality and liberally die() without cleaning things up.  I do
agree with others that libification of it is a very good thing, but
the second step (the first step is the easier "global to state
structure" one, which should be more or less mechanical) towards it
is to design how the errors are handled and resources are released.
