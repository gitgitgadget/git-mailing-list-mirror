From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Thu, 14 Oct 2010 13:02:10 +0200
Message-ID: <AANLkTi=N+4QokkiGmN+S17=7=QsgKWUXrsF0vZ_6Zt2H@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com> <7vhbgphf25.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 13:02:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6La7-0004mB-KI
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 13:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab0JNLCd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 07:02:33 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39347 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab0JNLCd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 07:02:33 -0400
Received: by pvc7 with SMTP id 7so525538pvc.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=hacNBrF2OU2tWedEOgfX6y+zAW7QwmDLKcbhGyK3bGo=;
        b=BvbgKcqCrEUEfE6Dxg/UsOMUhAP5vyyn+EJro/SyTc45QKkAKZkjANgpD8aM2E8+pf
         wcw056RCa939ByxPCMRBwfGs6LlPrnZeSzLcKXXORGzABHPdV74nBzC3hFs24Usl9lpP
         h9TWTOGN7WdZ5BI4xARgdGQuF1yu1LEzqROxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=VWmZUAvTHGCnf1kM1nfBR5OhvIs12NgdEDvfE7nGWCZQbE5ySyGFoKVy/1VRyQhga6
         96mjdDj7yPaYnQAoritb/B6KbIWzsxBF0di9RDnhwUqzatBUTNyZC6PiMgE26DJB462l
         xhbIx6I2omNsFWLhf8Q4A52GDMXatdId+qTNQ=
Received: by 10.143.41.2 with SMTP id t2mr8611180wfj.156.1287054152419; Thu,
 14 Oct 2010 04:02:32 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Thu, 14 Oct 2010 04:02:10 -0700 (PDT)
In-Reply-To: <7vhbgphf25.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159047>

On Thu, Oct 14, 2010 at 1:02 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> Windows does not supply the POSIX-functions fork(), setuuid(), setgi=
d(),
>> setsid() and initgroups(). Disable support for --user, --group and
>> --detach if the NO_POSIX_GOODIES flag is set.
>>
>> MinGW doesn't have prototypes and headers for inet_ntop and inet_pto=
n,
>> so include our implementation instead. MSVC does have, so avoid doin=
g
>> so there.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>> diff --git a/daemon.c b/daemon.c
>> index 9b97b58..aa580f6 100644
>> --- a/daemon.c
>> +++ b/daemon.c
>> @@ -965,7 +969,12 @@ static void store_pid(const char *path)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die_errno("failed to write pid file '%s'=
", path);
>> =A0}
>>
>> -static int serve(struct string_list *listen_addr, int listen_port, =
struct passwd *pass, gid_t gid)
>> +#ifndef NO_POSIX_GOODIES
>> +static struct passwd *pass;
>> +static gid_t gid;
>> +#endif
>> +
>> +static int serve(struct string_list *listen_addr, int listen_port)
>> =A0{
>> =A0 =A0 =A0 struct socketlist socklist =3D { NULL, 0, 0 };
>>
>
> This is ugly. =A0Why did you need to make the arguments file-scope st=
atic?
>

To avoid having different signatures for the serve-function dependent
on NO_POSIX_GOODIES.

Do you have any other suggestions on how to do this? Perhaps I should
just move the logic in serve() to the end of main()? It's the only
call-site for the function, and would remove the need for a function
prototype all-together...

>> @@ -974,10 +983,12 @@ static int serve(struct string_list *listen_ad=
dr, int listen_port, struct passwd
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("unable to allocate any listen socke=
ts on port %u",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 listen_port);
>>
>> +#ifndef NO_POSIX_GOODIES
>> =A0 =A0 =A0 if (pass && gid &&
>> =A0 =A0 =A0 =A0 =A0 (initgroups(pass->pw_name, gid) || setgid (gid) =
||
>> =A0 =A0 =A0 =A0 =A0 =A0setuid(pass->pw_uid)))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("cannot drop privileges");
>> +#endif
>
> It would be cleaner to make a helper (e.g. "drop-privileges") that is=
 a
> no-op on NO_POSIX_GOODIES platform, and call that without #ifdef here=
=2E
>

Sure, makes sense.

> The same aversion to too many #ifdef's apply to the rest of the patch=
=2E
>

I can remove some of them, like keeping the variables in main()
around, even though they'll be constant. That might cause some
compile-time warnings, though.
