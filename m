From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Question on shallow clones.
Date: Tue, 24 Feb 2015 16:33:44 +0700
Message-ID: <CACsJy8BECAo-ekv0TSYMY2dOwVuQ-d4ak_Rofxunz=WKDFcSyw@mail.gmail.com>
References: <40B70861-177F-4239-A86F-49C92121ACE7@mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Alfred Perlstein <bright@mu.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 10:34:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQBsl-0005iz-Em
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 10:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbbBXJeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 04:34:17 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:39017 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbbBXJeP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 04:34:15 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so25324554igb.5
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 01:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=z9DsswUdg0X9bSX1C0kQA1dE1opzg8CdJUyhjXhanIw=;
        b=QFNgJoc8ZVXiJ984YrxbOQhbCgSNnht6//sG8BA4ubdQMdu7cBN27T7WE67hKGKxDd
         rtmLLv3Fb2rHWLmG3115leLMBPDARTJks1CSg7nEu3cB1Yz4cSWKImUFHWLzcnRbvRA0
         Pupz/Zdo3zVnpvQIS87DCyTULz53kT9tz2F3dE5qTr0kRPapn82JnWX6FiHGUfGtElzs
         WcyTxP18mm0Oii7y2P0FGk3ynKmqQUuATRMXeXIvZOuYFjTFcOBhwW7glntlEijlgC6m
         +2HjH3OBulUGSLnFH28ozErnE42hs08TEn6J6tU4gJzJJ0nIj1GEk70wp8Ni5qL8tVG+
         HVFQ==
X-Received: by 10.107.8.213 with SMTP id h82mr18838629ioi.89.1424770454939;
 Tue, 24 Feb 2015 01:34:14 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Tue, 24 Feb 2015 01:33:44 -0800 (PST)
In-Reply-To: <40B70861-177F-4239-A86F-49C92121ACE7@mu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264317>

On Fri, Feb 20, 2015 at 9:13 PM, Alfred Perlstein <bright@mu.org> wrote:
> Hello,
>
> Very sorry if this has been explained before, I have been doing research past few weeks in spare time and have not found a good answer yet on the safety of doing something with git.
>
> Basically we have some repos with huge history, namely FreeBSD source and FreeBSD ports.  In order to reduce the space in $repo/.git as well as speed up clone time we were thinking of doing a shallow clone of the repo with something like --depth 5000.
>
> I am wondering, if we such a thing, basically:
>
> # get a shallow mirror of let's say 5000 entries
> git clone --depth 5000 --mirror our-freebsd.git  smaller-freebsd.git
> # move our current repo to a backup
> mv our-freebsd.git our-freebsd.git.backup
> # make shallow repo our primary
> mv smaller-freebsd.git our-freebsd.git
>
> Will we be able to push/pull from our "new" repo as if nothing happened?  Will hashes remain the same?

Yes (except the following) and yes if you use git 1.9.0 or later on
both client and server sides. The support in 1.9.0 targets this exact
use case (among others).

- Pushes that require updating $GIT_DIR/shallow (i.e. change the
history cut points, perhaps adding more of them) on server are
rejected by default, unless you set receive.shallowupdate. Normal
pushes should go through fine though.

- Because of the shortened history, found merge bases could be less
ideal than from a full clone. This may cause some more merge
conflicts.

> Can we in theory later do this:
>
> # merge branches from the "github" remote and push back to "our-freebsd.git"
> git clone /url/our-freebsd.git  our-freebsd.git
> cd our-freebsd.git
> git remote add github https://github.com/freebsd/freebsd.git
> git fetch github
> # get from our-freebsd
> git checkout -b master origin/master
> # now merge in freebsd changes
> git merge --no-ff github/master
> git push origin HEAD
>
> Or will this break terribly?

I'm not sure which repo is shallow, which is full (or both are
shallow?), Regardless, I don't see problems with this. If it breaks,
it's a bug.
-- 
Duy
