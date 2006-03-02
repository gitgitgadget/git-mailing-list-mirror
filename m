From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 15:27:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603021521250.22647@g5.osdl.org>
References: <20060302164405.GB7292@trixie.casa.cgf.cx> <20060302165510.GB18929@spearce.org>
 <20060302220930.GE6183@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 00:28:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FExCy-0007Eb-Cy
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 00:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWCBX1j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 18:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbWCBX1j
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 18:27:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751672AbWCBX1i (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 18:27:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k22NRWDZ009155
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Mar 2006 15:27:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k22NRORf014231;
	Thu, 2 Mar 2006 15:27:28 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060302220930.GE6183@steel.home>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17119>



On Thu, 2 Mar 2006, Alex Riesen wrote:

> Shawn Pearce, Thu, Mar 02, 2006 17:55:10 +0100:
> 
> > I've been using the Cygwin Perl with GIT without any problems
> > whatsoever.  Including the open(I, "-|")... exec(@argv) code that
> > doesn't work correctly in ActiveState and started this whole thread.
> 
> Unfortunately...

Here's a stupid first cut at git-fmt-merge-msg in C using the new revlist 
library interface.

It's not actually doing exactly the same thing, because I'm a lazy 
bastard, but some things it does better.

For example, afaik, when merging multiple branches that had partially been 
merged already (ie they had overlapping new stuff), if I read the old perl 
code correctly, it would talk about the new stuff multiple times. This one 
doesn't.

The things it doesn't do:
 - the old one had a limit of 20, the new one has a limit of 10 commits 
   reported
 - the old one was tested, the new one is written by me.
 - the old one honored the "merge.summary" git config option. The new one 
   doesn't.
 - the old one did some formatting of the branch message that I don't 
   follow because I'm not a perl user. The new one just takes the 
   explanatory message for the branch merging as-is.

But hey, this is all part of my cunning plan to make people get involved 
with the new rev-list libification, by giving them things that _almost_ 
work, but might need some tweaking.

		Linus

--- snip snip for "fmt-merge-msg.c" snip snip---
/*
 * fmt-merge-msg.c
 *
 * Magic auto-generation of merge messages.
 *
 * Copyright (C) 2006 Linus Torvalds and his army of programming ferrets
 */
#include "cache.h"
#include "commit.h"
#include "revision.h"

static void show_commit(struct commit *commit)
{
	char buffer[256];

	pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0, buffer, sizeof(buffer), 0);
	printf("   * %s\n", buffer);
}

int main(int argc, char **argv)
{
	struct rev_info revs;
	struct commit *commit;
	unsigned char sha1[20];
	char buffer[256];

	setup_revisions(0, NULL, &revs, NULL);
	if (get_sha1("HEAD", sha1) < 0)
		die("no HEAD revision");
	commit = lookup_commit_reference(sha1);
	if (!commit)
		die("no HEAD revision");

	commit->object.flags |= UNINTERESTING;
	insert_by_date(commit, &revs.commits);
	revs.topo_order = 1;
	revs.limited = 1;

	while (fgets(buffer, sizeof(buffer), stdin)) {
		int max;
		char *marker;

		if (get_sha1_hex(buffer, sha1) < 0)
			continue;
		commit = lookup_commit_reference(sha1);
		if (!commit)
			continue;

		/*
		 * Format after the SHA1:
		 *	<tab>marker<tab><type>'<name>' of <src>'
		 *
		 * where string is "not-for-merge" if
		 * we're not interested in this one,
		 * and empty otherwise.
		 */
		marker = buffer + 40;
		if (*marker++ != '\t')
			continue;
		if (*marker++ != '\t')
			continue;
		printf("Merge %s", marker);

		insert_by_date(commit, &revs.commits);
		prepare_revision_walk(&revs);

		max = 10;
		while ((commit = get_revision(&revs)) != NULL) {
			int n = --max;
			if (n > 0)
				show_commit(commit);
			else if (!n)
				printf("   ...");
		}
	}
}
