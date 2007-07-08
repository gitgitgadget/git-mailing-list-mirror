From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC][PATCH] Re: git-rm isn't the inverse action of git-add
Date: Sun, 8 Jul 2007 22:49:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707082240510.4248@racer.site>
References: <46893F61.5060401@jaeger.mine.nu>
 <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
 <46895EA4.5040803@jaeger.mine.nu> <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
 <vpq7ipittl2.fsf@bauges.imag.fr> <Pine.LNX.4.64.0707022205210.4071@racer.site>
 <vpqoditkc23.fsf@bauges.imag.fr> <Pine.LNX.4.64.0707031308170.4071@racer.site>
 <vpqir91hagz.fsf@bauges.imag.fr> <20070704200806.GA3991@efreet.light.src>
 <vpqd4z7q820.fsf@bauges.imag.fr> <vpqfy3yajbj.fsf_-_@bauges.imag.fr>
 <Pine.LNX.4.64.0707081855300.4248@racer.site> <vpq1wfi8wjl.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Hudec <bulb@ucw.cz>,
	Yann Dirson <ydirson@altern.org>,
	Christian Jaeger <christian@jaeger.mine.nu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jul 08 23:56:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ekD-0006qh-25
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 23:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624AbXGHV4j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 17:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757597AbXGHV4j
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 17:56:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:42569 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757457AbXGHV4i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 17:56:38 -0400
Received: (qmail invoked by alias); 08 Jul 2007 21:56:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 08 Jul 2007 23:56:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IuQ0ugwHI/Qg2suf1fkfciDenQd0sZEThXP3YUa
	qHggRhptdrDKDr
X-X-Sender: gene099@racer.site
In-Reply-To: <vpq1wfi8wjl.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51929>

Hi,

On Sun, 8 Jul 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> This patch proposes a saner behavior. When there are no difference at 
> >> all between file, index and HEAD, the file is removed both from the 
> >> index and the tree, as before.
> >> 
> >> Otherwise, if the index matches either the file on disk or the HEAD, 
> >> the file is removed from the index, but the file is kept on disk, it 
> >> may contain important data.
> >
> > However, if some of the files are of the first kind, and some are of 
> > the second kind, you happily apply with mixed strategies.  IMO that is 
> > wrong.
> 
> I'm not sure whether this is really wrong. The things git should
> really care about are the index and the repository itself, and the
> proposed behavior is consistant regarding that (either remove all
> files from the index, or remove none).

Well, I think it is wrong for the same reason as it is wrong to apply the 
changes to _any_ file when one would fail.  And since "git apply" shares 
my understanding, I think "git rm" should, too.

> >>  static struct {
> >>  	int nr, alloc;
> >> -	const char **name;
> >> +	struct file_info * files;
> >>  } list;
> >>  
> >>  static void add_list(const char *name)
> >>  {
> >>  	if (list.nr >= list.alloc) {
> >>  		list.alloc = alloc_nr(list.alloc);
> >> -		list.name = xrealloc(list.name, list.alloc * sizeof(const char *));
> >> +		list.files = xrealloc(list.files, list.alloc * sizeof(const char *));
> >
> > This is wrong, too.  Yes, it works.  But it really should be 
> > "sizeof(struct file_info *)".  Remember, code is also documentation.
> 
> You don't need to argue, that was a typo. My code is definitely wrong, 
> but you're wrong too ;-). That's actually sizeof(struct file_info).

Heh, right.

> >> +		if (!quiet)
> >> +			fprintf(stderr, 
> >> +				"note: file '%s' not removed "
> >> +				"(doesn't match %s).\n",
> >> +				path,
> >> +				fi.local_changes?"the index":"HEAD");
> >> +		return 0;
> >> +	}
> >> +}
> >
> > I suspect that this case does never fail. 0 means success for 
> > remove_file().  Not good.  You should at least have a way to ensure that 
> > it removed the files from the working tree from a script.  Otherwise there 
> > is not much point in returning a value to begin with.
> 
> I've changed it to have exit_status = 1 if git-rm aborted before
> starting, and 2 if git-rm skiped some file removals (and of course, 0
> if everything is done as expected).

Oh, so you do not take the return value of this function to determine if 
it has or has not done something with the files?  That's a bit confusing.

Besides, it would be all the more a reason for a test case, so that I can 
see that I am actually wrong.

> > Additionally, since this changes semantics, you better provide test 
> > cases to show what is expected to work, and _ensure_ that it actually 
> > works.
> 
> Sure. I forgot to mention it in my message, but I wanted to have 
> feedback before getting into the testsuite stuff.

I think it should be the other way.  If you change semantics with the 
patch, but another revision changes semantics _differently_, it is really 
easy to get lost.  In order to demonstrate what should be true, you have 
to provide examples.  And if you are already providing examples, just wrap 
them into

	test_description <description>
	. ./test-lib.sh

	...

	test_done

and prefix each test with "test_expect_success", and you're done.  It is 
really not something requiring a wizard.

> I'm posting the updated patch for info, but it should anyway not be
> merged until
> 
> * We agree on the behavior when different files have different kinds
>   of changes

I'd understand better what you wish to accomplish with the...

> * I add a testcase.

... testcase. So those are not two distinct points.

> >From f39ae646049b95b055e34da378ea470ef3f3caef Mon Sep 17 00:00:00 2001
> From: Matthieu Moy <Matthieu.Moy@imag.fr>
> Date: Sun, 8 Jul 2007 19:27:44 +0200
> Subject: [PATCH] Change the behavior of git-rm to let it obey in more circumstances without -f.

Please do not do this.

I meant to complain about your OP, but this time it is even worse.  The 
best way to guarantee that a patch gets lost in a thread is to move it _at 
the end_ of a reply.

Please follow the form that you change the subject, still reply, but but 
the quoted mail with your answers to that text between the "---" and the 
diffstat.

If that text is too long, you should use a separate email for the patch.

Ciao,
Dscho
