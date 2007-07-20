From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule fixes for call to git config --get-regexp
Date: Fri, 20 Jul 2007 11:07:51 -0700
Message-ID: <7vsl7jvthk.fsf@assigned-by-dhcp.cox.net>
References: <b6ebd0a50707201023h12ed3c61v31ccb2b356c1ee42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Chris Larson" <clarson@kergoth.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 20:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBwtW-0000qs-KO
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 20:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbXGTSHx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 14:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754216AbXGTSHx
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 14:07:53 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59361 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbXGTSHw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 14:07:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070720180751.NOBJ1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 20 Jul 2007 14:07:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ru7r1X00H1kojtg0000000; Fri, 20 Jul 2007 14:07:51 -0400
In-Reply-To: <b6ebd0a50707201023h12ed3c61v31ccb2b356c1ee42@mail.gmail.com>
	(Chris Larson's message of "Fri, 20 Jul 2007 10:23:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53106>

"Chris Larson" <clarson@kergoth.com> writes:

> Two minor git-submodule fixes:
> * Escape !'s in the git config --get-regexp, so submodule paths can
> contain them.

> --- git-submodule.sh.old	2007-07-20 10:13:22.578125000 -0700
> +++ git-submodule.sh	2007-07-20 10:14:56.281250000 -0700
> @@ -46,7 +46,8 @@ get_repo_base() {
> #
> module_name()
> {
> -       name=$(GIT_CONFIG=.gitmodules git config --get-regexp
> '^submodule\..*\.path$' "$1" |
> +       path=$(echo "$1" | sed -e 's/\!/\\!/g')

My first reaction was if it shouldn't be done for only the '!'
at the very beginning, to defeat "do_not_match" logic, but it
would not hurt if we have extra "\!" in the middle.

Once you introduce that sed to munge the path string, I suspect
you would also want and can afford to quote extended regular
expression metacharacters as well.

> +       name=$(GIT_CONFIG=.gitmodules git config --get-regexp
> '^submodule\..*\.path$' "^$path$" |
>        sed -nre 's/^submodule\.(.+)\.path .+$/\1/p')
>        test -z "$name" &&
>        die "No submodule mapping found in .gitmodules for path '$path'"
>
> -- 
> Chris Larson - clarson at kergoth dot com
> Dedicated Engineer - MontaVista - clarson at mvista dot com
> Core Developer/Architect - TSLib, BitBake, OpenEmbedded, OpenZaurus
