From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] checkout: do not switch branch during a rebase unless -f
 is given
Date: Tue, 28 Sep 2010 00:33:38 -0500
Message-ID: <AANLkTinUudOXmhKW-+rkcpzb-VNnSBLZwGZcjrS6UdMu@mail.gmail.com>
References: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
	<1285649702-24773-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 07:33:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Sp1-0006nz-CI
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 07:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758081Ab0I1Fdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 01:33:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61009 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab0I1Fdl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 01:33:41 -0400
Received: by iwn5 with SMTP id 5so5523117iwn.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 22:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6cIyk2iNDAiJSLsdD3PNDbvW8hleyyDF+xek7pE6EGc=;
        b=kbryTDCWUQ2unJx4C1/w9oq8zUmsn8PjqZldvAOQdb3hckneYtHEl+nwtcTnUNbYPL
         fanqqSDjlkADvbPhzC4bIXUpHNKCU1/yG430H7YblFq5jNho81fNlbEK/CumnV2of6u4
         M7HS9DBffpI/oPz0hRojuJjiKHiY9lk2DqIHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GJNdNM4odocImIJ8MQeAwJYbISdfnRHVB4qf6NH+YQ1PIhgfWfg3MR0zkXImH7DlXF
         15POPpIanBLFTHElZMfoLWVShSXDYCQMD0V1Nrmrf4R/6KM0su5xTXnsMQC6tYjg7MVS
         Fki7Yv62wFKdW0/OTkJuhjfAnRhxuiTO83uik=
Received: by 10.231.151.135 with SMTP id c7mr10084836ibw.184.1285652018596;
 Mon, 27 Sep 2010 22:33:38 -0700 (PDT)
Received: by 10.231.11.65 with HTTP; Mon, 27 Sep 2010 22:33:38 -0700 (PDT)
In-Reply-To: <1285649702-24773-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157388>

(+cc: Fr=C3=A9d=C3=A9ric, Dscho, Christian)

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> It does not make much sense to switch branch when you are in a middle
> of a rebase. Sometimes you might want to switch away for a moment the=
n
> back with "git checkout - ". But I find myself so many times switchin=
g
> away then forget that I was rebasing something.
>
> Avoid doing that by default. Users can use -f if they really want to.

Nice! But I worry is that scripts that use "git checkout" porcelain
during a rebase would be broken.

Even rebase --interactive uses checkout from time to time:

 - for preserving merges
 - to move to the correct branch in response to "git rebase -i
<upstream> <branch>"
 - to move to the target in "git rebase -i --onto <new base> <upstream>=
"

Unfortunately I do not have any good advice. Would it make sense to

 - first, change these call sites in git to use checkout -f
 - teach checkout to warn (without erroring out) to give people time
to change their scripts
 - warn loudly about the upcoming change in the release notes
 - later, change checkout to error out when -f is not supplied

or am I being too paranoid?

> =C2=A0I know there are other commands like rebase ("git am" comes to =
mind)
> =C2=A0but I don't use those. Feel free to put some more on top if som=
ebody
> =C2=A0finds it a good thing to do.

Another interesting one is "git bisect".
