From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-svn and submodules
Date: Mon, 15 Oct 2007 08:53:13 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710150848380.6887@woody.linux-foundation.org>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org>
 <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp>
 <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site>
 <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma>
 <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled>
 <Pine.LNX.4.64.0710142359020.25221@racer.site>
 <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Oct 15 18:34:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhSGk-00060z-Jq
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 17:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652AbXJOPyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 11:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756420AbXJOPyB
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 11:54:01 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49102 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756281AbXJOPyA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 11:54:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9FFrE2Q009057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Oct 2007 08:53:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9FFrDER012023;
	Mon, 15 Oct 2007 08:53:14 -0700
In-Reply-To: <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr>
X-Spam-Status: No, hits=-2.378 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_36,TW_SV
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61009>



On Mon, 15 Oct 2007, Benoit SIGOURE wrote:
>
>  - git svn create-ignore (to create one .gitignore per directory from the
> svn:ignore properties.  This has the disadvantage of committing the .gitignore
> during the next dcommit, but when you import a repo with tons of ignores
> (>1000), using git svn show-ignore to build .git/info/exclude is *not* a good
> idea, because things like git-status will end up doing >1000 fnmatch *per
> file* in the repo, which leads to git-status taking more than 4s on my
> Core2Duo 2Ghz 2G RAM)

Ouch.

That sounds largely unavoidable.. *But*.

Maybe we have a bug here. In particular, we generally shouldn't care about 
the exclude/.gitignore file for ay paths that we know about, which means 
that during an import, we really shouldn't ever even care about 
.gitignore, since all the files are files we are expected to know about.

So yes, in general, "git status" is going to be slow in a tree that has 
been built (since things like object files etc will have to be checked 
against the exclude list! (*)), but if it's a clean import with no 
generated files and only files we already know about, that should not be 
the case.

So maybe we have a totally unnecessary performance issue, and do all the 
fnmatch() on every path, whether we know about it or not?

		Linus

(*) It might be that we could also re-order the exclude list so that 
entries that trigger are moved to the head of the list, because it's 
likely that if you have tons of exclude entries, some of them trigger a 
lot more than others (ie "*.o"), and trying those first is likely a good 
idea.
