From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv3 5/6] fast-export: Fix output order of D/F changes
Date: Wed, 7 Jul 2010 22:36:38 -0600
Message-ID: <AANLkTiklqqxUhTBd4In-VQed_SMQ6X0nk2j2ysE20bmD@mail.gmail.com>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
	<1278480034-22939-6-git-send-email-newren@gmail.com>
	<7vy6dnrmvu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org, agladysh@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 06:36:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWiqr-0005M4-FQ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 06:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153Ab0GHEgk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 00:36:40 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44800 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab0GHEgj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 00:36:39 -0400
Received: by vws5 with SMTP id 5so583942vws.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 21:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r0Z+IKRCZ0XWeYmzBI6Eq2RT4V1vaktr44vDkfIkWlQ=;
        b=cX7SDJXqfPlJEbVfC/Cx27lnVihV6awLfpVhu/UL/VWVF3xz4VmxBKKPfoXhGGwKbP
         mIAyAQyByxig2vuxqcxaoezJORqK3bTh26arOqAOO3ivQk756/FPNVHqg/aPJLs3B1Y0
         /kD7fxtlsEZYC38rJyT8BdQVrbtXyoiTXflVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dwRD6O3wy9Em8zDu15l9pQVylqiCubxpPuG4cH1brDtaxsjChvB4WJM6F8pUE4wFmK
         5caUihZa6n8kZrOlWNLWIwnjJ4Z2xjLDO1G2NaIQd3vRAnH43pDiqfRmusMJnDXcQBpw
         HxHbncP/+mYP97Cp0aTOaQG7kgQlCxlkI6mtQ=
Received: by 10.220.125.4 with SMTP id w4mr3962402vcr.171.1278563798627; Wed, 
	07 Jul 2010 21:36:38 -0700 (PDT)
Received: by 10.220.92.199 with HTTP; Wed, 7 Jul 2010 21:36:38 -0700 (PDT)
In-Reply-To: <7vy6dnrmvu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150534>

On Wed, Jul 7, 2010 at 3:40 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> newren@gmail.com writes:
>
>> From: Elijah Newren <newren@gmail.com>
>>
>> The fast-import stream format requires incremental changes which tak=
e place
>> immediately, meaning that for D->F conversions all files below the r=
elevant
>> directory must be deleted before the resulting file of the same name=
 is
>> created. =C2=A0Reversing the order can result in fast-import silentl=
y deleting
>> the file right after creating it, resulting in the file missing from=
 the
>> resulting repository.
>>
>> We correct the order by instructing the diff_tree machinery to compa=
re
>> entries using df_name_compare instead of base_name_compare.
>
> I am not so sure about this one.
>
> You can be walking two trees, one of which has "b-1" (blob), "b-2" (b=
lob)
> and then "b" (tree), while the other one has "b" (blob), "b-1" (blob)=
 and
> then "b-2" (blob). =C2=A0The patch tells the machinery that "b" (tree=
) sorts
> just like "b" (blob) only during comparison, but the actual data stre=
am it
> is walking is sorted differently. =C2=A0Without some form of lookahea=
d, can you
> reliably "correct the order"?

Doh! Yep, you're right.  My patch would not handle that case
correctly.  I'll dig further.
