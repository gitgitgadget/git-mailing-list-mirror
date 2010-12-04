From: ghazel@gmail.com
Subject: Re: git reset and ctime
Date: Fri, 3 Dec 2010 17:39:08 -0800
Message-ID: <AANLkTi=MSf+0rkBmvuJQBaSs1-G_gFahnLvt44fnwAwf@mail.gmail.com>
References: <AANLkTimyYTup+PqJFJ+2g-tVwWXA2bxTT3noonEuKBSu@mail.gmail.com> <20101204005131.GB15906@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 02:39:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POh69-0006ri-LS
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 02:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab0LDBjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 20:39:31 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56013 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970Ab0LDBja convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 20:39:30 -0500
Received: by qwb7 with SMTP id 7so10291321qwb.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 17:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ebMxAOR8QxgM4NXiNC+h22m9PRMhK1fWFtNqbm5SfYA=;
        b=FH8Vymr9omBKbv/o0Imwnm01eB3HjyYmxPfnlkIlpwsJUxyXOakKMbVa99B8PaBuXq
         6iKwiaX8rIvV2dN1DceaIo0khPS+gp32obIrb+59+o8wh84TJOOkj/8J0TbylUvEWhJu
         61mdtWhigXkV4RkImr7l19CfXDH1zbHZQE8bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fqxEyaON3nFQ86ym4CZzfi5INVSTkbA3fH/JE9MeyfTUmdQkTYxBhZoc+ZfzTl/3Q/
         0t/ml87nbjdbthPgDEO6yAg10OmPWTbuwlZjJLU33vvb1nEHobmV4B2GgyxmdoZLMMUK
         BZfgAdEgZzHFQFnoxF7ojPPUti72KoA4kMwRo=
Received: by 10.220.181.65 with SMTP id bx1mr617637vcb.19.1291426768998; Fri,
 03 Dec 2010 17:39:28 -0800 (PST)
Received: by 10.220.16.68 with HTTP; Fri, 3 Dec 2010 17:39:08 -0800 (PST)
In-Reply-To: <20101204005131.GB15906@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162878>

On Fri, Dec 3, 2010 at 4:51 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> ghazel@gmail.com wrote:
>
>> I've encountered a strange issue where "git reset --hard" insists on
>> "Checking out files ..." when all that is changed is the ctime
>
> There is a performance trade-off. =C2=A0Refreshing the index requires
> reading+hashing the existing file if the stat information changed;
> this could be faster or slower than blindly overwriting depending on
> the situation.
>
> That said, I have no strong objection to an implicit refresh in "git
> reset" (performance-sensitive scripts should be using read-tree
> directly anyway). =C2=A0Have you tried making that change to
> builtin/reset.c? =C2=A0How does it perform in practice?

I did not make the modifications to reset.c, I just ran the refresh
before reset:

So originally:

$ time git reset --hard <rev>
Checking out files: 100% (2772/2772), done.

real    0m5.328s
user    0m2.539s
sys     0m2.542s

as opposed to:

$ time git update-index --refresh

real    0m1.236s
user    0m1.024s
sys     0m0.201s

$ time git reset --hard <rev>

real    0m0.055s
user    0m0.011s
sys     0m0.041s

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0My deploy process (c=
apistrano) maintains a cached copy of
>> a git repo, which it fetches, resets, and then hardlinks files from
>> when a deploy occurs ( https://github.com/37signals/fast_remote_cach=
e
>> ). The hardlinking step is meant to save the time of copying the fil=
e.
>> but hardlinking changes the ctime of the source files.
>
> Interesting. =C2=A0Setting "[core] trustctime =3D false" in the repos=
itory
> configuration could be a good solution (no performance downside I can
> think of).

This is a very useful suggestion. I do not see a case where ctime
would be valuable to me. Is it really valuable to other people? What
is the trade-off?

-Greg
