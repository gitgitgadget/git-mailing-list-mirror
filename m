From: Stephen Haberman <stephen@exigencecorp.com>
Subject: interactive rebase not rebasing
Date: Sun, 28 Sep 2008 23:50:13 -0500
Organization: Exigence
Message-ID: <20080928235013.5c749c6e.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__28_Sep_2008_23_50_13_-0500_9lH3vLMCZpS0/00="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 06:53:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkAlF-0005n6-Dr
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 06:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbYI2EuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 00:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbYI2EuS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 00:50:18 -0400
Received: from smtp122.sat.emailsrvr.com ([66.216.121.122]:43818 "EHLO
	smtp122.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbYI2EuR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 00:50:17 -0400
Received: from relay2.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay2.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id A51FF26F5C3
	for <git@vger.kernel.org>; Mon, 29 Sep 2008 00:50:16 -0400 (EDT)
Received: by relay2.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 5674726F22D
	for <git@vger.kernel.org>; Mon, 29 Sep 2008 00:50:16 -0400 (EDT)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sun__28_Sep_2008_23_50_13_-0500_9lH3vLMCZpS0/00=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

Per the emails from me last week, I'm working in an environment with
shared topic branches and am trying to find a bullet-proof way for devs
to rebase their local commits after the topic branch has moved.

The easy approach would be to just let `git pull` create merge commits,
and I would have been done with this long ago, but I'm striving to get
rebasing to "just work" and avoid the ugliness of same-branch merge
commits. Cross-branch merge commits are cool, but not same-branch.

So, here's a crazy scenario we've ran into--a new release has hit
stable, with two devs working on the same topic branch, and both of them
merge. One wins, and the other has to rebase. Previously, this was
replaying commits, but with great tips from the list last week, `rebase
-i -p` is handling most scenarios.

However, not this one:

# A --C------            <-- origin/stable
#  \  |      \
#   B -- D -- E -- F     <-- origin/topic2
#    \|
#     g -- h             <-- topic2

topic2 is a dev that has locally merged stable in g, moved on in h, is
ready to push, but another dev already merged stable in E, and also
committed F.

If we do a `git pull --no-rebase`, the result is:

# A --C------            <-- origin/stable
#  \  |      \
#   B -- D -- E -- F     <-- origin/topic2
#    \|             \
#     g -- h ------- i   <-- topic2

But i is a same-branch merge, and we'd rather rebase to something like:

# A --C------            <-- origin/stable
#  \         \
#   B -- D -- E -- F     <-- origin/topic2
#                   \
#                    h'  <-- topic2

(...maybe g' in there if g resolved stable conflicts differently
E did them. I'm not sure, I haven't gotten there yet.)

However, currently, `git rebase -i -p origin/topic2` results in:

# A --C------            <-- origin/stable
#  \  |      \
#   B -- D -- E -- F     <-- origin/topic2
#    \|
#     g -- h             <-- topic2

Nothing has changed. g & h haven't moved...I can keep executing this
operation and the commits never make it on top of origin/topic2's F. 

Frustratingly, if I run non-interactive rebase, it works perfectly. But
I've got other cases (see earlier posts) that do need the interactive
rebase. Personally, I could probably make do with trying each and
seeing what happened, but I'm really trying to find a bullet proof
command/alias/script for devs to run and have it "just work".

I've attached a test that sets up the DAG as above and currently passes
by asserting the not-desired/unchanged-DAG result. The assert for the
desired result is commented out at the end.

Am I correct in asserting this is some sort of bug in the interactive
rebase such that g & h are not ending up on top of F?

Thanks,
Stephen



--Multipart=_Sun__28_Sep_2008_23_50_13_-0500_9lH3vLMCZpS0/00=
Content-Type: text/x-sh;
 name="t3404b.sh"
Content-Disposition: attachment;
 filename="t3404b.sh"
Content-Transfer-Encoding: 7bit

#!/bin/sh

test_description='rebase interactive does not rebase'

. ./test-lib.sh

test_expect_success 'setup' '
	echo "setup" >a &&
	git add a &&
	git commit -m "setup" &&
	git clone ./. server &&
	rm -fr server/.git/hooks &&
	git remote add origin ./server &&
	git config --add branch.master.remote origin &&
	git config --add branch.master.merge refs/heads/master &&
	git fetch &&

	git checkout -b stable master &&
	echo "setup.stable" >a &&
	git commit -a -m "stable" &&
	git push origin stable
'
#
# A --C------            <-- origin/stable
#  \  |      \
#   B -- D -- E -- F     <-- origin/topic2
#    \|             \
#     g -- h ------- i   <-- topic2
#
# Trying to push F..i
#
# merge-base(F, h) has two options: B and C
#
test_expect_success 'merging in stable with tricky double baserev does not fool the script' '
	# B: start our topic2 branch, and share it
	git checkout -b topic2 origin/stable &&
	git config --add branch.topic2.merge refs/heads/topic2 &&
	echo "commit B" >a.topic2 &&
	git add a.topic2 &&
	git commit -m "commit B created topic2" &&
	git push origin topic2 &&

	# C: now, separately, move ahead stable, and share it
	git checkout stable
	echo "commit C" >a &&
	git commit -a -m "commit C moved stable" &&
	git push origin stable &&

	# D: have another client commit (in this case, it is the server, but close enough) moves topic2
	cd server &&
	git checkout topic2 &&
	echo "commit D continuing topic2" >a.client2 &&
	git add a.client2 &&
	git commit -m "commit D by client2" &&

	# E: the same other client merges the moved stable
	git merge stable &&

	# F: the same other client moves topic2 again
	echo "commit F" >a.client2 &&
	git commit -a -m "commit F by client2" &&
	F_hash=$(git rev-parse HEAD) &&
	cd .. &&

	# g: now locally merge in the moved stable (even though our topic2 is out of date)
	git checkout topic2 &&
	git merge stable &&
	g_hash=$(git rev-parse HEAD) &&

	# h: advance local topic2
	echo "commit H" >a.topic2 &&
	git commit -a -m "commit H continues local fork" &&
	h_hash=$(git rev-parse HEAD) &&

	# i: make a new merge commit
	git pull --no-rebase &&
	i_hash=$(git rev-parse HEAD) &&

	# Watch merge rejected as something that should get rebased
	# ! git push origin topic2
	test "$i_hash $h_hash $F_hash" = "$(git rev-list --parents --no-walk HEAD)"

	# Now fix it the merge by rebasing it
	git reset --hard ORIG_HEAD &&
	GIT_EDITOR=: git rebase -i -p origin/topic2 &&
	h2_hash=$(git rev-parse HEAD) &&

	# Should be:
	# test "$h2_hash $F_hash" = "$(git rev-list --parents --no-walk HEAD)"
	# But is just:
	test "$h_hash $g_hash" = "$(git rev-list --parents --no-walk HEAD)"
	# Where did $F_hash go?
'

test_done


--Multipart=_Sun__28_Sep_2008_23_50_13_-0500_9lH3vLMCZpS0/00=--
