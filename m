From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] git-daemon support for user-relative paths.
Date: Fri, 18 Nov 2005 13:13:28 -0800
Message-ID: <7viruphd6v.fsf@assigned-by-dhcp.cox.net>
References: <20051117193714.428785C7FA@nox.op5.se>
	<7voe4ird8v.fsf@assigned-by-dhcp.cox.net> <437DAA66.6070301@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 22:13:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdDY6-0000jj-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 22:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161248AbVKRVNb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 16:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbVKRVNb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 16:13:31 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:197 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1161248AbVKRVNb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 16:13:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118211223.YHHC17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 16:12:23 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437DAA66.6070301@op5.se> (Andreas Ericsson's message of "Fri, 18
	Nov 2005 11:18:14 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12263>

Andreas Ericsson <ae@op5.se> writes:

>>>-static int upload(char *dir)
>>>-{
>>>-	/* Try paths in this order */
>>>-	static const char *paths[] = { "%s", "%s/.git", "%s.git", "%s.git/.git", NULL };
>
>...
>
>> Under strict-path, I think not doing any DWIM like this is fine,
>> but otherwise I suspect changing this would break existing
>> remotes/origin file people may have.  In addition enter_repo()
>> as posted does its own DWIM to chdir to ".git" unconditionally
>> as I pointed out...
>
> DWIM? That's an acronym I don't know.

"Do what I mean".  It lets users say:

	git clone git://sample.xz/pub/uemacs uemacs

when the repository on the server side is at any of the
following places:

	/pub/uemacs

	-- a regular naked repository, with subdirectories
           /pub/uemacs/refs and /pub/uemacs/objects/, obviously.

        /pub/uemacs/.git

        -- /pub/uemacs is an ordinary repository with possibly a
           working tree; has /pub/uemacs/.git/refs and friends.

	/pub/uemacs.git

        -- when above two do not exist but this does; a regular
	   naked repository, with subdirectories
	   /pub/uemacs.git/refs and friends.

	/pub/uemacs.git/.git

        -- no /pub/uemacs, and /pub/uemacs.git is an ordinary
           repository with possibly a working tree; has
           /pub/uemacs.git/.git/refs and friends.

which is a nice feature, but under --strict-path we need to be
careful that we apply whitelist correctly while allowing DWIM.
