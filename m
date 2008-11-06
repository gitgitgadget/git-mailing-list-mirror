From: Mike Mazur <mmazur@gmail.com>
Subject: Workflow for sharing changes on top of often-rebased work
Date: Thu, 6 Nov 2008 10:57:58 +0900
Message-ID: <20081106105758.7107a801@sumo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 02:59:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxu9i-0006TG-9Y
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 02:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbYKFB6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 20:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbYKFB6K
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 20:58:10 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:60479 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbYKFB6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 20:58:09 -0500
Received: by rv-out-0506.google.com with SMTP id k40so360242rvb.1
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 17:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=UMjMLxoK60Z7Vj0tLgmrQ5y3izF9k4gtoNkg58zXFjU=;
        b=JtDd5VgBs4h/hBcEr61qO/gWoVB6v//3m12dEcKp3xlX966B5iVPZivKG+mVaD4kmF
         GjvmvKU0oU5bdKia2XME0fgbPUQbUXkW3gZlAlJ/amBUCETplacXvklQGwuVR+6WOXaP
         wv3SO2T5/HRU6S1b8F6lIwZ8iZqrdpcmDPX+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=I1hwF3EvvCb2rqIOYjTreijsn/KDo3DCTfU7fLFssTzk5L8qd+4lXk9aTQSQYBQJNX
         XFunzkEkPoTD70yZ5VHhC/g62PPVkLT18oo1nRf9Jh7HUPRTTgHQZJxMhzomsuUIV+cS
         uX9S1LuOnQBdsUwZxwCUOwhQg1bcTxLP6A/Qg=
Received: by 10.114.205.1 with SMTP id c1mr253473wag.128.1225936686454;
        Wed, 05 Nov 2008 17:58:06 -0800 (PST)
Received: from sumo (fw1.ngigroup.com [210.251.251.34])
        by mx.google.com with ESMTPS id n22sm1582531pof.18.2008.11.05.17.58.04
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 17:58:05 -0800 (PST)
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100208>

Hi,

I have a set of changes on top of an SVN tree I'm tracking with git.
The SVN changes regularly, and I like to keep my changes up-to-date as
well. The branch containing my changes lives on my workstation, but
also in a remote repo so I can also work from my laptop, and others can
look at my work.

Here's my current workflow:

First, I clone the SVN repo on my workstation:

$ git svn clone ssh://remote/svn repo
$ cd repo

I then created a bare repo on a server (git://remote/repo) which is how
I share my changes between my workstation, laptop, and others. In my
repo, I add this remote location as origin. Occasionally I will rebase
my master against SVN and push this to the server:

$ git remote add origin git://remote/repo
$ git remote update
$ git checkout master
$ git svn rebase
$ git push origin master:master

Now, to do my work, I made a branch based on master in which my changes
will live:

$ git branch my_work master
$ git checkout my_work

Then I hack away and have a bunch of commits. I publish this branch on
my server:

$ git checkout my_work
$ git push origin my_work # create branch my_work in git://remote/repo

Eventually, I'd like to rebase this work on top of the latest SVN
revision. First I update my master branch against SVN:

$ git checkout master
$ git svn rebase
$ git push origin master:master

And then I rebase my work on top of that:

$ git checkout my_work
$ git rebase master
# resolve conflicts
$ git rebase --continue

At this point, I'd like to push my_work to the server:

$ git checkout my_work
$ git push origin my_work:my_work
To git://remote/repo
 ! [rejected]        my_work -> my_work (non-fast forward)
error: failed to push some refs to 'git://remote/repo'

What's the proper way to do this?

I've read a few threads in the archives and came across an email by
Junio[1] that shows how using `git push --force` and setting
"receive.denynonfastforwards = false" on the remote repo will allow me
to push these changes. Is this the best way forward? If it is, how do I
(or others) update the my_work branch after a non-fast forward push to
the remote repo?

Your insights greatly appreciated!
Mike


[1] http://marc.info/?l=git&m=119540948816950&w=2
