From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: how to find outstanding patches in non-linux-2.6 repositories
 ?
Date: Tue, 3 Jan 2006 11:41:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601031123150.3668@g5.osdl.org>
References: <Pine.LNX.4.63.0601012228470.32311@wbgn013.biozentrum.uni-wuerzburg.de>
 <1136315518.11946.28.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 03 20:41:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ets26-0008Gd-BR
	for gcvg-git@gmane.org; Tue, 03 Jan 2006 20:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWACTlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 14:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWACTlT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 14:41:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932501AbWACTlS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2006 14:41:18 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k03JfGDZ019577
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Jan 2006 11:41:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k03JfF3o019764;
	Tue, 3 Jan 2006 11:41:16 -0800
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1136315518.11946.28.camel@cashmere.sps.mot.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14158>



On Tue, 3 Jan 2006, Jon Loeliger wrote:
> 
> Could someone remind me where the <ref>..<ref> syntax
> is documented, please?  I went digging, but I am lame
> and couldn't find it.

Hmm. It probably isn't. Technically, "start..end" is exactly the same 
thing as "end" + "^start", with an empty "end" being the same as HEAD (an 
empty "start" is largely meaningless and isn't supported - we _could_ make 
it mean the same as just specifying "end").

You can see this with "git-rev-parse":

	[torvalds@g5 linux]$ git-rev-parse v2.6.12..v2.6.15
	88026842b0a760145aa71d69e74fbc9ec118ca44
	^26791a8bcf0e6d33f43aef7682bdb555236d56de

ie it really does literally that transformation.

NOTE! Normally the "a" + "^b" format just means "everything that is 
reachable through "a", but not reachable through "b". In other words, it 
almost always ends up being a "commit set operation", and you can combine 
it with other "set" operations (like "--before=<date>" or other limiters).

But there is one special case: "git diff" will consider that to be a range 
of end-points, and will generate a diff from "b" to "a". It will do this 
regardless of whether "a" and "b" are even related, and it will _not_ care 
about set differences.

So there's a very fundamental difference between two things that 
_syntactically_ look very similar:

	git log a..b

and 

	git diff a..b

may look like they are related, but they really really are not. They are 
very very different.

The "git log" thing will show the commit log for every commit that is in 
"b" but not in "a". HOWEVER, if there's something in "a" that is not in 
"b" it will totally ignore it - it _literally_ means "show everything that 
is reachable from "b" but not reachable from "a". 

So doing "git log a..b" and "git log b..a" are _not_ "reverse" operations. 
They show totally disjunct sets. If one is a superset of the other, one of 
those will be empty. But if they have different development, the two "git 
log" commands will show what happened on one side but not the other.

In contrast, "git diff a..b" will show the raw differences between two 
heads. So doing "git diff a..b" and "git diff b..a" is exactly the same 
thing, the diff will just be "reversed". It's not an operation on a set of 
commits: it's purely an operation on the two end-points.

So keep this in mind: the meaning of "a..b" actually depends on the 
operation you do, although in all cases it will be exactly equivalent to 
"a" and "^b" (with the special case for an empty "a" meaning HEAD).

			Linus
