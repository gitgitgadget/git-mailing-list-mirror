From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFH] send-pack: fix pipeline.
Date: Fri, 29 Dec 2006 13:20:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612291307520.4473@woody.osdl.org>
References: <7v1wmjoumq.fsf@assigned-by-dhcp.cox.net> <7vzm96latb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Fri Dec 29 22:21:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0PAI-0006Wy-4z
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 22:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWL2VVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 16:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWL2VVT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 16:21:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55969 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965164AbWL2VVS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 16:21:18 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBTLKg2J001534
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Dec 2006 13:20:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBTLKfEF004826;
	Fri, 29 Dec 2006 13:20:42 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzm96latb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-1.175 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.165 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35609>



On Fri, 29 Dec 2006, Junio C Hamano wrote:
>
> I really need a sanity checking on this one.  I think I got the
> botched pipeline fixed with the patch I am replying to, but I do
> not understand the waitpid() business.  Care to enlighten me?

I think it was a beginning of a half-hearted attempt to check the exit 
status of the rev-list in case something went wrong.

Which we simply don't do, so if git-rev-list ends up with some problem 
(due to a corrupt git repo or something), it will just send a partial 
pack.

For some reason I thought we had fixed that by just generating the object 
list internally, but I guess we don't do that. That's just stupid. We 
should make "send-pack.c" use

	list-heads | git pack-objects --revs

	list-heads | git-rev-list --stdin | git-pack-objects

because as it is now, I think send-pack is more fragile than it needs to 
be.

Or maybe I'm just confused.

		Linus
