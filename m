From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Intermittent Failures in t1450-fsck (Bisected)
Date: Sat, 7 May 2011 16:25:28 -0400
Message-ID: <A3947D3B-B434-4C13-A069-6B3C731DABF0@silverinsanity.com>
References: <115C364B-E910-4A9C-949E-3B10E5E6116C@silverinsanity.com> <2838BCC7-FB14-401B-9498-D0FB78C98D91@silverinsanity.com> <20110505093226.GA29595@sigill.intra.peff.net> <60194977-A4A9-4E18-9878-C1CDE77B75C2@silverinsanity.com> <20110505210317.GE1770@sigill.intra.peff.net> <E577B7D7-423E-4E9E-AE47-30E4DB4D21BC@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sat May 07 22:25:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIo4I-0007OS-8K
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 22:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab1EGUZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 16:25:32 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:52527 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab1EGUZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2011 16:25:32 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 06AE21FFC146; Sat,  7 May 2011 20:25:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 035141FFC135;
	Sat,  7 May 2011 20:25:22 +0000 (UTC)
In-Reply-To: <E577B7D7-423E-4E9E-AE47-30E4DB4D21BC@silverinsanity.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173066>


On May 5, 2011, at 5:58 PM, Brian Gernhardt wrote:

> I've actually nailed it down to something even more specific than "OS X".  It's failing when I run it on a ramdisk.
>> 

I've tried to narrow it down even further.  I cut the test down to just the setup and failing test. Then I removed all "test_when_finished" and replaced the "test_must_fail" with "!" so I can directly copy/paste the test into a window.  When the test runs, it fails.  When I run it manually, even with using /bin/sh and eval, it succeeds.  Can anybody else think of what difference there might be between a shell and the test script that I should test?  (I did remember to set GIT_EXEC_PATH and my PATH to run the same version as the script is.)

There's some _very_ weird triggering condition involved here and I'm hoping to narrow it down so I can set some useful breakpoints in gdb and see what's going on inside.

Output follows:

t$ dev=`hdiutil attach -nomount ram://200000`
t$ diskutil erasevolume HFS+ Git_Test $dev
Started erase on disk1
Unmounting disk
Erasing
Initialized /dev/rdisk1 as a 100 MB HFS Plus volume
Mounting disk
Finished erase on disk1 Git_Test
t$ ./t1450-fsck.sh -i -v --root=/Volumes/Git_Test
Initialized empty Git repository in /Volumes/Git_Test/trash directory.t1450-fsck/.git/
expecting success: 
	git config gc.auto 0 &&
	git config i18n.commitencoding ISO-8859-1 &&
	test_commit A fileA one &&
	git config --unset i18n.commitencoding &&
	git checkout HEAD^0 &&
	test_commit B fileB two &&
	git tag -d A B &&
	git reflog expire --expire=now --all &&
	>empty

[master (root-commit) 1347563] A
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 fileA
Note: checking out 'HEAD^0'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b new_branch_name

HEAD is now at 1347563... A
[detached HEAD c9145d6] B
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 fileB
Deleted tag 'A' (was 1347563)
Deleted tag 'B' (was c9145d6)
ok 1 - setup

expecting success: 
	sha1_file() {
		echo "$*" | sed "s#..#.git/objects/&/#"
	} &&

	remove_object() {
		file=$(sha1_file "$*") &&
		test -e "$file" &&
		rm -f "$file"
	}

ok 2 - setup: helpers for corruption tests

expecting success: 
	sha=$(echo blob | git hash-object -w --stdin) &&
	cat >wrong-tag <<-EOF &&
	object $sha
	type commit
	tag wrong
	tagger T A Gger <tagger@example.com> 1234567890 -0000

	This is an invalid tag.
	EOF

	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
	echo $tag >.git/refs/tags/wrong &&
	! git fsck --tags 2>out &&
	cat out &&
	grep "error in tag.*broken links" out

tagged commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 (wrong) in 66f6581d549f70e05ca586bc2df5c15a95662c36
missing commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, not a blob
error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or missing
not ok - 3 tag pointing to something else than its type
#	
#		sha=$(echo blob | git hash-object -w --stdin) &&
#		cat >wrong-tag <<-EOF &&
#		object $sha
#		type commit
#		tag wrong
#		tagger T A Gger <tagger@example.com> 1234567890 -0000
#	
#		This is an invalid tag.
#		EOF
#	
#		tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
#		echo $tag >.git/refs/tags/wrong &&
#		! git fsck --tags 2>out &&
#		cat out &&
#		grep "error in tag.*broken links" out
#	
t$ /bin/sh
sh-3.2$ cd /Volumes/Git_Test/trash\ directory.t1450-fsck
sh-3.2$ rm .git/objects/63/499e4ea8e096b831515ceb1d5a7593e4d87ae5 .git/objects/66/f6581d549f70e05ca586bc2df5c15a95662c36 
override r--r--r--  brian/brian for .git/objects/63/499e4ea8e096b831515ceb1d5a7593e4d87ae5? y
override r--r--r--  brian/brian for .git/objects/66/f6581d549f70e05ca586bc2df5c15a95662c36? y
sh-3.2$ export GIT_EXEC_PATH=$HOME/dev/git
sh-3.2$ export PATH=$HOME/dev/git:$PATH
sh-3.2$ eval '
> sha=$(echo blob | git hash-object -w --stdin) &&
> cat >wrong-tag <<-EOF &&
> object $sha
> type commit
> tag wrong
> tagger T A Gger <tagger@example.com> 1234567890 -0000
> 
> This is an invalid tag.
> EOF
> 
> tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
> echo $tag >.git/refs/tags/wrong &&
> ! $HOME/dev/git/git fsck --tags 2>out &&
> cat out &&
> grep "error in tag.*broken links" out
> '
broken link from     tag 66f6581d549f70e05ca586bc2df5c15a95662c36
broken link from unknown unknown
dangling blob 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, not a commit
error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not load tagged object
error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
sh-3.2$ 
