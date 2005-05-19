From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 11:55:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505191148470.2322@ppc970.osdl.org>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> <7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
 <7vy8abys5a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 20:56:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYq8v-0002Ds-Qs
	for gcvg-git@gmane.org; Thu, 19 May 2005 20:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVESSyC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 14:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVESSyB
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 14:54:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:18311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261221AbVESSx6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 14:53:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4JIrlU3006431
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 May 2005 11:53:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4JIrkkf003312;
	Thu, 19 May 2005 11:53:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy8abys5a.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 19 May 2005, Junio C Hamano wrote:
> 
> Here is another "doubt" point.  I am almost embarrassed to ask
> this, but what's the right way to express the following?  I
> could not figure out how to silence const warnings from gcc
> without using the cast there, which defeats the whole point of
> const warnings:

You're not doing this right.

Like it or not, "execvp()" does not take a pointer to "const char *".

It takes a pointer to a constant array of _non-const_ "char *".

Which is not what you have. You have a non-const array of "const char *", 
and as a result, you need the cast.

In other words, you really need

	char *exec_arg[9];

or, if you can indeed set the array to be const, you can make it be

	char *const exec_arg[9] = {
		pgm, name,
		temp[0].name, temp[0].hex, temp[0].mode,
		temp[1].name, temp[1].hex, temp[1].mode,
	}

which would work, except to avoid warnings it obviously requires that none
of the strings themselves are "const" (which isn't true).

IOW, you're screwed. "execvp()" really should take an argument of type
"const char * const *", but it doesn't for historical reasons.

		Linus
