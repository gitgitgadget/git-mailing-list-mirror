From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: my git problem
Date: Mon, 28 Apr 2008 14:35:01 -0700
Message-ID: <20080428143501.7d6e3ad0.akpm@linux-foundation.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org>
	<20080427124454.6a606305.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:35:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqb0o-0003lV-HU
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbYD1VfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 17:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbYD1VfF
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:35:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50314 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965201AbYD1VfD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 17:35:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SLZ10L005967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 14:35:03 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3SLZ1MI016873;
	Mon, 28 Apr 2008 14:35:01 -0700
In-Reply-To: <alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.806 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80624>

On Sun, 27 Apr 2008 13:24:08 -0700 (PDT) Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So it depends on what you want.
> 
> 	git diff a...b
> 
> says literally "what has been added to 'b' since it diverged from 'a'". 

Confounded by Ingo.

origin.patch (generated via git-diff v2.6.25...origin) has:

commit 7f424a8b08c26dc14ac5c17164014539ac9a5c65
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Apr 25 17:39:01 2008 +0200

    fix idle (arch, acpi and apm) and lockdep


and git-x86 (generated via git-diff origin...git-x86) has:

commit 0a1679501624482a06c19af49d55b68d3973e2f0
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Apr 25 17:39:01 2008 +0200

    fix idle (arch, acpi and apm) and lockdep
    

which I assume is the same patch as a different commit.


The old `doit':

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

prevented that by doing a merge.


git-diff was "wrong" to claim that this change is actually present in the
origin->git-x86 diff.  But I guess it cannot operate at that level and we
need to do the merge to resolve it.  Or something.

ho hum.
