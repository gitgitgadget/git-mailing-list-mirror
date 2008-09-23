From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: rebasing merges
Date: Tue, 23 Sep 2008 13:29:16 -0500
Organization: Exigence
Message-ID: <20080923132916.b9603658.stephen@exigencecorp.com>
References: <20080922155749.c8070681.stephen@exigencecorp.com>
	<20080922231927.ef18f420.stephen@exigencecorp.com>
	<48D88813.9060400@viscovery.net>
	<20080923024653.a3bb8666.stephen@exigencecorp.com>
	<48D8A6EA.4020805@op5.se>
	<20080923040302.c4d0d33b.stephen@exigencecorp.com>
	<48D8B2C1.5070800@op5.se>
	<20080923043039.bf380694.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__23_Sep_2008_13_29_16_-0500_hMPTv+QDF+wOWYVX"
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 23 20:31:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiCfA-0000cA-4V
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 20:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbYIWS3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 14:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbYIWS3Z
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 14:29:25 -0400
Received: from smtp132.sat.emailsrvr.com ([66.216.121.132]:32947 "EHLO
	smtp132.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbYIWS3X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 14:29:23 -0400
Received: from relay3.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 57403250223;
	Tue, 23 Sep 2008 14:29:21 -0400 (EDT)
Received: by relay3.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id C9D452501F2;
	Tue, 23 Sep 2008 14:29:20 -0400 (EDT)
In-Reply-To: <20080923043039.bf380694.stephen@exigencecorp.com>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96582>

This is a multi-part message in MIME format.

--Multipart=_Tue__23_Sep_2008_13_29_16_-0500_hMPTv+QDF+wOWYVX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > That's beside the point though, as I firmly believe git should be more
> > helpful in this situation. If "git rebase -i -p" doesn't help you fix
> > the problems, I'll see what I can do to help.
> 
> That's very cool, thanks. I'll start writing a test now.

I've attached a test. You were both correct, `git rebase -i -p` keeps
the merge intact and doesn't duplicate the commits. This is awesome.

So, I'm wondering what the best way to integrate this into our workflow
is. Ideally, I think it would be great to just do:

    git pull --rebase --preserve-merges

Or even better just `git pull` with branch.x.rebase=true and
branch.x.preserve-merges=true property (throw in a
branch.autosetuppreservemerges and I'll be set, haha).

While `git fetch + git rebase -i -p` will work every time, it won't be
fun to have the editor pop open, just exit it because we're not really
doing an interactive rebase, we're just borrowing its more powerful
rebase implementation, and repeat this each time a dev wants to do a
pull. Or, tell them to do a "git pull --rebase" most of the time, until
it screws up, then back up and do the other. Both doable, but not ideal.

I understand Johannes's scenario of rebasing the entire branch, and it
looks like rebase--interactive already supports this as well--e.g. if
you pass `-p`, you get our desired behavior, and if you don't pass `-p`,
you get Johannes's desired behavior of merge squashing.

Given rebase--interactive seems to be a superset of the current rebase
implementation, could the current rebase implementation just go away and
instead become a non-interactive caller (e.g. just avoid popping up the
editor with the pick list) of rebase--interactive's more powerful
rebase logic?

(Disclaimer: I'm throwing the term "more powerful" around without really
knowing whether that is true or not--for our scenario, it seems that
way, but there could be other cases I don't know about where the current
rebase implementation is superior to rebase--interactive's.)

Thanks,
Stephen


--Multipart=_Tue__23_Sep_2008_13_29_16_-0500_hMPTv+QDF+wOWYVX
Content-Type: text/x-sh;
 name="t3402-rebase-merge2.sh"
Content-Disposition: attachment;
 filename="t3402-rebase-merge2.sh"
Content-Transfer-Encoding: 7bit

#!/bin/sh
#
# Copyright (c) 2005 Amos Waterland
#

test_description='git rebase should not destroy author information

This test runs git rebase and checks that the author information is not lost.
'
. ./test-lib.sh

GIT_AUTHOR_EMAIL=bogus_email_address
export GIT_AUTHOR_EMAIL

echo 'Setting up:

A1--A2  <-- origin/master
 \   \
  B1--M  <-- topic
   \
    B2  <-- origin/topic

'

test_expect_success 'prepare repository with topic branches' \
    'echo First > A &&
     git add A &&
     git-commit -m "Add A1" &&
     git checkout -b topic &&
     echo Second > B &&
     git add B &&
     git-commit -m "Add B1" &&
     git checkout -f master &&
     echo Third >> A &&
     git-commit -a -m "Modify A2" &&

     git clone ./. clone1 &&
     cd clone1 &&
     git checkout -b topic origin/topic &&
     git merge origin/master &&
     cd ..

     git clone ./. clone2
     cd clone2 &&
     git checkout -b topic origin/topic &&
     git merge origin/master &&
     cd .. &&

     git checkout topic &&
     echo Fourth >> B &&
     git commit -a -m "Modify B2"
'

# Blatant copy/paste from t3404-rebase-interactive.sh--needs cleaned up
echo "#!$SHELL_PATH" >fake-editor.sh
cat >> fake-editor.sh <<\EOF
case "$1" in
*/COMMIT_EDITMSG)
	test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
	test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
	exit
	;;
esac
test -z "$EXPECT_COUNT" ||
	test "$EXPECT_COUNT" = $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) ||
	exit
test -z "$FAKE_LINES" && exit
grep -v '^#' < "$1" > "$1".tmp
rm -f "$1"
cat "$1".tmp
action=pick
for line in $FAKE_LINES; do
	case $line in
	squash|edit)
		action="$line";;
	*)
		echo sed -n "${line}s/^pick/$action/p"
		sed -n "${line}p" < "$1".tmp
		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
		action=pick;;
	esac
done
EOF

test_set_editor "$(pwd)/fake-editor.sh"
chmod a+x fake-editor.sh

test_expect_failure 'rebase merge on moved topic' '
     cd clone1 &&
     git pull --rebase &&
     test $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) = 1
'

test_expect_success 'rebase -i -p merge on moved topic' '
     cd ../clone2 &&
     git fetch &&
     FAKE_LINES="1 2" git rebase -i -p origin/topic &&
     test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
     test 1 = $(git rev-list --all --pretty=oneline | grep "Merge commit" | wc -l)
'

test_done


--Multipart=_Tue__23_Sep_2008_13_29_16_-0500_hMPTv+QDF+wOWYVX--
