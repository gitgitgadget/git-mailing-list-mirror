From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [BUG] serious inflate inconsistency on master
Date: Wed, 4 Jul 2012 12:35:34 +0700
Message-ID: <CACsJy8AFs6PV8XCAUar9KadE8g-WSaZofKQAGPB6VjbhVpSRig@mail.gmail.com>
References: <20120703221900.GA28897@sigill.intra.peff.net> <7vipe4tqns.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 07:36:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmIG6-0001Fh-68
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 07:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422Ab2GDFgJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jul 2012 01:36:09 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:37761 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087Ab2GDFgG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2012 01:36:06 -0400
Received: by werb14 with SMTP id b14so4054360wer.19
        for <git@vger.kernel.org>; Tue, 03 Jul 2012 22:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=raWMGPYm89w8jr3ISpXXfeX3DUG1bZJ4Q/CQ87FgtIU=;
        b=imnFgZRlpDhxCqAnEt+m+KvpSO6TV3X47gQnk8utwnqLBz8mu6U/QxwYuuh3kxPO/d
         4Emc11lQSDwGHBojr/l0IjXqZ66N5OXLNSu6ecwSne+t9pA5SwFuplT6XzH/aNHELzaN
         eAEtDLypJe8mGjhjW8Qcv/waOTKh8U8qynQJgEIdlEtbF2hhgJTrhfcCPa8uEtlKEZFr
         IwodoxGtDwmwInppxLpRMu7Yr7Njhs0iCqNS2JGVedyiNnLc92H29g0K4ocV1VyWL2Q0
         YjeFZf8uSK6UL/l36O8MPrMv6TWWLgkzQsImDMmBB5mwSBMH5L5KhzLS2fk2QfZwt57R
         +sOg==
Received: by 10.180.78.197 with SMTP id d5mr37402184wix.7.1341380164458; Tue,
 03 Jul 2012 22:36:04 -0700 (PDT)
Received: by 10.223.79.76 with HTTP; Tue, 3 Jul 2012 22:35:34 -0700 (PDT)
In-Reply-To: <7vipe4tqns.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200983>

On Wed, Jul 4, 2012 at 5:40 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jeff King <peff@peff.net> writes:
>
>> The problem seems to be in index-pack.c:unpack_data, which does this=
:
>>
>>> =C2=A0 =C2=A0 =C2=A0git_inflate_init(&stream);
>>> =C2=A0 =C2=A0 =C2=A0stream.next_out =3D data;
>>> =C2=A0 =C2=A0 =C2=A0stream.avail_out =3D consume ? 64*1024 : obj->s=
ize;
>>>
>>> =C2=A0 =C2=A0 =C2=A0do {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char *last=
_out =3D stream.next_out;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t n =3D (len =
< 64*1024) ? len : 64*1024;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D pread(pack_fd=
, inbuf, n, from);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (n < 0)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0die_errno(_("cannot pread pack file"));
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!n)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0die(Q_("premature end of pack file, %lu byte missing",
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "premature end of pack file, %lu bytes mis=
sing",
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len),
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0len);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from +=3D n;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len -=3D n;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stream.next_in =3D =
inbuf;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stream.avail_in =3D=
 n;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D git_infl=
ate(&stream, 0);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (consume) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (consume(last_out, stream.next_out - last_out, cb_data)) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(inbuf);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(data);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0stream.next_out =3D data;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0stream.avail_out =3D 64*1024;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> =C2=A0 =C2=A0 =C2=A0} while (len && status =3D=3D Z_OK && !stream.a=
vail_in);
>>>
>>> =C2=A0 =C2=A0 =C2=A0/* This has been inflated OK when first encount=
ered, so... */
>>> =C2=A0 =C2=A0 =C2=A0if (status !=3D Z_STREAM_END || stream.total_ou=
t !=3D obj->size)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die(_("serious infl=
ate inconsistency"));
>
> Yeah, that "if (consume)" part is clearly bogus. =C2=A0It should feed
> what it read in "inbuf" fully to git_inflate() in a (missing) inner
> loop and keep feeding consume() with the inflated data, but instead
> happily goes on to read more from the packfile once the initial part
> of the inflated data is fed to consume, ignoring the remainder.

Agreed.

>> So I don't really understand what this !stream.avail_in is doing the=
re
>> in the do-while loop. =C2=A0Don't we instead need to have an inner l=
oop that
>> keeps feeding the result of pread into git_inflate until we don't ha=
ve
>> any available data left?
>
> Exactly. =C2=A0I do not think the avain_in check should be done at th=
e
> end of the outer loop at all. =C2=A0When we are buffering the entire
> inflated data in core without using consume, we allocate enough
> memory to "data" to hold the whole thing, so in that case, it may be
> OK to expect that git_inflate() would never return without consuming
> the input bytes (i.e. stream.avail_in would always be zero at the
> site of the check), but with consume(), we give small piece of
> memory as a temporary output area and call git_inflate(), and it is
> entirely possible and normal for it to run out of output before
> inflating all the input bytes.

Maybe the !stream.avail_in check is for safety? obj->size could be
wrong due to an index-pack bug, leading to insufficient avail_out..

By the way I searched the commit that introduces that check with "git
log --follow -p builtin/index-pack.c" but I could not find it. What
did I do wrong?
--=20
Duy
