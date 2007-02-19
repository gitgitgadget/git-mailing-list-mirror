From: Bill Lear <rael@zopyra.com>
Subject: Re: Where/how to create tracking branches?
Date: Mon, 19 Feb 2007 14:13:02 -0600
Message-ID: <17882.1230.704770.12880@lisa.zopyra.com>
References: <17881.54325.475907.468492@lisa.zopyra.com>
	<7vy7mu6ihj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 21:13:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJEsv-00021x-LS
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 21:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbXBSUNM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 15:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbXBSUNL
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 15:13:11 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61336 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932571AbXBSUNK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 15:13:10 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1JKD6A17129;
	Mon, 19 Feb 2007 14:13:06 -0600
In-Reply-To: <7vy7mu6ihj.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40147>

On Monday, February 19, 2007 at 11:43:36 (-0800) Junio C Hamano writes:
>...
>Assuming your clone was initially made from /public/repo/project,
>doesn't "git fetch" without _any_ parameter work?
>
>	$ git fetch

Short answer: yes, it does.  I had assumed I needed to create the
tracking branch somehow since I created the topic branch in the first
place in my private repo.  More detailed confirmation follows, but
thank you for pointing out that git is in fact smarter than I gave
it credit.

# set up a public repo with "master" branch and something in it...
mkdir public_repo && cd public_repo && git --bare init
cd ..
mkdir a_repo && cd a_repo && git init
echo A > A && git add A && git commit -a -m A
git push ../public_repo master:master

# clone public repo to get my private repo, create topic branch
cd ..
git clone public_repo private_repo
cd private_repo
git checkout -b topic
echo change >> A && git commit -a -m change

# publish my branch 'topic' to my public repo
git push ../public_repo topic:topic

# A peer grabs the topic branch, makes changes and pushes back to public
cd ..
git clone public_repo peer_repo
cd peer_repo
git checkout -b topic origin/topic
echo more >> A && git commit -a -m more
git push ../public_repo topic:topic

# Go to my private repo, pull latest changes (show output this time...)
cd ../private_repo
git checkout master
git pull
remote: Generating pack...
remote: Done counting 5 objects.
Result has 3 objects.
remote: Deltifying 3 objects.
remote: /3) done/3) done
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking 3 objects
 100% (3/3) done
* refs/remotes/origin/topic: storing branch 'topic' of /home/blear/test/public_repo
  commit: 4a8e157
Already up-to-date.

# Now, switch to topic branch
git checkout topic
cat A
A
change

# Ok, now I get it:
git diff origin/topic
[changes listed]
git merge origin/topic
cat A
A
change
more


Bill
