From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-commit: add --verbatim to allow unstripped commit
 messages
Date: Thu, 20 Dec 2007 15:55:18 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712201545450.21557@woody.linux-foundation.org>
References: <20071220211835.GA3052@steel.home> <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org> <20071220233324.GB3052@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 00:56:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5VFT-00040V-Lj
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 00:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758861AbXLTXzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 18:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757835AbXLTXzx
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 18:55:53 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38568 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754155AbXLTXzw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2007 18:55:52 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBKNtJ3k027780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Dec 2007 15:55:20 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBKNtI5V019792;
	Thu, 20 Dec 2007 15:55:18 -0800
In-Reply-To: <20071220233324.GB3052@steel.home>
X-Spam-Status: No, hits=-4.413 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_13,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69030>



On Fri, 21 Dec 2007, Alex Riesen wrote:
> 
> Yes, I afraid I need both. I use "git commit -t" almost (submission in
> perforce takes careful planning) every day. I also would like to keep
> the empty leading and trailing lines (perforce default GUI P4Win does
> not show them, but our scripts which check the descriptions will test
> the description text according to template which does have trailing
> empty lines).

Hmm. I think your updated patch was pretty good, although I still think it 
could be improved a bit. In particular, thinking more about it, I think we 
have more than an "on/off" switch - we really have three cases:

 a) strip whitespace _and_ comments
 b) strip unnecessary whitespace only
 c) leave things _totally_ alone

and on top of that we also have the issue of an editor.

So my patch basically said that in the absense of an editor, we'll still 
clean up whitespace, but not comments (ie "no_edit" implies doing (b) 
rather than (b)), while your patch basically results in (c) regardless of 
whether we run an editor or not.

But that still leaves one case: do we ever want to do (b) even *if* we use 
an editor? There's another possible choice: our old behaviour of (a) in 
the presense of an editor is now gone.

Now, that last choice (ie "case (a) without an editor") is not only 
unlikely to be anything people want to do anyway, it's also easy enough to 
do by just using "git stripspace -s" on whatever non-editor thing you feed 
to "git commit", so I don't think we need to worry about that one.

But the "maybe you want to run an editor, and you _do_ want case (b)" 
sounds like a case that is not at all unlikely. I could easily see the 
case where you want to have a template that uses '#', and *despite* that 
you want to (a) allow the user to edit things _and_ (b) clean up 
whitespace too.

So I'd almost suggest you make the "--verbatim" flag a three-way switch, 
to allow "totally verbatim" (leave everything in place) and a "don't touch 
comments" (just fix up whitespace) mode.

Hmm? Does that make sense to you?

			Linus
