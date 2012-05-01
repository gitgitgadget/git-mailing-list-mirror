From: Pete Wyckoff <pw@padd.com>
Subject: Re: git p4: in-place submit
Date: Tue, 1 May 2012 18:18:47 -0400
Message-ID: <20120501221847.GA8357@padd.com>
References: <20120430225848.GA2727@padd.com>
 <4F9F7497.5050504@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>,
	Michael Horowitz <michael.horowitz@ieee.org>
To: Luke Diamand <luke@diamand.org>,
	Gary Gibbons <ggibbons@perforce.com>
X-From: git-owner@vger.kernel.org Wed May 02 00:19:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPLPS-0003JP-Tc
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 00:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347Ab2EAWSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 18:18:53 -0400
Received: from honk.padd.com ([74.3.171.149]:48605 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755231Ab2EAWSv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 18:18:51 -0400
Received: from arf.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id 9D7B63125;
	Tue,  1 May 2012 15:18:50 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9559E313DD; Tue,  1 May 2012 18:18:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4F9F7497.5050504@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196763>

luke@diamand.org wrote on Tue, 01 May 2012 06:28 +0100:
> On 30/04/12 23:58, Pete Wyckoff wrote:
> >Tell me if you think this is a good idea.
> >
> >Now, submit requires a separate workspace.  You have one for git,
> >and a separate one used just to push files back into p4.  I'd
> >like to see if we can do the submit part from the git workspace
> >directly.
> >
> >My motivation is:
> >
> >     - managing both a git and a p4 workspace is extra hassle
> >
> >     - $work repo is big, and having a separate copy just for
> >       submits is a waste of space
> >
> >Setup would go something like:
> >
> >         # normal clone
> >         git p4 clone --destination=/home/pw/p4/proj //depot/proj@all
> >
> >         # build client at same location
> >         p4 client -i<<-EOF
> >         Client: pw:proj
> >         Description: pw proj client
> >         Root: /home/pw/p4/proj
> >         View: //depot/proj/... //pw:proj/...
> >         EOF
> >
> >         # set config to tell git p4 what to do
> >         cd /home/pw/p4/proj
> >         git config git-p4.submit-in-place true   ;# new!
> >         git config git-p4.client pw:proj
> >         git config git-p4.useClientSpec true
> >
> >but no "p4 sync".
> >
> >Then use git to edit/commit, and eventually "git p4 submit" as
> >usual.  The new submit-in-place code would:
> >
> >     - make sure everything is committed
> >
> >     - find git-p4 latest change number
> >         - ensuring linear series of commits back to p4/master
> >
> >     - warn if latest change in //depot/proj/... is greater, but proceed
> >
> >     - p4 sync -k @change  ;# -k means don't touch my workspace
> >
> >     - for each commit in p4/master..branch:
> >         - git checkout commit
> >         - p4 edit, move, delete, -t text+x, etc to prepare tree
> >         - p4 submit
> >         - if any files require resolution, fail
> >         - chmod +w affected files to undo p4 read-only changes
> >         - git checkout --hard HEAD to destroy RCS keyword updates
> >
> >     - if fail
> >         - git checkout --hard HEAD
> >         - rebase branch onto last successful commit
> >     - else
> >         - git p4 sync (as usual)
> >         - update branch to p4/master
> >         - git checkout branch
> >
> >Is this a worthwhile change?  What details have I overlooked?
> >
> >                 -- Pete
> 
> 
> So the trick here is the "chmod +w" - without that, you won't be
> able to edit code via git?

Gary: thanks for suggesting "allwrite".  That feels like the
obvious better alternative for this use case.  The sprinkled
"chmod +w" do feel a bit hacky.

> I think it would be well worth doing - I've always found having two
> trees a nuisance.
> 
> It's still worth keeping the existing scheme. I often find it useful
> to checkout random bits of our p4 depot without the hassle of
> setting up a client workspace if I just want a read-only copy.

Good point.  I'll keep it optional.

The other possibility is to stick the git commits into a branch
somewhere, then integrate the branch in the p4 sense.  This feels
more complex, but makes prettier feature branches in the
long-term history.

		-- Pete
