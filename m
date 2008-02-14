From: bdowning@lavos.net (Brian Downing)
Subject: Keeping reflogs on branch deletion
Date: Thu, 14 Feb 2008 08:01:52 -0600
Message-ID: <20080214140152.GT27535@lavos.net>
References: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com> <ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com> <18355.42595.377377.433309@lisa.zopyra.com> <ee77f5c20802131903i45b1629fpcb4a5c6e4f483052@mail.gmail.com> <7vr6fgkxt2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>, Bill Lear <rael@zopyra.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 15:02:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPefX-0004oO-P0
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 15:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbYBNOBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 09:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbYBNOBy
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 09:01:54 -0500
Received: from mxsf07.insightbb.com ([74.128.0.77]:38665 "EHLO
	mxsf07.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbYBNOBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 09:01:54 -0500
X-IronPort-AV: E=Sophos;i="4.25,352,1199682000"; 
   d="scan'208";a="247393072"
Received: from unknown (HELO asav01.insightbb.com) ([172.31.249.124])
  by mxsf07.insightbb.com with ESMTP; 14 Feb 2008 09:01:52 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAGrYs0dKhvkY/2dsb2JhbACBWa0o
X-IronPort-AV: E=Sophos;i="4.25,352,1199682000"; 
   d="scan'208";a="116833185"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav01.insightbb.com with ESMTP; 14 Feb 2008 09:01:52 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 7D130309F21; Thu, 14 Feb 2008 08:01:52 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <7vr6fgkxt2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73877>

On Wed, Feb 13, 2008 at 07:43:21PM -0800, Junio C Hamano wrote:
> People often mistake that the safety of "branch -d" is to not
> lose the commit (i.e. not making it unreachable), but that is
> not the case.  That safety already exists in HEAD reflogs.
> 
> The "branch -d" safety is about not losing the particular point.
> The information we really are trying to protect is "this branch
> points at _that commit_", which is just as important if not
> more.

This actually brings up something I've been intending to ask.

When deleting a branch, is there any reason we can't add a deletion
entry into the reflog and keep the reflog around?  This would seem to be
a lot safer; I know I've been burned by expecting the reflog safety net
to be there, and surprised that it's not when I've deleted a branch.

I expect that the reflog entry would look something like this:

0000000000000000000000000000000000000000 4685dfedd47683a476e75166b5c273c0269b7e54 Brian Downing <bdowning@lavos.net> 1202996833 -0600   branch: Created from ubuntu-dapper
4685dfedd47683a476e75166b5c273c0269b7e54 0000000000000000000000000000000000000000 Brian Downing <bdowning@lavos.net> 1202996863 -0600   branch: Deleted

A couple of problems I've noticed that would have to be fixed for this
to work:

* git log -g (and anything else that can take a reflog) would have to be
  fixed or modified to allow for taking branches that no longer exist:

  :; ls .git/logs/refs/heads/foo
  .git/logs/refs/heads/foo
  :; git log -g foo
  fatal: ambiguous argument 'foo': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions

  My uneducated suspicion is that this may be somewhat hard.

* If the above did work, it would be nice for the deletion entry to
  result in a nice "branch was deleted" entry in log -g output.  Today,
  that entry is missing in its entirety.

-bcd
