From: Andrew Pimlott <andrew@pimlott.net>
Subject: git cherry not marking commits with equivalent upstream
Date: Thu, 01 Jul 2010 12:38:45 -0700
Message-ID: <1278012954-sup-3724@pimlott.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 01 22:08:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQ3t-0005zN-SW
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab0GAUIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 16:08:32 -0400
Received: from pimlott.net ([72.249.23.100]:1912 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab0GAUIb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:08:31 -0400
X-Greylist: delayed 1785 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2010 16:08:31 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=default; d=pimlott.net;
	h=Received:Content-Type:Subject:From:To:Date:Message-Id:User-Agent:Content-Transfer-Encoding;
	b=kYU1NRcoHstyZggnCI+xrfAEKYuiMXGw3NhCs3JwlpRuKnEgOMd8UNcC3YFEXUKh1Bja55eUYwOozpM9nwurEyUvshLwPJD6pdAuLQ2Fnyn3PI40v9srNwRGzsf1aDokbw016Ka/UGosm8JRnYXuKYikhQ+plddlELNbyQBTD7Q=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.69)
	(envelope-from <andrew@pimlott.net>)
	id 1OUPav-0001L4-5p
	for git@vger.kernel.org; Thu, 01 Jul 2010 12:38:45 -0700
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150067>

The documentation for git-cherry says it marks changes in the current
checkout that have an "equivalent" change in the upstream branch.  It
even says it's useful when feeding patches upstream by email instead of
git, which is what I'm doing (with CVS instead of email).  But it
doesn't seem to work for me.

I'll simulate cloning an upstream repo, creating and commiting a patch,
then sending it via email upstream to have it applied there, then
pulling the upstream commit (the upstream repo is a, mine is b):

    ~% mkdir a && cd a
    ~/a% git init
    Initialized empty Git repository in /home/andrew/a/.git/
    ~/a% touch a
    ~/a% git add a
    ~/a% git commit -m 1
    [master (root-commit) be4fa74] 1
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 a
    ~/a% git clone . ../b && cd ../b
    Initialized empty Git repository in /home/andrew/b/.git/
    ~/b% echo test > a
    ~/b% git add a
    ~/b% git commit -m 2
    [master 551e90a] 2
     1 files changed, 1 insertions(+), 0 deletions(-)
    ~/b% cd ../a
    ~/a% echo test > a
    ~/a% git add a
    ~/a% git commit -m 3
    [master bb13e6c] 3
     1 files changed, 1 insertions(+), 0 deletions(-)
    ~/a% cd ../b
    ~/b% git pull
    remote: Counting objects: 5, done.
    remote: Total 3 (delta 0), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done.
    From /home/andrew/a/.
       be4fa74..bb13e6c  master     -> origin/master
    Merge made by recursive.
    ~/b% cat a
    test

Now, I think I have two equivalent commits in repo b, one of which came
from repo a (upstream).  So I expect git-cherry to show the other commit
with a '-' instead of a '+'.  But no:

    ~/b% git log
    commit 27158bb3e5f7cf80a43eb7364a735f16c43e447c
    Merge: 551e90a bb13e6c
    Author: Andrew Pimlott <andrew@pimlott.net>
    Date:   Thu Jul 1 12:25:21 2010 -0700

        Merge branch 'master' of /home/andrew/a/.

    commit bb13e6cea3a27a4450984b6d1d87f13d807d2d36
    Author: Andrew Pimlott <andrew@pimlott.net>
    Date:   Thu Jul 1 12:25:18 2010 -0700

        3

    commit 551e90ac390a2a27152661b9cbe73845d237e008
    Author: Andrew Pimlott <andrew@pimlott.net>
    Date:   Thu Jul 1 12:25:06 2010 -0700

        2

    commit be4fa741476176181947e96c5242003ffe4f4183
    Author: Andrew Pimlott <andrew@pimlott.net>
    Date:   Thu Jul 1 12:24:42 2010 -0700

        1
    ~/b% git show bb13e6cea3a27a4450984b6d1d87f13d807d2d36 | git patch-id
    58105e2bbccf2799f480bf82bb76467ff0301c52 bb13e6cea3a27a4450984b6d1d87f13d807d2d36
    ~/b% git show 551e90ac390a2a27152661b9cbe73845d237e008 | git patch-id
    58105e2bbccf2799f480bf82bb76467ff0301c52 551e90ac390a2a27152661b9cbe73845d237e008
    ~/b% git cherry
    + 551e90ac390a2a27152661b9cbe73845d237e008

Is my undestanding of how this should work wrong?  Is there any way to get
the result I want?

Andrew
(Please Cc me on replies)
