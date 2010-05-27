From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 15:06:11 +0200
Message-ID: <AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 15:06:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHcmw-0002qx-FD
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 15:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623Ab0E0NGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 09:06:13 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:59839 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab0E0NGN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 09:06:13 -0400
Received: by wwb34 with SMTP id 34so215481wwb.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=zBqBfGeEKuLsWAXRZWmXyItE6ZWUTWM0MFbFNkrGooQ=;
        b=fR+lGrIFmMMW5DaUZcrgoJtFJQaejtBUipJNXuKz2rW2YU4Lz62B5hQXLWrFxUELd1
         9JuXUM9yqniBXxQfCBd1JG+D8d4tL+1CK0+L+x6Hf5lK970c10GCKAcJou3NMCB+VaEi
         xj+ejMizWuyXEhy4h8qqt3Jz53QaWpGVcXL7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=um7u0FE+h6j5BIxAl8Db0n7K4M5hEcGiW2mXIF7OQgl34eyU4FFRa4cZ/0eqOrN2bq
         enVeYzUcdeRkP51CJD+iKYCEVl3V4QEY0n+/a1GmnkDPNPGwASmW/ek4hNWYLSOvsPZt
         KCtOdMfC+tKNw0M1L4xz12DEbC3n8TuvGl0/4=
Received: by 10.216.85.11 with SMTP id t11mr635073wee.55.1274965571432; Thu, 
	27 May 2010 06:06:11 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Thu, 27 May 2010 06:06:11 -0700 (PDT)
In-Reply-To: <AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147852>

On Thu, May 27, 2010 at 1:00 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> On Thu, May 27, 2010 at 12:10 PM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>> Implement the subset of poll() semantics needed by git in terms of
>> select(), for use by the Interix port. =A0Inspired by commit 6ed807f
>> (Windows: A rudimentary poll() emulation, 2007-12-01).
>>
>
> A possible problem with this approach is that the maximum number of
> file descriptors poll can handle limited by RLIMIT_NOFILE, whereas th=
e
> maximum number of file descriptors select can handle is limited by
> FD_SETSIZE.
>
> I don't think this is a big problem in reality, though - both values
> seem to be pretty high in most implementations. And IIRC git-daemon i=
s
> the only one who needs more than 2, and it doesn't even check
> RLIMIT_NOFILE.
>

To be clear: I think this strategy is the best option (at least for
non-Windows, where select() might be our only option).

But perhaps you should include a check along the lines of this:

if (nfds > FD_SETSIZE)
	return errno =3D EINVAL, error("poll: nfds must be below %d", FD_SETSI=
ZE);

Just so we can know when the code fails :)

--=20
Erik "kusma" Faye-Lund
