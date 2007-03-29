From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH/RFC] introduce GIT_WORK_TREE environment variable
Date: Thu, 29 Mar 2007 10:22:03 +0200
Message-ID: <20070329082202.GA4974@moooo.ath.cx>
References: <20070328141505.GA16600@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 10:22:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWptc-0003Xy-QG
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 10:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbXC2IWJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 04:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbXC2IWJ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 04:22:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:42911 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750735AbXC2IWG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 04:22:06 -0400
Received: (qmail invoked by alias); 29 Mar 2007 08:22:05 -0000
Received: from pD9EBB3EC.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.179.236]
  by mail.gmx.net (mp051) with SMTP; 29 Mar 2007 10:22:05 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+d7fIvsHadSX9PwZw0gGp4breVG7JeIloW864+Ew
	rTWcpXU6YITsf2
Content-Disposition: inline
In-Reply-To: <20070328141505.GA16600@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43412>

Matthias Lederhofer <matled@gmx.net> wrote:
> +	git_config(git_setup_config);

When $GIT_DIR was not set and the repository is found as a .git
directory $GIT_DIR will be the full path to the .git directory when
calling git_config().  git_config() calls git_path() which calls
get_git_dir() which calls getenv("GIT_DIR").
I'm not sure this is defined behaviour at all:
    
    char *foo = getenv("FOO");
    unsetenv("FOO");

Does foo still point to the old content of the FOO environment
variable?  If it does get_git_dir() will always return the full path
to the repository directory.

I can think of two ways to solve this (in case this is a problem):
1. Add a function to environment.c which will cause setup_git_env to
   be called again (either directly or by setting all the pointers to
   NULL again).
2. Use git_config_from_file() instead of git_config().  This will
   probably duplicate code from git_config().
