From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 12:05:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site>
 <86mywjcwv7.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 21:06:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INvXE-0008TF-2A
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 21:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764588AbXHVTFn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 15:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761735AbXHVTFl
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 15:05:41 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53856 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759628AbXHVTFj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 15:05:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7MJ5W40029072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Aug 2007 12:05:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7MJ5Q0H031883;
	Wed, 22 Aug 2007 12:05:27 -0700
In-Reply-To: <86mywjcwv7.fsf@lola.quinscape.zz>
X-Spam-Status: No, hits=-4.747 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56407>



On Wed, 22 Aug 2007, David Kastrup wrote:
> >
> > What is wrong with going from shell to C?
> 
> That it is not a script language where cause and effect of tying
> simple functionality together is apparent, and easy to do.

Why does it have to be a scripting language?

"git reset" is a command, not a scripting language. We can still script 
git as much as we want, but the fewer dependencies we have on anything 
external, the better off we are.

We ended up writing our own versions (or merging other peoples code) for 
things like appying patches, generating diffs, three-way merging etc, 
because not having external dependencies is *so* much more maintainable 
and portable that it's not even funny.

Was it "simpler" to just depend on external things like GNU patch and 
diff? Yes. But it was strictly much worse to maintain, and it also limited 
us - thanks to integrating our own diff/merge/patch, we've been able to 
make them suit us much better.

I'd love for every single shell-script in git core to be written in C, so 
that we can drop the dependency on shell *entirely*.

I also dispute your "easy to do". Quite often, shell (or any scripting 
language) is actually much *more* complicated than C. Yes, the C code may 
be more lines (in this case, the shell script is 106 lines, and the C code 
was 216 lines), but from a maintenance standpoint, C has had *much* fewer 
problems than the shell script stuff has ever had!

So scripting languages are often good for *prototyping*, and a lot of 
people like scripting languages for that reason. But once something is 
already prototyped, and if somebody then rewrites it in C, all the 
advantages of a scripting language have already disappeared!

I don't understand why people consider scripting languages (whether shell, 
perl, or anything else) "better" than C if there is an alternative. Once 
the C work has been done (and if you require C _anyway_ for other reasons, 
like git does), doing it in C is simply superior.

> Red herring.  The proposal was not to do nothing, but rather give git
> a dedicated scripting language internal to it.  Two suggestions of
> mine with different advantages were git-busybox and Lua.

Having tried to do internal scripting languages, I can say that it's just 
easier to do it in C once you get past the hump of getting it written in C 
in the first place.

The "impedance match" problem between core code (which is inevtiably in C) 
and the interfaces the scripting language offers is invariably a nasty 
issue.

So yes, we could just make the shell/etc from busybox _be_ the scripting 
language, but the fact is, that is *more* C code than just making the 
commands C code in the first place, and while a lot of the effort is 
already done for us, "busybox under windows" is actually likely to be more 
of a maintenance problem than "native git commands under windows" are.

So if we have the choice, and somebody has written a git command in native 
C code, I think we should *always* take it. Just because it means that 
_eventually_ we can drop shell entirely, even if it would be a git 
internal busybox shell.

And LUA may be a nicer scriping thing than most, but you still end up 
having the impedance match, and quite frankly, I think we'd have much 
fewer problems with just rewriting all the remaining shell scripts in C, 
than to integrate LUA and write them in that.

(Quite frankly, havign looked at monotone development, I can say that we 
should avoid LUA and things like Boost like the plague. If it's not a 
library that has been around for ten years or more, it's not worth the 
headache).

			Linus
