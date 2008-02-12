From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH updated] Add "--dirstat" for some directory statistics
Date: Tue, 12 Feb 2008 13:56:13 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802121346560.2920@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802121308360.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:02:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP3D6-0002Yw-GO
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 23:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbYBLWB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 17:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbYBLWB7
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 17:01:59 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58546 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751827AbYBLWB6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 17:01:58 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CLuEEH010924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 13:56:15 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CLuD5f024268;
	Tue, 12 Feb 2008 13:56:13 -0800
In-Reply-To: <alpine.LFD.1.00.0802121308360.2920@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.239 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73701>



On Tue, 12 Feb 2008, Linus Torvalds wrote:
> 
> But even for git itself, you can get some fun statistics. Try out
> 
>         git log --dirstat
> 
> and see the occasional mentions of things like Documentation/, git-gui/,
> gitweb/ and gitk-git/. Or try out something like
> 
>         git diff --dirstat v1.5.0..v1.5.4

Side note: this latter one is actually a good example of two 
different issues.

First off, it's an example of where --cumulative really does make sense, 
since it reports:

	  10.0% Documentation/
	   4.9% contrib/
	   5.7% git-gui/lib/
	  13.9% git-gui/macosx/
	   8.7% git-gui/po/
	  31.4% git-gui/
	   4.6% gitk-git/
	  13.1% t/

ie it makes it clear that almost a third of changes between 1.5.0 and 
1.5.4 was in git-gui/.

But secondly, it's an example of how the whole --dirstat is totally 
buggered in certain circumstances, because the above is simply not *true*: 
yes, a lot of the changes were actually due to git-gui, and all those *.po 
files, but the git-gui/macosx/ count is ridiculously off.

Why? That directory has a binary file, which doesn't have a "line count", 
so --dirstat actually ends up using the byte-count instead there, which 
inflates the macosx numbers a lot (same is true of git-gui/lib/, just to a 
smaller degree).

I don't think that's necessarily a bug, but it's certainly misleading. 
Does it matter? Not to me, because the kernel generally doesn't have those 
kinds of issues (no binary blobs that ever really change), but I did want 
to point out that there's room for perhaps improving things. Maybe we 
could add a byte count in general to the diffstat data structures and 
always just count bytes changed rather than lines changed. Or maybe we 
should consider binary files to have something like "32 bytes per virtual 
line" or something.

So _I_ don't care, but if somebody does, maybe they want to do something 
about it. I thought I'd point it out since I just noticed.

					Linus
