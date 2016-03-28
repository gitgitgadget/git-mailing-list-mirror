From: Max Kirillov <max@max630.net>
Subject: [ANNOUNCE] git-push-update, tool to push with "server-side" merge or
 rebase
Date: Mon, 28 Mar 2016 11:08:41 +0300
Message-ID: <20160328080841.GA12932@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 10:16:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akSLK-0004we-6N
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 10:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbcC1IQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 04:16:05 -0400
Received: from p3plsmtpa06-03.prod.phx3.secureserver.net ([173.201.192.104]:35193
	"EHLO p3plsmtpa06-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753416AbcC1IQB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2016 04:16:01 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Mar 2016 04:16:01 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa06-03.prod.phx3.secureserver.net with 
	id bL8h1s0035B68XE01L8pPg; Mon, 28 Mar 2016 01:08:50 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290029>

Hello.

I would like to announce git-push-update, a tool which emulates
server-side merge or rebase.

The link: https://github.com/max630/git-push-update

It is a bash script which fetches latest remote branch, creates
temporary clone, performs there merge or rebase, pushes results to
server. If during the merge or rebase remote branch was updated, it
fails cleanly, so you are not left with merge which did not go anywhere.
Or it can even retry the whole task from the beginning, until it
eventually succeeds.

I tried to make it easy to use by unexperienced users by making as few
options as possible and checking for some dangerous mistakes. It would
be nice if somebody tried to really use it, so there would be some data
does this direction worth exploring. Any other feedback is also welcome.

A longer explanation:

While topic branches/pullrequests/whatever-it-named workflow is
obviously superior to push-to-trunk approach which is used with
centralized VCSes, there can be cases to use the latter one. But doing
it with Git is not easy:

* when the trunk goes forward, user have to run merge or
  rebase (further "update"), interrupting other work which
  might be in progress.
* while doing fetch, update and push back a concurrent push can happen,
  making user to have to repeat it all over.
* some scenarios allow user to make a mistake combining branches which
  mean to be unrelated, for example merging or rebasing active
  development branch into maintenance branch for older version.
* for a merge case there is a problem of "evil pull"
  (http://thread.gmane.org/gmane.comp.version-control.git/247237)
  In short: the merges which are to go to remote branch should be "from
  local to remote", and git-pull merges "from remote to local".

This was discussed around some time ago, but I could not find anything
done about it. It might seem like nobody really interested much. But I
still can see discussions here and there. Also, some time ago extension
"pushrebase" for mercurial appeared, which indicates that there is
really a demand.

Looks like current git remote protocol does not really allow server to
tweak pushed commits: if it accepts reference, client will remember
exactly the commit it was pushing, no modifications is possible. Also,
if it is implemented as server-side feature, it might take years to
appear at github or other big public hostings, if ever. Until that most
users would not be able to try it.

This leaves only one option: perform merge or rebase locally, pretending
that it was done at server. It does not even have to be implemented in
git itself, instead a wrapper script can do everything.

So here is the script.

-- 
Max
