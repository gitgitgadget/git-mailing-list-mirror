From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 20:23:46 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708222006110.30176@woody.linux-foundation.org>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site>
 <86mywjcwv7.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708222033040.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 05:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO3It-0005bW-4H
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 05:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbXHWDYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 23:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754873AbXHWDYK
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 23:24:10 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41951 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753575AbXHWDYJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 23:24:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7N3NqAu017920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Aug 2007 20:23:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7N3Nkdv018524;
	Wed, 22 Aug 2007 20:23:47 -0700
In-Reply-To: <alpine.LFD.0.999.0708222033040.16727@xanadu.home>
X-Spam-Status: No, hits=-4.75 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56450>



On Wed, 22 Aug 2007, Nicolas Pitre wrote:
> 
> > We ended up writing our own versions (or merging other peoples code) for 
> > things like appying patches, generating diffs, three-way merging etc, 
> > because not having external dependencies is *so* much more maintainable 
> > and portable that it's not even funny.
> 
> Indeed. And this is the very same reason why Git should _also_ acquire a 
> script interpreter of its own if we want to continue bragging about 
> Git's easy scriptability.

I suspect that most people who want scriptability want it within the 
confines of whatever environment they run in.

For example, I swear by git's scriptability, but I do so not because I 
think it would be a good idea to script _within_ git using some magic 
language, but because I think we made good design decisions that makes it 
easy to integrate git with the kinds of scripts I write every day.

But the kinds of scriping *I* do has nothing to do with the kinds of 
scripting other people necessarily do. I use shell pipelines, and quite 
frankly, any "internal" scripting inside of git is totally uninteresting 
to me, exactly because I'm used to the generic UNIX tools, and I find it 
damn interesting to do things like

	git log -p --since=6.months | cut -c1 | sort | uniq -c

and use that as a really cheesy way to see how many lines have gotten 
added/removed in the patches in the last 6 months.

(Yeah, I get some other characters than just "+/-" too, I don't care, the 
part I care about is:

	 749754 -
	  96945 @
	1030104 +

ie about a hundred thousand hunks, with an average of 7.5 lines deleted 
per hunk, and 10 lines added)

See? Sure, some kind of internal git scripting language could do things 
like this too, but that defeats the point: it's that git is useful 
*within* a UNIX scripting environment, not that it makes its own.

There are enough scripting languages out there. It's wonderful if git can 
be used with then, rather than having to make up another language that you 
have to learn.

And yes, I agree with people who say that LUA is probably the best choice 
if people really want a scripting language, but would I actually use LUA 
for something like the above? No. I think that people who look for 
scriptability usually prefer the kind of scriptability that git already 
has, namely that it fits into their *existing* setup.

> > I'd love for every single shell-script in git core to be written in C, so 
> > that we can drop the dependency on shell *entirely*.
> 
> What about the test suite?

The test suite is indeed special. But I think that's a "build requiement", 
and if we require something like shell for *building*, that's different 
from requiring normal users to have it.

If somebody wants to re-code the test-suite in some other scripting 
engine, that would be fine by me. I'd hope you can automate it, though: 
that is a *lot* of lines of shell.

			Linus
