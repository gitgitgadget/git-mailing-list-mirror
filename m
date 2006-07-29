From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: log and diff family: honor config even from subdirectories
Date: Fri, 28 Jul 2006 18:17:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607281811580.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jul 29 03:18:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6dTn-0007Tk-G7
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 03:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWG2BRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 21:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbWG2BRc
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 21:17:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13988 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751381AbWG2BRb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 21:17:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6T1HQnW013867
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Jul 2006 18:17:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6T1HPZL024656;
	Fri, 28 Jul 2006 18:17:25 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.543 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24406>


Junio,
 I think your patch is fine as a band-aid, but I wonder if we shouldn't 
just move the "setup_git_directory()" call out of init_revisions(), and 
pass it as an argument to init_revision(). Some of the callers have 
already done setup_git_directory() earlier for their own reasons anyway.

And from a quick look it looks like you missed the same bug happening in 
cmd_format_patch(), which calls git_config(git_format_config) before 
having done the setup.

I'd actually _like_ to do the setup unconditionally inside the git wrapper 
(early - to make sure that we don't have this bug), but some things (at 
least "init-db", "clone" and "ls-remote") are obviously not supposed to do 
it, since they work outside of a git directory. So either we need to do it 
in each builtin command separately, or we'd need to add a flag in the 
command descriptor array.

Any clever ideas?

		Linus
