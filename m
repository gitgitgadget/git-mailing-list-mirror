From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: negated list in .gitignore no fun
Date: Thu, 18 Dec 2008 14:38:30 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812181429100.14014@localhost.localdomain>
References: <87hc51tajw.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, joey@kitenet.net
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Thu Dec 18 23:40:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDRXj-0007Ew-4f
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 23:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbYLRWjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 17:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752585AbYLRWjK
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 17:39:10 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46191 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752518AbYLRWjI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 17:39:08 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBIMcVKB029289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Dec 2008 14:38:32 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBIMcUWw016772;
	Thu, 18 Dec 2008 14:38:31 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <87hc51tajw.fsf@jidanni.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.049 required=5 tests=AWL,BAYES_00,SUBJECT_FUZZY_TION
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103504>



On Fri, 19 Dec 2008, jidanni@jidanni.org wrote:
> 
> I had dreams of tracking only a few files in a large tree.
> I thought I would maintain that list as a negated list in .gitignore,
> and then always use "git-add ." to keep git's index reflecting my list.
> 
> However that's just not possible.
> 
> # head -n 5 .gitignore
> *
> !X11/xorg.conf
> !anacrontab
> !apt/apt.conf.d/10jidanni
> !apt/sources.list
> # git-add .
> But git-status only shows anacrontab got added. None of the files in
> the subdirectories get added.

Yeah, the problem is that the '*' matches the subdirectories (like "X11"), 
but the negative matching does not. So the subdirectory gets ignored, and 
as a result, git won't even traverse into it and notice that there's a 
file in there that shouldn't be ignored.

It's actually logical, but not what you want.

So you have several possibilities:

 (a) either create a .gitignore that looks like this:

	*
	!X11
	!X11/xorg.conf
	!anacrontab
	!apt
	!apt/apt.conf.d
	!apt/apt.conf.d/10jidanni
	!apt/sources.list

    which should work around it by telling git that it shouldn't ignore 
    the subdirectories.

 (b) realize that ".gitignore" only matters for files that git doesn't 
     already know about, so if you only want to track a small set of 
     files, what you _should_ do is just do a .gitignore that looks like 
     this:

	*

     and then just force-add the few files you want to track, using 
     something like

	git add -f X11/xorg.conf anacrontab apt/apt.conf.d/10jidanni apt/sources.list

     and now you're done - git won't ignore them, since explciitly you 
     told git to track them.

 (c) Try to teach git to not ignore subdirectories leading up to 
     non-ignored files, and give you the .gitignore semantics you like. I 
     suspect it's not worth it, because the git behaviour is logical once 
     you know about it and understand it.

.. and possibly other things you could do too.

			Linus
