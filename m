From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Convert "pop" to the lib infrastructure
Date: Thu, 2 Apr 2009 17:20:45 +0100
Message-ID: <b0943d9e0904020920t1a5b87b3i6ac0b37fbcf2ec62@mail.gmail.com>
References: <20090331113027.2524.60993.stgit@pc1117.cambridge.arm.com>
	 <20090401120515.GA30918@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 18:22:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpPgR-0007b4-Cs
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 18:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759490AbZDBQUt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 12:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758789AbZDBQUt
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 12:20:49 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:38430 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756476AbZDBQUs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 12:20:48 -0400
Received: by fxm2 with SMTP id 2so605797fxm.37
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MTAdXkfJQBIknWlQPojBRlYVBpK56LPElJqj90dQing=;
        b=aBtbJY49OWVXAbne5NGf3qeMlBp7Pse0nDpOEwoMy7GWNIFIcGbfUejwi5Vb/M6F58
         g+XSp64iFcLHmzrZH7Ita8rJedsOdoWqdbstYS0TyQ/rRTr1dMsd3JEgwmHVTtmGwjR0
         rl5g4tWEVPgez7RXj7nwM+0QXBwBCw6gFgZ2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vnGty1l69X8MandmGmycL1/Gv7c/bBt8Qw36TxWEd8X9esl+07ea5C487i9M/vNc+y
         NfDqtEFaaQPGaHcuJaaaFOV5dRJY5bxt5oXBspu5UoSAO++/YxZ9ie578UaEgmQNDV83
         JzOMh5DPPmkN7xfyI12Dt9zb1dEhphbcItKGY=
Received: by 10.204.54.143 with SMTP id q15mr52340bkg.148.1238689245347; Thu, 
	02 Apr 2009 09:20:45 -0700 (PDT)
In-Reply-To: <20090401120515.GA30918@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115475>

2009/4/1 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-03-31 12:30:27 +0100, Catalin Marinas wrote:
>
>> @@ -47,7 +47,7 @@ test_expect_success 'Try to reset with --hard' '
>> =A0 =A0 =A0stg reset --hard master.stgit^~1 &&
>> =A0 =A0 =A0stg status a > actual.txt &&
>> =A0 =A0 =A0test_cmp expected.txt actual.txt &&
>> - =A0 =A0test "$(echo $(stg series))" =3D "> p1 - p3 - p2"
>> + =A0 =A0test "$(echo $(stg series))" =3D "> p1 - p2 - p3"
>> =A0'
>
> Hmm, why this change in behavior? Something that should be noted in
> the commit message?
>
>> @@ -47,7 +47,7 @@ test_expect_success 'Try to undo with --hard' '
>> =A0 =A0 =A0stg undo --hard &&
>> =A0 =A0 =A0stg status a > actual.txt &&
>> =A0 =A0 =A0test_cmp expected.txt actual.txt &&
>> - =A0 =A0test "$(echo $(stg series))" =3D "> p1 - p3 - p2"
>> + =A0 =A0test "$(echo $(stg series))" =3D "> p1 - p2 - p3"
>> =A0'
>
> And I guess this is the same.

I think we now get a slightly different behaviour because of how the
transactions are generated with the new infrastructure. In the above
case, you have "pop p2 p3" and "push p3", the latter failing. The "pop
p2 p3" command results in the stack being "> p1 - p2 - p3" while "push
p3" performs a single step for pushing and reordering. The old push
caused a reorder followed by a push.

So I think I should place the push changes before the pop ones so that
pop itself doesn't fail.

I'll try to push them tonight as I'll go on holiday soon for two weeks.

--=20
Catalin
