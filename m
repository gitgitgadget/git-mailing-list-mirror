From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues #3
Date: Sun, 20 Aug 2006 15:17:15 -0700
Message-ID: <7vy7tjxdas.fsf@assigned-by-dhcp.cox.net>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
	<1155923876.10054.205.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 00:17:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEvbf-0006uV-8q
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 00:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbWHTWRS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 18:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWHTWRS
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 18:17:18 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:9700 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751648AbWHTWRR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 18:17:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060820221716.OGCK6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 20 Aug 2006 18:17:16 -0400
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1155923876.10054.205.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Fri, 18 Aug 2006 12:57:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25769>

Jon Loeliger <jdl@freescale.com> writes:

> I have another:
>
> git-daemon virtualization so that consistent HTTP and
> native git protocols can appear to use consistent URLs
> even in the face of HTTP configurations aliasing them
> to somewhere else on the filesystem and for multiple
> virtually hosted domain names.

Good point.

Here are a handful others I have about git-daemon:

 * Possibly add --strict-symlink option we discussed a long time
   ago that prevents symbolic links inside the named whitelisted
   directory hierarchies to step outside.

   Nobody actually jumped up-and-down asking for it since we
   initially discussed this, so we may not need it after all.

 * The whitelist directories need to be specified with full path
   even when --base-path is used, which somewhat felt wrong.  I
   do not have strong feeling about this anymore, though.

 * Extend $GIT_DIR/git-daemon-export-ok mechanism and have it
   read from $GIT_DIR/config.

 * Also extend the same in a way similar to the discussion we
   had between Aneesh, me and Jakub to control 'blame' and
   'snapshot' in gitweb.  I.e. allow the site-wide configuration
   to specify which services are enabled by default and which
   services can be overridden per repository, and allow per
   repository configuration to specify what's enabled and what's
   not.

 * Add git-upload-tar as a potential program that can be
   executed from git-daemon.

If we are to do the last three items, my thinking is to do
something like this:

  * The config file can have:

       daemon.upload-pack = yes | no
       daemon.upload-tar = yes | no

      to enable or disable the services individually.

  * $GIT_DIR/git-daemon-export-ok is kept as a backward
    compatibility measure; it means upload-pack is enabled.

If we were to allow git-upload-tar from git-daemon:

 * Fix protocol exchange between git-upload-tar and git-tar-tree
   so that the downloader can name the <tree-ish> symbolically
   like this:

	git tar-tree --remote=git://git.kernel.org/pub/scm/git/git next

   Currently the downloader has to get the value of "next" at
   the remote server out-of-band and give an explicit object
   name.
