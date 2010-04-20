From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Fix checkout of large files to network shares under 
	Windows XP
Date: Tue, 20 Apr 2010 16:21:36 +0200
Message-ID: <i2kbdca99241004200721l7cbd0052oa6921533f7efb8a4@mail.gmail.com>
References: <4BCC5083.30801@gmail.com> <4BCCC05E.4030206@lsrfire.ath.cx>
	 <t2xbdca99241004200542ud4e8ea5azcad918c37bcacf1a@mail.gmail.com>
	 <4BCDA49C.4090405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 20 16:21:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4EKh-0006ju-Bm
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 16:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab0DTOVj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 10:21:39 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:55350 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751Ab0DTOVi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 10:21:38 -0400
Received: by bwz19 with SMTP id 19so15332bwz.21
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wpK9lRABGK/fVmhAn6BPCm3CgEsa1fa5Co4nPSLcL9Q=;
        b=uyHrmoGPefU8uxSKpUI5d4Ms0RG2TsX8drUDyAbzUDR4gvb7MEPkmvShIsXHcxySwe
         3t32ANZiqzCwX3SDMZXr/XZ/m+C2I9qTyu/2zAIiGMJbTbi8HpX+RP1yqrXxx9Rb+0c/
         Z/ayDp3EFfp0nCTgkrANTEQITbA6uibElLREc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dGM++a5x/9PcS/jgnIRS4eUaXxHktjtk1FY6huo3jMqSdMHd4nnWh/R0BGvZWtkOQ+
         Qu7rluGxVFJUBYlazOqTff7dgZJlPTIVT1XMrqOgwUnEa2eD6f6ciOUkIYvgM+stDMLy
         t3KuP/47EVUWLpejmwvSoM0GwKrNckQY17O8k=
Received: by 10.204.62.19 with HTTP; Tue, 20 Apr 2010 07:21:36 -0700 (PDT)
In-Reply-To: <4BCDA49C.4090405@viscovery.net>
Received: by 10.204.25.145 with SMTP id z17mr801851bkb.181.1271773296412; Tue, 
	20 Apr 2010 07:21:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145376>

On Tue, Apr 20, 2010 at 14:57, Johannes Sixt <j.sixt@viscovery.net> wro=
te:

> Am 4/20/2010 14:42, schrieb Sebastian Schuberth:
>> On Mon, Apr 19, 2010 at 22:43, Ren=C3=A9 Scharfe <rene.scharfe@lsrfi=
re.ath.cx> wrote:
>>> Shouldn't the loop be left in the successful case, too? =C2=A0write=
(2) is
>>> allowed to write less than requested, so the caller already needs t=
o
>>> deal with that case anyway.
>>
>> I prefer to make the wrapper as transparent as possible. If a direct
>> call to write would not write less than requested, the wrapper shoul=
d
>> not either.
>
> Sure, but Ren=C3=A9 meant the opposite case: When fewer bytes than re=
quested
> were written, then you shouldn't retry to write more! That is, you sh=
ould
> exit the loop when write(fd, buf, n) does not return n.

I see what you mean, but I do not fully agree. Who guarantees that (on
some obscure OS) a following call to write(fd, buf, n) will not return
n again, maybe because write() temporarily decided to write fewer
bytes than requested to make the next write() call do aligned writes
to something? That case then is probably already handled in the caller
to write(), but at least my code is not wrong in that respect.

> I still find your code unnecessarily hard to read. In particular, you
> should extract the non-problematic case out of the loop. If you follo=
wed
> my suggestion elsewhere in the thread, you wouldn't have to write any
> conditionals that 'break' out of a loop.

I didn't follow your suggestion on purpose because I experimented with
it and I found *yours* to be hard to read. It has three calls to
write() and more places where errors need to be checked. As I do not
have the will to waste more time on style discussions about code that
fixes other people's issues, and not the time to test the code on
Windows XP over and over again, I hope you are willing to accept code
that is different from how you would have written it. So it's take it
or leave it (or modify it yourself, if you feel like it).

--=20
Sebastian Schuberth
