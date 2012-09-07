From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] advice: extract function to print messages with prefix
Date: Fri, 7 Sep 2012 21:56:14 +0200
Message-ID: <CAN0XMOK5QnNn8471RF4y7u_X0rfda=-J-KrCtyMsgCGHXNrwVw@mail.gmail.com>
References: <7vhar9ybgk.fsf@alter.siamese.dyndns.org>
	<1347044705-17268-1-git-send-email-ralf.thielow@gmail.com>
	<1347044705-17268-2-git-send-email-ralf.thielow@gmail.com>
	<7v1uidy6ga.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worldhello.net@gmail.com, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 21:56:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA4fA-0007QN-QG
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 21:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757193Ab2IGT4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012 15:56:18 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:61915 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab2IGT4Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2012 15:56:16 -0400
Received: by wibhr14 with SMTP id hr14so146940wib.1
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3tdmQWfTgJ1dVRSJGISXTAv3W9+whQRQTG078fY9wLY=;
        b=r1LshBF3lureVBJBCRKg1FqSssuOAkOhFPImCoC9eaimL2HCDQWdUzfj9kNfxIksFW
         Zlfrqa3rzgKSV0w5kgSQTdVQ25BahW/pk+rAI1anb54eop6+Z8c0uPft8AzwizAGhcp4
         O12ZlI7wx2MpaPLXh7kBMPAgjbSSkFKKfJUDVCUz/dT02qF5kI65Pee0RvFffeYevoy4
         /sYbV5qJUuVM4kI6Wq6YhRvNqbRkZ4706smhSvqOpcv4o6YJuqhXz9kjx420U5F6zeMX
         YTWora/QJP+HtauzFh49wl7aj+cNqEMruz3end4IhxNmeIJroNc3QI4b2LFoUycMMVlG
         +J4A==
Received: by 10.180.109.166 with SMTP id ht6mr473544wib.11.1347047774822; Fri,
 07 Sep 2012 12:56:14 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Fri, 7 Sep 2012 12:56:14 -0700 (PDT)
In-Reply-To: <7v1uidy6ga.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204993>

On Fri, Sep 7, 2012 at 9:32 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> Extract a function that allows to print messages
>> with a prefix.
>>
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> ---
>>  advice.c | 14 ++++++++++----
>>  advice.h |  1 +
>>  2 Dateien ge=C3=A4ndert, 11 Zeilen hinzugef=C3=BCgt(+), 4 Zeilen en=
tfernt(-)
>>
>> diff --git a/advice.c b/advice.c
>> index edfbd4a..e73d53b 100644
>> --- a/advice.c
>> +++ b/advice.c
>> @@ -25,25 +25,31 @@ static struct {
>>       { "detachedhead", &advice_detached_head },
>>  };
>>
>> -void advise(const char *advice, ...)
>> +void print_with_prefix(const char *prefix, const char *msg, ...)
>>  {
>>       struct strbuf buf =3D STRBUF_INIT;
>>       va_list params;
>>       const char *cp, *np;
>>
>> -     va_start(params, advice);
>> -     strbuf_vaddf(&buf, advice, params);
>> +     va_start(params, msg);
>> +     strbuf_vaddf(&buf, msg, params);
>>       va_end(params);
>>
>>       for (cp =3D buf.buf; *cp; cp =3D np) {
>>               np =3D strchrnul(cp, '\n');
>> -             fprintf(stderr, _("hint: %.*s\n"), (int)(np - cp), cp)=
;
>> +             fprintf(stderr,  "%s %.*s\n", prefix, (int)(np - cp), =
cp);
>
> Hrm, naively, printf("%s: %.*s\n", _("hint"), ...) might look more
> natural, but I vaguely recall that the current code places _()
> around the entire "hint: %.*s\n" on purpose.  IIRC, it was to allow
> translations that flow from RTL e.g. ".siht od t'nod :tnih".
>
> Doesn't this patch break it?

Sorry but I don't know what you mean with "translations that flow
from RTL e.g. ".siht od t'nod :tnih"." so I can't check this.
As far as I can see the callers only put a simple message in it,
e.g. advise(_("Commit your changes or stash them to proceed."));
So I don't think that this patch would break anything.
