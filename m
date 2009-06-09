From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Tue, 9 Jun 2009 06:24:04 +0200
Message-ID: <c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	 <7vskidcf9s.fsf@alter.siamese.dyndns.org>
	 <200906070932.36913.chriscool@tuxfamily.org>
	 <4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>
	 <4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 06:24:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDstA-0003aK-4T
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 06:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbZFIEYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 00:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbZFIEYE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 00:24:04 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:41521 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbZFIEYD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 00:24:03 -0400
Received: by fxm9 with SMTP id 9so2672970fxm.37
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 21:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FWNLK7HN6323BYItxEAae1PmFxhi0iCl2LwbvUQovT0=;
        b=I+I0U08g8npoorh2htLnPXudGA1Y8vQr6zx7BgcXFWH172DXefhj3bIgC+aPOZSLJI
         GJa7Gn23zwZt+Bn07gkfU8Jv8R/ULVp3m9pxtPnWW7bHkme87V1HCfpZEIKLUv7L6wef
         pdAIRD0smeGUYvJPJxGxeSpbOQoHj6+BuyM2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tm5HKpiDMgTz19l/qKqUZWM3fUKIo+8pxm7fqcb52Z87pgJcTgF3DQQqDkoYxyETB+
         eZFuuTcp1kT6mHc/nvH6tAu02fsG1nqq2T7bnitbzJzyM8GCA1LgSxkF18aNd2LbH1he
         exlFXvqU9FufdIodo6QqjaInOMmXZmH+q1y4s=
Received: by 10.102.247.10 with SMTP id u10mr2713816muh.76.1244521444211; Mon, 
	08 Jun 2009 21:24:04 -0700 (PDT)
In-Reply-To: <7vzlcixwue.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121137>

On Mon, Jun 8, 2009 at 11:02 PM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> "H. Peter Anvin" <hpa@zytor.com> writes:
>
>> The advantage of that -- and I have to admit I don't know if it will
>> ever matter in practice -- is that using an actual PRNG:
>>
>> a) is less likely to get into pathological capture behaviors.
>> b) doesn't make people think later that there is something magic to =
the
>> =A0 =A0arbitrary chosen numbers.
>
> My gut feeling agrees with you that both are likely to be true; these=
 are
> good points.
>
> Christian, what do you think?

Here are some reasons why I think my algorithm might be better:

- using HPA's formula I get on average 0.86 bits of information at
each step when alternating (against 0.72 when using a PRNG)
- I think that if the branches in the graph merge often between each
other, then on a big scale it's like when you are on the linear case
- I don't think we should try too hard to avoid pathological capture
behaviors, because I think we can't avoid them anyway in some cases,
like if the first bad commit is near many untestable commits

In the end I think that when you have too many long and completely
untestable branches for example, the right solution would be to have
something that lets you cut them off your graph and bisect on a much
cleaner graph, that's why I started working on "git replace" in the
first place.

I think we should not penalize people who have a quite clean graph
because some other people have a much dirtier one.

So I would be ok to implement a config option or a switch to "git
bisect start" to let people use a PRNG instead of my algorithm but I
think something like my algorithm should be the default.

Best regards,
Christian.
