From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd broken "--date=now" behavior in current git
Date: Tue, 14 Apr 2015 21:47:38 -0700
Message-ID: <xmqqzj6ayp3p.fsf@gitster.dls.corp.google.com>
References: <CA+55aFxvcN8Dz-t6fi6etycg+AiyR0crXv5AcfCdv8ji-iNBpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 06:48:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiFF6-0007hh-9T
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 06:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbbDOErm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 00:47:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751424AbbDOErl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 00:47:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F13F4AF7D;
	Wed, 15 Apr 2015 00:47:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RYDEHi2LgVAQ3WGihIp2vS8y2Gg=; b=vn3PoI
	tsD+7QJqcmthvZfRdrFCpd6yB6mtlF59AEpE8LohwVs3bzuBdFflU1m+tkxk61xz
	7yV7ArSfVORgogFKj4zEl0EA08dCpk0cGO93dX2O0w71rUOzignPJQxMxulgsp4K
	7M65Z7WrN8Px3HwDxPWA3a+XNUNvFO5gVmfCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HxqSor4DgrshqxnPoU3vmn9RsIjfdGKM
	wTQsWAFSdheVWVUrPXKqWgOPi87f+A8TkFzyWNuAbuH5Tltiw99IRDdCIwxt7pia
	YOAt20bAM3TgakJbvXt+Ft8bsZiZ5FCAB4sgAz1m5srV1pSYicWddkUTHith7xw0
	qGp+F3nmNRc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 288DE4AF7C;
	Wed, 15 Apr 2015 00:47:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1B784AF7A;
	Wed, 15 Apr 2015 00:47:39 -0400 (EDT)
In-Reply-To: <CA+55aFxvcN8Dz-t6fi6etycg+AiyR0crXv5AcfCdv8ji-iNBpw@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 14 Apr 2015 21:18:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B841F8C-E32A-11E4-B6B9-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267184>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I just noticed this because I had amended some merge commits with
>
>    git commit --amend --date=now
>
> to update them, and that gets some funny broken timezones. I suspect
> it's some silly daylight savings time issue.
>
> Lookie here, I can reproduce it trivially with current git (in the git
> repo itself):
>
>     [torvalds@i7 git]$ date; git commit -m Test --allow-empty --date=now
>     Tue Apr 14 21:11:03 PDT 2015
>     [master ec7733db5360] Test
>      Date: Tue Apr 14 20:11:03 2015 -0800
>
> notice how the commit date message shows something funny. It shows an
> hour earlier, but in -0800.
>
> And the resulting commit is broken:
>
>     [torvalds@i7 git]$ git show --pretty=fuller
>     commit ec7733db5360966434e03eab1a849e6d4227231c (HEAD -> master)
>     Author:     Linus Torvalds <torvalds@linux-foundation.org>
>     AuthorDate: Tue Apr 14 20:11:03 2015 -0800
>     Commit:     Linus Torvalds <torvalds@linux-foundation.org>
>     CommitDate: Tue Apr 14 21:11:03 2015 -0700
>
>         Test
>
> notice how the AuthorDate has that "-0800", but the CommitDate has "-0700".
>
> Hmm.
>
> I can't be the only one seeing this? My guess is that there's a
> missing initialization of tm.tm_isdst somewhere or whatever.
>
> The above is with current git:
>
>     [torvalds@i7 git]$ git version
>     git version 2.4.0.rc2

With a quick check, the symptom exists at least at v2.1.4.  v2.0.x
series does not seem to have --date=now support but since there is
no change to date.c between v2.0.0 to v2.1.4, older approxidate may
be equally broken.

Will dig tomorrow, if nobody beats me to it, that is.

Thanks.
