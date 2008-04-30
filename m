From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug: git-diff silently fails when run outside of a repository
 (v1.5.4.2)
Date: Wed, 30 Apr 2008 09:34:51 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804300933570.17469@eeepc-johanness>
References: <3c6c07c20804291304n36976417wf3c2a13303aa3133@mail.gmail.com> <7vabjc5l3r.fsf@gitster.siamese.dyndns.org> <3c6c07c20804291603q4fbe957eq3e3da39d4a2e29c0@mail.gmail.com> <7vskx444h5.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300155320.17469@eeepc-johanness>
 <7vwsmg2ks7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Coleman <tutufan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 10:35:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr7mk-0006KF-HY
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 10:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758499AbYD3Iel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 04:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757297AbYD3Iek
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 04:34:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:51671 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751086AbYD3Iei (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 04:34:38 -0400
Received: (qmail invoked by alias); 30 Apr 2008 08:34:36 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp035) with SMTP; 30 Apr 2008 10:34:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19iW+dEqwZiY213kkKLkbW2nTMkFg3RdgNT9NsySe
	XPIHfaWlkY9fvW
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vwsmg2ks7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80809>

Hi,

On Tue, 29 Apr 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > Even so, this seems like a bug.  If I do this:
> >> >
> >> >     $ cd /
> >> >     $ git-diff
> >> >
> >> > there is no error message and no error status.  A diagnostic would be
> >> > very helpful.
> >> 
> >> Ah, that indeed is not very helpful.
> >> 
> >> Unfortunately, every time I look at this hack, I seem to find an unrelated
> >> bug in it.  Here is today's.
> >> 
> >> 	$ for i in 1 2 3; do >/var/tmp/$i; done
> >>         $ cd /
> >>         $ git diff /var/tmp/1
> >>         Segmentation Fault
> >> 
> >> When nongit is true, we know the user has to be asking --no-index diff, so
> >> perhaps we can fix it by doing something like this?
> >> 
> >> diff --git a/diff-lib.c b/diff-lib.c
> >> index 069e450..cfd629d 100644
> >> --- a/diff-lib.c
> >> +++ b/diff-lib.c
> >> @@ -264,6 +264,9 @@ int setup_diff_no_index(struct rev_info *revs,
> >>  			DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
> >>  			break;
> >>  		}
> >> +	if (nongit && argc != i + 2)
> >> +		die("git diff [--no-index] takes two paths");
> >> +
> >>  	if (argc != i + 2 || (!is_outside_repo(argv[i + 1], nongit, prefix) &&
> >>  				!is_outside_repo(argv[i], nongit, prefix)))
> >>  		return -1;
> >
> > That looks to me as if the second if() should have triggered, and the 
> > caller of setup_diff_no_index() should have errored out.
> 
> I think the above three-liner fix is something we should have done when we
> added --no-index codepath.  Before the --no-index hack was introduced, we
> did not even got this far to the place the caller of this function is, if
> we are outside a repository.  By returning -1 from here instead of dying,
> this code is driving the codepath that has always expected to already be
> in a repository into a nonrepository, causing them to segfault because
> there is no git-dir or work-tree set up done yet as they expect.

Fair enough.

Ciao,
Dscho
