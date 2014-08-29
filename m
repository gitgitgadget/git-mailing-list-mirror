From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] Use timer_settime for new platforms
Date: Fri, 29 Aug 2014 11:02:18 -0700
Message-ID: <xmqqd2bj6uol.fsf@gitster.dls.corp.google.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
	<1409330561-11806-9-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 20:02:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNQVT-0001x9-E2
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 20:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbaH2SCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 14:02:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53660 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbaH2SCe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 14:02:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BCC9233E65;
	Fri, 29 Aug 2014 14:02:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HVocS7RdrQlVACoJmglNx4PkBcw=; b=J4OdqI
	UXTvXpVA+FL+k/9T7hKOmzsBzdoO2WttYfHP4NvDpiST8tlTQFrjXeO9VyPolXvb
	6dfaNdBDstq6uYjwLHNl6bUMtbPUJwEKX2WoTvjIrgOMP9t3AYbZ6quiSZvWwQOO
	FuWrz7SD7323yND3NjSEcQ4t8nmp1SEIsT8qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w3cE6V31ln+4Z07iJvPFAH/HTaxLHGim
	goTqebWL7wqTRnjRcbvV57n10fUyNMK7KrjUhRYzQV9lYGCirmO1GZ5bT5FazzTo
	Af6QvmP2tp97FqEdbPr8DxzB4Lh3wC7lENDSzrl93UIq7AQz592FpSDqRM1QtOBK
	lZ6RbtFiMRg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B1EA933E64;
	Fri, 29 Aug 2014 14:02:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7048933E5E;
	Fri, 29 Aug 2014 14:02:20 -0400 (EDT)
In-Reply-To: <1409330561-11806-9-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Fri, 29 Aug 2014 09:42:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9EE337A8-2FA6-11E4-BCD5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256170>

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
>
> setitimer() is an obsolescent XSI interface and may be removed in a
> future standard. Applications should use the core POSIX timer_settime()
> instead.
>
> It's important that code doesn't simply check if timer_settime is
> available as it can give false positives. Some systems like contemporary
> OpenBSD provides the function, but it unconditionally fails with ENOSYS
> at runtime.

Doesn't this paragraph need tweaking?  I think you lost (which is a
good thing) "notice that timer_settime() call failed with ENOSYS and
switch to setitimer()", no?

> Clean up the progress reporting and change it to use timer_settime,
> which will fall back to setitimer automatically if timer_settime is not
> supported. (see git-compat-util.h for how it does this). If both
> functions are not present, then git-compat-util.h provides replacements
> which will always fail with ENOSYS.

While this paragraph may be true if patch 8b and 9 are taken
together, isn't what it describes mostly what 8b did, not 9?

Here by 8b I mean the change to git-compat-util.h in 8; the patch
might want to be split into two, 8a for the autoconf part whose log
message may begin with "This function was not previously used by
git." and 8b that adds an emulation of timer_settime() API in terms
of setitimer() API, or the other way around.

What 9 did is only "we used to use the setitmer() API to implement
the progress reporting; now we use timer_settime() API" (yes, it is
thanks to the abstraction given by 8, but the "callers has to only
know about one API, not worrying about the other API" is a merit
attributable to 8b, not this one).

> The approach used here enables us to use a single API (timer_settime)
> without having to worry about checking for #ifdefs or if blocks which
> make it an unreadable nightmare. The major downside is for systems
> without timer_settime support, they may fall back on a wrapped
> implementation which could have subtle differences. This should be a
> minor issue as almost all modern systems provide timer_settime support.

As this paragraph.

> Note that this change means that git should never use setitimer on its
> own now, as the fallback implementation of timer_settime assumes that it
> is the sole user of ITIMER_REAL, and timer_delete will reset the
> ITIMER_REAL.

And this one.
