From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git diff: support "-U" and "--unified" options properly
Date: Sun, 14 May 2006 17:58:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605141745410.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
 <7vzmhlsksm.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605131404391.3866@g5.osdl.org>
 <7vpsihsjq6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605131518390.3866@g5.osdl.org>
 <7vbqu0yvda.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 02:59:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfRQP-0007FW-Dl
	for gcvg-git@gmane.org; Mon, 15 May 2006 02:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWEOA6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 20:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWEOA6p
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 20:58:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751383AbWEOA6o (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 20:58:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4F0wetH011872
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 14 May 2006 17:58:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4F0wdaP019568;
	Sun, 14 May 2006 17:58:39 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqu0yvda.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20001>



On Sun, 14 May 2006, Junio C Hamano wrote:
> 
> I am not either after seeing your numbers and trying them
> myself.  I was going to look at it myself over the weekend, but
> I ended up spending most of the time migrating my environment,
> so no progress on that front yet.  Sorry.

I was looking at it, and I just suspect that "grep" is very optimized.

At the same time, the built-in one had many good features, notably that 
you could grep the cached copy and from a specific version. So I think it 
makes sense.

I have this suspicion that the best solution is to just handle the "grep 
against current tree" separately, and even make that something that only 
gets enabled on UNIX - I assume that trying to execve() grep externally 
would suck on windows again.

So I would actually assume that the solution is to simply make 
grep_cache() have a simple

	#ifdef __unix__
		if (!cached) {
			hit = external_grep(opt, paths, cached);
			if (hit >= 0)
				return hit;
		}
	#endif

at the top, so that we'd have the best of both worlds.

The "external_grep()" should look something like this:

	#define MAXARGS 1000

	static int external_grep(struct grep_opt *opt, const char **paths, int cached)
	{
		int nr;
		char *argv[MAXARGS];

		read_cache();
		argv[0] = "grep";
		argv[1] = "-e";
		argv[2] = opt->pattern;	/* whatever */
		argv[3] = "--";
		argc = 4;

		for (nr = 0; nr < active_nr; nr++) {
			struct cache_entry *ce = active_cache[nr];
			if (ce_stage(ce) || !S_ISREG(ntohl(ce->ce_mode)))
				continue;
			if (!pathspec_matches(paths, ce->name))
				continue;
			argv[argc++] = ce->name;
			if (argc < MAXARGS)
				continue;
			hit += exec_grep(argv, argc);
			argc = 4;
		}
		if (argc > 4)
			hit += exec_grep(argv, argc);
		return hit;
	}

and you're all done. Except for testing, and fixing my stupid bugs, which 
I'm too lazy to do.

The whole "exec_grep()" should basically be the same as "spawn_prog()". 
You get the idea.

Anybody?

		Linus
