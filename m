From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Do not generate full commit log message if it not
	going to be used
Date: Wed, 28 Nov 2007 22:10:59 +0100
Message-ID: <20071128211059.GA3173@steel.home>
References: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com> <474C0105.3010908@viscovery.net> <81b0412b0711270448s6534a849u86bcb161d4d7b3fe@mail.gmail.com> <7vfxyrd2x2.fsf@gitster.siamese.dyndns.org> <81b0412b0711271018m6419b076n269a0175494fac84@mail.gmail.com> <20071127214425.GA3156@steel.home> <Pine.LNX.4.64.0711281211130.27959@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Kristian =?iso-8859-15?Q?H=F8gsberg?= <krh@redhat.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:11:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxUBr-0007CO-MY
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 22:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbXK1VLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 16:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754391AbXK1VLF
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 16:11:05 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:51511 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320AbXK1VLE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 16:11:04 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg79ik=
Received: from tigra.home (Fcbf4.f.strato-dslnet.de [195.4.203.244])
	by post.webmailer.de (fruni mo13) (RZmta 14.3)
	with ESMTP id y00290jASJG7k3 ; Wed, 28 Nov 2007 22:11:00 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 85515277AE;
	Wed, 28 Nov 2007 22:11:00 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id EB56B56D22; Wed, 28 Nov 2007 22:10:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711281211130.27959@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66427>

Johannes Schindelin, Wed, Nov 28, 2007 13:18:10 +0100:
> On Tue, 27 Nov 2007, Alex Riesen wrote:
> 
> > Could not stop myself. Hopefully didn't beat anyone to it :)
> > Almost all code shamelessly stolen from builtin-diff-index.c.
> 
> Then I have to wonder if it would not be a better idea to refactor the 
> code, so that other people do not have to steal the code again, but are 
> able to reuse it ;-)

Not sure it will be worth the effort. It is really short.

OTOH, I missed a diff-index interface where I could pass a resolved
sha1 (the u8 array returned by get_sha1) and index state. Something
like "int diff_tree_index(const unsigned char *sha1, struct rev_info *)".

Tempting, but I have only one use case for it. I don't actually know
Git's code that well...

> > Preprocessor trickery in DIFF_OPT_* macros is disgusting, it breaks Vim 
> > word completion and trying to use many flags in one expression looks 
> > just ugly.
> 
> How does it break Vim word completion?  And why should something like
> 
> 		DIFF_OPT_SET(&rev.diffopt, QUIET | EXIT_WITH_STATUS);
> 
> look ugly?  I find it highly readable.

Oh, this would look ok. It just wont compile: DIFF_OPT_SET prepends
second argument with DIFF_OPT_:

#define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
#define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
#define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)

> > +	if (no_edit) {
> > +		static const char *argv[] = { NULL, "HEAD", NULL };
> > +		struct rev_info rev;
> > +		unsigned char sha1[40];
> > +		int is_initial;
> > +
> > +		fclose(fp);
> > +
> > +		if (!active_nr && read_cache() < 0)
> > +			die("Cannot read index");
> > +
> > +		if (get_sha1("HEAD", sha1) != 0)
> > +			return !!active_nr;
> 
> Don't want to be anal here, but are there possibly reasons (read "possible 
> errors") other than an empty repo where this triggers?

Definitely. I just don't know. OTOH, I can only return "committable"
or "not committable". If I return "commitable" for a broken repo,
it should fail elsewhere. If I return "not commitable" git-commit
shall finish telling user there is nothing to commit, which is just
wrong.

> > +
> > +		init_revisions(&rev, "");
> > +		rev.abbrev = 0;
> > +		(void)setup_revisions(2, argv, &rev, NULL);
> 
> (void)?

Yep. Sorry, I just got carried away by recent tendency (here at work)
to shut up PC-Lint (but please don't ask).

> Besides, would this not be more elegant as
> 
> 		setup_revisions(0, NULL, &rev, "HEAD");

Hmm... And I was so puzzled as to what that "def" argument could
possibly mean... Still am, in fact. But it works.

> > +		(void)run_diff_index(&rev, 1 /* cached */);
> 
> (void)?

I'll remove them and resubmit. Stupid custom.

> Other than that (including my remark about refactoring that piece of 
> code), I like it.

Me too: I have *extensively* tested it today and a commit on the
2.6GHz/2Gb/SATA windows machine is almost as fast as on my linux
laptop now (Centrino/1.2GHz downclocked to 800MHz/384Mb/IDE).
