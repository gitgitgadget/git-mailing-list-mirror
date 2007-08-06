From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] check_repository_format_version(): run git_default_config() again
Date: Mon, 06 Aug 2007 13:26:53 -0700
Message-ID: <7vsl6wbe9e.fsf@assigned-by-dhcp.cox.net>
References: <2BA49414-54E0-4353-B237-7799B675FAE8@silverinsanity.com>
	<Pine.LNX.4.64.0708061831070.14781@racer.site>
	<7vbqdkcxy3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 22:27:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II9Ap-0003gt-TU
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 22:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166AbXHFU1D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 16:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757526AbXHFU1C
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 16:27:02 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64306 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761193AbXHFU1A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 16:27:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070806202653.JNNY2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 6 Aug 2007 16:26:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YkSt1X00K1kojtg0000000; Mon, 06 Aug 2007 16:26:54 -0400
In-Reply-To: <7vbqdkcxy3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 06 Aug 2007 11:36:20 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55170>

Junio C Hamano <gitster@pobox.com> writes:

> Sorry, I do not understand this patch from the commit log
> description.
>
> In the old days in 1.5.2 before either implementation of
> work-tree stuff, this function never called git_default_config()
> and presumably "git log" worked as expected for Brian.  Why is
> this call needed _here_, not in some of the callers?

Sorry scratch that.  v1.5.2 did not even have core.pager.

I see git_config(git_default_config) is called from
setup_git_directory_gently() in the version that introduced
core.pager.  Curiously enough it does the config twice, once
where no GIT_DIR is set and it sets inside_work_tree, and
another by calling git_config(git_setup_config) -- big thanks
for sorting this mess out.

I however have a mild suspicion that this has to be done much
earlier.

For example, "git -p log" would first call handle_options(),
which calls the setup_pager() logic, and then we call
handle_internal_command() which calls setup_git_directory() that
eventually leads to the callchain of finding the .git directory
and .git/config file to be used.  In that case, when we make the
call to setup_pager() from handle_options(), we haven't even
figured out if there is a configuration file, let alone reading
from it.

We could work this around by having the "we need config -- where
is it" logic in setup_pager(), but if we later have new options
like -p that affects the way how git wrapper itself behaves
based on the configuration, we would need the same "early config
read" logic to support it.
