From: Pete Wyckoff <pw@padd.com>
Subject: Re: Git-P4 Bug With Filename Case Change
Date: Sat, 20 Jul 2013 09:34:18 -0400
Message-ID: <20130720133418.GA18479@padd.com>
References: <897B3B32-0200-4290-AA16-DCAF42923CE0@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Aaron Dwyer <Aaron.Dwyer@imgtec.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 15:34:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0XJ3-0007vw-JX
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 15:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045Ab3GTNeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jul 2013 09:34:23 -0400
Received: from honk.padd.com ([74.3.171.149]:57001 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986Ab3GTNeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 09:34:22 -0400
Received: from arf.padd.com (unknown [50.105.10.190])
	by honk.padd.com (Postfix) with ESMTPSA id 75AAC1E55;
	Sat, 20 Jul 2013 06:34:21 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id AD01623A3E; Sat, 20 Jul 2013 09:34:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <897B3B32-0200-4290-AA16-DCAF42923CE0@imgtec.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230896>

Aaron.Dwyer@imgtec.com wrote on Wed, 17 Jul 2013 22:11 +0000:
> 	We recently have moved our project from Git to Perforce and those of us who prefer Git still are using Git p4 to stay in Git land.  One of the files in our repository was renamed while still in Git, but the rename only consisted of a case change of a character in the name.  Now, on an OS X box with a case insensitive file system (not sure if that matters), one of our guys cloned from perforce with Git p4 and used @all to get all history.  When this operation is finished, the file name is in its original state, not the newer renamed state.

So original file "Foo", new file "foo", to make it concrete.

The "git p4 clone" command generates an internal .git/ history of
the entire p4 repository, before checking out any files in the
workspace.  It does this without touching the filesystem, so I
would expect it never to mangle case, even on OSX.

You should be able to verify this with:

    mkdir test1
    cd test1
    git init
    git p4 clone --bare --destination . //depot/proj@all

    git ls-tree HEAD

and see that "foo" is there, not "Foo".

Then check that the rename really did happen:

    git log --stat --summary --follow -- foo

should show a "rename Foo => foo" in there somewhere.

Does this all work?  I'd like to clear up this confusing part
first.

> 	Perforce doesn't respect that file as being in the repository.  We noticed this after making a local Git commit and upon issuing a Git p4 submit, things go haywire with "file(s) not opened on this client" and nothing getting submitted.

Yep, it's all bad from there-on, I'm sure.

I'm a bit out of my depth on case-insensitive file systems.  Do
check if the cloner in question has core.ignorecase config option
set:

    git config --get core.ignorecase


		-- Pete
