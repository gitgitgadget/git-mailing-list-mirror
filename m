From: Eric Raible <raible@gmail.com>
Subject: =?ISO-8859-1?Q?Re=3A_Schr=F6dinger=27s_diff?=
Date: Tue, 7 Jul 2009 23:13:01 -0700
Message-ID: <279b37b20907072313t79ddded2k84c819887c234e8b@mail.gmail.com>
References: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
	 <alpine.LNX.2.00.0907071316490.2147@iabervon.org>
	 <20090707193605.GA30945@coredump.intra.peff.net>
	 <7vtz1o9sv6.fsf@alter.siamese.dyndns.org>
	 <20090707195406.GA32131@coredump.intra.peff.net>
	 <7vfxd89lqf.fsf@alter.siamese.dyndns.org>
	 <279b37b20907071717r71f982b6u7333ff10fadfc39@mail.gmail.com>
	 <7v8wizanqr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 08:13:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOQP4-000726-EO
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 08:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbZGHGNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 02:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbZGHGNE
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 02:13:04 -0400
Received: from mail-vw0-f199.google.com ([209.85.212.199]:38951 "EHLO
	mail-vw0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbZGHGNC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 02:13:02 -0400
Received: by vwj37 with SMTP id 37so195276vwj.33
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 23:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k+zZYtkOmZDpj2Roi/O3RrbPkOp+c3tRRbBTvxDF2JY=;
        b=VVeOlSJcPIF5pAf8CGsMKe08ChWIGG2PaivyXcCqnEsZngrwQwn1scPVGEKienl84T
         gBv2HfuUKwYVI5eon5QX1shZVG9dVvJx4emooSagoraqkURwRN/ZQPKlrl1067xKuCZL
         6xpKpPaci53tDdN3dhxebQRnez4eNKHe/yGnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nDCc1YjPYMnqrPy4zSeWYbEuYFdh8XzZ0oB7gsFzbBR2xvqFxrW8GJMj/lhn1mcLG3
         DoTm0zcEaLOquzw+w+7JjDopcL3TRkInb0ztcN+WJojdvWRACvYmu/TlmRnvJLzMvGme
         KlXIzwYewwjOZCMXcF5Oh+IcltWJr1+K6thO0=
Received: by 10.220.75.141 with SMTP id y13mr13586272vcj.84.1247033581211; 
	Tue, 07 Jul 2009 23:13:01 -0700 (PDT)
In-Reply-To: <7v8wizanqr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122892>

On Tue, Jul 7, 2009 at 7:54 PM, Junio C Hamano<gitster@pobox.com> wrote:
> Eric Raible <raible@gmail.com> writes:
>
>> So what's the best way of "fixing once and for all" a repo infected with
>> carriage returns when you want to use autocrlf=true moving forward?
>
> Didn't "rm -f .git/index && git reset --hard HEAD" work?

Will, it "worked" in the sense that it usually [1] allows
"git diff --name-only" to correctly show the files that were
checked in with crlf endings and core.autocrlf false.

Those files are then out-of-date when core.autocrlf is
true and .git/index is up-to-date.

In other words, that first step worked around the fact
that sometimes that .git/index was out of date.

By "fixing it once and for all" I was trying to refer to creating
the correct commit to abolish the carriage returns from my repo.

I ended up with this crude-but-obvious loop which
generates many LF->CRLF warnings [2]:

for i in `git diff --name-only`; do
      echo $i
      sed 's/0x0D//' < $i > foo
      mv foo $i
      git add $i
done

>> Would you accept a patch explaining how "git reset --hard" doesn't
>> actually rebuild the index from scratch,...
>
> Absolutely.

I'll try to get to it, given the $dayjob / $significant_other constraints.

- Eric

[1] I've had cases where for whatever reasons a "git read-tree HEAD"
     seemed to be required, but I don't have the recipe yet.
[2] Which can be abolished by wrapping it in autocrlf=false
     before and autocrlf=true after
