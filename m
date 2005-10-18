From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon extra paranoia
Date: Tue, 18 Oct 2005 14:19:41 -0700
Message-ID: <7vll0qploy.fsf@assigned-by-dhcp.cox.net>
References: <435560F7.4080006@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 23:21:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERysD-0007P3-CI
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 23:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbVJRVTo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 17:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbVJRVTo
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 17:19:44 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:16263 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751499AbVJRVTn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 17:19:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051018211931.CVSG1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Oct 2005 17:19:31 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <435560F7.4080006@zytor.com> (H. Peter Anvin's message of "Tue,
	18 Oct 2005 13:54:15 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10234>

"H. Peter Anvin" <hpa@zytor.com> writes:

> This patch adds some extra paranoia to the git-daemon filename test.  In 
> particular, it now rejects pathnames containing // or ending with /; it 
> also adds a redundant test for pathname absoluteness (belts and suspenders.)
>
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> Extra paranoia about non-canonical pathnames

I would understand rejecting /../, and perhaps /./, but why
reject // in between or / at the end?

Especially, I think this part in daemon.c::upload():

	if (!path_ok(dir)) {
		logerror("Forbidden directory: %s\n", dir);
		return -1;
	}

	if (chdir(dir) < 0) {
		logerror("Cannot chdir('%s'): %s", dir, strerror(errno));
		return -1;
	}

	chdir(".git");

relies on the fact that you can say "/home/junio/git/" for me to
publish "/home/junio/git/.git/" repository, so I would suspect
that it is necessary to allow "ending with /" at least.
