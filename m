From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 01/11] mingw: add network-wrappers for daemon
Date: Wed, 2 Dec 2009 14:49:19 +0100
Message-ID: <40aa078e0912020549s792eb3ffi93b2cfdc6b7219dd@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
	 <alpine.DEB.2.00.0911261015140.14228@cone.home.martin.st>
	 <40aa078e0911260246j47fa36d5t421de7c1d07d5cca@mail.gmail.com>
	 <alpine.DEB.2.00.0911261250180.14228@cone.home.martin.st>
	 <40aa078e0912020501v9378c37l106e1e23b5e7b43d@mail.gmail.com>
	 <alpine.DEB.2.00.0912021511310.5582@cone.home.martin.st>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	dotzenlabs@gmail.com, Johannes Sixt <j6t@kdbg.org>
To: =?ISO-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Wed Dec 02 14:49:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFpaB-0004R6-BB
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 14:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbZLBNtP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2009 08:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753775AbZLBNtP
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 08:49:15 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:49038 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbZLBNtO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 08:49:14 -0500
Received: by ewy19 with SMTP id 19so247861ewy.21
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 05:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nKOqHieIg7ZxqEwLJ2tR5cDZepREvimtUZlZ4gDlXP4=;
        b=VB0r0OLL7zl3ZVvxn1a+QYTva2xitK4QcGJiK2Nq6O1CEA12M+rqBrcP5yxDT01AMU
         4Z/n/9pMFXaN42OeK4DKM0pm70nWPYE/dvrW380DXSqHZBddmMflTDyz3+9QFgMF2Nra
         6Sq14nVvvh6LLAkk8l8XwyWRAj4P3XIpFzMmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=SY6vLA35u82t0tgdW0jvxMIdMfMlcRsC9fn2g0UB0qlOg7r3kWUTBtYqkvci0Z9EQg
         FTwPZ7MfigjpVa1jGH0yIyypyKmQJARkEtVbdpBXm8HIDmY+uG7JfbpbghMk6uXZyfzw
         rLJyVV5QQasLh9FWark0rFekdef+k9RiE2cAI=
Received: by 10.216.89.76 with SMTP id b54mr41749wef.105.1259761759056; Wed, 
	02 Dec 2009 05:49:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912021511310.5582@cone.home.martin.st>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134334>

On Wed, Dec 2, 2009 at 2:21 PM, Martin Storsj=F6 <martin@martin.st> wro=
te:
> On Wed, 2 Dec 2009, Erik Faye-Lund wrote:
>
>> I'm not very familiar with poll(), but if I understand the man-pages
>> correctly it's waiting for events on file descriptors, and is in our
>> case used to check for incoming connections, right? If so, I see thr=
ee
>> possible ways forward: (1) extending our poll()-emulation to handle
>> multiple sockets, (2) change daemon.c to check one socket at the tim=
e,
>> and (3) using select() instead of poll().
>>
>> (1) seems like the "correct" but tricky thing to do, (2) like the
>> "easy" but nasty thing to do. However, (3) strikes me as the least
>> dangerous thing to do ;)
>
> Generally, poll is a better API than select, since select is limited =
to fd
> values up to (about) 1000, depending on the implementation. (This is =
due
> to the fact that fd_set is a fixed size bit set with a bit for each
> possible fd.)
>
> But since we're only doing select on the handful of sockets that were
> opened initially in the process (so these should receive low numbers)=
,
> this should only be a theoretical concern.
>

Yeah. In our case, I guess it's a maximum of two times the number of
network adapters installed, so I think we should be relatively safe.

>
>> --->8---
>> --- a/daemon.c
>> +++ b/daemon.c
>> @@ -812,26 +812,22 @@ static int socksetup(char *listen_addr, int li=
sten_port, i
>> nt **socklist_p)
>>
>> =A0static int service_loop(int socknum, int *socklist)
>> =A0{
>> - =A0 =A0 =A0 struct pollfd *pfd;
>> - =A0 =A0 =A0 int i;
>> -
>> - =A0 =A0 =A0 pfd =3D xcalloc(socknum, sizeof(struct pollfd));
>> -
>> - =A0 =A0 =A0 for (i =3D 0; i < socknum; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pfd[i].fd =3D socklist[i];
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pfd[i].events =3D POLLIN;
>> - =A0 =A0 =A0 }
>> -
>> =A0 =A0 =A0 =A0 signal(SIGCHLD, child_handler);
>>
>> =A0 =A0 =A0 =A0 for (;;) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fd_set fds;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct timeval timeout =3D { 0, 0 };
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 check_dead_children();
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (poll(pfd, socknum, -1) < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 FD_ZERO(&fds);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < socknum; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FD_SET(socklist[i], &f=
ds);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (select(0, &fds, NULL, NULL, &timeo=
ut) > 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (errno !=3D EINTR=
) {
>
> The first parameter to select should be max(all fds set in the fd_set=
) +
> 1, this should be trivial enough to determine in the loop above where=
 the
> fd:s are added with FD_SET.
>

Yeah, thanks for pointing out. I did a little bit of searching, and it
seems like "most other people passes zero, and it just works".
However, we should be nice to systems where it doesn't "just work", so
I'll fix this before sending it out.

> You're calling select() with a zero timeout - I'd guess this chews qu=
ite a
> bit of cpu just looping around doing nothing? If the last parameter w=
ould
> be set to NULL, it would wait indefinitely, just like the previous po=
ll
> loop did.
>

Ah, yes. That's much nicer!

>> @@ -854,6 +850,7 @@ static int service_loop(int socknum, int *sockli=
st)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hand=
le(incoming, (struct sockaddr *)&ss, sslen);
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> What's this good for?
>

When I clone git://localhost/some-repo, select() returns a fd-set with
both the IPv4 and IPv6 fds. After accept()'ing the first one, the
second call to accept() hangs. I solved this by accepting only the
first connection I got; the second one should be accepted in the next
round of the service loop (if still available).

--=20
Erik "kusma" Faye-Lund
