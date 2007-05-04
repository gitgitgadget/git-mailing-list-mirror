From: Junio C Hamano <junkio@cox.net>
Subject: Re: Initial support for cloning submodules
Date: Fri, 04 May 2007 15:52:15 -0700
Message-ID: <7vfy6cqk0w.fsf@assigned-by-dhcp.cox.net>
References: <11782762032207-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven Verdoolaege <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Sat May 05 00:52:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk6dR-0001ad-9u
	for gcvg-git@gmane.org; Sat, 05 May 2007 00:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031714AbXEDWwS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 18:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031720AbXEDWwS
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 18:52:18 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51565 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031714AbXEDWwR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 18:52:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070504225217.NORR22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 4 May 2007 18:52:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vAsF1W00j1kojtg0000000; Fri, 04 May 2007 18:52:16 -0400
In-Reply-To: <11782762032207-git-send-email-skimo@liacs.nl> (Sven
	Verdoolaege's message of "Fri, 4 May 2007 12:56:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46225>

The plumbing part looks very good, although I sensed a slight
slop toward the end (will comment on individual patches later).

I do not like the Porcelain part very much, though.  I do not
think we would want to add anything new to git-clone.  We should
lose as much code from git-clone that is common with git-fetch
as we can first, and add new features to git-fetch, with
possibly passthru options added to git-clone as needed (e.g. a
new --submodule option).

If you --submodule cloned a remote repository when it had two
submodules, and then later the remote adds another submodule,
you would need to have a way to fetch that can discover the
presense of the new submodule and add it for you, and at that
point, having the code that knows much about submodules in clone
would not help you much.

I suspect that a possible interaction between git-fetch and
git-clone would go like this:

 (1) "git-clone [--submodules]" would perform a normal clone,
     having most of its work done by git-remote and git-fetch;

 (2) when "--submodules" is given to "git-clone", it passes it
     through to underlying "git-fetch";

 (3) "git-fetch --submodules", after finishing what it would do
     without "--submodules" option, would inspect the fetched
     tree (or the index derived from it), find the tree entries
     with mode 160000 (i.e. submodule graft points), and _then_
     uses the pathnames of these tree entries to consult the
     config mechanism to see which URL(s) can be used to
     retrieve them, probably only for new submodules.  Your new
     "config --remote" mechanism may be one good way to prime
     the configuration from the originating site.

We could probably extend the upload-pack protocol to send the
same information as you are using submodules.*.url for, instead
of adding a yet another protocol and program pairs you used for
"git config --remote".  Having a generic program and protocol to
dump the whole configuration file is certainly simpler, easier
to debug, and easier to repurpose, it makes me somewhat worried
about security implications (if it is open to http then worrying
about it is not very useful, though).
