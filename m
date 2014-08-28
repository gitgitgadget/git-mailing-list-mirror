From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] Use timer_settime for new platforms
Date: Thu, 28 Aug 2014 12:43:03 -0700
Message-ID: <xmqq61hc9z94.fsf@gitster.dls.corp.google.com>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
	<1409187862-21257-10-git-send-email-sortie@maxsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas 'Sortie' Termansen <sortie@maxsi.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:43:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN5bS-0002Dg-S1
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 21:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbaH1TnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 15:43:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50397 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbaH1TnR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 15:43:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6214635262;
	Thu, 28 Aug 2014 15:43:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WxSCTuzjym659nh2rN0gOqaO+CI=; b=OCHhoO
	X0zOPGzAMxmssFpXuIbs/qexbysst8bBPz/yWurXHF2693Y+Kx0QRfRqVwuGZnc/
	OnMDV8bsrsfiIFNghOU6XIfBIFXzosR1L/wjwmbCBNQEsNRFwPMUQ3TJh/QZR4Hw
	GOE01UhA+lEohORuPz6DYLOqSdzQgHYirmgBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i0/e40tTfkVE+v1mb29X97xMT8mKAjEg
	XmKpuome/MNB9WpB+2qE8nnneO4RGjjV/tBCwge1LBI7XOcUNlX43MPqGfRdmY/+
	o2fEeYFOvCvAf+h3Se5zk5x6HBJjvT6mmsgWhLvIv0u+MlyGSOhSgvhvzKECoK3N
	Go2jEO3WPYg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 57E383525F;
	Thu, 28 Aug 2014 15:43:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 63A923524D;
	Thu, 28 Aug 2014 15:43:05 -0400 (EDT)
In-Reply-To: <1409187862-21257-10-git-send-email-sortie@maxsi.org> (Jonas
	Termansen's message of "Thu, 28 Aug 2014 03:04:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 878B1C62-2EEB-11E4-9B4F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256119>

Jonas 'Sortie' Termansen <sortie@maxsi.org> writes:

> setitimer() is an obsolescent XSI interface and may be removed in a
> future standard. Applications should use the core POSIX timer_settime()
> instead.
>
> This patch cleans up the progress reporting and changes it to try using
> timer_settime, or if that fails, setitimer. If either function is not
> provided by the system, then git-compat-util.h provides replacements
> that always fail with ENOSYS.
>
> It's important that code doesn't simply check if timer_settime is
> available as it can give false positives. Some systems like contemporary
> OpenBSD provides the function, but it unconditionally fails with ENOSYS
> at runtime.
>
> This approach allows the code using timer_settime() and setitimer() to
> be simple and readable. My first attempt used #ifdef around each use of
> timer_settime(), this quickly turned a into unmaintainable maze of
> preprocessor conditionals.
>
> Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
> ---
>  builtin/log.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
>  progress.c    | 34 +++++++++++++++++++++++++++-------
>  2 files changed, 67 insertions(+), 14 deletions(-)

Yuck.  I didn't look at the change very carefully, but are the two
interface so vastly different that you cannot emulate one in terms
of the other, and use a single API at the callsites, isolating the
knowledge of which kind of API is used to interact with the system
timer in one place (perhaps in compat/itimer.c)?

Having to sprinkle "if (is_using_timer_settime)" around means we
need to support two APIs at each and every callsite that wants timer
interrupt actions.
