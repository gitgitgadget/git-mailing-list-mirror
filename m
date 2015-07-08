From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] check_and_freshen_file: fix reversed success-check
Date: Wed, 08 Jul 2015 12:24:41 -0700
Message-ID: <xmqqegkixxja.fsf@gitster.dls.corp.google.com>
References: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl>
	<20150707141305.GA629@peff.net>
	<DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl>
	<20150707194956.GA13792@peff.net> <559D60DC.4010304@kdbg.org>
	<20150708180539.GA12353@peff.net> <20150708183331.GA16138@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	X H <music_is_live_lg@hotmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 21:25:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCuxr-0004WO-Km
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 21:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933507AbbGHTY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 15:24:57 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38230 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758791AbbGHTYs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 15:24:48 -0400
Received: by igrv9 with SMTP id v9so175600266igr.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Bu2DIhRjkCGmYm8FJuqPZpR/0fndfMzI2Apgig0yR4s=;
        b=0NOMQ1mzRU3Fd3VHL/T/V4AvXVUPrIa/su6Z2Z7Ie3kVX97GADYOEiNTwZZ6dZU6SU
         1HInKxednO+t8wP1JFiMX2xcbR7tD+w2T4BYYV4ffYe+R32KvwV4FvaOnWgX/lk8mamD
         WY3SysDKe2Q7LJUu9lJSmLUFi5O1k86vPxcaxs45/TGjmYfF32OwbK3RXciktUIz07ZG
         9NIId+0clZmGDsdkK9c0UwkSbJWrnrfG6maf9iJRblc9TY6v5iPyluVQ9IJl2/EBy/1x
         klDPDe8BPCxhv+zvCz4yBVA43Rf7qvmMMBXHy1ieb39o+2Nl+K1RVpjFd27BRuH3dZcu
         PLEg==
X-Received: by 10.107.152.146 with SMTP id a140mr19544671ioe.72.1436383483267;
        Wed, 08 Jul 2015 12:24:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6567:f006:f2bd:2568])
        by smtp.gmail.com with ESMTPSA id k203sm2440769ioe.42.2015.07.08.12.24.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 12:24:42 -0700 (PDT)
In-Reply-To: <20150708183331.GA16138@peff.net> (Jeff King's message of "Wed, 8
	Jul 2015 14:33:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273703>

Jeff King <peff@peff.net> writes:

> Subject: check_and_freshen_file: fix reversed success-check
>
> When we want to write out a loose object file, we have
> always first made sure we don't already have the object
> somewhere. Since 33d4221 (write_sha1_file: freshen existing
> objects, 2014-10-15), we also update the timestamp on the
> file, so that a simultaneous prune knows somebody is
> likely to reference it soon.
>
> If our utime() call fails, we treat this the same as not
> having the object in the first place; the safe thing to do
> is write out another copy. However, the loose-object check
> accidentally inverst the utime() check; it returns failure

s/inverst/invert/?

> _only_ when the utime() call actually succeeded. Thus it was
> failing to protect us there, and in the normal case where
> utime() succeeds, it caused us to pointlessly write out and
> link the object.
>
> This passed our freshening tests, because writing out the
> new object is certainly _one_ way of updating its utime. So
> the normal case of a successful utime() was inefficient, but
> not wrong.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The worst part of this is that I had the _same_ bug in the pack code
> path when I initially posted what became 33d4221. Ren=C3=A9 noticed d=
uring
> review, and my fix was to invert the return value from freshen_file t=
o
> match the other functions. But of course doing that without fixing th=
e
> other caller meant I introduced the same bug there.

I think each of the functions in the check_and_freshen_* callchain
can at least have a comment in front of it, saying what the returned
value means, to unconfuse readers.  "Return 1 when the thing exists
and no further action is necessary; return 0 when the thing does not
exist or not in a good state and should be overwritten (if the
caller has something to overwrite it with, that is)" or something?

Their returning "1" instead of "-1" could be taken as a hint that
says "this non-zero return does not signal a _failure_", but it is a
rather weak hint.

>
> I'll be curious if this fixes the problem the OP is seeing. If not, t=
hen
> we can dig deeper into the weird EPERM problems around this particula=
r
> object database.
>
>  sha1_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 77cd81d..721eadc 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -454,7 +454,7 @@ static int check_and_freshen_file(const char *fn,=
 int freshen)
>  {
>  	if (access(fn, F_OK))
>  		return 0;
> -	if (freshen && freshen_file(fn))
> +	if (freshen && !freshen_file(fn))
>  		return 0;
>  	return 1;
>  }
