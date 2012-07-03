From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Tue, 3 Jul 2012 11:25:16 +0700
Message-ID: <CACsJy8AmCo82YxHA_6+rkbuJOjOG-HqCgjoP2tz753SXH5w8_Q@mail.gmail.com>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost> <20120702215736.GA5790@sigill.intra.peff.net>
 <m2vci5n5r5.fsf@igel.home> <20120703032345.GA7143@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 06:26:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slugd-0002AV-I0
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 06:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724Ab2GCEZs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jul 2012 00:25:48 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59081 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab2GCEZs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2012 00:25:48 -0400
Received: by wgbdr13 with SMTP id dr13so5864282wgb.1
        for <git@vger.kernel.org>; Mon, 02 Jul 2012 21:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5cv8aIsM+LG6gZHIok0s2xx3G3sJ+u3gdjxVbU4Muj4=;
        b=kgaA/vP/d2kSrXUdMB5m3iV/meq+jE82y+My/IkybAw71x9p6MPLiv5kvrjBF57VwV
         zurCQjf7mddMOD7hSv/Yg2/YEcR/ERvL6QVqjj0Ybq09sXQWcdCYx4dw2YeKep4Nf1/W
         EliRuIw33p+F2ZyriRWJw1Bey1cvFooOW6rfullg5lHlzEqf3Sa69O3RrrPSBqxbOL9e
         Fe36mTlQ5V4vfiNyNfgB8IOTwLHRqPSc5VLoGOmfokSK7EQEQbLT3T0MyKhmk1CeSzaC
         X0JOE+FBZEOdXpeVoM1zbw44phX0MTVma729aKyJ8bpTHtY+M3GerioMBw6oeh07NLJA
         MfDw==
Received: by 10.180.81.10 with SMTP id v10mr28437905wix.17.1341289546816; Mon,
 02 Jul 2012 21:25:46 -0700 (PDT)
Received: by 10.223.79.76 with HTTP; Mon, 2 Jul 2012 21:25:16 -0700 (PDT)
In-Reply-To: <20120703032345.GA7143@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200896>

On Tue, Jul 3, 2012 at 10:45 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 03, 2012 at 12:43:42AM +0200, Andreas Schwab wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > It's very odd for pread to report ENOENT (since it is always opera=
ting
>> > on an already-opened file descriptor).
>>
>> It doesn't, but gettext will clobber errno:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D pread(pack_fd=
, inbuf, n, from);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n < 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die_errno(_("cannot pread pack file"));
>>
>> There is nothing that saves errno. =C2=A0This isn't limited to i18n =
though,
>> any function call in the arguments may potentially clobber errno.
>
> That's horribly lame of gettext. I don't expect arbitrary functions t=
o
> save errno, but when the entire purpose of a function is to be a
> non-intrusive wrapper to massage messages to the user, it seems kind =
of
> evil to overwrite errno. Isn't the whole point of calling it "_" that
> you don't want to or have to notice it?

Agreed.

> Can we do something like this to get around it?
>
> diff --git a/gettext.h b/gettext.h
> index 57ba8bb..b7c3ae5 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -44,7 +44,10 @@ extern int use_gettext_poison(void);
>
> =C2=A0static inline FORMAT_PRESERVING(1) const char *_(const char *ms=
gid)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 return use_gettext_poison() ? "# GETTEXT POISO=
N #" : gettext(msgid);
> + =C2=A0 =C2=A0 =C2=A0 int saved_errno =3D errno;
> + =C2=A0 =C2=A0 =C2=A0 const char *r =3D use_gettext_poison() ? "# GE=
TTEXT POISON #" : gettext(msgid);
> + =C2=A0 =C2=A0 =C2=A0 errno =3D saved_errno;
> + =C2=A0 =C2=A0 =C2=A0 return r;
> =C2=A0}
>
> =C2=A0static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)

The last line belongs to Q_(), which needs the same treatment.
--=20
Duy
