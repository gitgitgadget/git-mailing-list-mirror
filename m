From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Don't leak file descriptors from unavailable pack files.
Date: Fri, 02 Feb 2007 00:37:54 -0800
Message-ID: <7vbqkdhs4d.fsf@assigned-by-dhcp.cox.net>
References: <20070202080003.GA21094@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 09:38:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCtvj-0003dr-9f
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 09:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933316AbXBBIh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 03:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933322AbXBBIh4
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 03:37:56 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:48911 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933316AbXBBIh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 03:37:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202083756.XUZI1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 2 Feb 2007 03:37:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JYdv1W0081kojtg0000000; Fri, 02 Feb 2007 03:37:55 -0500
In-Reply-To: <20070202080003.GA21094@spearce.org> (Shawn O. Pearce's message
	of "Fri, 2 Feb 2007 03:00:03 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38476>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If open_packed_git failed it may have been because the packfile
> actually exists and is readable, but some sort of verification
> did not pass.  In this case open_packed_git left pack_fd filled
> in, as the file descriptor is valid.

>  			if (p->pack_fd == -1 && open_packed_git(p)) {
> +				if (p->pack_fd != -1) {
> +					close(p->pack_fd);
> +					p->pack_fd = -1;
> +				}

I agree leaking fd is not nice, but I wonder if that should be
dealt with by the caller.

Originally it did not matter as open_packed_git() died, but
shouldn't it be closing the fd and marking p->pack_fd with -1, as
you made it return instead of die?
