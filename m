From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] core: use env variable instead of config var to turn
 on logging pack access
Date: Tue, 4 Jun 2013 14:48:04 +0700
Message-ID: <CACsJy8BwKfzU0KOPpsPUb601HVpMPWiMAjctHLdpcOSUUUxfGw@mail.gmail.com>
References: <7vmwr7c59b.fsf@alter.siamese.dyndns.org> <1370299959-5573-1-git-send-email-pclouds@gmail.com>
 <7vzjv68k8b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 09:48:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujlyx-00062E-IT
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 09:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759631Ab3FDHsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 03:48:36 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:63305 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759028Ab3FDHsf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jun 2013 03:48:35 -0400
Received: by mail-ob0-f171.google.com with SMTP id dn14so8882469obc.30
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/C/sklUslRdMmJIa3uYmeqh0C/DaVQC/ApOAGRBJeDQ=;
        b=yKxXkuEhsu0PCCmvrtZS8jEGrhx60H2GknZ8m79Zcvq1VqahcYzbu35rKxqMPWSBGT
         wnhAay4vKE+BZJ4h8Jtet8wJEtNsA/3kYXZ4D5lnnbW1dRwKeqhIUqxXOYKKn21QbRZB
         1g3KNVNov0F0b+qJaPaWSjWfIhJTc8a3h2+cy1cRM7UaGVTXWBXhzEIidMdEKyNw7Bew
         OjueCS5SYimAGHIbdUVdhKnZgX9rRO5a25U9pfdwS8qZEE/mFFhtPGQvCfBM+hy3B3mg
         z12qDdfl49wt0vMLomxBQTuvVv5/9ej+CY/1g1bmPgVfYyNc5vSXJN3FnnLuwSeUy+dU
         63Kw==
X-Received: by 10.182.106.130 with SMTP id gu2mr11636850obb.0.1370332114554;
 Tue, 04 Jun 2013 00:48:34 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Tue, 4 Jun 2013 00:48:04 -0700 (PDT)
In-Reply-To: <7vzjv68k8b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226322>

On Tue, Jun 4, 2013 at 1:26 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>>  > Have you ever tested this?
>>  >
>>  > Once log_pack_access goes to NULL (e.g. when it sees the empty
>>  > string it was initialized to), this new test will happily
>>  > dereference NULL.
>>
>>  My bad. I did test when GIT_TRACE_PACK_ACCESS was set, not when it
>>  was set to an empty string. All cases tested now.
>>
>> @@ -1956,6 +1958,14 @@ static void write_pack_access_log(struct pack=
ed_git *p, off_t obj_offset)
>>  {
>>       static FILE *log_file;
>>
>> +     if (!*log_pack_access) {
>
> The first time, we will see the static empty string and come into
> this block...
>
>> +             log_pack_access =3D getenv("GIT_TRACE_PACK_ACCESS");
>> +             if (log_pack_access && !*log_pack_access)
>> +                     log_pack_access =3D NULL;
>> +             if (!log_pack_access)
>> +                     return;
>> +     }
>
> This may
>
>  (1) not find the env-var, in which case log_pack_access becomes
>      NULL here, and the function returns.
>
>  (2) find the env-var to be an empty string, in which case
>      log_pack_access becomes NULL in the next statement, and the
>      function returns.
>
>  (3) find the env-var to be a non-empty string, and the function
>      does not return.
>
> And the next time around, (3) above may work fine; the first if()
> will fail and we do not come in.  But in either (1) or (2), don't
> you keep checking the environment every time you come here?
>
> Oh, no, it is worse than that.  Either case you set the variable to
> NULL, so the very first "if (!*log_pack_access)" would dereference
> NULL.

You found it out already. The only caller does this

if (log_pack_access) write_pack_access_log(p, obj_offset);

so in (1) and (2), write_pack_access_log() will never be called again.
Originally I had "log_pack_access && !*log_pack_access" in the first
if(), but I dropped it because of the caller's condition. It's a bit
fragile though. Imagine a new callsite is added.. (to be continued)

> Why not start from NULL:
>
>     static const char *log_pack_access;
>
> treat that NULL as "unknown" state, and avoid running getenv over
> and over again by treating non-NULL value as "known"?  Perhaps like
> this?
>
>         if (!log_pack_access) {
>                 /* First time: is env set? */
>                 log_pack_access =3D getenv("GIT_TRACE_PACK_ACCESS");
>                 if (!log_pack_access)
>                         log_pack_access =3D "";

or set log_pack_access to SomePredefinedButUselessString here. I
wanted to do this but couldn't because of global variable
initialization.

>         }
>         /* Now GIT_TRACE_PACK_ACCESS is known */
>         if (!*log_pack_access)
>                 return; /* not wanted */
>
> As you can no longer rely on "config is read before we do anything
> else" by switching to lazy env checking, your guard at the caller
> needs to be updated, if you want to reduce unneeded call-return
> overhead:
>
>         if (!log_pack_access || *log_pack_access)
>                 write_pack_access_log(...);

and this turns to "if (!log_.. || log !=3D SomePrede...)", no more
peeking into log_pack_access.

>
> But the guard is purely for performance, not correctness, because
> the function now does the "return no-op if we know we are not
> wanted" itself.

(continued here) ..so yeah this looks better.

> Also you no longer need to have an extern variable in environment.c

will fix.
--
Duy
