From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 0/3] git-rev-list libification effort: the next stage
Date: Tue, 28 Feb 2006 11:19:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Feb 28 20:20:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEAOO-0007uL-Ga
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 20:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWB1TUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 14:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWB1TUH
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 14:20:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932447AbWB1TUF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 14:20:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1SJJlDZ007042
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Feb 2006 11:19:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1SJJg6G025643;
	Tue, 28 Feb 2006 11:19:45 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16946>


Ok, the following three patches that I'll send out are still pretty rough, 
but they actually get us to the first real point of this whole exercise: 
writing one of the trivial git helper scripts in C.

In particular, at the end, we have "git log" being implemented as this 
trivial C function:

	#define LOGSIZE (65536)

	static int cmd_log(int argc, char **argv, char **envp)
	{
		struct rev_info rev;
		struct commit *commit;
		char *buf = xmalloc(LOGSIZE);

		argc = setup_revisions(argc, argv, &rev, "HEAD");
		prepare_revision_walk(&rev);
		setup_pager();
		while ((commit = get_revision(&rev)) != NULL) {
			pretty_print_commit(CMIT_FMT_DEFAULT, commit, ~0, buf, LOGSIZE, 18);
			printf("%s\n", buf);
		}
		free(buf);
		return 0;
	}

which is actually a pretty good example of what I wanted to do.  It's
not perfect yet (it doesn't parse the "--pretty=xxx" option yet, nor the
"--since" and "--until" dates, for example), but I think this is all
going in the right direction. 

			Linus
