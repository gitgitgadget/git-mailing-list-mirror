From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Summary of core GIT while you are away.
Date: Wed, 25 May 2005 18:53:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505251845270.2307@ppc970.osdl.org>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org> <20050526004411.GA12360@vrfy.org>
 <7vzmuig561.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 03:50:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db7VS-0002QJ-9r
	for gcvg-git@gmane.org; Thu, 26 May 2005 03:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVEZBvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 21:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVEZBvm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 21:51:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:20162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261623AbVEZBvk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 21:51:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4Q1pSjA013733
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 25 May 2005 18:51:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4Q1pR3P028759;
	Wed, 25 May 2005 18:51:27 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmuig561.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 25 May 2005, Junio C Hamano wrote:
> 
> I haven't done anything about this yet.  I was kind of waiting
> for the blob retention API for "struct object" derivatives to
> come to the conclusion.

I decided on it, and it's a hacky (but reasonable) decision.

"parse_commit()" always retains the buffer for the commit. It's very
commit-specific, since (a) that's the main data structure that you'd
actually want to retain and (b) of all the core objects (ignoring tags)  
commits tend to be the smallest and fewest, so this fixed policy has the
least impact memory-usage-wise.

If you want to free it, you can do

	free(commit->buffer);
	commit->buffer = NULL;

and you should be all good (but the only user I thought migh want to is 
"fsck", and that one doesn't need to, since it never calls 
"parse_commit()" at all - it calls "parse_commit_buffer()" which does 
_not_ do this, since the caller already knows the buffer and can choose to 
do it if it wants to.

Oh, thinking about that actually brings up a bug: mixing parse_commit()
and parse_commit_buffer() is unsafe, since the state of the buffer is
unclear. Normally that's ok, _except_ when we use just "parse_object()" 
(like we do in "lookup_commit_reference()"), when we really don't know. 
Hmm.

		Linus
