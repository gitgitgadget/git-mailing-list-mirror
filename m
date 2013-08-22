From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: git-svn: Use prefix by default?
Date: Thu, 22 Aug 2013 11:02:05 +0200
Message-ID: <CAEcj5uVRcXF+XADFvy_q2mbQOdWPZkz57q1vePOqroMbQw4+HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 22 11:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCQmV-0007Qz-DV
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 11:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab3HVJCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 05:02:08 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45283 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab3HVJCG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 05:02:06 -0400
Received: by mail-wi0-f172.google.com with SMTP id hj13so367873wib.5
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=pRLpNOfvsJY3Pzw4OS0YcsmuNTtpqbgaVAHdNOXiJOU=;
        b=BY6p4fhbUiYAWFV/K2D5oNPGpMrwD4tp/rIdWFv150HeB2Nj/xcHZ70crTrPY4h9R7
         RUsdWRqtnbpTUxYLbWMgXw/twC8nC3g5gUnaMAi5Ra9UJip4Ldf5Kd9t5dxDUvTD8NXs
         ETHGXqHSMGtF/LNYou3USdwLhlYWiDMqHG68L46RBGH0BIzDMZr1nCfy93R4U/Cbpxjp
         SBXcKNbt24udkppUB0VPVFXsrsrWtotmf8DhdAL8DCdF1GfPZMV0rnVsRHlwSJkXvYJ/
         gzPRqOqMDxQErbMysEh8bEDjOilazYeK2fTDgTcM77UTOycqgiFqqrhcrDYq1sBrr5oX
         GWjQ==
X-Received: by 10.180.11.233 with SMTP id t9mr8900266wib.41.1377162125053;
 Thu, 22 Aug 2013 02:02:05 -0700 (PDT)
Received: by 10.216.163.2 with HTTP; Thu, 22 Aug 2013 02:02:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232761>

I've recently been forced back into using git-svn, and while I was at
it, I noticed that git-svn generally behaves a lot better when it is
initialized using the --prefix option.

For example, I make a standard-layout svn clone:

$ git svn clone -s https://svn.company.com/repos/project-foo/

.. and end up with this .gitconfig:

[svn-remote "svn"]
        url = https://svn.company.com/repos/
        fetch = project-foo/trunk:refs/remotes/trunk
        branches = project-foo/branches/*:refs/remotes/*
        tags = project-foo/tags/*:refs/remotes/tags/*

And my remote branches looks like this:
    remotes/trunk
    remotes/feat-bar

Now, let's say I want to work on the feat-bar branch, so I attempt to
create a tracking branch by the same name:

$ git checkout feat-bar  # will detach head
$ git checkout remotes/feat-bar  # will detach head
$ git checkout -t remotes/feat-bar # fatal: Missing branch name; try -b
$ git checkout -tb remotes/feat-bar # Branch remotes/feat-bar set up
to track local branch master.

Well, that's not what I wanted.. So I end up doing it the good
old-fashioned way:

$ git checkout -tb feat-bar remotes/feat-bar # works

Now I am up and rolling, but I get this warning with every checkout or rebase:

     warning: refname 'feat-bar' is ambiguous.

So, let's see what happens when I create the svn clone using a
--prefix=mirror/ instead. Here's the config:

[svn-remote "svn"]
        url = https://svn.company.com/repos/
        fetch = project-foo/trunk:refs/remotes/mirror/trunk
        branches = project-foo/branches/*:refs/remotes/mirror/*
        tags = project-foo/tags/*:refs/remotes/mirror/tags/*

Here are my remote branches:
     remotes/mirror/trunk
     remotes/mirror/feat-bar

Let's create the tracking branch:

$ git checkout feat-bar  # Branch feat-bar set up to track remote
branch feat-bar from mirror.

Voila, worked on the first try. And no more warnings about ambiguous refnames.

So now my question is: If using a prefix is so healthy for git's
branch tracking conventions, why doesn't git-svn default to use some
prefix like 'origin' or something when initializing a git svn clone?

The examples were made using 1.8.1.2 on OSX by the way.
