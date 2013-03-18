From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make GIT_USE_LOOKUP default?
Date: Mon, 18 Mar 2013 09:44:20 -0700
Message-ID: <7vtxo8ody3.fsf@alter.siamese.dyndns.org>
References: <CACsJy8AihriCDfN=cz7FjdHzZAhnPPGML_w8yWcVVrmTQLZyjw@mail.gmail.com>
 <7vd2uxrdh7.fsf@alter.siamese.dyndns.org>
 <20130318073229.GA5551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 18 17:44:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHdB6-0003Bl-G1
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 17:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872Ab3CRQoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 12:44:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62568 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766Ab3CRQoX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 12:44:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF2EAA999;
	Mon, 18 Mar 2013 12:44:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7R0GfVBuGhYf1QnezeJu4SjjqwM=; b=LSNv1Z
	/diOW+QWas7e3xjYPsgpx/7lrGM9TSTOc9E3bKdxwR5qbzjagWakyVAqlAsN1uge
	Aeou99rgOg/wsWrzZtY56+AJVrM/ExMK2pslrtmQ6I4dl1xM0kN/bJoXLLnCv+b9
	qR7QoBD5kFsvrjsLccpKpqHni8AXWa3R262Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qR8DeJ33h8oaT1Eher+zj1j2inqhDO5m
	Jfo8ZXfgPrEt/Ylv7IBHQoAaOh+1yJYGuFavAMY7FJkvA/7ZSDBQT2sSSqkh32fN
	KV7VJhOsQnU0kFkrj6kGQkkeksQovPGVONR0WE2Vv6359zdYPCYp7PjA9fur138n
	au7vyuk0PBs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE872A998;
	Mon, 18 Mar 2013 12:44:22 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1624BA993; Mon, 18 Mar 2013
 12:44:21 -0400 (EDT)
In-Reply-To: <20130318073229.GA5551@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 18 Mar 2013 03:32:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15E8A084-8FEB-11E2-8F2A-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218427>

Jeff King <peff@peff.net> writes:

> By the way, looking at that made me think for a few minutes about
> hashcmp, and I was surprised to find that we use an open-coded
> comparison loop. That dates back to this thread by Ingo:
>
>   http://article.gmane.org/gmane.comp.version-control.git/172286
>
> I could not replicate his benchmarks at all. In fact, my measurements
> showed a slight slowdown with 1a812f3 (hashcmp(): inline memcmp() by
> hand to optimize, 2011-04-28).
>
> Here are my best-of-five numbers for running "git rev-list --objects
> --all >/dev/null" on linux-2.6.git:
>
>   [current master, compiled with -O2]
>   real    0m45.612s
>   user    0m45.140s
>   sys     0m0.300s
> ...
>   [revert 1a812f3 (i.e., go back to memcmp), -O2]
>   real    0m44.358s
>   user    0m43.876s
>   sys     0m0.316s
> ...
> I wonder why we get such different numbers. Ingo said his tests are on a
> Nehalem CPU, as are mine (mine is an i7-840QM). I wonder if we should be
> wrapping the optimization in an #ifdef, but I'm not sure which flag we
> should be checking.

FWIW, I am getting something like this on my

$ grep 'model name' /proc/cpuinfo | uniq -c
  4 model name      : Intel(R) Core(TM)2 Quad  CPU   Q9450  @ 2.66GHz

The same "rev-list --objects --all >/dev/null", best of five:

[current master, compiled with -O2]
real    0m39.956s
user    0m39.562s
sys     0m0.396s

[revert 1a812f3 (i.e., go back to memcmp), -O2]
real    0m42.161s
user    0m41.879s
sys     0m0.284s

It could be that the difference may be how well memcmp() is
optimized, no?  My box runs Debian with libc6 2.11.3-4 and gcc
4.4.5.
