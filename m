From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Tue, 15 Jan 2008 19:09:51 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com> <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com> <alpine.LNX.1.00.0801151728120.13593@iabervon.org>
 <7vhched3kw.fsf@gitster.siamese.dyndns.org> <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org> <7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 04:10:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEyfo-0006qG-Nc
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 04:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215AbYAPDKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 22:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757102AbYAPDKL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 22:10:11 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42659 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756539AbYAPDKK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 22:10:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G39qAK006771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 19:09:53 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G39ppT017390;
	Tue, 15 Jan 2008 19:09:51 -0800
In-Reply-To: <7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.218 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70608>



On Tue, 15 Jan 2008, Junio C Hamano wrote:
>
> If a non-standard prefix is used by --no-prefix, --src-prefix,
> or --dst-prefix options, the resulting diff becomes something
> git-apply would not grok.  In such a case, we should not trigger
> the more strict check git-apply does for patches in "diff --git"
> format.

I think this is wrong.

If we do any git-specific stuff, we need to have that "--git" thing there. 
That is *not* just limited to the prefix, but to all the other things git 
diffs can do: renames, mode changes, etc.

> Metainformation (e.g. "index", "similarity", etc.) lines will
> safely be ignored by patch and git-apply (even when the latter
> parses a non-git diff output), so this patch does not bother
> stripping them away.

It's not necessarily safe to ignore some of them, like the rename info. If 
you see a rename patch and don't understand it as a rename, it's 
pointless.

So I would argue that you need something stronger to say "don't do a git 
diff", and that should also disallow rename detection at a minimum. Quite 
frankly, any program that is so stupid as to not accept current git 
patches (ie TortoiseSVN), then we damn well shouldn't just disable the 
most trivial part of it. We should make sure that we do not enable *any* 
of the rather important extensions: even if ToirtoiseSVN would ignore 
them, if ignoring them means that it mis-understands the diff, it 
shouldn't be allowed at all.

So maybe a --standard-diff option that removes the "--git" part, but also 
removes everything else.

And add a "--index-header" to enable the (totally *idiotic*) "Index:" 
prefix that is such a total waste of time that it's not even funny (ie it 
cannot do renames, which makes it entirely pointless). 

We do not want to make it particularly easy for people to create 
mind-bogglingly stupid diff output. 

		Linus
