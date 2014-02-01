From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 1/2] init-db.c: honor case on case preserving fs
Date: Sun, 2 Feb 2014 03:47:44 +0400
Message-ID: <CAHkcotgdEKkZZ756LHxD0fum0_z43cerQE_yZR0VSnPZOKtKpA@mail.gmail.com>
References: <1391246067-30499-1-git-send-email-reubenhwk@gmail.com>
	<52ECE5EB.6090304@web.de>
	<CAD_8n+RWNZkGO31XveDuSy2aXv5uAMy087AUUu2+wXtO=MngAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 02 00:47:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9kHt-0003wh-Px
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 00:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbaBAXrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Feb 2014 18:47:45 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:60213 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbaBAXrp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Feb 2014 18:47:45 -0500
Received: by mail-qa0-f48.google.com with SMTP id f11so8202831qae.7
        for <git@vger.kernel.org>; Sat, 01 Feb 2014 15:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wfrEmRYREn8wvWCETT94A4aDv9nZOvMKiFg+YKtcRF8=;
        b=U0X7ZpS4R2I+/QWgU8H5iLHTgyEzoyheZXEvokcCRui9fZRioB44g3hqfWRt4DROUt
         KpS1dA+UnypZV04hNW98uLF0dP0tr17pG13Ge+OH1cxTOgdcGnGoPM68xrm++RazAW8x
         zrB+Nt/tuEaoPYRNN9YkNlUr+w1hfncmNvoEZ6QA4ZGR9/at9TFwLPfXccSTFQCybYi/
         PHYqgs5ysjA2GtYiYSoVNalxN6yuoQbcfPFm5u0mgH2Vi3AUWR0mMtstcdcYwmJbe30P
         3VxWLgiQ1aFYqXnyaYffUlYd14hmDgpKRP8MwujQaJ8ft6/XHw2g1CS00j4hzKPtwAFA
         bvzQ==
X-Received: by 10.224.16.72 with SMTP id n8mr44757835qaa.76.1391298464448;
 Sat, 01 Feb 2014 15:47:44 -0800 (PST)
Received: by 10.96.213.101 with HTTP; Sat, 1 Feb 2014 15:47:44 -0800 (PST)
In-Reply-To: <CAD_8n+RWNZkGO31XveDuSy2aXv5uAMy087AUUu2+wXtO=MngAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241345>

On Sat, Feb 1, 2014 at 1:14 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
> Most case-insensitive filesystems are case-preserving. In these
> filesystems (such as HFS+ on OS X) you can name a file Filename.txt,
> then rename the file to FileName.txt.  That file will be accessible
> by both filenames, but the case is otherwise honored.  We don't want
> to have git ignore case on these case-preserving filesystem
> implementations.

Actually, we want to ignore case on ANY case-insensitive file system whether
it is a case-preserving or not.

Let's suppose we have a central repository where Filename.txt is renamed
as FileName.txt. Now a user pulls changes from that repository on Windows.

With core.ignorecase = true, everything works perfectly:

$ git pull
remote: Counting objects: 3, done.
remote: Total 2 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (2/2), done.
From z:/shared/test2/
   3d885e6..ce5deef  master     -> origin/master
Updating 3d885e6..ce5deef
Fast-forward
 Filename.txt => FileName.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Filename.txt => FileName.txt (100%)

$ ls
FileName.txt

Now, if you try to do the same thing with core.ignorecase = false,
you get this:

$ git pull
remote: Counting objects: 3, done.
remote: Total 2 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (2/2), done.
From z:/shared/test2/
   3d885e6..ce5deef  master     -> origin/master
Updating 3d885e6..ce5deef
error: The following untracked working tree files would be overwritten by merge:
        FileName.txt
Please move or remove them before you can merge.
Aborting

I have tested this with git version 1.8.3.msysgit.0, but I don't think
it is any different with the latest version.

> This fixes a problem where if you import an hg repository, using
> git-remote-hg,

Perhaps, it fixes that case, but it breaks a far more common case.
So I believe that git-remote-hg should be corrected and not init-db.c


Dmitry
