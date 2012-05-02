From: Gary Gibbons <ggibbons@perforce.com>
Subject: Re: git p4: in-place submit
Date: Wed, 2 May 2012 10:06:19 -0700
Message-ID: <B4B1DDAA-FA1A-4CAB-81BB-ED1D42FAFB43@perforce.com>
References: <20120430225848.GA2727@padd.com> <4F9F7497.5050504@diamand.org> <20120501221847.GA8357@padd.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org,
	Vitor Antunes <vitor.hda@gmail.com>,
	Michael Horowitz <michael.horowitz@ieee.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed May 02 19:06:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPd0W-0005H0-7C
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 19:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370Ab2EBRGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 13:06:23 -0400
Received: from mx2.perforce.com ([206.173.243.14]:17625 "EHLO mx2.perforce.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894Ab2EBRGW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 13:06:22 -0400
Received: from imappy.perforce.com ([10.0.50.41])
  by mx2.perforce.com with ESMTP; 02 May 2012 10:06:21 -0700
Received: from dhcp-176-n101.dhcp.perforce.com (dhcp-176-n101.dhcp.perforce.com [10.0.101.176])
	by imappy.perforce.com (8.14.3/8.14.3) with ESMTP id q42H6Kfh028658;
	Wed, 2 May 2012 10:06:20 -0700 (PDT)
	(envelope-from ggibbons@perforce.com)
In-Reply-To: <20120501221847.GA8357@padd.com>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196843>

Perforce 12.1 introduces a new command 'p4 reconcile'
which 

   reconcile -- Open files for add, delete, and/or edit to reconcile
                 client with workspace changes made outside of Perforce

This is intended to do all the work one would need to do to 
prepare a git managed workspace for submission back into Perforce.

We could use this for in-place-submit when the p4d supports it.





Entire 'p4 help reconcile':

    reconcile -- Open files for add, delete, and/or edit to reconcile
                 client with workspace changes made outside of Perforce

    status    -- synonym for 'reconcile -n' (output uses local paths)
    status -A -- synonym for 'reconcile -ead' (output uses local paths)

    p4 reconcile [-c changelist#] [-e -a -d -f -I -l -n] [file ...]

	'p4 reconcile' finds unopened files in a client's workspace and
	detects the following:

	1. files in depot missing from workspace, but still on have list
	2. files on workspace that are not in depot
	3. files modified in workpace that are not opened for edit

	By default, the files matching each condition above in the path
	are reconciled by opening files for delete (scenario 1), add
	(scenario 2), and/or edit (scenario 3). The -e, -a, and -d flags
	may be used to limit to a subset of these operations. If no file
	arguments are given, reconcile and status default to the current
	working directory.

	The -n flag previews the operation without performing any action.

	If -c changelist# is included, the files are opened in the specified
	pending changelist.

	The -e flag allows the user to reconcile files that have been
	modified outside of Perforce. The reconcile command will open
	these files for edit.

	The -a flag allows the user to reconcile files that are in the
	user's directory that are not under Perforce source control. These
	files are opened for add.

	The -f flag allows the user to add files with filenames that contain
	wildcard characters. Filenames that contain the special characters
	'@', '#', '%' or '*' are reformatted to encode the characters using
	ASCII hexadecimal representation.  After the files are added, you
	must refer to them using the reformatted file name, because Perforce
	does not recognize the local filesystem name.

	The -I flag informs the client that it should not perform any ignore
	checking configured by P4IGNORE.

	The -d flag allows the user to reconcile files that have been
	removed from the user's directory but are still in the depot.
	These files will be opened for delete only if they are still on the
	user's have list.

	The -l flag requests output in local file syntax using relative
	paths, similar to the workspace-centric view provided by 'status'.






On May 1, at May 1 3:18 PM, Pete Wyckoff wrote:

> luke@diamand.org wrote on Tue, 01 May 2012 06:28 +0100:
>> On 30/04/12 23:58, Pete Wyckoff wrote:
>>> Tell me if you think this is a good idea.
>>> 
>>> Now, submit requires a separate workspace.  You have one for git,
>>> and a separate one used just to push files back into p4.  I'd
>>> like to see if we can do the submit part from the git workspace
>>> directly.
>>> 
>>> My motivation is:
>>> 
>>>    - managing both a git and a p4 workspace is extra hassle
>>> 
>>>    - $work repo is big, and having a separate copy just for
>>>      submits is a waste of space
>>> 
>>> Setup would go something like:
>>> 
>>>        # normal clone
>>>        git p4 clone --destination=/home/pw/p4/proj //depot/proj@all
>>> 
>>>        # build client at same location
>>>        p4 client -i<<-EOF
>>>        Client: pw:proj
>>>        Description: pw proj client
>>>        Root: /home/pw/p4/proj
>>>        View: //depot/proj/... //pw:proj/...
>>>        EOF
>>> 
>>>        # set config to tell git p4 what to do
>>>        cd /home/pw/p4/proj
>>>        git config git-p4.submit-in-place true   ;# new!
>>>        git config git-p4.client pw:proj
>>>        git config git-p4.useClientSpec true
>>> 
>>> but no "p4 sync".
>>> 
>>> Then use git to edit/commit, and eventually "git p4 submit" as
>>> usual.  The new submit-in-place code would:
>>> 
>>>    - make sure everything is committed
>>> 
>>>    - find git-p4 latest change number
>>>        - ensuring linear series of commits back to p4/master
>>> 
>>>    - warn if latest change in //depot/proj/... is greater, but proceed
>>> 
>>>    - p4 sync -k @change  ;# -k means don't touch my workspace
>>> 
>>>    - for each commit in p4/master..branch:
>>>        - git checkout commit
>>>        - p4 edit, move, delete, -t text+x, etc to prepare tree
>>>        - p4 submit
>>>        - if any files require resolution, fail
>>>        - chmod +w affected files to undo p4 read-only changes
>>>        - git checkout --hard HEAD to destroy RCS keyword updates
>>> 
>>>    - if fail
>>>        - git checkout --hard HEAD
>>>        - rebase branch onto last successful commit
>>>    - else
>>>        - git p4 sync (as usual)
>>>        - update branch to p4/master
>>>        - git checkout branch
>>> 
>>> Is this a worthwhile change?  What details have I overlooked?
>>> 
>>>                -- Pete
>> 
>> 
>> So the trick here is the "chmod +w" - without that, you won't be
>> able to edit code via git?
> 
> Gary: thanks for suggesting "allwrite".  That feels like the
> obvious better alternative for this use case.  The sprinkled
> "chmod +w" do feel a bit hacky.
> 
>> I think it would be well worth doing - I've always found having two
>> trees a nuisance.
>> 
>> It's still worth keeping the existing scheme. I often find it useful
>> to checkout random bits of our p4 depot without the hassle of
>> setting up a client workspace if I just want a read-only copy.
> 
> Good point.  I'll keep it optional.
> 
> The other possibility is to stick the git commits into a branch
> somewhere, then integrate the branch in the p4 sense.  This feels
> more complex, but makes prettier feature branches in the
> long-term history.
> 
> 		-- Pete
