From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git guidance
Date: Fri, 7 Dec 2007 23:00:25 +0100
Message-ID: <20071207220025.GD2001@atjola.homenet>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com> <200712070737.18519.a1426z@gawab.com> <475906F7.5010309@op5.se> <200712071353.11654.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Transfer-Encoding: 8bit
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Susi <psusi@cfl.rr.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jing Xue <jingxue@digizenstudio.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 23:02:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0lFe-00036z-5K
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 23:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623AbXLGWAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 17:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754428AbXLGWAb
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 17:00:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:40765 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755467AbXLGWAa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 17:00:30 -0500
Received: (qmail invoked by alias); 07 Dec 2007 22:00:27 -0000
Received: from i577AE940.versanet.de (EHLO localhost) [87.122.233.64]
  by mail.gmx.net (mp033) with SMTP; 07 Dec 2007 23:00:27 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19bAroJ1vxbem0kwvT+ZwvmNL1Wj/tEOoJdJwpD6q
	VZXVq09H+xjF56
Content-Disposition: inline
In-Reply-To: <200712071353.11654.a1426z@gawab.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67477>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2007.12.07 13:53:11 +0300, Al Boldi wrote:
> Andreas Ericsson wrote:
> > So, to get to the bottom of this, which of the following workflows is it
> > you want git to support?
> >
> > ### WORKFLOW A ###
> > edit, edit, edit
> > edit, edit, edit
> > edit, edit, edit
> > Oops I made a mistake and need to hop back to "current - 12".
> > edit, edit, edit
> > edit, edit, edit
> > publish everything, similar to just tarring up your workdir and sending
> > out ### END WORKFLOW A ###
> >
> > ### WORKFLOW B ###
> > edit, edit, edit
> > ok this looks good, I want to save a checkpoint here
> > edit, edit, edit
> > looks good again. next checkpoint
> > edit, edit, edit
> > oh crap, back to checkpoint 2
> > edit, edit, edit
> > ooh, that's better. save a checkpoint and publish those checkpoints
> > ### END WORKFLOW B ###
> 
> ### WORKFLOW C ###
> for every save on a gitfs mounted dir, do an implied checkpoint, commit, or 
> publish (should be adjustable), on its privately created on-the-fly 
> repository.
> ### END WORKFLOW C ###
> 
> For example:
> 
>   echo "// last comment on this file" >> /gitfs.mounted/file
> 
> should do an implied checkpoint, and make these checkpoints immediately 
> visible under some checkpoint branch of the gitfs mounted dir.
> 
> Note, this way the developer gets version control without even noticing, and 
> works completely transparent to any kind of application.

Ouch... That looks worse than "plain" per-file versioning. Not only do
you per definition get "broken" commits if there's a change that affects
two dependent files, you also get an insane amount of commits just for
testing stuff, or fixing bugs.

And unless you use some kind of union-fs on top (or keep ignored files
in special unversioned area in your gitfs, which seems somewhat ugly),
you'll probably also have to track lots of files in the working
directory that are generated, unless you want to re-generate them after
each reboot. And that leads to even more absolutely useless revisions.

Just thinking of my vim .swp files (which I definitely don't want to
loose on a crash/power outtage/pkill -9 .<ENTER> dammit) makes me scream
because of the gazillion of commits they will produce (and no, I don't
want them in some special out of tree directory).

Plus, I have vim setup to _replace_ files on write, so that I can more
easily use hard-linked copies with changing all copies at once _unless_
I explicitly want to, meaning that I'd get full remove/add commits,
which are absolutely useless. And trying to detect such patterns
(rename, then write the changed file with the old name and then delete
the renamed file) is probably not worth the trouble, because you
coincidently might _want_ to have just these three steps recorded when
you happen to perform them manually. And if you go for heuristics,
you'll complain each time you get a false-positive/negative.


That said, out of pure curiousness I came up with the attached script
which just uses inotifywait to watch a directory and issue git commands
on certain events. It is extremely stupid, but seems to work. And at
least it hasn't got the drawbacks of a real gitfs regarding the need to
have a "separate" non-versioned storage area for the working directory,
because it simply uses the existing working directory wherever that
might be stored. It doesn't use GIT_DIR/WORK_DIR yet, but hey, should be
easy to add...

Feel free to mess with that thing, hey, maybe you even like it and
extend it to match your proposed workflow even more. I for sure won't
use or even extend it, so you're likely on your own there.

Side-note: Writing that script probably took less time than writing this
email and probably less time than was wasted on this topic. Makes me
want to use today's preferred "Code talks, b...s... walks" statement,
but I'll refrain from that... Just because I lack the credibility to say
that, and the script attached is quite crappy ;-)

Björn

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=git-watch

#!/bin/bash
inotifywait -m -r --exclude ^\./\.git/.* -e close_write -e move -e create -e delete . 2>/dev/null |
while read FILE_PATH EVENT FILE_NAME
do
	FILE_NAME="$FILE_PATH$FILE_NAME"
	FILE_NAME=${FILE_NAME#./}

	# git doesn't care about directories
	if [ -d "$FILE_NAME" ]
	then
		continue
	fi

	case "$EVENT" in
		*CLOSE_WRITE*)
		ACTION=change
		;;
		*MOVED_TO*)
		ACTION=create
		;;
		*MODIFY*)
		ACTION=change
		;;
		*DELETE*)
		ACTION=delete
		;;
		*MOVED_FROM*)
		ACTION=delete
		;;
		*CREATE*)
		ACTION=create
		;;
		*)
		continue
		;;
	esac

	case $ACTION in
		create)
		git add "$FILE_NAME"
		git commit -m "$FILE_NAME created"
		;;
		delete)
		git rm --cached "$FILE_NAME"
		git commit -m "$FILE_NAME removed"
		;;
		change)
		git add "$FILE_NAME"
		git commit -m "$FILE_NAME changed"
		;;
	esac
done

--2oS5YaxWCcQjTEyO--
