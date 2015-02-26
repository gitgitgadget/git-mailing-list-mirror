From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Salvaging borked project history
Date: Thu, 26 Feb 2015 10:56:33 -0800
Message-ID: <xmqqh9u8mrha.fsf@gitster.dls.corp.google.com>
References: <54EB5DD7.7050202@free.fr>
	<xmqq7fv8to7e.fsf@gitster.dls.corp.google.com>
	<54EF098B.4080803@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Mason <slash.tmp@free.fr>
X-From: git-owner@vger.kernel.org Thu Feb 26 19:56:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR3c1-0004CF-2H
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 19:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbbBZS4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 13:56:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753798AbbBZS4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 13:56:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DA0C3B292;
	Thu, 26 Feb 2015 13:56:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xkmoIkUbqUlmEAiGa/7ITIRLAh8=; b=VyYI3S
	8wctysNPmvVI/IE6qhHtbjmO8JUr5rCTGBV+9cyLMwNLyI7TaUZyTLOWQg0J1kAr
	kQE0TZlMuc3gn5hzpJkx2gLT4LcMrRiBgxZI+AkEeTU1Qw/C2BKPGDDeLFhMsdfZ
	MqmFtMmoKraJ5+ncwI4MlONluEt6hPsrdGcew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uguYPP1L9xUcSpSMX5cy0ymAGFiOe4vB
	4MRqCCvLXEZ0lupiX9ajLjiDS/Lk5uqK8n0XRX4lB4Bgmri7ma59th994Y+Byk+Y
	7+gPLrAM4nUy2ELIPGuPlRE4KPb8iDMurUF78ZlSrtMkWvZxCgfJiiAThLFFIyFP
	iuZn18483Uw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E2AB3B291;
	Thu, 26 Feb 2015 13:56:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D05503B290;
	Thu, 26 Feb 2015 13:56:34 -0500 (EST)
In-Reply-To: <54EF098B.4080803@free.fr> (Mason's message of "Thu, 26 Feb 2015
	12:54:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2F6C9CC6-BDE9-11E4-B7C2-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264451>

Mason <slash.tmp@free.fr> writes:

> Thanks! At least now, I see the light at the end of the tunnel.
>
> I fetched linux-stable.git inside our repo.
> I created ~300 patches using git format-patch -1 in a loop.
> I can now run 'git am --3way $IGNORE *.patch'
>
> IGNORE is used to --exclude the directories I'm not interested in.
>
> Note: it seems --exclude=arch/mips and --exclude=arch/mips/ are
> not sufficient, I need to write --exclude=arch/mips/* for git-apply
> to ignore changes to files inside arch/mips.
>
> Is that expected behavior?

I have no idea; at least to me, "--exclude" option to "git apply"
was invented to name individual paths, not patterns, and I wouldn't
be surprised if glob working were merely by accident not by design.

> Another nit: if a patch contains only changes to files inside arch/mips
> then git-apply will create an "empty commit" (one with no diff). Is there
> an option to say "skip empty patches"?

"git am --skip" perhaps?

"git am" may pass the "--exclude/--include" options to "git apply"
but I wouldn't be surprised if that support was added without
thinking.  Perhaps the reason why you discovered that it needed a
lot more thinking to properly integrate these options to "git am"
only now is because hardly anybody uses it ;-).  Not just passing
these options, the code in "git am" to react to the result of patch
application to avoid the issue you observed when these options are
passed need to be adjusted by changes that started passing them, but
I do not think they did, cf. 77e9e496 (am: pass exclude down to
apply, 2011-08-03).

> One more thing: "regular" diff -q returns 0 when the files are identical,
> and 1 when they differ. It seems git diff -s does not have that behavior.
> Is that by design?

"diff -s" may be accepted but it is an idiotic thing for a user to
say.  The "-s" option is to squelch output from "log" and friends,
and it is exposed to "diff" only because these two families of
commands share the command line parser.
