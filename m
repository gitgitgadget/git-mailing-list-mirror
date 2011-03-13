From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [RFD] make rebase abort to original branch, not rebased branch
Date: Sat, 12 Mar 2011 22:58:20 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1103122253560.15442@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 13 04:58:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PycRv-00084x-8f
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 04:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321Ab1CMD6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 22:58:24 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52663 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381Ab1CMD6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 22:58:24 -0500
Received: by vxi39 with SMTP id 39so3584502vxi.19
        for <git@vger.kernel.org>; Sat, 12 Mar 2011 19:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:subject:message-id
         :user-agent:mime-version:content-type;
        bh=LMszZLQcIqqRUCCgJRcAzKtQZfYUyFX46P7ASIGCxNw=;
        b=J+a8j/fT01FilQ8HDcG8K+pAu1lbYcO/rT0TrlkTzrVP7vBfXiYX/2f9gAH1Iy/71b
         imGeNoqk/g68AwKO08Rzj8cFXih31KKuY+UztDhcsTfUDj9vGHUn1ZqB0P3m/lO6G4NX
         PQbPeRfsxgHxX+YLaJTunerSaPNl+6eHmDHkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:subject:message-id:user-agent:mime-version
         :content-type;
        b=iTY7/HLmea+EyrFClISmEgqW1AWV176rE/RgdPhS2HAFTnwhPas/bIgvTKXr8xlIL5
         lRdp5zG/yuABkthGLvpUYFXrZIAROOEDEu2JZUz7Dbr83liYr+dl3mZs6JRgzVNM79v/
         /uenreeMXy3/Cf+E15h1K3AHZzmTOQUqLMhBU=
Received: by 10.220.202.133 with SMTP id fe5mr2843805vcb.277.1299988703104;
        Sat, 12 Mar 2011 19:58:23 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id f32sm1963542vcm.38.2011.03.12.19.58.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Mar 2011 19:58:22 -0800 (PST)
X-X-Sender: martin@debian
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168959>

When git rebase is aborted, it will return the HEAD to the rebased
branch (which has not moved). If the current branch is "topic" and a
run of "git rebase master" is aborted, "topic" is therefore checked
out, which is both what I expect and what I want. When the
two-argument version of git rebase is used, as in "git rebase master
topic", and then aborted, "topic" will be checked out. This is not
what I would expect, although I'm aware of it by now, and usually not
what I want. I would expect to be returned to the branch/commit that
was checked out when I started "git rebase master topic".

In most cases, this is just a small annoyance, since it's usually
quick and easy to manually switch back to the original
branch. However, I have run into at least two cases where it has been
a bit more annoying:

 1. When on a detached HEAD and running "git rebase HEAD topic", if
    you abort the rebase, you will have to look up the old commit in
    the reflog.

 2. I once was rebasing many old branches, mostly to see which ones
    could be rebased without conflicts. The project I was working on
    was pretty big and a lot had changed since those old branches were
    created. If a "new" branch is currently checked out and "git
    rebase master old-branch" is run and causes conflicts, the old
    branch would be checked out. In my case, this would take 5-10
    seconds. Since Junio improved rebase in 0cb0664 (rebase [--onto O]
    A B: omit needless checkout, 2008-03-15), there will be no
    checkouts of any "old" commit in the successful case, so it's a
    shame that it has to happen in the unsuccessful case when the
    rebase is aborted.

Are there valid cases where the current behavior is bettter?

I suppose we can not just change the current behavior due to backward
compatibility constraints. We could introduce a configuration
variable, of we could perhaps change it in 1.8.0. Maybe the problem is
not big enough to do either...


/Martin
