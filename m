From: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: [PATCH] Added support for dropping privileges to git-daemon.
Date: Sat, 19 Aug 2006 10:25:33 -0700
Message-ID: <20060819172533.GB64962@gaz.sfgoth.com>
References: <1155990772.6591@hammerfest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 19 19:17:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEURT-0002ZZ-NG
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 19:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422723AbWHSRQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 13:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422724AbWHSRQ7
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 13:16:59 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:34243 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1422723AbWHSRQ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 13:16:58 -0400
Received: from gaz.sfgoth.com (localhost.sfgoth.com [127.0.0.1])
	by gaz.sfgoth.com (8.12.10/8.12.10) with ESMTP id k7JHPatV065765;
	Sat, 19 Aug 2006 10:25:36 -0700 (PDT)
	(envelope-from mitch@gaz.sfgoth.com)
Received: (from mitch@localhost)
	by gaz.sfgoth.com (8.12.10/8.12.6/Submit) id k7JHPXTE065764;
	Sat, 19 Aug 2006 10:25:33 -0700 (PDT)
	(envelope-from mitch)
To: Tilman Sauerbeck <tilman@code-monkey.de>
Content-Disposition: inline
In-Reply-To: <1155990772.6591@hammerfest>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Sat, 19 Aug 2006 10:25:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25730>

Tilman Sauerbeck wrote:
> +	if (user && group)
> +		drop_privileges();

It seems "if (user)" would be sufficient here.

> +	if (!user ^ !group)
> +		die("either set both user and group or none of them");

For simplicities sake I'd actually suggest allowing group==NULL.  So
change this test to be

	if (group && !user)
		die("--group supplied without --user");

Then in drop_privileges() do something like:

	struct passwd *p;
	gid_t gid;

	p = getpwnam(user);
	if (!p)
		die("user not found - %s", user);
	if (group == NULL)
		gid = p->pw_gid;
	else {
		struct group *g = getgrnam(group);
		if (!g)
			die("group not found - %s", group);
		gid = g->gr_gid;
	}

Since usually you want to use the same gid that is normally associated
with that pid, this just makes things a little easier on the user

-Mitch
