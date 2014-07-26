From: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
Subject: Bug: git pull --rebase rewinds without applying commits in special
 workflow.
Date: Sat, 26 Jul 2014 15:17:29 +0200
Message-ID: <53D3AA69.9040205@ursus.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 15:27:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XB204-00016t-T0
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jul 2014 15:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbaGZN05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2014 09:26:57 -0400
Received: from brln-4dba7733.pool.mediaWays.net ([77.186.119.51]:30610 "EHLO
	here" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751302AbaGZN04 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2014 09:26:56 -0400
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jul 2014 09:26:55 EDT
Received: from [192.168.0.14] (unknown [192.168.0.14])
	by here (Postfix) with ESMTP id 7F96C266F7D
	for <git@vger.kernel.org>; Sat, 26 Jul 2014 15:17:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254280>

Hi,

in our workflow commits can be removed from from the tip of the branch 
in the
central repo. After this git pull --rebase on the "client" side may "lose"
commits, because the rewinding takes place without an fast-forwarding.


$ git log --oneline master           # example repo with 3 commits
b52b381 c3
faf6bbe c2
2ad3897 c1

$ git push origin master             # let the remote be up-to-date

$ git push origin +master^^:master   # simulate removal on remote

$ git pull --no-rebase               # pull without rebase works fine
Already up-to-date.                  # master points still to c3

$ git pull --rebase --prune          # pull --rebase with pruning also works
Current branch master is up to date. # master points still to c3

$ git pull --rebase                  # git pull --rebase does part of 
its job
First, rewinding head to replay your work on top of it...

$ git log --oneline master           # commits c2 and c3 are "lost" on 
master
2ad3897 c1


The actual workflow is that the commits are removed in the post-receive
hook of the central repo and send to an automatic test. After this passes
the commit is sent to svn and the result is then put to the top of the
branch.In case of a failure, the user should still have his commits in
his repo, so he could amend it and send again.
Using -p with git pull is currently the workaround to this.

Regards
Andreas
