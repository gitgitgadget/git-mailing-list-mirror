From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 16:38:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601311750270.25300@iabervon.org> <7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Baldwin <cnb@fc.hp.com>,
	Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 01:42:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F464h-0003vZ-Fl
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 01:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWBAAmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 19:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWBAAmR
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 19:42:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43983 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932356AbWBAAmQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 19:42:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k110cqDZ017317
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 16:38:52 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k110coUk009754;
	Tue, 31 Jan 2006 16:38:51 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15368>



On Tue, 31 Jan 2006, Junio C Hamano wrote:
> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I sort of suspect that "git commit some_other_file" should really read 
> > HEAD into a temporary index, update "some_other_file" in that (and the 
> > main index), and commit it.
> > ...
> > The surprising thing is that "git commit path ..." means
> > "everything I've already mentioned, plus path..." not just
> > "path ...", and it's particularly surprising because people
> > only tend to specify paths when they've done something they
> > don't want to commit.
> 
> Interesting idea, and a good point.

One thing to be careful about is merges.

This actually happens to me:

	git pull ....

	.. uhhuh, trivial conflict in one file ..
	.. edit the/file/that/conflicted ..

	git commit the/file/that/conflicted

and there is no way that it would ever be correct to then just commit that 
one file. The fact that it's a merge means that the rest of the index - 
which is all from the merge, and correct - absolutely _must_ be committed 
too.

And yes, I could use "git commit -a" (and I often do), but the thing is, I 
surprisingly often have edits in unrelated files (stuff that the merge 
never touched), and doing "git commit -a" would do the wrong thing.

So the current "git commit filename" behaviour is actually the only 
possible correct one for a merge. Nothing else makes any sense 
what-so-ever.

Now, I can hear people arguing that "ok, merges are special, and for 
merges we always do it in the current index", but that makes "git commit 
pathname" act very _differently_ for a merge than for a normal commit. 
That just smells wrong to me.

So if you do this change (which may be the right one) then please make 
sure that "git commit <filename>" doesn't work _at_all_ when a merge is in 
progress (ie MERGE_HEAD exists), because it would do the wrong thing.

And yes, then I'll just have to force my fingers to do a simple

	git-update-index filename
	git commit

instead. I can do that.

Oh, one final suggestion: if you give a filename to "git commit", and you 
do the new semantics which means something _different_ than "do a 
git-update-index on that file and commit", then I'd really suggest that 
the _old_ index for that filename should match the parent exactly. 
Otherwise, you may have done a

	git diff filename

and you _thought_ you were committing just a two-line thing (because you 
didn't understand about the index), but another, earlier, action caused 
the index to be different from the file you had in HEAD, and in reality 
you're actually committing a much bigger diff.

In other words: if you want "git commit <filename>" to _not_ care about 
the current index, then it should make sure that the index at least 
_matches_ the current HEAD in the files mentioned.

Ie "git-diff-index --cached HEAD <filespec>" should return empty. Or 
something like that.

			Linus
