From: Pete Wyckoff <pw@padd.com>
Subject: git p4: in-place submit
Date: Mon, 30 Apr 2012 18:58:48 -0400
Message-ID: <20120430225848.GA2727@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Michael Horowitz <michael.horowitz@ieee.org>,
	Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 00:58:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOzYW-0007HF-Ik
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 00:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073Ab2D3W6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 18:58:52 -0400
Received: from honk.padd.com ([74.3.171.149]:48314 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756584Ab2D3W6v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 18:58:51 -0400
Received: from arf.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id E5A8725F9;
	Mon, 30 Apr 2012 15:58:50 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5197B313DD; Mon, 30 Apr 2012 18:58:48 -0400 (EDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196626>

Tell me if you think this is a good idea.

Now, submit requires a separate workspace.  You have one for git,
and a separate one used just to push files back into p4.  I'd
like to see if we can do the submit part from the git workspace
directly.

My motivation is:

    - managing both a git and a p4 workspace is extra hassle

    - $work repo is big, and having a separate copy just for
      submits is a waste of space

Setup would go something like:

        # normal clone
        git p4 clone --destination=/home/pw/p4/proj //depot/proj@all

        # build client at same location
        p4 client -i <<-EOF
        Client: pw:proj
        Description: pw proj client
        Root: /home/pw/p4/proj
        View: //depot/proj/... //pw:proj/...
        EOF

        # set config to tell git p4 what to do
        cd /home/pw/p4/proj
        git config git-p4.submit-in-place true   ;# new!
        git config git-p4.client pw:proj
        git config git-p4.useClientSpec true

but no "p4 sync".

Then use git to edit/commit, and eventually "git p4 submit" as
usual.  The new submit-in-place code would:

    - make sure everything is committed

    - find git-p4 latest change number
        - ensuring linear series of commits back to p4/master

    - warn if latest change in //depot/proj/... is greater, but proceed

    - p4 sync -k @change  ;# -k means don't touch my workspace

    - for each commit in p4/master..branch:
        - git checkout commit
        - p4 edit, move, delete, -t text+x, etc to prepare tree
        - p4 submit
        - if any files require resolution, fail
        - chmod +w affected files to undo p4 read-only changes
        - git checkout --hard HEAD to destroy RCS keyword updates

    - if fail
        - git checkout --hard HEAD
        - rebase branch onto last successful commit
    - else
        - git p4 sync (as usual)
        - update branch to p4/master
        - git checkout branch

Is this a worthwhile change?  What details have I overlooked?

                -- Pete
