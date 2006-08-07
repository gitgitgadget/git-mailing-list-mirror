From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Mon, 07 Aug 2006 15:00:36 -0700
Message-ID: <7v4pwo1a0r.fsf@assigned-by-dhcp.cox.net>
References: <200608071626.52655.jnareb@gmail.com>
	<7v3bc82v7l.fsf@assigned-by-dhcp.cox.net> <eb8cdh$s6n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 00:01:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAD9R-0002mX-Ea
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 00:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWHGWAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 18:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWHGWAj
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 18:00:39 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:34756 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751143AbWHGWAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 18:00:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060807220037.HXZJ18826.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Aug 2006 18:00:37 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eb8cdh$s6n$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	07 Aug 2006 23:47:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25044>

Jakub Narebski <jnareb@gmail.com> writes:

> Currently after rename we have the following git_read_* functions
>
> * git_read_info_refs, which reads .git/info/refs directly and relies on it's
> format
> * git_read_hash which translates ref to hash by reading ref file
> (e.g. .git/refs/heads/master) which means that it doesn't support symrefs
> yet; but first, it should be easy to implement without invoking any git
> command, and second, there are usually no symrefs beside HEAD, and I'm not
> sure that git would work with non-HEAD symref.
> * git_read_refs (or rather git_readdir_refs) which reads .git/refs directory
> * git_read_projects (or rather git_readdir_projects) which checks for
> projects checking if HEAD file exists
> * git_read_description which reads .git/description; but in the future
> description might be stored in repository config
>
> What is also important is the fast that git_read_* functions are fast,
> with exception of git_read_info_refs...

Hmph.  readdir-refs is quite bad for future compatibility, so is
read_hash.

If you want _fast_ then make the implementation fast (or leave
room to make it fast later); encoding the fastness assumption in
the name IS WRONG.

For example, sub git_get_hash (not git_read_hash) can stay as
(potentially buggy wrt symrefs) "reading from .git/refs/$thing"
or could even be fixed to read from git-rev-parse (which is the
kosher way).  If it turns out to be a bottleneck, it could be
rewritten using Git.xs.  The same thing for read_refs which I
think should be doing ls-remote on the repository if it wants to
be kosher.

>> The problem is when...
>
> With two scripts attached to the first post in this thread it would be
> simple to apply pre-rename patch, by converting gitweb to pre-rename using
> gitweb-unrename.sh script, then applying patch, then restoring new names
> using gitweb-rename.sh script, and finally comitting changes (or amending
> commit).

That assumes the rename be done now, and nobody introduces new
functions following old naming convention in the meantime.
