From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 11:47:49 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org>
 <20080623183358.GA28941@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 20:50:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAr7Q-0007mI-T3
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 20:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbYFWSt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 14:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753795AbYFWSt2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 14:49:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44870 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752288AbYFWSt1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 14:49:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NIlosh027998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 11:47:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NIlnPe010714;
	Mon, 23 Jun 2008 11:47:49 -0700
In-Reply-To: <20080623183358.GA28941@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.845 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85904>



On Mon, 23 Jun 2008, Jeff King wrote:
> 
> It's worse than that. We assume by default that the option has no
> argument, so the argument becomes a non-option parameter to the original
> command. Try (with current git-blame, but I think your patch doesn't
> change this):
> 
>   $ git blame -n 1 git.c
>   fatal: bad revision '1'
> 
>   $ git blame --default HEAD git.c
>   fatal: cannot stat path HEAD: No such file or directory
> 
> Oops.

Oops. And then, how would you fix this most easily?

Be honest now.

Hint: it _still_ involves PARSE_OPT_CONTINUE_ON_UNKNOWN. It would fix both 
cases.

IOW, the whole builtin-blame.c option parsing *should* look like this:

	argc = parse_options(argc, argv, options, usage, PARSE_OPT_CONTINUE_ON_UNKNOWN);
	init_revisions(&revs, NULL);
	setup_revisions(argc, argv, &revs, NULL);

and it should just work.

But we should *also* have some way to do things like the code in 
builtin-ls-files.c which have a few options that don't work well with the 
current parse_options(). Yes, you can make all of them work with 
callbacks, but that often ends up requiring moving arguments around. 
There's no way to make a trivial conversion for 90% of the cases, and then 
leaving the 10% that need other changes.

Example: many arguments cause multiple option variables to change. 
parse_options() simply can't handle that well - you can do it with a 
callback, but then you need to make the option variables global or make 
them a structure or something. All of which just makes it nasty to do 
partial conversions for the simple cases.

And I guarantee that just adding PARSE_OPT_{CONTINUE|STOP}_ON_UNKNOWN is 
going to be the smallest patch, and make for the easiest usage case. It 
may not be "pretty", but I can whip up a patch in five minutes.

Or are we going to sit around discussing this for another five months?

			Linus
