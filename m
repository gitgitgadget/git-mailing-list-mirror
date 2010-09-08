From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/3] merge-recursive: Small code cleanup
Date: Wed, 8 Sep 2010 00:24:03 -0600
Message-ID: <AANLkTim5AA7mnAhkbqJaFcUv9vniTVG7siOMxE+y=ehf@mail.gmail.com>
References: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
	<1283806070-22027-3-git-send-email-newren@gmail.com>
	<EF9FEAB3A4B7D245B0801936B6EF4A254B6BBD@azsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"oinksocket@letterboxes.org" <oinksocket@letterboxes.org>
To: "Schalk, Ken" <ken.schalk@intel.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 08:24:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtE4q-0007WV-AG
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 08:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757110Ab0IHGYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 02:24:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54788 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab0IHGYF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 02:24:05 -0400
Received: by fxm16 with SMTP id 16so525064fxm.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 23:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Vg2A8YFTKlT03yht0X76cbECN0lu9r+kXKMlFYGfm6g=;
        b=gpyyOAM/t7LEKL6T41leRcHYY2YOrZvxgU8Oqr49fEORs86iUg8yUNVfCbSsN7CFTs
         F50c0c4Pro8DEK9tnwxzAVLaCdJuPcb8TwMpmbXz6bzaTtWd4IEUVVjoG0RBUmYJn7Wd
         UwH0sGus3hwgDvTISScULGk81xyJeXIrLyWao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=laCXRRW38POiPu7iLoLwPKMPCD4heJ9rTNvCTdLBCTchxOAZofB2R8K32k7oEYsgwm
         gDiC8KAduUv5N7OT8olbUi8y5ngkZ9t6XBXLN1NwgU1LFYGaNNB/2eUitoTRvlGJnc37
         fPhE2ysvYDv2GeQw83ZoxIuA6uTZeObNUj5Po=
Received: by 10.223.116.20 with SMTP id k20mr624551faq.97.1283927043763; Tue,
 07 Sep 2010 23:24:03 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Tue, 7 Sep 2010 23:24:03 -0700 (PDT)
In-Reply-To: <EF9FEAB3A4B7D245B0801936B6EF4A254B6BBD@azsmsx503.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155768>

On Tue, Sep 7, 2010 at 10:23 AM, Schalk, Ken <ken.schalk@intel.com> wro=
te:
>>Also, in d5af510 (RE: [PATCH] Avoid rename/add conflict when contents=
 are
>>identical 2010-09-01), a separate if-block was added to provide a spe=
cial
>>case for the rename/add conflict case that can be resolved (namely wh=
en
>>the contents on the destination side are identical). =C2=A0However, a=
s a
>>separate if block, it's not immediately obvious that its code is rela=
ted to
>>the subsequent code checking for a rename/add conflict. =C2=A0We can =
combine and
>>simplify the check slightly.
>
> Originally I tried the fix the way you've re-structured it, just addi=
ng a test to the if around the rename/add conflict handling. =C2=A0Unfo=
rtunately that didn't completely solve the problem in the case that ori=
ginally motivated the fix (rename vs. rename+symlink, as in my initial =
post and my first attempt at adding a test to t/t3030-merge-recursive.s=
h). =C2=A0That's why I changed it to a separate if block.
>
> The problem comes down in the code inside the "if(try_merge)" block b=
elow. =C2=A0It merges the source of the rename on the other side with t=
he renamed file, rather than the destination. =C2=A0In the case with th=
e symlink on the other side, this code merged a symlink with a regular =
file which resulted in a conflict. =C2=A0I was trying to eliminate both=
 conflicts in this case by avoiding the final else that sets try_merge=3D=
1.
>
> Your re-structuring will therefore only solve half the problem I was =
trying to solve.
>
> I suppose an alternative solution would have been to change the "if(t=
ry_merge)" code to merge with the destination of the rename on the othe=
r side, if it exists and is the same type. =C2=A0However that clearly w=
ould have had a much more significant impact on other merge cases, so i=
t didn't seem like a good choice to me.

Interesting...that means we probably should have stuck with the
original testcase you suggested (though marking it with the SYMLINK
dependence), since the new one doesn't fail with my modifications but
the old one would.  The typechange is critical.  So I'll drop that
portion of my patch.

Perhaps you could submit another patch changing your testcase back to
using a symlink to make sure someone like me doesn't break your
original testcase in the future?


Thanks,
Elijah
