From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix incorrect diff of a link -> file change if core.filemode = false.
Date: Fri, 16 Feb 2007 16:15:52 -0800
Message-ID: <7vodntzljb.fsf@assigned-by-dhcp.cox.net>
References: <200702170009.02500.johannes.sixt@telecom.at>
	<7vejop1ysu.fsf@assigned-by-dhcp.cox.net>
	<200702170030.04014.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Feb 17 01:16:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIDFM-0007ZN-Ql
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 01:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946343AbXBQAPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 19:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946342AbXBQAPz
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 19:15:55 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:58509 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946340AbXBQAPy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 19:15:54 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217001552.HLXF21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 19:15:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QQFt1W00A1kojtg0000000; Fri, 16 Feb 2007 19:15:53 -0500
In-Reply-To: <200702170030.04014.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sat, 17 Feb 2007 00:30:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39962>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> The fix is that the cached mode must only be allowed to override the file's 
> actual mode (which includes the type information) if _both_ the working tree 
> entry and the cached entry are regular files.

Ah, I misunderstood.

I suspect you do not want to get random, unreliable executable
bit from lstat(), even when previously index recorded non
regular file for a path that is now a regular file.  In
builtin-update-index.c, add_file_to_cache() has this:

	ce->ce_mode = create_ce_mode(st.st_mode);
	if (!trust_executable_bit) {
		/* If there is an existing entry, pick the mode bits
		 * from it, otherwise assume unexecutable.
		 */
		int pos = cache_name_pos(path, namelen);
		if (0 <= pos)
			ce->ce_mode = active_cache[pos]->ce_mode;
		else if (S_ISREG(st.st_mode))
			ce->ce_mode = create_ce_mode(S_IFREG | 0666);
	}

and I agree what it _tries_ to do, although I think the above
also makes the regular file being added to a symlink and needs
to be fixed.  You helped us find another bug.

	# In a new, empty directory...
	$ git init
        $ ln -s foo A
        $ git add A
        $ git ls-files -s
	120000 19102815663d23f8b75a47e7a01965dcdc96468c 0	A
        $ git config core.filemode false
        $ rm A ; echo foo >A
        $ git add A
        $ git ls-files -s
	120000 19102815663d23f8b75a47e7a01965dcdc96468c 0	A

The fix is probably like this:

	ce->ce_mode = create_ce_mode(st.st_mode);
	if (!trust_executable_bit && S_ISREG(st.st_mode)) {
		/* If there is an existing entry, pick the mode bits
		 * from it, otherwise assume unexecutable.
		 */
		int pos = cache_name_pos(path, namelen);
		if (0 <= pos &&
                    S_ISREG(ntohl(active_cache[pos]->ce_mode)))
			ce->ce_mode = active_cache[pos]->ce_mode;
		else 
			ce->ce_mode = create_ce_mode(S_IFREG | 0666);
	}

Back to the part of the code you patched, I think the fix should
be something like this instead:

	mode = create_ce_mode(st.st_mode);
	if (!trust_executable_bit && S_ISREG(st.st_mode)) {
		/* If there is an existing entry, pick the mode bits
		 * from it, otherwise assume unexecutable.
		 */
                if (S_ISREG(ntohl(ce->ce_mode)))
			mode = ce->ce_mode;
                else
                	mode = create_ce_mode(S_IFREG | 0666);
                
        }
