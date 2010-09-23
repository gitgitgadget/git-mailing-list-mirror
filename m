From: Kevin Ballard <kevin@sb.org>
Subject: Re: git-reflog bails if branch points to bad commit
Date: Thu, 23 Sep 2010 16:03:16 -0700
Message-ID: <D1EE3839-DC24-4C2B-AA0A-3FD554E8E514@sb.org>
References: <F628129C-56AE-4BB5-9227-4282763C5B7E@sb.org> <AANLkTimzQ5Jdw5oqiE17859YBiM0EQ6fnTp5+x6JR48k@mail.gmail.com> <6532E729-31B8-44D3-A26A-780DDD784703@sb.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 24 01:03:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyup3-0002w4-6M
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 01:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab0IWXDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 19:03:20 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40339 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab0IWXDT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 19:03:19 -0400
Received: by pzk34 with SMTP id 34so474311pzk.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 16:03:19 -0700 (PDT)
Received: by 10.114.46.4 with SMTP id t4mr2606142wat.40.1285282999289;
        Thu, 23 Sep 2010 16:03:19 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id d38sm2302032wam.8.2010.09.23.16.03.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 16:03:18 -0700 (PDT)
In-Reply-To: <6532E729-31B8-44D3-A26A-780DDD784703@sb.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156924>

On Sep 23, 2010, at 2:57 PM, Kevin Ballard wrote:

> At this point, attempting to say `git reflog show foo` was complaining "fatal: Bad object foo" even though the reflog itself is perfectly valid, and in fact the only problem in the entire repository is the ref currently points to a hash that doesn't exist in the object database.

It appears the problem is `git reflog show` uses the current value of the branch as the first entry in the reflog, rather than actually showing the latest entry in the reflog. It still uses the message from the latest reflog entry, but the commit hash shown is the actual value of the branch. Is there any reason for this behavior? I admit it may be confusing if the reflog for a branch doesn't actually show the current branch pointer, but that should not be possible under normal behavior, and in a corrupt repo I believe showing the reflog is more important than showing the branch pointer. If necessary, we could even make it display a warning in this case.

Curiously, when the branch points to a commit not in the reflog, running `git rev-parse master@{0}` gives me something like

warning: Log .git/logs/refs/heads/master unexpectedly ended on Thu, 23 Sep 2010 13:09:56 -0700.
d73cfd127a564756f7790d2c4ae00af0126ead29

Note that the hash it shows is actually the current value of the branch rather than the latest reflog entry. Arguably, this should also use the reflog unambiguously, as again, under normal operations that should be identical to the current branch, and with a corrupt repo the user may care more about the reflog. I can't think of any scenario where I would expect master@{0} to give me back the master branch if it differs from what the reflog says.

My proposal is twofold. First, modify `git reflog show` to only show the reflog and to not even attempt to show the current commit. It may also be worth extending it to not fail when it hits a bad object, but to simply log that and continue. And second, modify master@{0} to show the reflog entry in the event where it doesn't match the current value of the branch. Any comments/suggestions on this?

-Kevin Ballard