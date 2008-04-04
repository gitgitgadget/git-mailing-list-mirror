From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and	broken
 branch imports
Date: Fri, 04 Apr 2008 11:52:57 +0200
Message-ID: <47F5FA79.8010604@alum.mit.edu>
References: <1207100091.10532.64.camel@gandalf.cobite.com>	 <0C7AA499-56AD-4D20-AED0-9E7DDD0C77DF@zib.de> <1207230582.17329.39.camel@gandalf.cobite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: David Mansfield <david@cobite.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 11:54:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhicd-00035Q-0N
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 11:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758266AbYDDJxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 05:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbYDDJxX
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 05:53:23 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:46911 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758097AbYDDJxW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 05:53:22 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.142] (may be forged))
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m349qvnS026356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 4 Apr 2008 11:52:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080227 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
In-Reply-To: <1207230582.17329.39.camel@gandalf.cobite.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78798>

David Mansfield wrote:
> The main issue with git-cvsimport stems from an unfixable problem.
> cvsps's design goal is to show commits in chronological order.  Based
> solely on this data, it's impossible to always reconstruct a branch
> point (or a tag) since a person could have committed files after someone
> else's commit, but not done an update then tagged.  

Just to be more explicit, I think you are talking about a situation like
this:

1. Add file1:1.1 and file2:1.1 to repository.
2. User1 modifies file1 and commits file1:1.2.
   ...some non-negligible amount of time passes...
3. User2 modifies file2 and commits file2:1.2.
4. User2, without updating file1 to revision 1.2, adds a tag.

This results in a tag that refers to file1:1.1 and file2:1.2, even
though those two revisions never appeared in the repository at the same
time.

> So some files are from before the 'other' user's commit, and some files
> after.  What can you do?  

You can do the only thing that is consistent with the CVS
history--create the tag not from a single source revision but from
multiple revisions.  Unfortunately, git cannot handle this directly, but
there is a workaround using a "fixup branch" [1].

cvs2svn/cvs2git [2] creates a "fixup branch", copies file1:1.1 and
file2:1.2 onto that branch, then creates the tag from the fixup branch.
 This ensures that checking the tag out of git gives the same file
contents as checking the tag out of CVS.  I think that git-cvsimport
gets this wrong (!?!)

It is your framing of the problem that is leading to the impossibility.
 CVS's design does *not* require that a tag or branch is created in a
single commit, nor that it is created from a single source revision.
Trying to impose these artificial constraints means that the resulting
git repository is inconsistent with the CVS repository in quite common
circumstances.

> It's not per se a flaw in cvsps, it always wanted to show commits in
> chronological order, but it is a severe limitation in using cvsps to
> generate changesets for git.

cvs2git always creates commits in chronological order too, but its
output is by design always consistent with the CVS record.

> By engineering a direct tool (such as parsecvs, I presume) these
> obstacles can be overcome by constructing some commits that were never
> made by the actual users of the cvs repo in order to get it right.
> 
> I'm not sure exactly how this is done, because I've never looked at
> parsecvs.

cvs2git's design is documented quite extensively, if you are interested
[3].  Parsecvs, AFAIK, uses a similar approach.

Michael

[1] http://www.kernel.org/pub/software/scm/git/docs/git-fast-import.html
[2] http://cvs2svn.tigris.org/cvs2git.html
[3] http://cvs2svn.tigris.org/svn/cvs2svn/trunk/doc/design-notes.txt
