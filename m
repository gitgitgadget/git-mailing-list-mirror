From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cvsexportcommit: handle file status reported out of
 order (was Re: [PATCH] Make git-cvsexportcommit "status" each file in
 turn)
Date: Thu, 2 Oct 2008 14:32:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810021428170.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <48E4AB7D.5030705@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nick Woolley <nickwoolley@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 02 14:27:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlNHV-0006z3-Vr
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 14:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbYJBM0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 08:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753060AbYJBM0c
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 08:26:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:40939 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753059AbYJBM0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 08:26:31 -0400
Received: (qmail invoked by alias); 02 Oct 2008 12:26:29 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 02 Oct 2008 14:26:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/f9Ds8GGLfbHEIGb/6X9v2kSOFzFJ94d57YfwpdL
	gQSAJljNfLvBLI
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <48E4AB7D.5030705@yahoo.co.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97318>

Hi,

On Thu, 2 Oct 2008, Nick Woolley wrote:

> I've encountered a problem with the Ubuntu Hardy version of 
> git-cvsexportcommit (part of git-cvs 1:1.5.4.3-1ubuntu2). This seems to 
> be the same problem describedin August last year in the thread on this 
> list I referenced (Make git-cvsexportcommit "status" each file in turn).
> 
> The problem is that cvsexportcommit rejects a patch erroneously when CVS 
> does not report file statuses in the expected order.  It confuses one 
> file's status for another and says (at least in my case):
> 
> > Checking if patch will apply
> > cvs server: nothing known about XXXXXXXXX
> > cvs server: nothing known about XXXXXXXXX
> > File XXXXXXXXX is already known in your CVS checkout   -- perhaps it\
> >  has been added by another user. Or this may indicate that it exists\
> >  on a different branch. If this is the case, use -f to force the\
> >  merge.
> > Status was: Up-to-date
> > File XXXXXXXXX not up to date but has status   'Unknown' in your\
> >  CVS checkout!
> > Exiting: your CVS tree is not clean for this merge. at /usr/bin/git\
> >  -cvsexportcommit line 235.
> 
> I searched this list - including the release announcements - and the web 
> and it did not seem that anyone had applied this patch or otherwise 
> addressed it.
> 
> I then found the git release repository and it *does* seem to have been 
> addressed in 1.6.0.  However, and correct me if I'm mistaken, but the 
> implementation seems to assume that the committed files' basenames are 
> unique? This can't be guaranteed in general, can it?

Please research a bit better.  If the basenames are not unique, several 
cvs status calls are used.  See commit
fef3a7cc5593d3951a5f95c92986fb9982c2cc86.

> Anyway, by then I'd already had a go at fixing it myself, and I had an 
> alternative approach, partly based on the suggestions from Robin 
> Rosenberg in the referenced thread. It doesn't assume basenames are 
> unique, and therefore I think should be more robust.
> 
> So, attached is a patch against v1.5.4.  It works for me, but has only 
> been tested with my particular circumstance, so there could be 
> assumptions I made which aren't universally true.  I did try using the 
> test suite in git 1.6.0 but it didn't work for reasons I don't want to 
> spend too much more time investigating.  I think the patch as it is 
> should be easy to follow and integrate with 1.6.0 for someone familiar 
> with the codebase.
> 
> Some notes about the patch.
> 
>  - It parses the output of CVS status / update, getting the
>    file status much as before
> 
>  - save_pipe_capture() is modified to capture STDERR as well as STDOUT
> 
>  - The STDERR message 'nothing known about <path>' is used
>    preferentially to get a file's path.
> 
>  - Otherwise, uses the 'Repository revision' field, extracting the
>    relevant part by removing the repository root constructed from
>    meta-data in the CVS/Root and CVS/Repository files.
> 
> I hope this helps.  Comments welcome.

I can only assume that you have not really hung out on this list for very 
long; this is no way near the way patches are expected here.  For more 
help, refer to Documentation/SubmittingPatches, as has been mentioned in 
the notes from the maintainer quite a number of times.  Or imitate how 
other people submit their patches.

Also, given the fact that you actually verified that it was fixed in 
1.6.0, what exactly is your proposed course of action?  Revert the fix in 
1.6.0 and apply your patch?  Apply your patch to 1.5.6.5, cracking a 
release 1.5.6.6 with your patch?

Puzzled,
Dscho
