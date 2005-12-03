From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull aborts in 50% of cases
Date: Fri, 02 Dec 2005 18:26:39 -0800
Message-ID: <7vu0dq29wg.fsf@assigned-by-dhcp.cox.net>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru>
	<43909963.60901@zytor.com>
	<20051202211250.GA11384@mipter.zuzino.mipt.ru>
	<4390B64E.20601@zytor.com>
	<Pine.LNX.4.63.0512030316520.19086@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sat Dec 03 03:26:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiN6q-0004v8-Cp
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 03:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVLCC0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 21:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVLCC0l
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 21:26:41 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:8178 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751164AbVLCC0l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 21:26:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051203022514.QCYL17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Dec 2005 21:25:14 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512030316520.19086@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 3 Dec 2005 03:18:01 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13141>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> 0.99.9k is clearly bad.
>
> Huh? It could be slower, and it could therefore hit the maximum client 
> count faster, but it should not be bad.
>
> All changes to pull were done in a manner so as to be backward compatible. 
> In both ways.

I do not think the fetch-pack common computation changes is
involved in this problem at all.

What is suspect is the repository validity check code,
specifically (quoting from diff between 0.99.9j and 0.99.9k
daemon.c::path_ok() function):

+               /* The validation is done on the paths after enter_repo
+                * canonicalization, so whitelist should be written in
+                * terms of real pathnames (i.e. after ~user is expanded
+                * and symlinks resolved).
+                */

I suspect (but have not heard back from HPA to confirm) that
kernel.org runs git-daemon with /pub/scm as the whitelist, but
there is a symbolic link (or bind mount?) involved, and the real
path checked based on getcwd() return value is somewhere else.
