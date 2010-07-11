From: Brian Craft <bcboy@thecraftstudio.com>
Subject: Re: command return values
Date: Sun, 11 Jul 2010 07:53:30 -0700
Message-ID: <AANLkTikLjU4GjFdgKht2VgUkFS1xNQPpNyjCb_tDlomF@mail.gmail.com>
References: <AANLkTimQcqhD8FClAXef5dGAWRDbAGdVBmIVXxotzKoa@mail.gmail.com>
	<20100711113733.GA19113@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 11 16:53:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXxuS-000205-Jf
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 16:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab0GKOxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jul 2010 10:53:31 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52499 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab0GKOxa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jul 2010 10:53:30 -0400
Received: by pwi5 with SMTP id 5so1476601pwi.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=8XpTEVH5M/MloI3ZOMLwR6+WjNtzPYUloJZh7nzj6+g=;
        b=itauUIRPra5DtEAcvleeJfWLb8h74oBtKNuvqSOlPEmwPoq9NwRKvBSOHg+WdxrR98
         PPbmZZD3Po6Es4HWOy1lDZdVYadst156J0MAGSLMnlJ3xtJai4lmcfjeS2aAzKmGByT7
         WSO4qjDdPqW5yurdBo075n3lpOEZ7lnaT59rw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=JKoXV8Nx5jWKFME4XFCJGh8VRrNqJKpGhMbGNOGZo0TcwdLlb1wS32BvZctePvVZOL
         xWR6lppt0xu4vPXcLXsFvV0tsWODyY5rXYQFVIYt4SDukN24CP16S8aOdc97F6dzu+b5
         wXJmebhezTRsCRMafwaxd5GGC4VKmWzdEH0aA=
Received: by 10.142.199.20 with SMTP id w20mr14489594wff.249.1278860010113; 
	Sun, 11 Jul 2010 07:53:30 -0700 (PDT)
Received: by 10.143.7.4 with HTTP; Sun, 11 Jul 2010 07:53:30 -0700 (PDT)
In-Reply-To: <20100711113733.GA19113@coredump.intra.peff.net>
X-Google-Sender-Auth: mG-U3rDf1GwDIizJAx7Nfu7O0qo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150779>

Ah, you're right about the return value. I was losing it in a
scripting error. And breaking down "clone -b" is a good work-around
for the non-existent branch.

Thanks!
b.c.

On Sun, Jul 11, 2010 at 4:37 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Jul 10, 2010 at 09:11:18PM -0700, Brian Craft wrote:
>
>> I'm finding that "git clone" doesn't return useful error codes, e.g.
>> trying to clone from a bad repository. =A0Also, it doesn't abort if =
you
>> try to clone a branch that doesn't exist. The command succeeds,
>> leaving you with the wrong result. I haven't found a way to tell whe=
n
>> the command really succeeds, except for scraping the output.
>
> It should give useful error codes. I see:
>
> =A0$ git clone parent child; echo $?
> =A0Cloning into child...
> =A0done.
> =A00
>
> =A0$ git clone bogus child; echo $?
> =A0Cloning into child...
> =A0fatal: '/home/peff/foo/bogus' does not appear to be a git reposito=
ry
> =A0fatal: The remote end hung up unexpectedly
> =A0128
>
> =A0$ find parent -depth | xargs chmod ogu-r
> =A0$ git clone parent child; echo $?
> =A0Cloning into child...
> =A0fatal: failed to open '/home/peff/foo/parent/.git/objects': Permis=
sion
> =A0denied
> =A0128
>
> So those all seem reasonable. Is there some other case of a "bad
> repository" that fails but gets you a zero exit code?
>
> For the case of a non-existent branch, I see:
>
> =A0$ git clone -b bogus parent child; echo $?
> =A0Cloning into child...
> =A0done.
> =A0warning: Remote branch bogus not found in upstream origin, using H=
EAD
> =A0instead
> =A00
>
> So yes, it completes with a warning. I agree that is not ideal, as a
> script that clones has no idea that it did not actually get the data =
it
> was looking for.
>
> I think the rationale for not aborting totally is that we have done
> significant work (including network traffic) during the clone, and th=
e
> warning can generally be remedied with "git checkout the-right-branch=
".
> We could perhaps keep the repository but signal with a non-zero exit
> code.
>
> The other option for a script is not to use "-b", which only impacts
> checkout. Instead, you could do:
>
> =A0$ git clone -n parent child &&
> =A0 =A0cd child &&
> =A0 =A0git checkout -b interesting-branch origin/interesting-branch
>
> which is just as efficient, but lets you react differently to failure=
 of
> each part. You can also break it down further into:
>
> =A0$ git init &&
> =A0 =A0git remote add origin parent &&
> =A0 =A0git fetch origin &&
> =A0 =A0git branch interesting-branch origin/interesting-branch &&
> =A0 =A0git checkout interesting-branch
>
> but I don't think there is much point in doing so.
>
> -Peff
>
