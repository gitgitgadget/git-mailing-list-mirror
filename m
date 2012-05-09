From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] sha1_name: support sha1^{note} to return note sha-1
Date: Wed, 9 May 2012 15:25:15 +0700
Message-ID: <CACsJy8AfD-N6L6nZNDG3uw4s6jAdYqkuQ8Jt2XRXRGzRwt1ncQ@mail.gmail.com>
References: <1336482870-30842-1-git-send-email-pclouds@gmail.com> <20120508161126.GB26838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 09 10:25:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS2Dc-0002Yo-BU
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 10:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757780Ab2EIIZu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 04:25:50 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49916 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab2EIIZr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 04:25:47 -0400
Received: by wibhr2 with SMTP id hr2so181153wib.1
        for <git@vger.kernel.org>; Wed, 09 May 2012 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ASmv6qL8JUYtGjzG9JONSZZ5TNnWYSgZ5u0yfFVG/04=;
        b=MzONf0E4XMNVFFvE+PPXadslL50qNKDhx7PwzOnS/PGHuFAE7BJf0U9K1pqcXHYL0E
         IbLy8jrmQp1IoujQSWjLQwVJedvLGIk0L8EqAVLQ89td/WoUCD7vxxwoiD9gpQIzCOw6
         rgjWwcbhUJRozxSkCf7ho01TtKG3FEoyrzOfWQm7+g7gmtm6U6XniPjUPZM7AZAKXrR/
         gzJVNlPN7ksLV9gfcRKIvzpdLiTZtWW3phnBKuib0zm+/+HeaBYSoJMjiSk0LUc8dEfK
         lEJ9yimVEi3Ecp4dP5bKRYi7thw2LsKy2xFsjQ9vrNPFTZTxZxE7e5Xrt9i9rrB5Ns1S
         HWSA==
Received: by 10.180.81.166 with SMTP id b6mr4704324wiy.0.1336551946572; Wed,
 09 May 2012 01:25:46 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Wed, 9 May 2012 01:25:15 -0700 (PDT)
In-Reply-To: <20120508161126.GB26838@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197461>

On Tue, May 8, 2012 at 11:11 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 08, 2012 at 08:14:30PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> =C2=A0It may be useful for scripting, and looks nice. Though may be =
not
>> =C2=A0worth adding if there are no actual users.
>
> There can be many notes refs. So I think to do this right, you would
> want something like:
>
> =C2=A0foo^{note:bar}
>
> which would look in refs/notes/bar (this logic is handled by
> expand_notes_ref). And "foo^{note}" would be a synonym for the defaul=
t
> note ref.

Right. Thanks.

>> @@ -473,7 +474,19 @@ static int peel_onion(const char *name, int len=
, unsigned char *sha1)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_type =3D O=
BJ_NONE;
>> =C2=A0 =C2=A0 =C2=A0 else if (sp[0] =3D=3D '/')
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_type =3D O=
BJ_COMMIT;
>> - =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 else if (!strncmp("note}", sp, 5)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned char *not=
e;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct notes_tree t;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_sha1_1(name, sp =
- name - 2, outer))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&t, 0, sizeof(t))=
;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_notes(&t, NULL, NUL=
L, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 note =3D get_note(&t, ou=
ter);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (note)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 hashcpy(sha1, note);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free_notes(&t);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return note ? 0 : -1;
>> + =C2=A0 =C2=A0 } else
>
> The notes code is relatively expensive to initialize, with the
> assumption that the effort will be amortized across multiple lookups
> (which are made faster). Is it possible to cache this initialized not=
es
> structure in case many lookups are done?

No idea. I have never worked/used notes until yesterday (and these
patches were the result). I will look into it.

> It may not be as important as it used to be, either. I think more rec=
ent
> versions of the code will progressively load the notes tree rather th=
an
> filling it all in at initialization time. But it has been a while sin=
ce
> I've done anything with notes.
--=20
Duy
