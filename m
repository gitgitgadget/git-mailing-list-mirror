From: David Brown <git@davidb.org>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Mon, 15 Sep 2008 21:12:01 -0700
Message-ID: <20080916041201.GA25033@linode.davidb.org>
References: <16219.81556.qm@web95005.mail.in2.yahoo.com> <20080915063521.GA1533@linode.davidb.org> <7vy71tetvt.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0809151354040.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>, dhruva <dhruva@ymail.com>,
	GIT SCM <git@vger.kernel.org>, Simon Hausmann <simon@lst.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 06:13:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfRwI-0003Zr-Jx
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 06:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbYIPEMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 00:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbYIPEMH
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 00:12:07 -0400
Received: from linode.davidb.org ([72.14.176.16]:36540 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbYIPEMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 00:12:05 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KfRuz-0006ej-QX; Mon, 15 Sep 2008 21:12:01 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0809151354040.19665@iabervon.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95968>

On Mon, Sep 15, 2008 at 03:22:33PM -0400, Daniel Barkalow wrote:

>Actually, the problem seems to be that git-p4 tries to create the modified 
>file by applying the git-generated diff to the p4-provided file, and this 
>fails if the context for the git-generated diff contains a keyword, since 
>the p4-provided file has it expanded and git has it collapsed.

It is very likely that I've never made a change within context-lines
of a RCS header.  The files we have with these headers tend to also
comment blocks at the top that don't change after the file is created.

>I think the right solution is for git-p4 to check that p4 thinks the file 
>is the correct file and then simply replace it rather than trying to 
>generate the right result by patching. To be a bit more careful, git-p4 
>could check that the contents it's replacing actually would exactly match 
>the git contents if the keywords were callapsed (if the p4 setting is to 
>use keywords in this file).

Part of the problem is that p4 isn't very good at knowing whether
files have changed or not.  'p4 sync' will update the file _if_ if
thinks your version is out of date, but it does nothing if someone has
locally modified the file, hence the need for the 'p4 sync -f'.

A simple way to be paranoid would be something (shell-ish) like:

   p4 print filename | collapse-keywords | git hash-object --stdin

and make sure that is the version we think the file should have
started with.  I think we're really just making sure we didn't miss a
P4 change that someone else made underneath, and we're about to back
out.

Even this isn't robust from p4's point of view.  The p4 model is to do
a 'p4 edit' on the file, and then the later 'p4 submit' will give an
error if someone else has updated the file.  This would require using
p4's conflict resolution, and I'm guessing someone using git-p4 would
rather abort the submit and rebase.

David
