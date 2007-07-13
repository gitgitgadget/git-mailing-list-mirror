From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 01:03:16 +0200
Message-ID: <469804B4.1040509@alum.mit.edu>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Jul 14 02:08:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9VBg-0005vq-NV
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 02:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763933AbXGNAIg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 20:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763944AbXGNAIf
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 20:08:35 -0400
Received: from fallback-mx.in-berlin.de ([192.109.42.17]:59760 "EHLO
	hirscho.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763913AbXGNAIf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 20:08:35 -0400
X-Greylist: delayed 3909 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jul 2007 20:08:34 EDT
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by fallback-mx.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l6DN4j8O018782
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 01:04:46 +0200
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.135] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l6DN3GNd015615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 14 Jul 2007 01:03:17 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52424>

Julian Phillips wrote:
> Has anyone managed to succssfully import a Subversion repository that
> was initially imported from CVS using cvs2svn using fast-import?
> 
> It looks like cvs2svn has created a rather big mess.   It has created
> single commits that change files in more than one branch and/or tag. It
> also creates tags using more than one commit.  Now I come to try and
> import the Subversion history into git and I'm having trouble creating a
> sensible stream to feed into fast-import.

I'm the main cvs2svn developer.  Obviously, the tool is intended to
convert to Subversion, but there are ways to tune it to make its output
a little bit more git-friendly.

[Please note that both CVS and SVN allow changes to multiple
tags/branches in a single commit and creating tags using more than one
commit.  That is why cvs2svn converts these repository "features" 1:1 by
default.]

Release 2.0.0-rc1 of cvs2svn (released today) has a
--no-cross-branch-commits option that prevents commits that affect more
than one branch.  For multiproject conversions, the
"ctx.cross_project_commits" option might also be useful.  (The latter is
only available if you start cvs2svn with an --options file.)

The new cvs2svn release is also more intelligent about determining the
most likely source branch from which a tag/branch was created.  This
does not eliminate the creation of tags from more than one revision, but
it should reduce its frequency.  If your repository uses any vendor
branches, you might also consider --exclude'ing them.  In the new
cvs2svn version, this causes vendor revisions to be grafted onto trunk
and thereby eliminates another common cause of multiple-source
branches/tags.

Incidentally, now that cvs2svn 2.0.0 is nearly out, I am thinking about
what it would take to write some other back ends for cvs2svn--turning
it, essentially, into cvs2xxx.  Most of the work that cvs2svn does is
inferring the most plausible history of the repository from CVS's
sketchy, incomplete, idiomatic, and often corrupt data.  This work
should also be useful for a cvs2git or cvs2hg or cvs2baz or ...

I haven't played with a distributed SCM yet, but if somebody would be
interested in working with me on this please let me know.

Michael
