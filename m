From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Support gitlinks in fast-import/export.
Date: Sat, 19 Jul 2008 01:21:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807190109570.3064@eeepc-johanness>
References: <200807182103.37272.angavrilov@gmail.com> <alpine.DEB.1.00.0807181810400.8986@racer> <200807182234.47363.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 01:22:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJzH9-0004Zk-95
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 01:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbYGRXVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 19:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbYGRXVK
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 19:21:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:37842 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752920AbYGRXVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 19:21:09 -0400
Received: (qmail invoked by alias); 18 Jul 2008 23:21:06 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp037) with SMTP; 19 Jul 2008 01:21:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hVsVCKY6hAjp+JSDSozlNi0YKADGNnai5YZj4kq
	qRVGOED05H1AQX
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807182234.47363.angavrilov@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89087>

Hi,

On Fri, 18 Jul 2008, Alexander Gavrilov wrote:

> On Friday 18 July 2008 21:36:26 Johannes Schindelin wrote:
> > > 	What I'm unsure of is, should fast-export try to reuse commit 
> > > 	marks for gitlinks where it happened to recognize the object, or 
> > > 	always output the SHA as it is stored in the tree?
>  
> > Are they commit marks?  No.  So they should be handled as marks, just 
> > as those for blobs and trees.
> > 
> > (They are commit marks in the _submodule_, but that does not matter 
> > here.)
> 
> Well, I was thinking of that unlikely case when the master module and 
> the submodule are in the same repository and are exported together. But 
> probably it is best to just output the SHA after all.

Exactly.

What you describe is a _possibility_.  Requiring it would be a serious 
mistake.

> > >  	for (i = 0; i < diff_queued_diff.nr; i++)
> > > -		handle_object(diff_queued_diff.queue[i]->two->sha1);
> > > +		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
> > > +			handle_object(diff_queued_diff.queue[i]->two->sha1);
> > 
> > Why?  You do not want to export changes in the submodules?
> 
> handle_object opens the sha as a blob and outputs it. As gitlinks aren't 
> blobs, it won't work. And if the submodule is in a separate repository, 
> there is nothing to open anyway.

So what should happen to them instead?  Ignoring them?

Possible.

My earlier remark about the marks was this: you might want to mark SHA-1s 
of gitlinks with a (shorter) number, but maybe that is just bullocks.  At 
the same time, it might be not.

> Simultaneously reading commits from the submodule repository is a whole 
> different level of complexity. I'm afraid I'm not up to it yet.

Good news for you:  I think it would be a serious mistake to read commits 
from the submodule.

> > >  		else {
> > >  			struct object *object = lookup_object(spec->sha1);
> > > -			printf("M %06o :%d %s\n", spec->mode,
> > > -			       get_object_mark(object), spec->path);
> > > +			int mark = object ? get_object_mark(object) : 0;
> > 
> > As I said, that looks wrong.  Maybe we have to fake objects for the 
> > gitlinks.
> 
> I tried to avoid faking blobs and stick to the interface of the M 
> command itself.

My point was: I do not see gitlinks handled _at all_.

I agree that they should not be handled the same as blobs, but i did not 
have time to check that gitlinks are not just ignored by your patch.  
Which would be wrong: you want the exported commits to contain them.

> > > @@ -1900,7 +1901,16 @@ static void file_change_m(struct branch *b)
> > >  		p = uq.buf;
> > >  	}
> > >  
> > > -	if (inline_data) {
> > > +	if (S_ISGITLINK(mode)) {
> > > +		if (inline_data)
> > > +			die("Git links cannot be specified 'inline': %s",
> > > +				command_buf.buf);
> > > +		else if (oe) {
> > > +			if (oe->type != OBJ_COMMIT)
> > > +				die("Not a commit (actually a %s): %s",
> > > +					typename(oe->type), command_buf.buf);
> > 
> > How is that supposed to work?  Do I understand correctly that you 
> > require the user to construct a commit object for the gitlink?  That 
> > would be actively wrong.
> 
> There are three forms of the M command:
> 
> M mode inline some/path
> ...some data...
> 
> M mode :mark some/path
> 
> M mode SHA some/path
> 
> For usual files the mark must be created by the 'blob' command,
> and the SHA must refer to an existing blob. This hunk makes fast-import
> require for gitlinks a commit mark instead, and accept the SHA without
> checking (as it is expected to be in another repository).

What's this commit mark thing?  I hope you do not mean to ask the user to 
construct a commit object in the _superproject's_ repository...

> > Oh, and your patch lacks test cases that demonstrate how you envisage 
> > the whole thing to work.
> 
> Ok, I'll make some tests tomorrow.

Maybe I should enhance on my point, to drive it home:

If you do _not_ include automated tests, other people have less reason to 
trust that your patch does what you insist it does.

If you do not include tests, and have a sparse commit message (which you 
do), people are left to guess what your patch tries to do, and do not even 
have the chance to see something you wanted to work.

If you do not include tests, and your patch does something a reviewer 
feels it should not to, or omits something a reviewer feels it _should_ 
do, there is less of an opportunity to see if this was intended: a 
comprehensive test script would show what the submitter expects to 
work alright.

So in a very real sense, it is advisable to write the test _first_, and 
then the patch.

Not everything XP brought to this world is evil.  (Oh yes, you guessed it, 
I was talking about eXtreme Programming...)

Ciao,
Dscho
