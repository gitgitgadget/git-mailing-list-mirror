From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] C implementation of the 'git' program, take two.
Date: Tue, 15 Nov 2005 18:02:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511151751520.13959@g5.osdl.org>
References: <20051115233125.3153B5BF76@nox.op5.se> <Pine.LNX.4.64.0511151603510.11232@g5.osdl.org>
 <437A8067.9050308@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 03:03:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcCdG-0004a5-U6
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 03:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbVKPCCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 21:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVKPCCj
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 21:02:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32723 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965166AbVKPCCi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 21:02:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAG22YnO014409
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 15 Nov 2005 18:02:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAG22XLA000413;
	Tue, 15 Nov 2005 18:02:34 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437A8067.9050308@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11989>



On Wed, 16 Nov 2005, Andreas Ericsson wrote:
> 
> It was your idea to begin with, actually, in the thread on how to do proper
> path validation in the git-daemon. :)

But that was because the important part wasn't to get an absolute path, 
but because the important part was to get the _canonical_ path. 

That was for security. 

Besides, I don't think we ever switched back. We just did a chdir() + a 
getcwd().

> > Why don't you just do
> > 
> > 	if (exec_path[0] != '/') {
> > 		.. prepend "cwd/" to exec_path ..
> > 
> 
> You mean
> 	setenv("PATH", concat3(cwd, exec_path, old_path), 1);

No.

I mean exactly what I said.

I mean testing whether the exec_path[] is already absolute, and not 
touching it at all if it is.

It's really as simple as something like

	const char *absolute_path(const char *input)
	{
		int a, b;
		char *buf;
		char cwd[PATH_MAX];

		if (*input == '/')
			return input;

		if (!getcwd(cwd, sizeof(cwd))
			return NULL;

		/* Do some trivial cleanup */
		while (!strncmp(input, "./", 2)) {
			input += 2;
			while (*input == '/')
				input++;
		}

		a = strlen(cwd);
		b = strlen(input);
		buf = malloc(a + b + 2);
		if (!buf)
			return NULL;

		memcpy(buf, cwd, a);
		buf[a] = '/';
		memcpy(buf + a + 1, input, b);
		buf[a + 1 + b] = 0;
		return buf;
	}

and there it is.

The magic rule being:
 - if the path is already absolute, it's _good_. Don't play games with it.
 - just append the dang thing with cwd. Don't play games (the above does 
   trivial simplification, which is unnecessary, but it's so simple that 
   hey, who cares? And it makes one common case a bit prettier)

Then, you just prepend it to the PATH, with a : in between (and if the 
pathname has a ":" in it, tough, there's nothing we can do about it).

		Linus
