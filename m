From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: CVS to git: parsing ChangeLog entries?
Date: Sat, 15 Mar 2008 11:38:42 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080315103841.GB14769@ins.uni-bonn.de>
References: <20080312190827.GE3198@ins.uni-bonn.de> <20080313170322.GA3580@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 15 11:39:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaTnt-0007l7-O4
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 11:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbYCOKit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 06:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbYCOKit
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 06:38:49 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:52787 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbYCOKis (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 06:38:48 -0400
Received: from localhost.localdomain (xdsl-87-78-111-54.netcologne.de [87.78.111.54])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 2154840002E0A;
	Sat, 15 Mar 2008 11:38:46 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1JaTmk-0004OZ-4L; Sat, 15 Mar 2008 11:38:42 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080313170322.GA3580@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77317>

* Jeff King wrote on Thu, Mar 13, 2008 at 06:03:22PM CET:
> On Wed, Mar 12, 2008 at 08:08:27PM +0100, Ralf Wildenhues wrote:
> 
> > when migrating a project that uses GNU-style ChangeLogs from CVS
> > to git, is it possible to extract patch author information from
> > the ChangeLog entries rather than from the CVS commit logs?

> I don't think there is a way to do this automatically with
> git-cvsimport. However, once imported, I think you could rewrite history
> using git-filter-branch with a filter that looked at the diff of
> ChangeLog for that commit and rewrote the author. See the documentation
> for git-filter-branch.

Thank you, I just learned a new cool tool!

FWIW, here's what I used successfully on a repository with only one
ChangeLog file (some fiddling to cope with format variations):

git filter-branch -d /dev/shm/t --tree-filter '
  line=`sed -n "s,^[12][90][0-9][0-9]-[0-1][0-9]-[0-3][0-9]  *\([A-Za-z].*\),\1,;
                s,.*  \([A-Za-z].*\),\1,;
                /./{
                        s/(tiny change)//
                        s/ *$//
                        p
                        q
                }" ChangeLog`
  author=`echo "$line" | sed "s, *[<(].*,,"`
  email=`echo "$line" | sed "s,[^,(]*[<(],<,; s/[)>].*/>/"`
  test -n "$author" && test -n "$email" && {
        GIT_AUTHOR_NAME="$author"
        GIT_AUTHOR_EMAIL="$email"
        export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
  }'

> > Related question: when CVS commit logs have varying encoding,
> > say, some latin1 and some UTF-8, is it possible to have uniformly
> > encoded git log entries?
> 
> I don't think git-cvsimport does much with encodings at all. But again,
> you could probably go back through the imported repo with
> git-filter-branch and iconv the commit messages as appropriate.

I'll try that, too.

Thanks!
Ralf
