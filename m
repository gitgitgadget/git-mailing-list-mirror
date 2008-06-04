From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] http clone does not checkout working tree
Date: Wed, 4 Jun 2008 12:30:57 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806041222300.3473@woody.linux-foundation.org>
References: <20080604183858.GA7095@sigill.intra.peff.net> <alpine.LFD.1.10.0806041145170.3473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 04 21:32:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3yjA-0006Kk-Nf
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 21:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760959AbYFDTbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 15:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758326AbYFDTbp
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 15:31:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50942 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756762AbYFDTbo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 15:31:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m54JUwWK016158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jun 2008 12:30:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m54JUvqT005236;
	Wed, 4 Jun 2008 12:30:58 -0700
In-Reply-To: <alpine.LFD.1.10.0806041145170.3473@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.887 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83814>



On Wed, 4 Jun 2008, Linus Torvalds wrote:
> 
> and quite frankly, it's rather possible that we should get rid of the 
> "void *buffer" and "unsigned long size" in the tree *entirely*, because 
> the above would likely be better written as
..

Side note: the actual historical context here is that "parse_tree()" used 
to create that "tree_entry_list" of all the entries in the tree. So we 
used to do things like

	struct tree_entry_list *list;

	if (parse_tree(tree))
		die(..)
	list = tree->entries;
	while (list) {
		...

so "parse_tree()" was something much bigger (and generated much slower and 
less dense data structures).

These days, parse_tree() basically just reads the object buffer and 
length. So it boils down to just caching the result of "read_sha1_file()", 
but we have all those legacy uses that come from the old historical thing. 
And to some degree it may have made sense to drop the buffer, but keep the 
actual list of entries in that old model.

See commit 2d9c58c69d1bab601e67b036d0546e85abcee7eb.

		Linus
