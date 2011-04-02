From: Dan McGee <dpmcgee@gmail.com>
Subject: Fwd: [PATCH 1/5] diff_tree_sha1: skip diff_tree if old == new
Date: Sat, 2 Apr 2011 13:38:21 -0500
Message-ID: <BANLkTi=hJm4ax__5DDCvK9VdLcNxVO2bVA@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
	<7vfwq1ehcq.fsf@alter.siamese.dyndns.org>
	<AANLkTinPSqDPdGi5nA3sH1D2wMSW1SQc+5gRqdLy++y0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 20:38:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q65iP-00086G-5Z
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 20:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360Ab1DBSiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Apr 2011 14:38:24 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48310 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1DBSiX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Apr 2011 14:38:23 -0400
Received: by wwa36 with SMTP id 36so5174356wwa.1
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=SVtcrQWTmGCSdyFPU1SrtC5ZdDiPvJqEOSMdkAvQNso=;
        b=VWbGGmcsnx+tcJCbvSalA1DDs9qh46HWXLJeQ2UknD2/ej+rp2/u1Ild9A+sp7WLOE
         c94NJBvruoGnyOFkDJaIow1vcybf/bC9ippfGy0qn5szUwv8Y3s919z8CmPACco6DkTL
         qidz+0oTXJDsJ+1g3rDcwbjMrKln1Wcl/BDPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=iZ122+lybjG1cZdVX6/ByyhyiazEjYaRGtNbkw5nx7o0pr3D5zaKMXkuhuNuEJBj47
         zhQsl2WqX5cjyLGFDA1BHIqzaVqJrGQtdfnC+oT3ODRLaqD4SZSN0F8QIA0oClBSOn/z
         JNH/vHjSlTWwSOMgGuUoOgoIg0SE44mupvhCI=
Received: by 10.227.195.6 with SMTP id ea6mr5460454wbb.74.1301769501941; Sat,
 02 Apr 2011 11:38:21 -0700 (PDT)
Received: by 10.227.147.16 with HTTP; Sat, 2 Apr 2011 11:38:21 -0700 (PDT)
In-Reply-To: <AANLkTinPSqDPdGi5nA3sH1D2wMSW1SQc+5gRqdLy++y0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170657>

=46orgot to forward this to the list as well, I apologize.

On Fri, Apr 1, 2011 at 5:28 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Dan McGee <dpmcgee@gmail.com> writes:
>
>> This was seen to happen in some invocations of git-log with a filter=
ed
>> path. Only do it if we are not recursively descending, as otherwise =
we
>> mess with copy and rename detection in full tree moves.
>
> There is no code that corresponds to your "Only do it..." description=
 in
> your patch, though. =C2=A0The existing code already takes care of tha=
t part
> with or without your patch, no?

Damn, I forgot to update the message- see below.

>> diff --git a/tree-diff.c b/tree-diff.c
>> index 76f83fc..ab90f1a 100644
>> --- a/tree-diff.c
>> +++ b/tree-diff.c
>> @@ -286,6 +286,9 @@ int diff_tree_sha1(const unsigned char *old, con=
st unsigned char *new, const cha
>> =C2=A0 =C2=A0 =C2=A0 unsigned long size1, size2;
>> =C2=A0 =C2=A0 =C2=A0 int retval;
>>
>> + =C2=A0 =C2=A0 if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashc=
mp(old, new))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> +
>
> I am very curious why this patch makes a difference; doesn't an exist=
ing
> test in compare_tree_entry() oalready cull extra recursion? =C2=A0The=
re is:

This was originally testing RECURSIVE; however I discovered that was
not the culprit to my failed tests.

t9300-fastimport.sh was failing on "copy then modify subdirectory" due
to the full info not being loaded for the before sha1 in that test-
instead of showing the fcf778cda ... C100 part (this is just the first
line of expected, all were the same), it was 000000 ... A. once I
added the above fallthrough to not shortcut if this option was
enabled, things worked fine and all tests passed.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)=
 && !hashcmp(sha1, sha2) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mode1 =3D=3D m=
ode2)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> before a recursive call to diff_tree_sha1() to dig deeper.
>

I'm not totally sure why this check wasn't working, but without the
above exception my patch definitely broke tests.

-Dan
