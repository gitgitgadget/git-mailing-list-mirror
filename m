From: Antriksh Pany <antriksh.pany@gmail.com>
Subject: Re: [PATCH v3 1/2] compat: add a mkstemps() compatibility function
Date: Wed, 3 Jun 2009 21:29:06 +0530
Message-ID: <e6cd6cf90906030859m2725856cl77e210d87e261df0@mail.gmail.com>
References: <1243503831-17993-1-git-send-email-davvid@gmail.com>
	 <e6cd6cf90906020535m24d588eau40b800555c9e906f@mail.gmail.com>
	 <4A252381.9000103@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, markus.heidelberg@web.de, jnareb@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 17:59:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBss4-0005Lp-Aw
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 17:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbZFCP7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2009 11:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753741AbZFCP7H
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 11:59:07 -0400
Received: from mail-qy0-f189.google.com ([209.85.221.189]:48306 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbZFCP7G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 11:59:06 -0400
X-Greylist: delayed 98607 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2009 11:59:06 EDT
Received: by qyk27 with SMTP id 27so123609qyk.33
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aaNBkSnLXTtQBTU5F5K9+DRiFwo/7QBdk9gQ5gdUFdw=;
        b=D2YbPVOYzvrxRS3S4DzaT1dQBVO1X+GoLK52lM62V0tTMykcZSVBw8lVC4Cx9BY+k/
         kExVa9deoSThJaZUGdN7oCGIWN8lvW42ZRShZdHzwhJbyCP2+ogVI3IlkFgtR3824w6U
         TNGGVYEFUM5IkBhgDdFq+Lreh4eRVG7Fgzg48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J3fYTlb5k89qszFWWYZGB7T1lIMdGvnsi9+0ewAPCg4yFphwpIVZxdzzHCEeU9FBMK
         nZ3dOqbUrTsE4ciOOxCIuP/eXyE2fQaHrFwe/H5/1RPrKRjftjnFXTkHmyu7/2ZZ4In+
         qaYuZPLa4az3z6dLxfIvEWzMFHxJ5r14AcyQ4=
Received: by 10.229.70.139 with SMTP id d11mr386849qcj.51.1244044747046; Wed, 
	03 Jun 2009 08:59:07 -0700 (PDT)
In-Reply-To: <4A252381.9000103@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120617>

Oh ok, didn't realize the sixth division was not used. In which case,
we needn't have the sixth division.

Also, 62^5 compared to 2^32 still gives a ~ 21% probability of the
fifth division becoming zero, fairly high perhaps.

The suggestion to change the code to
   ((uint64_t) tv.tv_usec) << 16)
might help here. This would still leave about a 1.4% chance of v
becoming zero, higher than (being pedantic!) what perfect randomness
would require. Livable. But (just curious), do we see any loss in
shifting a few more positions?

- Antriksh


On Tue, Jun 2, 2009 at 6:35 PM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Antriksh Pany schrieb:
>> 2. tv_usec has a decimal value range of 0-999999 =A0(10^6 usec make =
1
>> sec). Which means that tv_usec fits completely in 20 bits (or less).
>> (tv_usec << 16) yields a number that fits completely in 36 bits (or
>> less). Max value of this number is 999999 * 2^16, or for convenience=
,
>> about M =3D 10^6 * 2^16. This number (in the range of 0 to M) goes o=
n to
>> be divided by D=3D62^6. Also, M > D. Thus, there is about a =A0D / M=
 * 100
>> ~ 87 % probability of the division M / D working out to be zero. i.e=
,
>> in 87% cases, the last division (v/=3D num_letters) will cause 'v' t=
o
>> become 0.
>
> But this value (after the 6th division, mind you) is not used. v is u=
sed
> the last time after the 5th division; at this time it still carries e=
nough
> randomness: 62^5 < 2^32.
>
> -- Hannes
>
>
