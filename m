From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH 1/2] sha1_name: try to use same abbrev length when
 core.abbrevguard is specified
Date: Thu, 10 Mar 2011 14:27:35 +0900
Message-ID: <1299734855.1496.9.camel@leonhard>
References: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
	 <7vipvsaz27.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 06:27:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxYPd-0000Rg-6r
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 06:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197Ab1CJF1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 00:27:44 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34580 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab1CJF1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 00:27:43 -0500
Received: by iwn34 with SMTP id 34so1193809iwn.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 21:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=FWi8gbykH+MmXEfxt2ofQhMyDYmOQ540aYpbJecmDus=;
        b=EeiRLWvWO/dPYt5jqyNxO798S0IKEGTts2kewE/8ENZ8xUWWOCpXe6p0Y06v6JMWTG
         HXC2M0xUKpCUKCCI1E38TDHKoeY+DF2AiiBtjD9Ccax/Y4uYtmZ5NBYTjyl9o+BdhMxP
         W2Vij28h45lSQasW4CYIopyh3Y6NXnuZdXTtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=FYOTx/moHzpAjKuGFSQn4jVp7yGKLHI6eDvrmM6nq2rGMGRC5vDnT9cxx1kZ2ifAnI
         Hwkrcpu1tgC0zEJtXG+nGowsjp4vSYEjjryRcFxE3oSZ5Sm7P5RqpE4/BLWBKycuXcF5
         gt0YTNJHvHbGeIPL9PhbgHfhrs0nhJkQlJBys=
Received: by 10.43.55.2 with SMTP id vw2mr9281666icb.326.1299734862740;
        Wed, 09 Mar 2011 21:27:42 -0800 (PST)
Received: from [118.176.73.109] ([118.176.73.109])
        by mx.google.com with ESMTPS id wo11sm1359744icb.20.2011.03.09.21.27.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 21:27:41 -0800 (PST)
In-Reply-To: <7vipvsaz27.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168788>

2011-03-09 (=EC=88=98), 11:12 -0800, Junio C Hamano:=20
> Namhyung Kim <namhyung@gmail.com> writes:
>=20
> > If find_unique_abbrev() finds a ambiguous SHA1 name, it tries
> > to find again with increased length. In this case, result hex
> > strings could have different lengths even though the
> > core.abbrevguard config option is specified. But if the option
> > is specified and increased length (delta) is less than its
> > value, the result could be adjusted to the same length.
>=20
> I am not sure if I can understand what problem you are trying to solv=
e
> from the above description.
>=20

That's probably because of my poor English. :(


> The function is given "len" from the caller to specify the minimum le=
ngth
> of the output the caller expects (i.e. even if 4 hexdigits is enough =
to
> identify the given commit in a small project, the caller can say it w=
ants
> to see at least 7 hexdigits).  The loop without your patch finds the
> shortest prefix whose length is at least that given length that uniqu=
ely
> identifies the given object (or the shortest prefix that doesn't iden=
tify
> any existing object if the given sha1 does not exist in the repositor=
y).
> And then ensures the returned value is longer by the guard as an extr=
a
> safety measure, so that later when the project grows, the disambiguat=
ion
> we find today has a better chance to survive.
>=20
> With this patch, the loop decreases the length of the guard when "len=
"
> given by the caller is insufficient to ensure uniqueness, which does =
not
> sound right.
>=20
> Suppose the given object has ambiguous other objects and you need 8
> hexdigits at least to make it unique in today's history.  The caller =
gives
> you len of 7, and the guard is set to 3.
>=20
> With the original code, the loop starts with 7, finds that it is not
> long enough to disambiguate, increments and retries, finds that 8 is =
the
> shortest prefix, and then adds the guard and returns 11 hexdigits.
>=20
> With your patch, the loop starts with 7 with extra set to 3, finds th=
at 7
> is not long enough and decrements extra to 2, finds that 8 is the sho=
rtest
> prefix, and then returns only 10 hexdigits.
>=20
> Which feels like totally going against the reason why we added the gu=
ard.
>=20
> What am I missing?
>=20

What I was thinking is like below (from a user's point of view):

I knew git use 7 hexdigit to represent a commit object and it was not
enough for my project. So I gave it 5 for the guard and expected to see
12 in everywhere - if 12 always guarantees uniqueness for the project
now and probably, the near future. But sometimes git prints 13 even
though 12 is long enough to represent the commit uniquely. Because 7 is
not enough but 8 is, and simply add 5 (the guard) to it.

So I thought it would be natural to print 12 always in this case and
thus, submitted the patch.

Thanks.

--=20
Regards,
Namhyung Kim
