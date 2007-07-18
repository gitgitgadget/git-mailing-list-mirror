From: David Kastrup <dak@gnu.org>
Subject: Empty directories...
Date: Wed, 18 Jul 2007 02:13:11 +0200
Organization: Organization?!?
Message-ID: <85lkdezi08.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 02:13:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAxAZ-00022X-8c
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 02:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758829AbXGRAN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 20:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757824AbXGRAN2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 20:13:28 -0400
Received: from main.gmane.org ([80.91.229.2]:47050 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756863AbXGRAN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 20:13:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IAxAQ-0008QO-JN
	for git@vger.kernel.org; Wed, 18 Jul 2007 02:13:22 +0200
Received: from dslb-084-061-005-188.pools.arcor-ip.net ([84.61.5.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 02:13:22 +0200
Received: from dak by dslb-084-061-005-188.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 02:13:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-005-188.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:jC71b5xjd/1U7hI0mWz3egPNoE8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52813>


GIT(7) -- 03/05/2007

NAME
	git - the stupid content tracker


Well, I use git for tracking contents.  That means, for example,
installation trees for some application.  Let's take a typical TeXlive
tree as an example.  Those trees contain, among other things,
directories where new fonts/formats/whatever get placed as things run.
Quite a few of them start out empty, but their permissions have to
correspond to their purpose (for example, some are world-writable).

I see little chance to get this achieved without doing something like

find -type d -empty -execdir touch {}/.git-this-is-empty +

before every checkin and

find -name .git-this-is-empty -exec rm -- {} +

after every checkout.  Which is pretty stupid.

As some anecdotal stuff, I did something like

mkdir test
cd test
git-init
touch README
git-add README # another peeve: why is no empty reference point possible?
git-commit -a -m "Initial branch"
git checkout -b newbranch master
unzip ../somearchive -d subdir
git add subdir
git commit -a -m "Add subdir"
git checkout -b newbranch2 master

and expect to have a clean slate.  No such luck: without warning, all
empty directories in the zip file are still remaining within subdir,
which as a consequence has not been cleaned up.

So even if one is of the opinion that empty directories are not worth
putting into the repository: if I check in an entire subdirectory
hierarchy and then switch to a branch where this subdirectory is not
existent, I expect the subdirectory to be _gone_, and not have some
littering of empty directories lying around.

And that git-diff can see nothing wrong with that does not really
improve things.

So if git is supposed to be a content tracker, I can't see a way
around it actually being able to track content, and empty directories
_are_ content.  It can't let them flying around with arbitrary
permissions on them when I switch branches or tags.  And the
workaround using "touch" mentioned above is really awful to do
manually all the time.

Could git technically track a file with a zero-length filename in
empty directories if one tells it explicitly to include it, like with
git-add \! -x "" subdir
or has somebody a better idea or interface or rationale?  I understand
that there are use cases where one does not bother about empty
directories, but for a _content_ tracker, not tracking directories
because they are empty seems quite serious.

Ok, kill me.  This must likely be the most common FAQ/rant/whatever
concerning git.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
