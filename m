From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add core.symlinks to mark filesystems that do not support symbolic links.
Date: Fri, 02 Mar 2007 16:12:01 -0800
Message-ID: <7vr6s7chim.fsf@assigned-by-dhcp.cox.net>
References: <200703022211.30322.johannes.sixt@telecom.at>
	<7vvehjchsp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Mar 03 01:12:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNHrH-00014e-NU
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 01:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992772AbXCCAME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 19:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992783AbXCCAME
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 19:12:04 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:39524 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992772AbXCCAMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 19:12:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303001201.YUQO24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 2 Mar 2007 19:12:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id W0C21W00K1kojtg0000000; Fri, 02 Mar 2007 19:12:03 -0500
In-Reply-To: <7vvehjchsp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 02 Mar 2007 16:05:58 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41260>

Junio C Hamano <junkio@cox.net> writes:

> This code (I am the guilty one before your change above) always
> confused me.  How about doing something like this instead?
>
>     static inline unsigned int ce_mode_from_stat(struct cache_entry *ce,...
>     {
>         /*
>          * A regular file that appears on the filesystem can have
>          * a "wrong" st_mode information.  A few repository config
>          * variables can tell us to trust the mode recorded in the
>          * index more than what we get from the filesystem.
>          */
>         if (ce && S_ISREG(mode)) {
>             extern int trust_executable_bit, has_symlinks;
>
>             if (!has_symlinks && S_ISLNK(ntohl(ce->ce_mode)))
>                 return ce->ce_mode;

Oops, these three lines

>             if (!trust_executable_bit && S_ISREG(ntohl(ce->ce_mode)))
>                 return ce->ce_mode;
>             return create_ce_mode(0666);

should be:

		if (!trust...) {
                	if (S_ISREG(...))
                        	return ce->ce_mode;
			return create_ce_mode(0666);
		}

Still confused I am ;-(.
