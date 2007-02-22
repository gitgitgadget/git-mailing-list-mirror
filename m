From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive
Date: Thu, 22 Feb 2007 17:20:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702221719030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xeqllxk.fsf@assigned-by-dhcp.cox.net> <7v4ppellev.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 17:20:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKGgG-0001LG-67
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 17:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbXBVQUZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 11:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbXBVQUZ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 11:20:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:55946 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750881AbXBVQUY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 11:20:24 -0500
Received: (qmail invoked by alias); 22 Feb 2007 16:20:23 -0000
X-Provags-ID: V01U2FsdGVkX18Eq+takgIEg/bvSXGYXpKnEeI8PAMwK6XGsOzZq3
	fj+w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v4ppellev.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40355>

Hi,

On Wed, 21 Feb 2007, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> >> +static int verify_bundle(struct bundle_header *header)
> >> +{
> >> +	/*
> >> +	 * Do fast check, then if any prereqs are missing then go line by line
> >> +	 * to be verbose about the errors
> >> +	 */
> >> +	struct ref_list *p = &header->prerequisites;
> >> +	const char *argv[5] = {"rev-list", "--stdin", "--not", "--all", NULL};
> >> +	int pid, in, out, i, ret = 0;
> >> +	char buffer[1024];
> >> +
> >> +	in = out = -1;
> >> +	pid = fork_with_pipe(argv, &in, &out);
> >> +	if (pid < 0)
> >> +		return error("Could not fork rev-list");
> >> +	if (!fork()) {
> >> +		for (i = 0; i < p->nr; i++) {
> >> +			write(in, sha1_to_hex(p->list[i].sha1), 40);
> >> +			write(in, "\n", 1);
> >> +		}
> >> +		close(in);
> >> +		exit(0);
> >> +	}
> >> +	close(in);
> >
> > What if write() fails?  That can happen when one of the objects
> > you feed here, or its parent objects, is missing from your
> > repository -- receiving rev-list would die() and the writing
> > child would sigpipe.
> >
> > I also wonder who waits for this child...
> 
> In general, fork() to avoid bidirectional pipe deadlock is a
> good discipline, but in this particular case I think it would be
> easier to handle errors if you don't (and it would save another
> process).  The other side "rev-list --stdin --not --all" is
> running a limited traversal, and would not emit anything until
> you stop feeding it from --stdin, or until it dies because you
> fed it a commit that does not exist.  So as long as you check
> the error condition from write() for EPIPE to notice the other
> end died, I think you are Ok.

Thinking about this deeper, I have to say I find my decision to use 
"--stdin" rather silly, given that I know the exact number of revisions, 
and their SHA1s.

But it might make more sense to rewrite the checking part, instead of 
fork()ing it.

Ciao,
Dscho
