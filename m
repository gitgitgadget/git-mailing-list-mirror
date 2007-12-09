From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How-to combine several separate git repos?
Date: Sun, 9 Dec 2007 11:43:36 +0100
Message-ID: <20071209104336.GA3163@steel.home>
References: <475B8C59.7050707@saville.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 11:44:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Jdh-0006lL-Sa
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 11:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbXLIKnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 05:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbXLIKnj
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 05:43:39 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:48686 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbXLIKni (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 05:43:38 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+fjq4=
Received: from tigra.home (Fc86b.f.strato-dslnet.de [195.4.200.107])
	by post.webmailer.de (fruni mo61) (RZmta 14.5)
	with ESMTP id o02179jB94dhjq ; Sun, 9 Dec 2007 11:43:37 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id DC9E2277AE;
	Sun,  9 Dec 2007 11:43:36 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 60D4D56D22; Sun,  9 Dec 2007 11:43:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <475B8C59.7050707@saville.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67618>

Wink Saville, Sun, Dec 09, 2007 07:34:01 +0100:
> I've got several git repositories of different projects and was thinking
> I should combine into one repository, but my googling around didn't turn up
> any simple way of doing it.
>
> Any advice?

Should they both be visible in one working tree as directories?
Should these be independent branches?

For instance, you can fetch one into another:

    $ cd project1
    $ git config remote.project2.url /path/to/project2
    $ git config remote.project2.fetch 'refs/heads/*:refs/project2/*'
    $ git fetch project

That will give you two (or more) branches, containing history of the
project1 and project2. They are still completely independent, just use
the same object store.

You can merge them, for example:

    $ cd project1
    $ git merge project2/master

Assuming that there is no filename collisions you'll get a repo with
two merged histories (and two starting points). In case you get
conflicts you can either resolve them by editing or just move the
problematic project in subdirectory:

    $ git merge -s ours --no-commit project2/master
    Automatic merge went well; stopped before committing as requested

here will be no conflicts. Merge strategy "ours" (-s ours) does not
take anything from the branch to be merged. The coolest strategy ever.
"--no-commit" stops the operation just before committing.

    $ git read-tree --prefix=project2/ project2/master
    $ git checkout-index -a
    $ git commit

That's it. The histories are merged and the files of project2 are
placed in the directory "project2". It is a wee bit harder to browse
the history of the files: you have to give both new and "old" name of
the project2's files, as if you renamed them (that's what read-tree
with --prefix did).
