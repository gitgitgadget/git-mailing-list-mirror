From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 09:25:10 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 23 18:27:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAotC-0004Ra-L6
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 18:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbYFWQ0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 12:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754541AbYFWQ0b
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 12:26:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45318 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753725AbYFWQ0b (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 12:26:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NGPBEw013728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 09:25:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NGPADV005163;
	Mon, 23 Jun 2008 09:25:10 -0700
In-Reply-To: <alpine.DEB.1.00.0806231312130.6440@racer>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.845 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85882>



On Mon, 23 Jun 2008, Johannes Schindelin wrote:
> 
> Thinking about the recursive approach again, I came up with this POC:

"recursive" is pointless.

The problem with the current "parse_options()" is not that it's recursive 
(although that has been claimed multiple times!.

The problem with parse_options() is that it's currently impossible to 
write something that handles _partial_ cases.

Let me explain.

Look at cmd_apply() in builtin-apply.c. Notice how it currently absolutely 
CANNOT sanely be turned into using "parse_options()", not because it needs 
any "recursive" handling, but simply because it wants to do *incremental* 
handling.

It should be perfectly possible to change that argument loop from

	for (i = 1; i < argc; i++) {
		const char *arg = argv[i];
		if (strcmp(arg, "-")) {
			.. handle <stdin> ..
			continue;
		}
		...

to doing something like this:

	for (;;) {
		const char *arg;
		argc = parse_options(argc, argv,
			options, usage, PARSE_OPT_STOP_AT_UNKNOWN);
		if (!argc)
			break;
		arg = argv[1];
		argv++;
		argc--;
		if (strcmp(arg, "-")) {
			.. handle <stdin> ..
			continue;
		}
		...	

or whatever. See?

Could you handle that with callbacks? Of course. "You can solve any 
problem in computer science with an added level of indirection". But would 
it be simpler to convert existing users? Hell no. 

Could you handle the "recursive" use of parse_options() in builtin-blame.c 
by teaching it about recursion? Yes. But again, it's just _simpler_ to 
just teach parse_options() to parse the things it knows about, and leave 
the other things in place.

			Linus
