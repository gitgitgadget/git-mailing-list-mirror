From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 4/8] gitweb: Extract print_sidebyside_diff_lines()
Date: Fri, 6 Apr 2012 00:57:33 +0200
Message-ID: <201204060057.34138.jnareb@gmail.com>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com> <201204050047.10357.jnareb@gmail.com> <20120405080633.3836f49b@mkiedrowicz.ivo.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:57:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFvcc-0003n4-2M
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 00:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751Ab2DEW5g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 18:57:36 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55324 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab2DEW5f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 18:57:35 -0400
Received: by wgbdr13 with SMTP id dr13so1720147wgb.1
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 15:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=jSvHtZKx4gy2Ncy0VHFMOuqUszR3JgXBFuKj2HFlFoM=;
        b=WLw/WmEaL/5GRALOgsp5X9zLIjEAC1XLgawd+99mijmbmYnkMRjUAQo1J3Dm6BS/6q
         QOfdmFoxClOfHSKuknd6Yt49GNEnjuAryqDkdtFhX31rmGOT+3XLXR44h96Oa2VpM85B
         IKeRgQbaf8TWGY3Zd/TCWuSDzvEXcvKrOA4rFLEacATag5it2K+GLEy2p5gC1Cjz2sAb
         vNRfuvREuvtuhqYaR4lxE33RmhNWkGaYlpIS1qrqx5C30w9yjSpFSPSzHQ9wIngreKQh
         Y8yr2AAjQmyE0cDLSf+zEwxQwaKrfzxW2VYcVg6j+n43LlPRZ1p6KEF2tAo56U/jgnR9
         wt+A==
Received: by 10.180.92.228 with SMTP id cp4mr14666656wib.2.1333666654030;
        Thu, 05 Apr 2012 15:57:34 -0700 (PDT)
Received: from [192.168.1.13] (acxc205.neoplus.adsl.tpnet.pl. [83.11.160.205])
        by mx.google.com with ESMTPS id k6sm1141487wie.9.2012.04.05.15.57.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 15:57:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120405080633.3836f49b@mkiedrowicz.ivo.pl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194818>

Michal Kiedrowicz wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Junio C Hamano wrote:
>>> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

>>>> -		# empty add/rem block on start context block, or
>>>> end of chunk
>>>> -		if ((@rem || @add) && (!$class || $class eq
>>>> 'ctx')) { -...
>>>> +		## print from accumulator when have some add/rem
>>>> lines or end
>>>> +		# of chunk (flush context lines)
>>>> +		if (((@rem || @add) && $class eq 'ctx')
>>>> || !$class) {
>>>=20
>>> This seems to change the condition.  Earlier, it held true if
>>> (there is anything to show), and (class is unset or equal to ctx).
>>> The new code says something different.
>>=20
>> Yes it does, as described in the commit message:
>>=20
>>                                                     [...] It should
>>   not change the gitweb output, but it **slightly changes its
>> behavior**. Before this commit, context is printed on the class
>> change. Now,  it's printed just before printing added and removed
>> lines, and at the end of chunk.
>>=20
>> The difference is that context lines are also printed accumulated no=
w.
>> Though why this change is required for refactoring could have been
>> described in more detail...
>=20
> I changed that because I wanted to squash both conditions (the one th=
at
> checks if @ctx should be printed and the one that prints @add/@rem
> lines) and have just one call to print_sidebyside_diff_lines().  Late=
r,
> this function is changed to print_diff_lines() and controls whether
> 'inline' or 'side-by-side' diff should be printed.  Having two
> conditions and two calls/functions would make the code redundant.  Th=
en
> I thought that instead of calling twice print_sidebyside_diff_lines()
> (for @ctx and @add/@rem lines, like the code from pre-image prints
> these lines separatedly), I can just call it once.
>=20
> I can revert this change to previous behavior but I think that would
> make the condition more complicated.

No, I think that this change is good idea if it simplifies code flow.
But it really should be described in commit message, not only "what"
(which you did describe), but also "whys".

--=20
Jakub Narebski
Poland
