From: Albert Dvornik <dvornik+git@gmail.com>
Subject: "git svn fetch" on a branch is broken after "git svn reset"
Date: Wed, 5 Jan 2011 01:22:35 -0500
Message-ID: <AANLkTikhaPP0bHEEeFf_2RgK_bdE-i+gaCKopfQjqgHP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 07:22:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaMle-0002qz-6U
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 07:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398Ab1AEGWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 01:22:37 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43476 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab1AEGWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 01:22:36 -0500
Received: by eye27 with SMTP id 27so6608201eye.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 22:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=gYYdIvGFU30XRr+TBNCGVS7QWL2KyyLGg6uyFkKYzK4=;
        b=gBgP9GeOenQxYa3BMTSYyuCBsdr7dJA0kK06qIyka8sxeeBmDkFP/8numEQ6PDaTuf
         zf1Re+QlclmmNFmWZQi3kMQgXt05EFRqlhkPqc/HDWnbjeDIX6qBXjC28crRrQ7quXSK
         Y/YKZHQ69AWJ0rUqaddzih67qwJC7/iAoa9SM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=JPcaqYF/sEtNeMrK1PN0aIyFozsdKG+CbY6aT21oOEVECMb71enbk/j3nkhH+O6V59
         aDlcTm+PxTgEuoIdkeOT80WWmiQZxbi5slL0ydtkJYJEmf5/CtDRZ3ZgwuFUHtS+VpQV
         Qc5LxiHRcZbXX49Rsk2VPQyBIpNtzSIGhZ04Q=
Received: by 10.213.22.66 with SMTP id m2mr18605269ebb.76.1294208555459; Tue,
 04 Jan 2011 22:22:35 -0800 (PST)
Received: by 10.213.113.137 with HTTP; Tue, 4 Jan 2011 22:22:35 -0800 (PST)
X-Google-Sender-Auth: UBlNyvuKSLosQvIsqm8NRBgnE8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164550>

The documentation for git svn claims that this should work:

    git svn reset -r2 -p
    git svn fetch

But when I tried it (using an SVN tree that has recent commits only in
a branch, not the trunk), it didn't work correctly.  "fetch" grabbed
just the latest version from SVN, and not all revs from <revnum> to
the head!  Note that it matters that this is in an SVN branch-- if I
repeat the test using revs in the trunk, everything works as expected.

Specifically, what I did was this:

    git co -b testing refs/remotes/test-branch
    git svn fetch

    git svn reset -r 850
    # does correctly rewind to rev 850, undoing commits in test-branch

    git svn fetch
    # oops, only fetches the *head* revision (rev 856) from SVN!
    # In refs/remotes/test-branch, SVN rev 850 is now followed by 856!

I then tried this again, but between reset and fetching I manually
edited .git/svn/.metadata and moved back the *-maxRev versions to 850;
after doing this, the fetch does the right thing.  I tried examining
the logic in git-svn.perl to figure out why this happens and why it
would be affecting a branch but not the trunk, but I didn't get very
far.

I can reproduce the problem on Linux (git version 1.7.2.1) and Windows
(Git for Windows version 1.7.3.2.msysgit.0.4.ga4f3f or Cygwin git
1.7.2.3).

Thoughts?

--bert
