From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Tue, 16 Sep 2008 13:12:31 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0809161211440.19665@iabervon.org>
References: <16219.81556.qm@web95005.mail.in2.yahoo.com> <20080915063521.GA1533@linode.davidb.org> <7vy71tetvt.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0809151354040.19665@iabervon.org> <20080916041201.GA25033@linode.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, dhruva <dhruva@ymail.com>,
	GIT SCM <git@vger.kernel.org>, Simon Hausmann <simon@lst.de>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 19:13:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfe7T-0006v8-6f
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 19:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbYIPRMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 13:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbYIPRMd
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 13:12:33 -0400
Received: from iabervon.org ([66.92.72.58]:51918 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958AbYIPRMc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 13:12:32 -0400
Received: (qmail 3790 invoked by uid 1000); 16 Sep 2008 17:12:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Sep 2008 17:12:31 -0000
In-Reply-To: <20080916041201.GA25033@linode.davidb.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96019>

On Mon, 15 Sep 2008, David Brown wrote:

> On Mon, Sep 15, 2008 at 03:22:33PM -0400, Daniel Barkalow wrote:
>
> >I think the right solution is for git-p4 to check that p4 thinks the file is
> >the correct file and then simply replace it rather than trying to generate
> >the right result by patching. To be a bit more careful, git-p4 could check
> >that the contents it's replacing actually would exactly match the git
> >contents if the keywords were callapsed (if the p4 setting is to use keywords
> >in this file).
> 
> Part of the problem is that p4 isn't very good at knowing whether
> files have changed or not.  'p4 sync' will update the file _if_ if
> thinks your version is out of date, but it does nothing if someone has
> locally modified the file, hence the need for the 'p4 sync -f'.

I think losing those changes are what we're trying to be careful to avoid. 
What matter for making the submission correctly is that p4 think that your 
version is the version you want to replace, and that the file contents are 
what you want it to end up with.

> A simple way to be paranoid would be something (shell-ish) like:
> 
>   p4 print filename | collapse-keywords | git hash-object --stdin
> 
> and make sure that is the version we think the file should have
> started with.  I think we're really just making sure we didn't miss a
> P4 change that someone else made underneath, and we're about to back
> out.

p4 keeps track of which revision of each file you have synced to in your 
client (so that it can fail to update it sometimes, as you mention above), 
and will complain if the synced-to version isn't the latest when you try 
to submit. That's how it avoids having people accidentally back out each 
other's changes in ordinary operation. As long as we can be sure that the 
client hasn't been synced to a later version than what the parent of the 
commit we're submitting is an import of, which should be done with "p4 
sync <changenumber>", rather than trying to spot check for having 
accidentally acknowledged more p4 history than we've accounted for.

> Even this isn't robust from p4's point of view.  The p4 model is to do
> a 'p4 edit' on the file, and then the later 'p4 submit' will give an
> error if someone else has updated the file.  This would require using
> p4's conflict resolution, and I'm guessing someone using git-p4 would
> rather abort the submit and rebase.

p4 doesn't let you submit files that you don't do a "p4 edit" on (or an 
equivalent like add), so we can't help but do it correctly (assuming that 
we haven't synced to a later version that the parent, of course). If you 
get an error on the submit, you just revert everything you editted, rebase 
the git side, and try again (sync to the new parent of the git commit, 
edit the files, replace with the git content, and submit).

	-Daniel
*This .sig left intentionally blank*
