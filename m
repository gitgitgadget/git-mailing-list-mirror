From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable parallelism in git submodule update.
Date: Fri, 27 Jul 2012 16:25:58 -0700
Message-ID: <7vk3xoyeex.fsf@alter.siamese.dyndns.org>
References: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com>
 <7vwr1ozxz5.fsf@alter.siamese.dyndns.org>
 <CAHOQ7J_jYAe7r1q6Cg9OJb8f+79UfS=JfRk9NrS4R4a+oLM8LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 01:26:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SutvA-0008Rw-TR
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 01:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab2G0X0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 19:26:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41813 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358Ab2G0X0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 19:26:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BC26814E;
	Fri, 27 Jul 2012 19:26:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/psj9LfUNzvUddJSD1L2qMS+ky4=; b=SKpNvA
	tmP9j5sNXdATdg5SkddBfN6j7HyifFCROJuy5xSQETkb9bwkVMFu0YsawQGs0ZWs
	cK/9bQbRLgO+wMZDsJefXxjAdjr/cWD47TvHK2ACa5Ah6WuaDj3qBQYhqYpY4+Ln
	tibMpI/K7cDy6urOH9ubhHnyNGpOEB2sFYZxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xAgLka9Yzisj9i29mCIIMmK4cd6UJZz1
	BTl+pWOORSD2fjcdqBXkXyqNE2tubyOTHOKOOi0E1UcPgnDSpZFFq0sez1k8FNul
	NN0fjEudsz8TrE57WBFjYa182C+gASEIeHF7niYQyZBRdCamnHor/vKyBzwG8XPK
	f3uDGH5GcNQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDD70814B;
	Fri, 27 Jul 2012 19:26:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F7958149; Fri, 27 Jul 2012
 19:25:59 -0400 (EDT)
In-Reply-To: <CAHOQ7J_jYAe7r1q6Cg9OJb8f+79UfS=JfRk9NrS4R4a+oLM8LA@mail.gmail.com> (Stefan
 Zager's message of "Fri, 27 Jul 2012 14:54:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6CAFCD0E-D842-11E1-8373-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202394>

Stefan Zager <szager@google.com> writes:

> On Fri, Jul 27, 2012 at 2:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Stefan Zager <szager@google.com> writes:
>>
>> > +             module_list "$@" | awk '{print $4}' | xargs -L 1 -P
>> "$jobs" git submodule update $orig_args
>>
>> Capital-P option to xargs is not even in POSIX, no?
>
> I wasn't aware of that, but you appear to be correct.  Don't know if you
> have a policy about that, but anecdotally, -P is supported on my linux,
> mac, and win/msys systems.

About "policy", we use POSIX as a rough yardstick to warn us that we
might be breaking people on minority platforms.  We do _not_ say "It
is in POSIX, so it is safe to use it", but we say "It is not even in
POSIX, so we need to think twice."  We do not usually say "Linux,
Mac and Windows are the only things that matter, and they all
support it."

Of course, any set of rules have exceptions ;-) There are a few
things to which we say "Even though it is not in POSIX, everybody
who matters supports it, and without taking advantage of it, what we
want to achieve will become too cumbersome to express".

In the core parts of the system, we try to be very conservative. In
the fringe where nobody cares about, we tend to be looser.
