From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge doesn't remove files
Date: Sat, 03 Feb 2007 17:41:57 -0800
Message-ID: <7vd54qzoka.fsf@assigned-by-dhcp.cox.net>
References: <20070203224819.20131.qmail@b1b53206edee41.315fe32.mid.smarden.org>
	<7vy7nezr1f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Gerrit Pape <pape@smarden.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 02:42:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDWOH-0003Bw-Ki
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 02:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbXBDBl7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 20:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbXBDBl7
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 20:41:59 -0500
Received: from fed1rmmtai18.cox.net ([68.230.241.41]:62159 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751887AbXBDBl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 20:41:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204014158.HTHF1302.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 20:41:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KDhx1W00j1kojtg0000000; Sat, 03 Feb 2007 20:41:58 -0500
In-Reply-To: <7vy7nezr1f.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 03 Feb 2007 16:48:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38633>

Junio C Hamano <junkio@cox.net> writes:

> Gerrit Pape <pape@smarden.org> writes:
>
>> Shouldn't git remove the original file after merging a commit that moved
>> the file away?
>
> I think this has been fixed quite a while ago --- does not seem
> to reproduce with the current v1.5.0-rc.

Having said that, I think there is a worse problem with
merge-recursive.  It loses untracked files that are not
involved in the merge.

    $ mkdir repo && cd repo
    $ git init-db
    Initialized empty Git repository in .git/
    $ echo a >foo && git add foo
    $ git commit -a -m'add foo'
    Created initial commit da51b094c7c75aef4362e229975be7f376fa00cb
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 foo
    $ git branch b
    $ git mv foo bar
    $ git commit -a -m'move foo'
    Created commit 3154467cd539db7a90e04b7291442384222de4a4
     2 files changed, 1 insertions(+), 1 deletions(-)
     create mode 100644 bar
     delete mode 100644 foo

The 'master' branch renames 'foo' to 'bar'

    $ git checkout b
    Switched to branch "b"
    $ echo ttt >>foo
    $ git commit -a -m'change foo'
    Created commit eb14bff5f399b1a9ca6aa450a803833c3f7b7b3a
     1 files changed, 1 insertions(+), 0 deletions(-)

The 'b' branch keeps 'foo' but modifies it.

    $ git checkout master
    Switched to branch "master"
    $ echo frotz >foo

The 'master' branch has an untracked file 'foo' now.

    $ git merge b
     100% (5/5) done
    Merge made by recursive.
     bar |    1 +
     1 files changed, 1 insertions(+), 0 deletions(-)
    $ ls -a
    ./  ../  bar  .git/

Oops.  'foo' is not involved in the merge but is lost.

Sadly, a similar case was fixed in merge-resolve where our
branch has already removed a file, had an untracked file of the
same name in the working tree, and merging an old branch that
still had that path.

    $ git init
    Initialized empty Git repository in .git/
    $ echo a >foo ; echo b >bar ; git add .
    $ git commit -m 'initial'
    Created initial commit 7925ec23146d4bffa1078a2c220df2c2f9935ca8
     2 files changed, 2 insertions(+), 0 deletions(-)
     create mode 100644 bar
     create mode 100644 foo
    $ git branch b
    $ rm foo ; echo ttt >>bar
    $ git commit -a -m 'remove foo and update bar'
    Created commit 7fbbec4cb0d4af95090e0ba4f1fb8c9630d8e438
     2 files changed, 1 insertions(+), 1 deletions(-)
     delete mode 100644 foo
    $ git checkout b
    Switched to branch "b"
    $ echo c >baz ; git add .
    $ git commit -m 'side'
    Created commit 272ef105f43df5e3629d6915001476651cafa139
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 baz
    $ git checkout master
    Switched to branch "master"
    $ ls -a
    ./  ../  bar  .git/
    $ echo throw >foo
    $ git merge -s resolve b
    Trying really trivial in-index merge...
    fatal: Merge requires file-level merging
    Nope.
    Trying simple merge.
    Merge made by resolve.
     baz |    1 +
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 baz
    $ ls -a
    ./  ../  bar  baz  foo  .git/
    $ cat foo
    throw

Fortunately merge-recursive gets this case right, but when a
rename is involved it does not.
