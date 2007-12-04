From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Pulling tags no longer works in 1.5.3.4...
Date: Mon, 03 Dec 2007 23:41:25 -0800
Message-ID: <7v8x4a9aai.fsf@gitster.siamese.dyndns.org>
References: <4754B4AF.8070408@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 08:41:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzSPi-0005lo-KR
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 08:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbXLDHle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 02:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbXLDHld
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 02:41:33 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39979 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbXLDHld (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 02:41:33 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B3D762EF;
	Tue,  4 Dec 2007 02:41:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1029B999C3;
	Tue,  4 Dec 2007 02:41:50 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67012>

Jeff Garzik <jeff@garzik.org> writes:

> 	git pull ../linux-2.6
> 	git pull --tags ../linux-2.6

This is tricky, and in order to decide the right course of action, we
need to understand some background.

"git pull" is defined as "fetch the history missing at this end from the
remote, and integrate the remote change to the current branch".

    Side note. Historically, "integrate ... to the current branch" was
    defined as "merge", so I would have phrased the above as "pull is
    fetch followed by merge", but I am being a bit careful here.
    Upcoming 1.5.4 will optionally allow you to rebase on top of what
    was fetched instead of merging.

Now, your second "git pull --tags" is about fetching the tags but what
is it integrating?  Nothing.  What you wanted to would have been
expressed much better with "git fetch --tags".

    Side note.  My conclusion at the end would NOT be "so your usage is
    wrong, do not complain", so swallow the "I do not care.  This has
    always worked!" for a while and read on.

    Side note.  For a long time, the first "git pull" from a repository
    you track with tracking branches followed the tags automatically,
    and there shouldn't be any reason to do a separate "fetch --tags"
    these days.

Now, what is integrated by "integration of remote change into the
current branch" step has long been defined as "merge refspec explicitly
given from the command line (if exists), otherwise use the first Pull:
line in .git/remotes/ file or corresponding remote.*.fetch line in
.git/config", no matter which branch you are on.  This traditional
definition was fine as long as the puller stayed on the primary
integration branch.

Then people started using multiple branches in a single repository a lot
more than before.  Running "git pull" when you are on a branch that is
not your primary integration branch still merged the default branch you
get from the remote into your current branch.  This behaviour was
unpopular.  Users, especially with ones with shared repository workflow,
wanted to have branches A and B at the remote to correspond to their
local branches A and B, and wanted to merge A from the remote when they
issued "git pull" while on branch A and remote B while on branch B.

This was made possible by allowing branch.*.merge configuration variable
set for each branch to specify what remote branch to merge in during
git-pull.  Everybody was happier.  But the default stayed the same to
help old timers (like us).  Without such a configuration, "first refspec
configured" rule still apply.

Now, some users ran "git pull" without configuring branch.*.merge and
got the default (typically, "master") remote branch merged into the
branch they happened to have checked out.  Again this was unpopular.

So there was an additional safety devised, early December 2006.  If
branch.*.merge is not configured, "git-pull" may not find any remote
branch to merge to the current branch without being told explicitly from
the command line (i.e. "git pull $there master").  For such a case, the
help message you saw is issued, instead of silently failing, to instruct
the user about the configuration variable.  This message, from the point
of view of users who complained about the unpopular behaviour described
above, was a bugfix.  The earlier behaviour of not issuing any help
message when you did "git pull --tags" was a bug.

Now with that long background story in mind...

Still, it does not make sense to "integrate the changes reachable from
the tags to my current branch" at all.  While we could argue that use of
"git pull --tags" is a nonsense to begin with, we can also argue that
the command line is saying "I am not interested in integrating anything
I got from the remote with this fetch" explicitly from the command line.

We could just honor that and be silent in such a case, instead of giving
the message you saw.

We could do something like the following patch, but it does feel like a
special hack to keep "traditional misuse" working, doesn't it?

---
 git-pull.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 74bfc16..00f73d1 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -97,6 +97,13 @@ case "$merge_head" in
 	esac
 	curr_branch=${curr_branch#refs/heads/}
 
+	nontag=$(sed -e '/	not-for-merge	tag/d' "$GIT_DIR/FETCH_HEAD")
+	case "$nontag" in
+	'')
+		exit 0 ;# git pull --tags
+		;;
+	esac
+
 	echo >&2 "You asked me to pull without telling me which branch you"
 	echo >&2 "want to merge with, and 'branch.${curr_branch}.merge' in"
 	echo >&2 "your configuration file does not tell me either.  Please"
