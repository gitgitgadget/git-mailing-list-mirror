From: Stephen Bash <bash@genarts.com>
Subject: Re: Git SVN non-standard branch/tag/trunk layout
Date: Mon, 13 Dec 2010 09:23:20 -0500 (EST)
Message-ID: <13731475.185564.1292250200171.JavaMail.root@mail.hq.genarts.com>
References: <006c01cb9a44$8407d2f0$8c1778d0$@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Albert Krawczyk <pro-logic@optusnet.com.au>
X-From: git-owner@vger.kernel.org Mon Dec 13 15:23:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS9JO-0005E4-BK
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 15:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757831Ab0LMOX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 09:23:29 -0500
Received: from hq.genarts.com ([173.9.65.1]:61607 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755204Ab0LMOX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 09:23:28 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 3326F1E26314;
	Mon, 13 Dec 2010 09:23:27 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iFv-2LoE6QDY; Mon, 13 Dec 2010 09:23:20 -0500 (EST)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 52C571E2635C;
	Mon, 13 Dec 2010 09:23:20 -0500 (EST)
In-Reply-To: <006c01cb9a44$8407d2f0$8c1778d0$@optusnet.com.au>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163556>

----- Original Message -----
> From: "Albert Krawczyk" <pro-logic@optusnet.com.au>
> To: git@vger.kernel.org
> Sent: Sunday, December 12, 2010 4:35:34 PM
> Subject: Git SVN non-standard branch/tag/trunk layout
> 
> The SVN repo I am now faced with has the trunk/branch/tag folders on
> selected folders in the tree.
> 
> Essentially instead of having one project per repo, there are multiple
> projects in the repo. So the repo looks like this
> 
> ---SVN Root --- Folder(Proj1) ---- Files
> \
> ---- Folder(Proj2) --- Trunk - Files
> |	       \
> |		- Branch - Files
> |		|
> |		- Tag - ...
> |
> |- Proj3 - Files
> |- Proj4 - Trunk
> |-Branch
> | - Tag
> 
> The question is, is there a way I can get Git SVN to understand and
> replicate this layout in a git repo? I don't mind if I have to import
> the entire repo again into git.

When I have to deal with non-standard SVN layouts I do the following:
 1) git svn init tgtDir
 2) Edit the config file (see below)
 3) cd tgtDir
 4) git svn fetch

Basically the svn-remote section of the config file allows you to play games with the translation of SVN paths to Git branches.  Basically each line is of the form svnPath:gitRef.

'fetch' lines are fixed SVN paths that map to a fixed Git ref.  You can have zero or more fetch lines as long as the Git refs are unambiguous (add to the static portion of each ref name to make it unambiguous).  

'branches' and 'tags' lines are each allowed to have a single asterisk (*) on either side of the colon (:) that acts like a wildcard -- the SVN directory name at the position of the asterisk will take the place of the asterisk on the right hand side (which must be the end of the line).  Again, you can have zero or more of each of these as long as the left hand side of each is unambiguous.

So taking a SWAG at your project layout (I'm assuming 'Branch' is the actual branch name, not a directory called 'Branch', similar for 'Tag', and I don't know where proj3 and proj4 are -- are they under Proj2 or back in the SVN root?):

[svn-remote "svn"]
        url = http://server.org/svn

        # Project 1 (note use of the name 'trunk' in Git is a personal choice)
        fetch = proj1:refs/remotes/proj1/trunk

        # Project 2
        branches = proj2/*:refs/remotes/proj2/*

        # Project 3 (note use of the name 'trunk' in Git is a personal choice)
        fetch = proj3:refs/remotes/proj3/trunk

        # Project 4 (note use of the name 'trunk' in Git is a personal choice)
        fetch = proj4/trunk:refs/remotes/proj4/trunk

        # etc...

Project 2 is an interesting one because it looks like the trunk is at the same level as branches/tags.  If that's the case, the 'branches' line above will work (it will treat the trunk like any other branch -- a very Git-like approach).  Also note that those projects that didn't have a 'trunk' directory in SVN I added a 'trunk' on the Git side to keep things consistent -- this is completely optional.

Once you get comfortable with the rules governing the config lines, you can pretty much untangle any SVN layout.

HTH,
Stephen
