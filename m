From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/7] gitweb: Trying to improve history view speed
Date: Wed, 6 Sep 2006 08:57:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609060847521.27779@g5.osdl.org>
References: <200609061504.40725.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 17:57:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKzmO-0004GQ-AL
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 17:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWIFP53 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 11:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWIFP53
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 11:57:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751165AbWIFP52 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 11:57:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k86FvPnW006530
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Sep 2006 08:57:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k86FvOmI014020;
	Wed, 6 Sep 2006 08:57:24 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609061504.40725.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.982 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26537>



On Wed, 6 Sep 2006, Jakub Narebski wrote:
>
> Unfortunately, git-rev-list is broken: 'git rev-list <commit> 
> --full-history --parents -- <filename>' shows all merges in addition
> to what 'git rev-list <commit> --parents -- <filename>' and 
> 'git rev-list <commit> --full-history -- <filename>' shows, see
> "git-rev-list --full-history --parents doesn't respect path limit 
> and shows all merges" thread

If you ask for "--full-history" and "--parents", then pretty much by 
_definition_ you need every single merge, because otherwise your history 
wouldn't be fully connected.

Without that, things like "gitk" and "qgit" wouldn't work.

> So probably those patches should be dropped or put in freezer until
> git-rev-list is corrected.

git-rev-list _is_ correct, and if you want something else, you need to 
either use a different set of flags (like _only_ using "--full-history") 
or ask for a totally new flag (like "--most-history").

So the rule is:

 - using "--full-history" + "--parents" means that you want (surprise 
   surprise) full history with parenthood, which means that you get all 
   the connecting merges too. And since you asked for the _full_ history, 
   that means EVERY SINGLE MERGE.

 - using _just_ "--parents" means that you want a connected history with 
   parenthood information, but since you didn't ask for the _full_ 
   history, it will optimize away the merges that didn't change the file, 
   and only follow the changed side. You still get merges, but now you get 
   only those merges where both (all) sides actually mattered.

 - using _just_ "--full-history" (without asking for parenthood) means 
   that you're not asking for a connected history (since you're not asking 
   for parents), and as such, it will only show individual _commits_ that 
   change the file. That does potentially include merges, but again, it 
   only includes merges that actually _changed_ something.

In other words, "--parents" means a lot more than just "show what the 
parents" were. In particular, it means (and always has meant, apart from 
bugs) that we show the _rewritten_ parents after we've done history 
munging, and that we always output enough commits to actually make sense 
of that history from the result.

So what you are asking for is pretty nonsensical. You ask for parenthood 
info, but then you seem to not want to actually connect the dots. So why 
do you ask for parents in the first place? If you don't want to connect 
the commits to their parents, you shouldn't ask for it.

		Linus
