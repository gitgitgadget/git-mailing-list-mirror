From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH] fast-import: catch garbage after marks in from/merge
Date: Mon, 2 Apr 2012 12:56:40 +0600
Message-ID: <CA+gfSn_8J-HzNjLMi2fXn1XQNA9wx3EVuiseq3pjy0nP-odb5A@mail.gmail.com>
References: <20120401225407.GA12127@padd.com>
	<20120401231259.GE20883@burratino>
	<20120402001354.GA12651@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 08:56:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEbC3-0006X5-CB
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 08:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab2DBG4m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 02:56:42 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44288 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751088Ab2DBG4l convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 02:56:41 -0400
Received: by lahj13 with SMTP id j13so2604319lah.19
        for <git@vger.kernel.org>; Sun, 01 Apr 2012 23:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=puM1jqbdwTT6wVX48sxP4beJkYWtZ/xsRXaZlxw9cTY=;
        b=xw3no7vIZZkACdsVM4Mtdw3rswsNot4YdZooApGyRqrnY21O9Kkug/Ln+aQUbQjYWm
         oSUkdmCWYcbeeIaDB7sSPetiKP1R1QCH7TDY+nqK6/bcCSOAkT42SpoTAKmBiO7jOs0n
         pFSqFg9IF64eOLBJCt9MDW+DbMq+5cawG3KT7ZnrdnUKp4CzoLvSsSRp/RJ0yU+aZ5TU
         go6FZfuxnLt1wiAC55+rs4fjkycrLLvdVnOyw9J1f769aR9znG6b3qrHd4ou+u4iRZrz
         /akrC3v1wOUxQ4ZO7zA68M3DmPE0TrkOKYfTyMxJevKjxcaUdjOAZ47LwS14b7sEcDe5
         nRGg==
Received: by 10.152.146.39 with SMTP id sz7mr8346378lab.3.1333349800443; Sun,
 01 Apr 2012 23:56:40 -0700 (PDT)
Received: by 10.152.11.231 with HTTP; Sun, 1 Apr 2012 23:56:40 -0700 (PDT)
In-Reply-To: <20120402001354.GA12651@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194498>

On Mon, Apr 2, 2012 at 6:13 AM, Pete Wyckoff <pw@padd.com> wrote:
> jrnieder@gmail.com wrote on Sun, 01 Apr 2012 18:12 -0500:
>> Hi Pete,
>>
>> Pete Wyckoff wrote:
>>
>> > =A0 =A0 from :1M 100644 :103 hello.c
>> >
>> > It is missing a newline and should be:
>> >
>> > =A0 =A0 from :1
>> > =A0 =A0 M 100644 :103 hello.c
>>
>> Good idea; thanks.
>>
>> I agree that this at least deserves a warning and probably should
>> error out.
>>
>> [...]
>> > --- a/fast-import.c
>> > +++ b/fast-import.c
>> > @@ -2537,8 +2537,16 @@ static int parse_from(struct branch *b)
>> > =A0 =A0 =A0 =A0 =A0 =A0 hashcpy(b->branch_tree.versions[0].sha1, t=
);
>> > =A0 =A0 =A0 =A0 =A0 =A0 hashcpy(b->branch_tree.versions[1].sha1, t=
);
>> > =A0 =A0 } else if (*from =3D=3D ':') {
>> > - =A0 =A0 =A0 =A0 =A0 uintmax_t idnum =3D strtoumax(from + 1, NULL=
, 10);
>> > - =A0 =A0 =A0 =A0 =A0 struct object_entry *oe =3D find_mark(idnum)=
;
>> > + =A0 =A0 =A0 =A0 =A0 char *eptr;
>> > + =A0 =A0 =A0 =A0 =A0 uintmax_t idnum =3D strtoumax(from + 1, &ept=
r, 10);
>> > + =A0 =A0 =A0 =A0 =A0 struct object_entry *oe;
>> > + =A0 =A0 =A0 =A0 =A0 if (eptr) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (; *eptr && isspace(*ept=
r); eptr++) ;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*eptr)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Garbage=
 after mark: %s",
>>
>> The implementation seems more complicated than it needs to be. =A0Wh=
y
>> allow whitespace after the mark number?
>
> Fear of breaking existing fast-import users that might happen
> to have stray whitespace, or \r\n terminators.
>
> Other similar fast-import are less forgiving, such as
> parse_cat_blob. =A0Maybe we should generalize and enforce its
> approach to parsing marks.

Docs say that "fast-import is very strict about its input", so
probably it is ok to both deny trailing spaces and fix all other
strtoumax()-es.

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-- Pete
