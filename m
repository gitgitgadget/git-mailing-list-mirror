From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Thu, 02 Jan 2014 13:08:55 -0800
Message-ID: <xmqqha9mozvc.fsf@gitster.dls.corp.google.com>
References: <52C5A039.6030408@gmail.com>
	<alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
	<xmqqtxdmp39a.fsf@gitster.dls.corp.google.com>
	<52C5D0AB.7050309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 22:09:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VypWB-0001xN-4e
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 22:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbaABVJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 16:09:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56851 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012AbaABVI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 16:08:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B8F25FF41;
	Thu,  2 Jan 2014 16:08:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9oiVQqu0UZCYpQq18E8iviCF8T8=; b=SUVDht
	4b1oH30e8ihytcyquvPcdt6XNH6j9lFTO/1y1K9aN+UVWP1MmAgqgvWtC+v9ReaD
	s7usA/1x96gsPRH9Y4VouV17BZ3p9nVgeSqvQKGxloGUwosbMOLJsAqISVsH8TJ+
	TlRxdiZLgXcr15eZhZLoJkdVUBaD1hABezSU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xaxMA/MG4YvMpthepBE5FWZULMOstm8c
	x+kw9qsqovPbyY3HydERdYs1La3TWWcGaF3zO5x6C6h74PK29ebZiMGQIIgLLYJC
	ZEFOaoJZUYNxjaiUdTDGpUVkIIob7YtbCrxqRqW1yeH5XOO1Hc0BHyFmR1qFv1NO
	216hshJK3u4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE3A45FF3F;
	Thu,  2 Jan 2014 16:08:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C5845FF3E;
	Thu,  2 Jan 2014 16:08:58 -0500 (EST)
In-Reply-To: <52C5D0AB.7050309@gmail.com> (Sebastian Schuberth's message of
	"Thu, 02 Jan 2014 21:48:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 18854144-73F2-11E3-82C4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239881>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On 02.01.2014 20:55, Junio C Hamano wrote:
>
>> Thanks; the conclusion is correct --- you need a good commit
>> message in the recorded history.  That does not have anything to do
>> with integrating with pulling from subsystem maintainers, which we
>> regularly do.
>
> I'll send a v2 which adds a proper commits message inline.
>
>> Perhaps with s|Linux|POSIX|, but more importantly, was there a
>> specific error scenario that triggered this change?
>
> Yes, cloning to a non-existent directory with Windows paths fails like:
>
> fatal: could not create work tree dir 'c:\foo\bar'.: No such file or directory

OK.  That was why I wanted to see (and Dscho correctly guessed) a
good description in the proposed log message to see what problem the
change is trying to address, so that we can judge if the change is
tackling the right problem.

> Seems like the path to clone to is taken as-is from argv in
> cmd_clone(). So maybe another solution would be to replace all
> backslashes with forward slashes already there?

That sounds like a workable alternative, and it might even be a
preferable solution but if and only if clone's use of the function
to create paths that lead to a new working tree location is the only
(ab)use of the function.  That was what I meant when I said "it may
be that it is a bug in the specific caller".  AFAIK, the function
was meant to be used only on paths we internally generate, and the
paths we internally generate all are slash separated, in line with
how paths are stored in the index.

If we are going to change the meaning of the function so that it can
now take any random path in platform-specific convention that may be
incompatible with the internal notion of paths Git has (i.e. what is
passed to safe_create_leading_directories() may have to be massaged
into a slash-separated form before it can be used in the index and
parsed to be stuffed into trees), it is fine to do so as long as all
the codepaths understands the new world order, but my earlier "git
grep" hits did not tell me that such a change is warranted.

Thanks.
