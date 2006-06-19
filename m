From: Junio C Hamano <junkio@cox.net>
Subject: [Q] what to do when waitpid() returns ECHILD under signal(SIGCHLD, SIG_IGN)?
Date: Mon, 19 Jun 2006 16:49:09 -0700
Message-ID: <7vwtbc7ll6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jun 20 01:49:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsTUl-0006Ee-PQ
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 01:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWFSXtP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 19:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWFSXtO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 19:49:14 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:59783 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932541AbWFSXtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 19:49:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060619234910.SHFO19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Jun 2006 19:49:10 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22147>

Somebody I met last week in Japan reported that the socks client
he uses to cross the firewall to connect to git:// port from his
company environment seems to do signal(SIGCHLD, SIG_IGN) before
spawning git.  When "git clone" is invoked this way, we get a
mysterious failure.

I can reproduce the problem without using funny socks client
like this:

        : gitster; trap '' SIGCHLD
        : gitster; git clone git://git.kernel.org/pub/scm/git/git.git/ foo.git
        error: waitpid failed (No child processes)
        fetch-pack from 'git://git.kernel.org/pub/scm/git/git.git/' failed.
        : gitster; ls foo.git
        ls: foo.git: No such file or directory

We could work this around by having signal(SIGCHLD, SIG_DFL)
upfront in git.c::main(), but I am wondering what the standard
practice for programs that use waitpid() call.  Do they protect
themselves from this in order to reliably obtain child exit
status?  Or do they simply consider it is a user error to run a
program that use waitpid() with SIGCHLD ignored?

http://www.opengroup.org/onlinepubs/009695399/functions/waitpid.html

explicitly says this is an expected behaviour, so barfing upon
ECHILD sounds like a bug on our part.
