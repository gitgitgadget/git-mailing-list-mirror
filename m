From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFC 2/2] Make path-limiting be incremental when possible.
Date: Thu, 30 Mar 2006 22:05:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603302153350.27203@g5.osdl.org>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
 <Pine.LNX.4.64.0603301652531.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Mar 31 08:05:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPClL-0000tD-9V
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 08:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWCaGFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 01:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWCaGFc
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 01:05:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751018AbWCaGFb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Mar 2006 01:05:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2V65RCo020787
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Mar 2006 22:05:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2V65REJ009589;
	Thu, 30 Mar 2006 22:05:27 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0603301652531.27203@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18216>



On Thu, 30 Mar 2006, Linus Torvalds wrote:
> 
> This makes git-rev-list able to do path-limiting without having to parse
> all of history before it starts showing the results.
> 
> This makes it things like "git log -- pathname" much more pleasant to use.

Sadly, it seems to react really badly to Junio's new --boundary logic for 
some reason that I haven't quite figured out yet.

That reaction is independent of the actual pathname restriction, and seems 
to be related to how the --boundary logic expected 
pop_most_recent_commit() to work. In particular:

	...
                        if (commit->object.flags & BOUNDARY) {
                                /* this is already uninteresting,
                                 * so there is no point popping its
                                 * parents into the list.
                                 */

that code is magic, and seems to depend on something subtle going on with 
the list, and the incremental thing already popped the parent earlier and 
screwed up whatever magic that the BOUNDARY code depends on.

Junio? I think you did some funky special case with BOUNDARY commits, and 
I broke it for you, can you look at the patch and see if you can see it? 
I'd really like to have the incremental path-limiter, because it really 
makes a huge difference in the usability of "git log pathname".

		Linus
