From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Sun, 16 Aug 2009 10:14:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> <200908142223.07994.jnareb@gmail.com> <7veird4yyi.fsf@alter.siamese.dyndns.org> <200908160137.30384.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 10:14:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcask-0003ad-Ey
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 10:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbZHPIOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 04:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbZHPIOH
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 04:14:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:56804 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750722AbZHPIOE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 04:14:04 -0400
Received: (qmail invoked by alias); 16 Aug 2009 08:14:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 16 Aug 2009 10:14:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2f+0jZtb2LxRnig/q3dWJmPzF6D2UAOQ9wRxKUj
	yRf8Q3N1674N9D
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200908160137.30384.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126051>

Hi,

On Sun, 16 Aug 2009, Jakub Narebski wrote:

> On Sat, 15 Aug 2009, Junio C Hamano wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:
> > 
> >>>> Hmmm... this looks like either argument for introducing --full 
> >>>> option to git-checkout (ignore CE_VALID bit, checkout everything, 
> >>>> and clean CE_VALID (?))...
> >>>>
> >>>>  ...or for going with _separate_ bit for partial checkout, like in 
> >>>>  the very first version of this series, which otherwise functions 
> >>>>  like CE_VALID, or is just used to mark that CE_VALID was set using 
> >>>>  sparse.
> > 
> > How would a separate bit help?  Just like you need to clear CE_VALID 
> > bit to revert the index into a normal (or "non sparse") state somehow, 
> > you would need to have a way to clear that separate bit anyway.
> > 
> > A separate bit would help only if you want to handle assume-unchanged 
> > and sparse checkout independently. But my impression was that the 
> > recent lstat reduction effort addressed the issue assume-unchanged 
> > were invented to work around in the first place.
> 
> Well, if we assume that we don't need (don't want) to handle 
> assume-unchanged and sparse checkout independently, then of course the 
> idea of having separate or additional bit for sparse doesn't make sense.

For the shallow/graft issue, we had a similar discussion.  Back then, I 
was convinced that shallow commits and grafted commits were something 
fundamentally different, and my recent patch to pack-objects shows that: 
shallow commits do not have the real parents in the current repository, 
and that makes them different from other grafted commits.

Now, if you want to say that assume-unchanged and sparse are two 
fundamentally different things, I would be interested in some equally 
convincing argument as for the shallow/graft issue.

There is a fundamental difference, I grant you that: the working directory 
does not contain the "sparse'd away" files while the same is not true for 
assume-unchanged files.

But does that matter?  The corresponding files are still in the index and 
the repository.

IOW under what circumstances would you want to be able to discern between 
assume-unchanged and "sparse'd away" files in the working directory?

I could _imagine_ that you'd want a tool that allows you to change the 
focus of the sparse checkout together with the working directory.  
Example: you have a sparse checkout of Documentation/ and now you want to 
have t/, too.  Just changing .git/info/sparse will not be enough.

The question is if the tool to change the "sparseness" [*1*] should not 
change .git/info/sparse itself; if it does not, it would be good to be 
able to discern between the "assume-unchanged" and "sparse'd away" files.

Although it might be enough to traverse the index and check the presence 
of the assume-unchanged files in the working directory to determine which 
files are sparse, and which ones are merely assume-unchanged.

Ciao,
Dscho

Footnote [*1*]: I think we need some nice and clear nomenclature here.  
Any English wizards with a good taste of naming things?
