From: Jiang Xin <worldhello.net@gmail.com>
Subject: The order of multiple remote.xx.fetch is significant for some operations
Date: Fri, 6 Jul 2012 10:06:58 +0800
Message-ID: <CANYiYbEH_qxj40SiVeYgLT_fYiRSh7O+wwSim1u=dBDfoZMiFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 04:07:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smxwq-0004xt-LG
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 04:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340Ab2GFCHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 22:07:00 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:53330 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935Ab2GFCG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 22:06:59 -0400
Received: by ghrr11 with SMTP id r11so8135114ghr.19
        for <git@vger.kernel.org>; Thu, 05 Jul 2012 19:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Z6ZQ7OfUbKMsy9IJboJvA2cAehpVXTOMPNmhA9cwLn0=;
        b=yNHGpqC/Gqt7CaUac+PK4qP1IxoyHG0Edgypck+oxr3LF4rHCArG1+N5GmF21lfiPv
         LCw3rnK3I7Ai8SVIDmYrLr3kKcJiVuPrpNc7ExWrnmWYT7uBJWK0hPJtPWk3oLjdnaMh
         guKijutC31Fbfk+bUuZnK8YKyvsSECFCcfsyftZb2+jMgo+uHEOnMBX5butHiT5xsK0O
         Y+q/R7aKPHVYcgbxK6FzoEH34wO2dz7pEQOLC0M0GmJnWlQrIfuyYwUnHnjiR/bu5BKG
         CocoXShE+nbVtTlY9WzyjOtmpxNFSzFVdU15rfBnZ4R+tktjopywuTQFuxdYSaGU/6J6
         NPig==
Received: by 10.50.89.130 with SMTP id bo2mr1362970igb.19.1341540418742; Thu,
 05 Jul 2012 19:06:58 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Thu, 5 Jul 2012 19:06:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201084>

Someone asked me how to remove obsolete topgit feature branches from
the remote topgit controlled git repo. I found we can not run
"git fetch --prune" directly to delete stale remote branches from
local, because of the wrong order of multiple "remote.XX.fetch" config
variable.

For example, config variables for remote "origin":

    [remote "origin"]
          fetch = +refs/heads/*:refs/remotes/origin/*
          url = git@github.com:ossxp-com/topgit.git
          fetch = +refs/top-bases/*:refs/remotes/origin/top-bases/*

When running "git fetch --prune", will check all local refs, and delete
stale remote branches from local if their conterparts do not exist in
remote repo. But in this case, all remote branches under
"refs/remotes/origin/top-bases/" namespace will be deleted, even their
remote conterparts "refs/top-bases/*" still exist in remote repo.

How does this happen? e.g. a local ref:
"refs/remotes/origin/top-bases/t/featureX"

 * First make a reverse look up according to the remote.origin.fetch
   config variables;

 * The first remote.origin.fetch matches, and this local ref is mapped
   as "refs/heads/top-bases/t/featureX";

 * The remote repo does not have ref "refs/heads/top-bases/t/featureX",
   (it should be "refs/top-bases/t/featureX"), then this local refs is
   deleted as a stale remote branch.

 * While if we change the order of remote.origin.fetch config variables,
   The result is different. This local ref will map to
   "refs/top-bases/t/featureX", and won't be deleted.

So, it's not a bug of git, but a flaw of user generated config variables.
The hacks for Topgit are simple, see:

 * https://github.com/ossxp-com/topgit/blob/master/debian/patches/t/delete-remote-branch.diff
 * https://github.com/ossxp-com/topgit/blob/master/debian/patches/t/prune-stale-remote-branch.diff

--
Jiang Xin
