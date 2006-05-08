From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 7 May 2006 17:25:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605071718440.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 08 02:25:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FctZT-0000y2-36
	for gcvg-git@gmane.org; Mon, 08 May 2006 02:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWEHAZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 20:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWEHAZp
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 20:25:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51624 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751112AbWEHAZp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 20:25:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k480PgtH022378
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 May 2006 17:25:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k480Pf4Q030002;
	Sun, 7 May 2006 17:25:41 -0700
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19728>



On Sun, 7 May 2006, Linus Torvalds wrote:
>
> The downside is that if you start using config files like this, you 
> literally can't go back to older git versions. They'll refuse to touch 
> such a config file (rather than just ignoring the new entries) and will 
> exit with nasty messages. That might be unacceptable.

Side note: with this syntax, the _users_ will all just basically do

	if (!strncmp(name, "branch.", 7)) {
		branch = name + 7;
		dot = strchr(branch, '.');
		if (!dot)
			return -1;
		*dot++ = 0;
		.. we now have the branchname in "branc",
		    and the rest in "dot" ..

and if your branch names are purely alphabetical and lower-case, you can 
now write

	[branch.origin]
		remote = true
		url = git://git.kernel.org/...
		fetch = master

	[branch.master]
		pull = origin

and it will be parsed _exactly_ the same as

	["origin"]
		remote = true
		url = git://git.kernel.org/...
		fetch = master

	["master"]
		pull = origin

while the [branch.origin] syntax allows old versions of git to happily 
ignore it. So that would be a kind of cheesy work-around: the new 
double-quoted format is only _required_ for any branch-names that have 
special characters in it.

		Linus
