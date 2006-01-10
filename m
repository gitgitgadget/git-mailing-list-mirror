From: Junio C Hamano <junkio@cox.net>
Subject: Re: undoing changes with git-checkout -f
Date: Mon, 09 Jan 2006 21:57:40 -0800
Message-ID: <7vk6d8aaln.fsf@assigned-by-dhcp.cox.net>
References: <43C2D2C4.2010904@cc.jyu.fi>
	<7vmzi5hy69.fsf@assigned-by-dhcp.cox.net>
	<20060110045533.GO18439@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lamikr <lamikr@cc.jyu.fi>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 06:57:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwCVv-0000KF-Q0
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 06:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWAJF5p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 00:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWAJF5o
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 00:57:44 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:62175 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750727AbWAJF5o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 00:57:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060110055541.PVII26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 Jan 2006 00:55:41 -0500
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20060110045533.GO18439@ca-server1.us.oracle.com> (Joel Becker's
	message of "Mon, 9 Jan 2006 20:55:33 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14407>

Joel Becker <Joel.Becker@oracle.com> writes:

> 	Can we teach the git:// fetch program to use CONNECT over HTTP
> proxies?  rsync can do this, but git:// cannot, so firewalls that block
> 9418 mean we use rsync://
> 	I'm mostly offline this week or I'd take a stab at it.

It's been there for quite some time, although I never liked the
way it interfaces with the outside world.

	$ cat .git/config
        [core]
                repositoryformatversion = 0
                filemode = true
                gitproxy = /usr/local/bin/tn-gw-nav-local
	$ cat /usr/local/bin/tn-gw-nav-local
        #!/bin/sh
	# Use squid running at localhost
        exec tn-gw-nav -H -h 127.0.0.1 -p 3128 "$1" "$2"
	$ grep SSL /etc/squid/squid.conf
        acl SSL_ports 443 563 9418 # https snntp git
        http_access deny CONNECT !SSL_ports
	$ git fetch --tags git://git.kernel.org/pub/scm/git/git.git/

It is a bit inconvenient that "git clone" wrapper cannot be used
on an existing repository, and without an existing repository
you cannot have .git/config. You could have the config file in
your site-wide template area, but admittably it is a bit
awkward.
