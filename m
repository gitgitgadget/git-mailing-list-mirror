From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: lstat() call in rev-parse.c
Date: Wed, 26 Apr 2006 08:43:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604260832240.3701@g5.osdl.org>
References: <17483.27938.890830.375324@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0604230906370.3701@g5.osdl.org> <E1FYlwn-0005mf-CL@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 17:45:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYmBI-0000C5-48
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 17:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWDZPnx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 11:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWDZPnx
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 11:43:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65254 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964826AbWDZPnw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 11:43:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3QFhmtH029424
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 26 Apr 2006 08:43:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3QFhl6s030626;
	Wed, 26 Apr 2006 08:43:48 -0700
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FYlwn-0005mf-CL@moooo.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19209>



On Wed, 26 Apr 2006, Matthias Lederhofer wrote:

> > So the rule is: if you don't give that "--", then we have to be able 
> > to confirm that the filenames are really files. Not a misspelled 
> > revision name, or a revision name that was correctly spelled, but for 
> > the wrong project, because you were in the wrong subdirectory ;)
> 
> Shouldn't git rev-parse try to stat the file (additionally?) in the 
> current directory instead of the top git directory? git (diff|log|..) 
> seem to fail everytime in a subdirectory without --.

Good point. However, the reason for that is that it actually _does_ stat 
the file in the current directory, but it has done the 

	revs->prefix = setup_git_directory();

in the init path (and it does need to do that, since that's what figures 
out where the .git directory is, so that we can parse the revisions 
correctly).

And that "setup_git_directory()" will chdir() to the root of the project.

So the "lstat()" should probably take "revs->prefix" into account, the 
way get_pathspec() does. Ie we should probably use

	char *name = argv[i];
	if (rev->prefix)
		name = prefix_filename(rev->prefix, strlen(rev->prefix), name);
	if (lstat(name, ..) < 0)
		die(...)

instead of just a plain lstat().

Probably worth doing as a small helper funtion of its own (and get rid of 
the current "die_badfile()" - and do all of that inside the helper 
function).

Somebody?

		Linus
