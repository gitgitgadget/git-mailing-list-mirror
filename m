From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] i18n: add infrastructure for translating Git with gettext
Date: Wed, 16 Nov 2011 11:25:09 +0100
Message-ID: <CACBZZX4nypBW1agNw6NrC-7LBWbjZ1ycgpn-zvBsg0x4EDBD0g@mail.gmail.com>
References: <1321191835-24062-1-git-send-email-avarab@gmail.com> <7vlirhx14x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 11:25:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQcgT-0000SM-Pk
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 11:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab1KPKZd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 05:25:33 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37805 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394Ab1KPKZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 05:25:32 -0500
Received: by bke11 with SMTP id 11so351780bke.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 02:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vN2buiJqy0VhVNIZt4lxgvUO+BBFPF/YUJaoyhVjQsI=;
        b=T3pGaZBiqF6qPtgc5qLtmmg5JFasWkRX8fI5jFs3zXHnWIe8Lx0IJO9KG5Y76uSMe8
         c3vBvHiEYF8pl6MfoUh1DJHzCXfgYYE5SJIWznjomgwyI9NuReNpXY4uiXIsd+slftnL
         gxbtAl0ABqSIvqJVK5BnzCWU8PJaJ1TAjyS5Q=
Received: by 10.204.9.1 with SMTP id j1mr28508733bkj.57.1321439131125; Wed, 16
 Nov 2011 02:25:31 -0800 (PST)
Received: by 10.204.69.71 with HTTP; Wed, 16 Nov 2011 02:25:09 -0800 (PST)
In-Reply-To: <7vlirhx14x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185534>

On Tue, Nov 15, 2011 at 09:04, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> Change the skeleton implementation of i18n in Git to one that can sh=
ow
>> localized strings to users for our C, Shell and Perl programs using
>> either GNU libint or the Solaris gettext implementation.
>
> Happy ;-).
>
> Isn't it libintl, though?
>
>> This new internationalization support is enabled by default. If
>> gettext isn't available, or if Git is compiled with
>> NO_GETTEXT=3DYesPlease, Git fall back on its current behavior of sho=
wing
>
> s/fall/falls/;

I'll fix both of these speling errurs in a new version of the
patch.

But I won't send it for at least a few days. I don't think there's
much point as we're in no rush to apply this, and it might as well sit
on-list for a few days to accumulate more review.

>> This change is somewhat large because as well as adding a C, Shell a=
nd
>> Perl i18n interface we're adding a lot of tests for them, and for
>> those tests to work we need a skeleton PO file to actually test
>> translations.
>
> You _could_ split it up this way, I think, if you really wanted to:
>
> =C2=A0* The mechanism, i.e. integration with libintl and gettext, wit=
hout any
> =C2=A0 translated strings but with the .pot file, with tests to make =
sure in a
> =C2=A0 locale that is missing *.mo files for it, we get the default o=
utput;
>
> =C2=A0* Sample translation for is_IS locale, with tests to make sure =
that we
> =C2=A0 get translated output in a locale that has *.mo files for it.
>
> But I am not sure if that is better.

I think it's better to keep it in one large patch. The changes to the
core code are pretty minimal, most of what it's adding is new stuff
that's only ever used if i18n itself is used.

>> diff --git a/.gitignore b/.gitignore
>> index 8572c8c..c47f3a8 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -224,3 +224,4 @@
>> =C2=A0*.pdb
>> =C2=A0/Debug/
>> =C2=A0/Release/
>> +/share/
>
> I somehow find it distasteful that this is overly wide; same with the
> change in Makefile to "rm -rf share/". I suspect it wouldn't be the c=
ase
> if it were limited to share/locale/ or something.
>
> But perhaps we would never ship anything in share/ and things in ther=
e
> will always come from elsewhere.
>
>> diff --git a/Makefile b/Makefile
>> index ee34eab..896f5fd 100644
>> --- a/Makefile
>> +++ b/Makefile
>> ...
>> @@ -2435,6 +2507,7 @@ clean:
>> =C2=A0 =C2=A0 =C2=A0 $(RM) $(TEST_PROGRAMS)
>> =C2=A0 =C2=A0 =C2=A0 $(RM) -r bin-wrappers
>> =C2=A0 =C2=A0 =C2=A0 $(RM) -r $(dep_dirs)
>> + =C2=A0 =C2=A0 $(RM) -r po/git.pot share/
>
> It seems "distclean" tells us to clean po/git.pot, which hints at me =
that
> normal "clean" shouldn't?

I'm not quite sure what we should do with it.

Here's what we do with the sharedir currently:

 * It's used as the gitwebdir already, and is used also as the
   localedir with this patch:

    sharedir =3D $(prefix)/share
    gitwebdir =3D $(sharedir)/gitweb
    localedir =3D $(sharedir)/locale

 * Even then I can't find the option that makes gitweb put something
   in it, after a "make" with this patch:

    $ find share -type f
    share/locale/is/LC_MESSAGES/git.mo

 * It *is* important that we have this under a
   $SOMETHING/is/LC_MESSAGES/git.mo structure, since we set
   GIT_TEXTDOMAINDIR to $SOMETHING, and the gettext library will only
   understand something in this layout.

   But that $SOMETHING doesn't have to be $ROOT/share, it could be
   e.g. $ROOT/po/generated, which would make it not conflict with the
   gitwebdir.

 * Yeah, we shouldn't remove po/git.pot in "clean" as well as
   "distclean". I missed that it had been added in 92a684b916 while
   applying this patch.
