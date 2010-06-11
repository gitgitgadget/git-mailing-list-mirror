From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH next v2] log_ref_setup: don't return stack-allocated array
Date: Fri, 11 Jun 2010 15:54:41 -0300
Message-ID: <AANLkTikhgl2b_66POXPf1nJSlhwkY5PV1Qce3cA9yXOx@mail.gmail.com>
References: <e888313d5a782585f4a5e7ee8914302953c187e2.1276173576.git.trast@student.ethz.ch> 
	<47daf53b6b2cc25cc013c5f2183e309a671dc9d3.1276174233.git.trast@student.ethz.ch> 
	<AANLkTillDOCNQrpaEiFsFdq6HpU_LlwWI2ELIrEcrWHc@mail.gmail.com> 
	<201006101929.11034.trast@student.ethz.ch> <AANLkTimEwV_bJkd_2csJB0L6T9Lq6F0hpllUO2pJTL8m@mail.gmail.com> 
	<20100611051236.GA3947@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 11 20:55:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON9O0-0004b4-QA
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 20:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185Ab0FKSzG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 14:55:06 -0400
Received: from mail-yw0-f204.google.com ([209.85.211.204]:37748 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290Ab0FKSzD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 14:55:03 -0400
Received: by ywh42 with SMTP id 42so1524605ywh.15
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SlMfSZ6Nc+fF2PE87ZfdyMBSNskjLIoDG9o/0KN6kZU=;
        b=hL/LQCjHkaJkNnNDgKJ1SzuzQTielvvIMFMaFuDO05xixjvtrqEuFiEKd9NDLMcRLO
         odTwdUSggpL+vQPUzSTo6oERngjBcMPFQ4WTpYhI504KXAHPuPCMqenGQzql8CvIJb7u
         wDmUFdLwi2gYhK/WQmGQT+4aNPv0zr4igqpZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iQ7luYoYZ1vpmmNhvj2Cn0FfTJAEyFRZLYUJOjCQphlbMU6pO9wW2rVKj0UThymc96
         n/gZr899RKj5oBRgkugVuYTHOSbkSOacd95EcOd0jHwk+SG62spRSyiWEddna7Q2DkZs
         BfnU5mLwNKAaKgt18nNscL04pd4iAlyhNbQcM=
Received: by 10.150.171.5 with SMTP id t5mr3528005ybe.441.1276282502071; Fri, 
	11 Jun 2010 11:55:02 -0700 (PDT)
Received: by 10.151.15.7 with HTTP; Fri, 11 Jun 2010 11:54:41 -0700 (PDT)
In-Reply-To: <20100611051236.GA3947@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148964>

Hi,

2010/6/11 Jeff King <peff@peff.net>:
> No, Thomas is right. This invokes undefined behavior. We point the
> passed-in log_file pointer to the front of a character array with
> automatic duration. After log_ref_setup returns, we must never
> dereference that pointer again, but we do. So we need this patch or
> something like it.

You and Thomas are right on this subject.  I don't know when and how I
could see a malloc() in git_(v)snpath().  My fault.

>> Then git_snpath() creates a char array in the heap with the right
>> content and changes the stack pointer logfile to it. =C2=A0Then when=
 we do
>
> No, it doesn't. git_snpath writes into the buffer you provide it, jus=
t
> like snprintf (hence the name).

The source of my failure.

> We have some false positives in git, but you don't see them because
> t/valgrind/default.supp suppresses them. For example:
>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/106335/f=
ocus=3D107302
>
> If you are using a binary package of valgrind, it probably ships with
> some system-specific suppressions, too. Right now valgrind on Debian
> unstable is next to useless because glibc has been upgraded to 2.11, =
but
> the suppressions haven't been updated. So you get false positives all
> over the place because of clever architecture-specific optimizations
> (e.g., I am seeing a lot of __strlen_sse2 problems, which are probabl=
y
> just the function over-reading its input data because processing big
> chunks is faster).
>
> -Peff

Thanks for the extended explanation about valgrind.

Regards to all
