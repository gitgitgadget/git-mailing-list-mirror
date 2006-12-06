X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Wed, 6 Dec 2006 14:42:58 -0500
Message-ID: <20061206194258.GD20320@spearce.org>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com> <20061206192800.GC20320@spearce.org> <e5bfff550612061134r3725dcbu2ff2dd6284fcd651@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 19:43:20 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <e5bfff550612061134r3725dcbu2ff2dd6284fcd651@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33512>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs2fd-0003bR-3C for gcvg-git@gmane.org; Wed, 06 Dec
 2006 20:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937433AbWLFTnF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 14:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937563AbWLFTnF
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 14:43:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54375 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937433AbWLFTnC (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 14:43:02 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gs2f8-0005Jh-5j; Wed, 06 Dec 2006 14:42:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 259D020FB7F; Wed,  6 Dec 2006 14:42:59 -0500 (EST)
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

Marco Costalba <mcostalba@gmail.com> wrote:
> On 12/6/06, Shawn Pearce <spearce@spearce.org> wrote:
> >Marco Costalba <mcostalba@gmail.com> wrote:
> >> The time it takes to read, without processing, the whole Linux tree
> >> with this approach it's almost _double_ of the time it takes 'git
> >> rev-list' to write to a file:
> >>
> >> 3) Other suggestions?  ;-)
> >
> >The revision listing machinery is fairly well isolated behind some
> >pretty clean APIs in Git.  Why not link qgit against libgit.a and
> >just do the revision listing in process?
> >
> 
> Where can I found some documentation (yes I know RTFS, but...) or,
> better, an example of using the API to read git-rev-list output?

builtin-rev-list.c.  :-)
 
I think all you may need is:

	#include "revision.h"
	...
	struct rev_info revs;
	init_revisions(&revs, prefix);
	revs.abbrev = 0;
	revs.commit_format = CMIT_FMT_UNSPECIFIED;
	argc = setup_revisions(argc, argv, &revs, NULL);

where argv just a char** of the arguments you were going to hand
to rev-list on the command line.

then get the data back:

	static void show_commit(struct commit *commit)
	{
		const char * hex = sha1_to_hex(commit->object.sha1);
		... copy from hex to your own structures ...
	}

	static void show_object(struct object_array_entry *p)
	{
		/* do nothing */
	}

	prepare_revision_walk(&revs);
	traverse_commit_list(&revs, show_commit, show_object);

-- 
