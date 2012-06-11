From: Joseph Chiu <joechiu@joechiu.com>
Subject: Git repository name-guessing corner case
Date: Mon, 11 Jun 2012 12:28:51 -0700 (PDT)
Message-ID: <1339442931056-7561236.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 21:29:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeAIM-0000FD-Ak
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838Ab2FKT2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 15:28:52 -0400
Received: from sam.nabble.com ([216.139.236.26]:49081 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068Ab2FKT2w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 15:28:52 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <joechiu@joechiu.com>)
	id 1SeAIF-0002LS-29
	for git@vger.kernel.org; Mon, 11 Jun 2012 12:28:51 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199712>

Hello,

I ran into an admittedly bizarre corner case, caused in part by my own
failings, but I wanted to report it.  I haven't come across anyone else
having had this experience (but I suspect that I haven't properly exhausted
the right combination of search terms).

I maintain a big handful of my workplace's git repo's - there is a "north"
server and a "south" git server.  They both run gitosis for access control. 
The repo's are generally setup to sync the north and south repos to each
other for disaster recovery purposes.

I'll glossing over the backstory - but the process for creating repo's for
new projects is partially automated, and involves some manual steps.  

On the north machine, I created the repo wizard.git, with the mirroring
configured to south:wizard.git

On the south machine, I first accidentally created the repo wizard.git.git
(note the double .git), with the mirroring configured by default to
north:android.git (I'll gloss over the back story here - but basically, the
template used for repo setup used a working config file from the android
project - and the real repo name was left in the template).

On the south machine, I then created the repo wizard.git with the mirror
configured to north:wizard.git

As you might guess, there was already a north:android.git and
south:android.git repo's configured.

So the corner case (or perhaps just a "gotcha") that occured is this:  when
my developer pushed their new code into the north:wizard.git repo, the hook
to replicate the repo fired, mirroring to south:wizard.git -- however,
instead of operating on the wizard.git bare repo, the mirroring was done to
the wizard.git.git repo.   The hook that subsequently fired mirrored to
north:android.git and, in turn, a mirroring was done to south:android.git.

Because the android.git bare repo was recently set to allow deletes of
branches and tags for housekeeping reasons, this allowed the push to the
north:wizard.git repo to chain to the android.git repo's, deleting all
branches in that project.

I'm guessing this must be the result of the git repo name guessing code
trying a repo name with a .git attached first.  Admittedly, this problem was
caused by my dumb actions (template config file pointing to a real repo; not
removing the wrong bare repo as soon as I created it) -- but I suspect that
this is an undesired behavior.  (BTW, no permanent damage was done in my
case - I was able to replicate a relatively recent clone back into the
master servers.)

Thanks for reading this.
Joseph



--
View this message in context: http://git.661346.n2.nabble.com/Git-repository-name-guessing-corner-case-tp7561236.html
Sent from the git mailing list archive at Nabble.com.
