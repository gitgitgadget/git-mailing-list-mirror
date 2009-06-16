From: John Bito <jwbito@gmail.com>
Subject: Re: git diff looping?
Date: Tue, 16 Jun 2009 08:48:41 -0700
Message-ID: <3ae83b000906160848x12ff8a27m57520c687306e1fa@mail.gmail.com>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com>
	 <20090616114726.GA4343@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 17:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGau3-0005gq-Br
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 17:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbZFPPsm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2009 11:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbZFPPsl
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 11:48:41 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:62788 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbZFPPsk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2009 11:48:40 -0400
Received: by yw-out-2324.google.com with SMTP id 5so3008857ywb.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 08:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jSV4bufR/6zClNnGM+I/XqRvnGevRsOb8omc90ELiIM=;
        b=gPlXEfct7yTlTn4CDeqZW+GQi1FYpeHtB07QabE0U26VO/l2IZWF0ED5b1dcsRSkPT
         ugJ4c1tCa4XRkLVB8NLh/taXxR7besD2n7LSHwzDJHlXB3CphdMrE0NVFEj6FjZuQYk+
         meZAlHR86TR8ayOcfPJ2aR5HxqiyAPgOnN2Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k8CsogQVZ2QBtSlS16N3y5efSTlpoX37Dpo8KDNGvgpAfROfAkEQSLavv8FiyqGgW0
         9EIFgKPa2wsg9jMYHW7kkK88UEDPiueOoXLuUlPk8LhYBAuP0byjh5XIL+JTFB2qmG1L
         iEXhvUK1xduhEsZoMWmXQ4HtydHK/BJoy/3x0=
Received: by 10.100.10.13 with SMTP id 13mr10822037anj.10.1245167321333; Tue, 
	16 Jun 2009 08:48:41 -0700 (PDT)
In-Reply-To: <20090616114726.GA4343@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121686>

Thank you, Jeff!

Configuring the dummy regex allows the diff process to complete on
Solaris 10, as well.

~John

On Tue, Jun 16, 2009 at 4:47 AM, Jeff King<peff@peff.net> wrote:
> On Mon, Jun 15, 2009 at 06:37:21PM -0700, John Bito wrote:
>
>> Running Git 1.6.1 on Solaris 10, git diff seems to go into a loop -
>> consuming CPU and producing no output after a little bit. =A0While t=
he
>> repository isn't small, it's not huge (it's
>> http://repo.or.cz/w/egit.git). I've tried the following:
>
> I can reproduce the problem on Solaris 8 using git v1.6.3. It seems t=
o
> be caused by a horribly slow system regex implementation; it really
> chokes on the regex we use to find the "funcname" line for java files=
=2E I
> tried running "git diff v0.4.0" and it still hadn't finished after 90
> seconds. Then I did:
>
> =A0git config diff.java.xfuncname foo ;# some garbage regex
> =A0git diff v0.4.0
>
> and it completed in about 2.5 seconds.
>
> Can you try that and see if it works around the problem for you?
>
> If anybody wants to look further into the problem, I think it is
> specifically triggered by this file (and the built-in xfuncname for j=
ava
> files):
>
> =A0$ git clone git://repo.or.cz/egit.git
> =A0$ git diff v0.4.0 -- \
> =A0 =A0org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_=
ConnectProviderOperationTest.java
>
> which isn't even all that big a file, but it is either causing some
> horrible algorithmic behavior in the regex library, or is outright
> sending it into an infinite loop.
>
> I tried building against the code in compat/regex; it completes in a
> reasonable amount of time, though it is still noticeably slow. With
> system regex, the diff given above doesn't complete in less than 90
> seconds (at which I get bored and kill it). With compat/regex, it
> completes in about 2.2 seconds. Disabling the xfuncname, it completes=
 in
> 0.14 seconds.
>
> So I think it is a viable solution to recommend building against
> compat/regex on Solaris, but I think there is still room for improvem=
ent
> in what we ship in compat/.
>
> -Peff
>
