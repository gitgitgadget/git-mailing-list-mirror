From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Sat, 4 Feb 2012 21:30:42 +0200
Message-ID: <CAMP44s2r-fcnfpdT4u5U7TwF1z6Abp+J1U7oqfsSrYMuD6weOQ@mail.gmail.com>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
	<20120202084859.GC3823@burratino>
	<7v8vklvxwh.fsf@alter.siamese.dyndns.org>
	<CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
	<7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
	<7vehuboe5g.fsf@alter.siamese.dyndns.org>
	<CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
	<20120204182611.GA31091@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 04 20:30:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtlJw-00051o-Vr
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 20:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384Ab2BDTao convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 14:30:44 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46776 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753895Ab2BDTan convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 14:30:43 -0500
Received: by lagu2 with SMTP id u2so2376576lag.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 11:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=P3qCIGQ+TlBu6pJ1vknO6MUnV7v1GCqvzMYld8tKqjQ=;
        b=LUJgKOHRKZFoeKKOEAxkbiWsZBIhqSoi++ErvmP3BuzNyXiVRtJEoMLBXGEdMVoQHv
         bBIReb5SLGTOGa5VACzTjhenn0Q5NjFCreViaJ82APXThTemsGtdclayJAsup8t9gZSk
         kM61rVI7vQ2a48XNugewyBef0/t5t+3KHLeio=
Received: by 10.152.114.169 with SMTP id jh9mr6156187lab.20.1328383842326;
 Sat, 04 Feb 2012 11:30:42 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sat, 4 Feb 2012 11:30:42 -0800 (PST)
In-Reply-To: <20120204182611.GA31091@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189894>

On Sat, Feb 4, 2012 at 8:26 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 04, 2012 at 05:46:05PM +0200, Felipe Contreras wrote:
>
>> In any case, the one to blame for the header corruption is git:
>> [...]
>> f2bb9f88 (<spearce@spearce.org>> 2006-11-27 03:41:01 -0500 952)
>>
>> Notice the mail is wrong.
>
> Ugh. The fault lies in this code:

Yes, I found that as well.

> But that comment is wrong. If there's no email mapping needed, map_us=
er
> will leave the "mail" buffer intact, in which case it will have the
> trailing ">" (because we feed the address with enclosing angle
> brackets). =C2=A0So while map_user tries to accept either "foo@exampl=
e.com\0"
> and "foo@example.com>", it is up to the contents of the mailmap wheth=
er
> you get back something with the closing angle bracket or not. Which i=
s a
> pretty error-prone interface.
>
> You can fix it with this:
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 5a67c20..9b886fa 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1406,7 +1406,8 @@ static void get_ac_line(const char *inbuf, cons=
t char *what,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add a trail=
ing '>' to email, since map_user returns plain emails
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Note: =
It already has '<', since we replace from mail+1 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mailpos =3D me=
mchr(mail, '\0', mail_len);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mailpos && mai=
lpos-mail < mail_len - 1) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mailpos && mai=
lpos-mail < mail_len - 1 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mail=
pos > mail && *(mailpos-1) !=3D '>') {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*mailpos =3D '>';
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*(mailpos+1) =3D '\0';
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}

Yes, I already did this. I'm writing tests for this right now, but I
think I found yet another bug...

> but it feels like the fix should go into map_user. =C2=A0I tried a fe=
w things,
> like "git log -1 --format=3D%aE", and couldn't find other code paths =
with
> this problem. So presumably they are all feeding email addresses with=
out
> the closing ">" (so one option is to just say "map_user needs to get
> NUL-terminated strings).

Perhaps, but I though the idea was to make it efficient. I think the
above fix should be ok.

We should have tests for this though, to make sure it doesn't get
broken again. I'm on that.

Cheers.

--=20
=46elipe Contreras
