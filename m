From: Gary Gibbons <ggibbons@perforce.com>
Subject: Re: git p4: in-place submit
Date: Tue, 1 May 2012 12:27:42 -0700
Message-ID: <5CADA0D2-54A0-4CF7-931B-1FB82B52C1E4@perforce.com>
References: <20120430225848.GA2727@padd.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Michael Horowitz <michael.horowitz@ieee.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue May 01 21:42:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPIxT-0007t5-Vi
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 21:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756419Ab2EATlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 15:41:55 -0400
Received: from mx2.perforce.com ([206.173.243.14]:22644 "EHLO mx2.perforce.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754852Ab2EATly convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 15:41:54 -0400
X-Greylist: delayed 815 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 May 2012 15:41:54 EDT
Received: from imappy.perforce.com ([10.0.50.41])
  by mx2.perforce.com with ESMTP; 01 May 2012 12:27:49 -0700
Received: from [10.20.0.3] (dhcp3.vpnnet.perforce.com [10.20.0.3])
	by imappy.perforce.com (8.14.3/8.14.3) with ESMTP id q41JRkkD061868;
	Tue, 1 May 2012 12:27:47 -0700 (PDT)
	(envelope-from ggibbons@perforce.com)
In-Reply-To: <20120430225848.GA2727@padd.com>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196732>

I agree this is a good idea - overlapping the git and the p4 workspace.
In that git p4 is creating the client ( and not the user)
we can consider creating the P4 Client ->  Options: with "allwrite" which would leave files writable
after all p4 commands. ( that default of "noallwrite" has often produced complaints for Perforce).




(I have been away and then busy on some things.. thank you very much for including me in these emails!!)

Gary




On Apr 30, at Apr 30 3:58 PM, Pete Wyckoff wrote:

> Tell me if you think this is a good idea.
> 
> Now, submit requires a separate workspace.  You have one for git,
> and a separate one used just to push files back into p4.  I'd
> like to see if we can do the submit part from the git workspace
> directly.
> 
> My motivation is:
> 
>    - managing both a git and a p4 workspace is extra hassle
> 
>    - $work repo is big, and having a separate copy just for
>      submits is a waste of space
> 
> Setup would go something like:
> 
>        # normal clone
>        git p4 clone --destination=/home/pw/p4/proj //depot/proj@all
> 
>        # build client at same location
>        p4 client -i <<-EOF
>        Client: pw:proj
>        Description: pw proj client
>        Root: /home/pw/p4/proj
>        View: //depot/proj/... //pw:proj/...
>        EOF
> 
>        # set config to tell git p4 what to do
>        cd /home/pw/p4/proj
>        git config git-p4.submit-in-place true   ;# new!
>        git config git-p4.client pw:proj
>        git config git-p4.useClientSpec true
> 
> but no "p4 sync".
> 
> Then use git to edit/commit, and eventually "git p4 submit" as
> usual.  The new submit-in-place code would:
> 
>    - make sure everything is committed
> 
>    - find git-p4 latest change number
>        - ensuring linear series of commits back to p4/master
> 
>    - warn if latest change in //depot/proj/... is greater, but proceed
> 
>    - p4 sync -k @change  ;# -k means don't touch my workspace
> 
>    - for each commit in p4/master..branch:
>        - git checkout commit
>        - p4 edit, move, delete, -t text+x, etc to prepare tree
>        - p4 submit
>        - if any files require resolution, fail
>        - chmod +w affected files to undo p4 read-only changes
>        - git checkout --hard HEAD to destroy RCS keyword updates
> 
>    - if fail
>        - git checkout --hard HEAD
>        - rebase branch onto last successful commit
>    - else
>        - git p4 sync (as usual)
>        - update branch to p4/master
>        - git checkout branch
> 
> Is this a worthwhile change?  What details have I overlooked?
> 
>                -- Pete
