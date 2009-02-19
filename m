From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid segfault with 'git branch' when the HEAD is
 detached
Date: Thu, 19 Feb 2009 02:15:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902190212290.10279@pacific.mpi-cbg.de>
References: <cover.1234980819u.git.johannes.schindelin@gmx.de> <ad680bce413ddea084d84b3fcd7c4cc356c3cb0e.1234980819u.git.johannes.schindelin@gmx.de> <20090219004504.GB25808@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jay Soffian <jaysoffian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 02:15:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZxVo-0001zu-0E
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 02:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbZBSBOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 20:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbZBSBOG
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 20:14:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:33987 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751801AbZBSBOD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 20:14:03 -0500
Received: (qmail invoked by alias); 19 Feb 2009 01:14:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 19 Feb 2009 02:14:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18881p+zJw8W6h99474/hK80Y+s9icBcrEW42pTrL
	vUCZp4gO1RvyBD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090219004504.GB25808@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110604>

Hi,

On Wed, 18 Feb 2009, Jeff King wrote:

> On Wed, Feb 18, 2009 at 07:14:59PM +0100, Johannes Schindelin wrote:
> 
> > A recent addition to the ref_item struct was not taken care of, leading
> > to a segmentation fault when accessing the (uninitialized) "dest" member.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > 
> > 	Unfortunately not found by valgrind.
> 
> Meaning that the bug was created after your valgrind testing (which 
> takes a painfully long time to run, and so only happens occasionally), 
> and therefore you found it by hand? Or meaning that even running the 
> test suite with valgrind did not reveal the problem?

It bit me.

IOW I had to fix it before I could finish up the work for the day.

> If the latter, isn't that an indication that this code path was not 
> being exercised by the test suite and it should be?

Like I said, I had to finish up some work for the day, that's why I did 
not have time to add a test.

> Now if only we had a way of measuring test coverage...

Yes, I also want the gcov series.  Patience, grass hopper, patience: after 
1.6.2.

> > --- a/builtin-branch.c
> > +++ b/builtin-branch.c
> > @@ -441,7 +441,9 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
> >  	    is_descendant_of(head_commit, with_commit)) {
> >  		struct ref_item item;
> >  		item.name = xstrdup("(no branch)");
> > +		item.len = strlen(item.name);
> >  		item.kind = REF_LOCAL_BRANCH;
> > +		item.dest = NULL;
> >  		item.commit = head_commit;
> >  		if (strlen(item.name) > ref_list.maxwidth)
> >  			ref_list.maxwidth = strlen(item.name);
> 
> Maybe replace the repeated strlens below with item.len? I.e., squash in
> 
> diff --git a/builtin-branch.c b/builtin-branch.c
> index 13e4de8..14d4b91 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -443,8 +443,8 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
>  		item.kind = REF_LOCAL_BRANCH;
>  		item.dest = NULL;
>  		item.commit = head_commit;
> -		if (strlen(item.name) > ref_list.maxwidth)
> -			ref_list.maxwidth = strlen(item.name);
> +		if (item.len > ref_list.maxwidth)
> +			ref_list.maxwidth = item.len;

Yeah, I did not think of that.  I checked that there are no other 
instances where a member of ref_item was uninitialized, and that took 
already more time than I had.

Ciao,
Dscho
