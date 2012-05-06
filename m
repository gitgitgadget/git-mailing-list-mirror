From: Mitar <mmitar@gmail.com>
Subject: post-fetch, tweak-fetch hook
Date: Sun, 6 May 2012 22:52:53 +0200
Message-ID: <CAKLmikNaqVRb=pGUhbvVQTX2tYWT0HSS2R6Ezmico3X0rMgvYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 22:53:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR8Rv-0003Hi-Gk
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 22:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab2EFUwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 16:52:55 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43231 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754465Ab2EFUwy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 16:52:54 -0400
Received: by vcqp1 with SMTP id p1so2972533vcq.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 13:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=b7QIZplkSpylfUu2ac4rW0vj9N8hhw5bx1/3d/1NFpg=;
        b=JozHok/fgInQUKCeQLCuDIr8DQ54ZavDAtQt8akG9mf5R3g5BMhoMzaXrA34pld2DZ
         BwMIa5I00bOEApVSXmWPf+p/LfO7Q3UO4ELD0VONZqBdAQL3IqZwRpiGPmoCXwTwdjEO
         3toBt13L8nXpxLSuGeRAsRMCf5CTSVkemk0b/1gy7cS9wxjkeu4tM9k/M5QVxVI7Z6Xn
         3Yvumi9sf9CUdCnpYgNEARMC6wJy3eu0dh0ZWMwthyuitsbhHsk7wOvICVAqoVomOjdH
         GXrW7wr1qmTCuisVfRA30gGjg1DDcBHf8fl7WZbSJ4HG0dDmq64buuMOIVbfHO4ZJMAQ
         ovUQ==
Received: by 10.52.22.79 with SMTP id b15mr2683881vdf.10.1336337573936; Sun,
 06 May 2012 13:52:53 -0700 (PDT)
Received: by 10.52.28.13 with HTTP; Sun, 6 May 2012 13:52:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197211>

Hi!

I am writing a plugin which allows syncing of GitHub repositories with
local Trac mirrored ones.

http://trac-hacks.org/wiki/GitHubSyncPlugin

In this configuration, I have a git clone --mirror local repository of
GitHub repository and on each push to GitHub repository, GitHub does a
POST notification to my Trac installation, where my Trac plugin
receives that notification and calls fetch on local mirror.

The problem is that I also have to notify Trac of all new revisions
(their hashes) the fetch retrieved. If this would be push,
post-receive hook would be a place to get this information. But as I
read, there is no post-fetch hook. The argument is that it is not
needed. That locally run fetch can also run needed post-processing.
But I have three counter arguments to this, based on my current
experience:

Code reuse: having same interface for both post-fetch and post-receive
hooks would mean easier post-processing. They are similar and I can
imagine that there exist many scenarios where same script would be
used for both hooks. Together with this is also maintainability: you
could make a myfetch command doing custom post-processing, but
interfacing this with a known API through hooks, all in one directory,
would make things much easier to maintain. Not that one script is in
hooks (post-receive) and the other is invoked in some other manner.

I am a git newbie, but after few hours or reading and searching I have
not found a simple way to get a list of revisions retrieved by a
fetch, so that I could call my custom post-processing. If this is
really so simple that there is no need for post-fetch hook, I am all
ears. FETCH_HEAD file contains only last revisions for each branch,
not a range (old-new, like post-receive). Furthermore, even if there
have been no new revisions retrieved, FETCH_HEAD file stays at its old
state (not for example deleting it), so some additional logic would be
needed. Parsing the output of git fetch also does not look like
something easily parsed by a program.

Even if there is a way to reconstruct data passed to post-receive (to
be given to post-fetch), I am concerned about race-condition of this.
Because in post-receive this data is tightly connected to the push
being done. Even if there is another push in process at the same time,
git would take care post-receive is called with exactly those
revisions. In case of reconstructing those revisions, it could happen,
that two fetches overlap in such a manner that in my custom myfetch
script I reconstruct same revisions for both fetches (for example,
read same version of FETCH_HEAD file which has been updated twice by
fetch, but I would get only one version), while there were of course
different.

I have found some work from Joey Hess on tweak-fetch hook and I would
really welcome such addition. Maybe my problems stem only from me
being a git novice, but post-fetch (tweak-fetch) hook would really
really make things simple and intuitive also for such users.

So I would kindly ask for some advice on how to get in a safe manner
data similar to what is provided to post-receive.


Mitar
