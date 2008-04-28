From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: my git problem
Date: Mon, 28 Apr 2008 12:33:00 -0700
Message-ID: <20080428123300.f5406ca9.akpm@linux-foundation.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org>
	<20080427124454.6a606305.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
	<20080428114509.240ef4ae.akpm@linux-foundation.org>
	<alpine.DEB.1.00.0804281948270.19187@eeepc-johanness>
	<20080428120917.dd9f01e8.akpm@linux-foundation.org>
	<alpine.DEB.1.00.0804282012140.19187@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:35:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqZ7y-00045J-6C
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966364AbYD1Tdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937178AbYD1Tdg
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:33:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50812 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937071AbYD1Tde (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 15:33:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SJX0W3025894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Apr 2008 12:33:02 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3SJX0lO011627;
	Mon, 28 Apr 2008 12:33:00 -0700
In-Reply-To: <alpine.DEB.1.00.0804282012140.19187@eeepc-johanness>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.806 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80596>

On Mon, 28 Apr 2008 20:13:43 +0100 (BST) Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> > Oh well.  Can you suggest how I can extract the changelogs for the 
> > patches which `git-diff origin...git-ia64' will print out?
> 
> I think you get what you want with
> 
> 	$ git-log --cherry-pick origin...git-ia64
> 
> (although I might be wrong on the order of origin and git-ia64).

Nope, that still generates thousands of lines of wrongness.

It's also very slow, for a non-empty tree:

git-log --cherry-pick origin...git-audit-master > /dev/null  50.47s user 0.56s system 99% cpu 51.043 total

git-diff origin...git-audit-master > /dev/null  0.35s user 0.02s system 100% cpu 0.369 total

weird that it's hundreds of times slower than the corresponding git-diff. 
he-who-pulls-75-trees would be unhappy.

Back to my original problem...

>From my old script:

doit()
{
	tree=$1
	upstream=$2

	cd $GIT_TREE
	git reset --hard "$upstream"
	git fetch "$tree" || exit 1
	git merge --no-commit 'test merge' HEAD FETCH_HEAD > /dev/null

	{
		git_header "$tree"
		git log --no-merges ORIG_HEAD..FETCH_HEAD
		git diff --patch-with-stat ORIG_HEAD
	} >$PULL/$tree.patch
	{
		echo DESC
		echo $tree.patch
		echo EDESC
		git_header "$tree"
		git log --no-merges ORIG_HEAD..FETCH_HEAD
	} >$PULL/$tree.txt
	git reset --hard "$upstream"
}

the `git log' here does what I want.

The new version:

doit()
{
	tree=$1
	upstream=$2

	cd $GIT_TREE
	git reset --hard "$upstream"
	git fetch "$tree" || exit 1

	{
		git_header "$tree"
		git log --no-merges $upstream...$tree
		git diff -p --stat --no-merges $upstream...$tree
	} >$PULL/$tree.patch
	{
		echo DESC
		echo $tree.patch
		echo EDESC
		git_header "$tree"
#		git log --no-merges $upstream...$tree
	} >$PULL/$tree.txt
	git reset --hard "$upstream"
}

loses the changelogs :(
