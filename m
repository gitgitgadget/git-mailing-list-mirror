From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push to a local directory with no .git in it
Date: Thu, 29 Sep 2005 17:05:33 -0700
Message-ID: <7v7jcze7xu.fsf@assigned-by-dhcp.cox.net>
References: <loom.20050930T011606-58@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 02:06:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL8PC-0002f3-Pp
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 02:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVI3AFg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 20:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVI3AFg
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 20:05:36 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:10941 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932391AbVI3AFf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 20:05:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050930000529.STWZ29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 20:05:29 -0400
To: Richard Curnow <rc@rc0.org.uk>
In-Reply-To: <loom.20050930T011606-58@post.gmane.org> (Richard Curnow's
	message of "Thu, 29 Sep 2005 23:25:59 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9529>

Richard Curnow <rc@rc0.org.uk> writes:

> I get
>
> fatal: /home/richard/homepage/git/mairix.git doesn't appear to be a git directory
>
> presumably because there is no .git in it.

Please don't presume, but dig.

        $ git grep -n 'doesn.t appear to be'
        receive-pack.c:275:		die("%s doesn't appear to be a git directory", dir);

And the lines around there are:

	/* chdir to the directory. If that fails, try appending ".git" */
	if (chdir(dir) < 0) {
		if (chdir(mkpath("%s.git", dir)) < 0)
			die("unable to cd to %s", dir);
	}

	/* If we have a ".git" directory, chdir to it */
	chdir(".git");
	putenv("GIT_DIR=.");

	if (access("objects", X_OK) < 0 || access("refs/heads", X_OK) < 0)
		die("%s doesn't appear to be a git directory", dir);
	write_head_info();

We chdir to mairix.git/, and then try to chdir to .git beneath
it _if_ _exists_; we do not care if the second chdir fails.  So
if you do not have mairix.git/.git, that's OK.  We will stay in
mairix.git/ directory and then set the GIT_DIR there.

If you do not have mairix.git/objects or mairix.git/refs/heads/
then that's when you get that error message.

	$ cd /home/richard/homepage/git/mairix.git
        $ ls -ld objects refs refs/heads

would tell us more.

        
