From: Alex Vandiver <alex@chmrr.net>
Subject: Race condition in git push --mirror can cause silent ref rewinding
Date: Wed, 02 Jul 2014 17:10:13 -0400
Message-ID: <53B47535.3020101@chmrr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 23:43:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2SJ8-0004KS-FO
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 23:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbaGBVnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 17:43:10 -0400
Received: from chmrr.net ([209.67.253.66]:54976 "EHLO utwig.chmrr.net"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbaGBVnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 17:43:09 -0400
X-Greylist: delayed 1952 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jul 2014 17:43:08 EDT
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=[10.1.10.102])
	by utwig.chmrr.net with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <alex@chmrr.net>)
	id 1X2RnO-0003p8-P2; Wed, 02 Jul 2014 17:10:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Enigmail-Version: 1.6
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.76 (build at 25-May-2011 17:04:25)
X-Date: 2014-07-02 17:10:27
X-Connected-IP: 75.147.59.54:49097
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252843>

Heya,

We recently ran into a particularly troubling race condition, discovered
in git 2.0.0.  The setup for it is as follows:

The repository is a bare repository, which developers push to via ssh;
it mirrors its changes out onto github.  In its config:

    [remote "github"]
        url = git@github.com:bestpractical/rt.git
        fetch = +refs/*:refs/*
        mirror = yes

It has a post-receive hook which does:

    sudo -u git -H /usr/bin/git push github


We recently saw a situation where a push of a new branch caused a
simultaneous update of a different branch (by a different user) to be
rewound.  From the reflog of the created branch (4.2/html-gumbo-loading):

    0000000000000000000000000000000000000000
1aefd600fcbb5ded14376f77d77a14758668fb39 Wallace Reis
<wreis@bestpractical.com> 1404326443 -0400       push

And the updated branch (4.2-trunk), which was rewound:

    44dc8ad0e4603e3f674b7c00deacc122ca52707a
1e743b6225d502ad1a265929fb873f4c0bf4f8a5 Kevin Falcone
<falcone@bestpractical.com> 1404326446 -0400    push
    1e743b6225d502ad1a265929fb873f4c0bf4f8a5
44dc8ad0e4603e3f674b7c00deacc122ca52707a git <git@bestpractical.com>
1404326446 -0400        update by push

It is my belief that this comes because the "--mirror" argument causes
the local refs to be treated as tracking refs -- and thus updates all of
them during the push.  I believe the race condition is thus:

  1. User A starts a push --mirror; git records the values of the refs

  2. User B updates a ref, commit mail goes out, etc

  3. User A's push completes, updates "tracking" branch to value at (1).


Needless to say, silently losing commits which appeared for all purposes
to be pushed successfully (neither User A nor User B sees anything out
of the ordinary) is extremely troubling.

 - Alex
