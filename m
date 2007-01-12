From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Change to the repository's root directory if needed.
Date: Fri, 12 Jan 2007 13:18:04 -0800
Message-ID: <7vtzywq703.fsf@assigned-by-dhcp.cox.net>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
	<200701121501.24642.andyparkins@gmail.com>
	<20070112191044.GA5113@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 22:18:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Tmw-0001rj-0m
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 22:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbXALVSI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 16:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbXALVSH
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 16:18:07 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39477 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030459AbXALVSG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 16:18:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112211805.TRWH20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 16:18:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AMHD1W00h1kojtg0000000; Fri, 12 Jan 2007 16:17:14 -0500
To: koreth@midwinter.com
In-Reply-To: <20070112191044.GA5113@midwinter.com> (koreth@midwinter.com's
	message of "Fri, 12 Jan 2007 11:10:44 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36713>

koreth@midwinter.com writes:

> Signed-off-by: Steven Grimm <koreth@midwinter.com>
> ---
>
> Or try this instead. It seems to work in my limited testing, but it's
> possible this breaks something somewhere.

Porcelains that define SUBDIRECTORY_OK but do not do cdup are
very valid, and they should not be cd'ed up automatically.
They set SUBDIRECTORY_OK for three different reasons:

 (1) some of them always cdup themselves.  git-fetch is the sole
     example I can think of and I do not think it even needs to.

 (2) some of them stay in the subdirectory, and rely on the
     plumbing level to limit the scope of operation with the
     current directory.  The most notable example used to be
     "git-diff" but that is now a built-in.

     Also they take filename that could be relative to the
     current directory.  git-commit is an example.

 (3) some of them are complex mixture of (1) and (2) -- most
     notable is git-checkout

 (4) some of them do not care.  git-verify-tag is an example.

Your patch assumes everybody is either (1) or (4).  I would not
be surprised if you see breakage everywhere.  For example, I
think you just broke "git-tag -F <file>".  Also I think you
surprised users of git-clean (which I do not use personally);
it would start removing stuff outside of the current directory.
