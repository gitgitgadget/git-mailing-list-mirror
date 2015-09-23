From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: make batch mode optional for git-cat-file
Date: Wed, 23 Sep 2015 00:35:16 +0000
Message-ID: <20150923003516.GA6086@dcvr.yhbt.net>
References: <1442843498-22908-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqqeghraauu.fsf@gitster.mtv.corp.google.com>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D6@mail.accesssoftek.com>
 <20150923001350.GA22266@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 02:35:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeY1x-00022k-Lp
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 02:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759901AbbIWAfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 20:35:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47486 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759812AbbIWAfS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 20:35:18 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5071FE1C;
	Wed, 23 Sep 2015 00:35:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20150923001350.GA22266@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278450>

Eric Wong <normalperson@yhbt.net> wrote:
> Victor Leschuk <vleschuk@accesssoftek.com> wrote:
> > The thing is that git-cat-file keeps growing during work when running
> > in "batch" mode. See the figure attached: it is for cloning a rather
> > small repo (1 hour to clone about ~14000 revisions). However the clone
> > of a large repo (~280000 revisions) took about 2 weeks and
> > git-cat-file has outgrown the parent perl process several times
> > (git-cat-file - ~3-4Gb, perl - 400Mb).

How much of that is anonymous memory, though?
(pmap $PID_OF_GIT_CAT_FILE)

Running the following on the Linux kernel tree I had lying around:

(for i in $(seq 100 200); do git ls-files | sed -e "s/^/HEAD~$i:/"; done)|\
  git cat-file --batch >/dev/null

Reveals about 510M RSS in top, but pmap says less than 20M of that
is anonymous.  So the rest are mmap-ed packfiles; that RSS gets
transparently released back to the kernel under memory pressure.
