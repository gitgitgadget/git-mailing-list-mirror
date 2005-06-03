From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 3 Jun 2005 14:38:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506031410560.1876@ppc970.osdl.org>
References: <20050603152212.GA4598@jmcmullan.timesys>
 <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org> <1117814982.32257.64.camel@jmcmullan.timesys>
 <Pine.LNX.4.58.0506030929150.1876@ppc970.osdl.org> <1117819137.32257.75.camel@jmcmullan.timesys>
 <Pine.LNX.4.58.0506031035470.1876@ppc970.osdl.org> <1117827011.8970.2.camel@jmcmullan.timesys>
 <Pine.LNX.4.58.0506031320190.1876@ppc970.osdl.org> <1117832172.8970.22.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT Mailling list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:35:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeJoA-0005pZ-9z
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 23:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVFCVhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 17:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVFCVhP
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 17:37:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:19142 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261418AbVFCVgr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 17:36:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j53LagjA032720
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Jun 2005 14:36:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j53Laf76015290;
	Fri, 3 Jun 2005 14:36:42 -0700
To: "McMullan, Jason" <jason.mcmullan@timesys.com>
In-Reply-To: <1117832172.8970.22.camel@jmcmullan.timesys>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 3 Jun 2005, McMullan, Jason wrote:
> 
> 1) I used the stdin/stdout stuff as debugging
> 
> 2) It works with xinetd
> 
> 3) Because I can't figure out how to get /bin/sh to give me two pipes
>    that hook together two processes. What I really want:
> 
> ssh user@remote git server --db /my/git.git <|> git server request HEAD

Ok, so a ssh connection _would_ work per se, and the only real issue is
the pipe itself is one-directional as done by the shell?

> Where 'xxx <|>  yyy' means:
> 
> 	Take process xxx's stdin, hook it to yyy's stdout,
> 	Take process yyy's stdin, hook it to xxx's stdout,
> 	Run till they both die.
> 
> If you know how to do that, I'd be grateful.

Yeah, you're right, you can't do bi-directional piping with shell, and 
you'd need to do it inside your program. It should be easy enough to do 
with something like adding a new flag that says "--exec", and when seeing 
that, doing something like

	if (!strcmp(argv[i], "--exec")) {
		int fd[2][2];
		pid_t pid;

		if (pipe(fd[0]) < 0 || pipe(fd[1]) < 0)
			die("unable to create pipes");
		pid = fork();
		if (pid < 0)
			die("unable to fork exec process");

		if (!pid) {
			dup2(fd[0][0], 0);
			dup2(fd[1][1], 1);
			close_pipes(fd);
			exit(system(argv[i+1]));
		}
		dup2(fd[1][0], 0);
		dup2(fd[0][1], 1);
		close_pipes(fd);
	}

where "close_pipes()" just looks like

	void close_pipes(int *fd)
	{
		int i;
		for (i = 0; i < 3; i++)
			close(fd[i]);
	}

and as usual, the above is totally and utterly untested. And using 
"system()" is cheezy and does an extra unnecessary fork(), so if you want 
to, it could be better done with just a "execve(/bin/sh -c 'string')" 
approach by hand.

Anyway, with _something_ like the above you could do something like

	git-sync --exec "ssh master.kernel.org git-sync" ....

and it would do the obvious thing.

What do you think?

		Linus

