From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Wed, 23 Jul 2008 02:10:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807230203350.8986@racer>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 03:11:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLSsl-0002S0-Ts
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 03:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbYGWBKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 21:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbYGWBKI
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 21:10:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:36299 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751802AbYGWBKH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 21:10:07 -0400
Received: (qmail invoked by alias); 23 Jul 2008 01:10:05 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp050) with SMTP; 23 Jul 2008 03:10:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19350shcC93H8ATE9D9zMTCS6bQzauXwAm3AM2wZP
	GRGcw4Q03rq+kT
X-X-Sender: gene099@racer
In-Reply-To: <7vy73tihl6.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89587>

Hi,

On Tue, 22 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When a file's crlf attribute is explicitely set, it does not make 
> > sense to ignore it, just because the config variable core.autocrlf has 
> > not been set.
> 
> I am not sure if I agree with that reasoning.
> 
> Attribute defines what each path is.  Is it a text file, is it a binary? 
> The nature of the contents does not change between people on POSIX and 
> Windows, and that is why it is described in .gitattributes and cloned 
> across repositories.
> 
> On the other hand, the configuration defines what to do with contents with
> various attributes in this particular repository.  Do I want to see a text
> file checked out with CRLF endings, or LF?

Actually, I now see that I expressed myself badly.  Extremely badly.

The whole issue is about _check in_, as can be seen from the test case I 
provided.

And I think it is even a bug in crlf handling, as gitattributes.txt has 
this to say about crlf=input:

        This is similar to setting the attribute to `true`, but
        also forces git to act as if `core.autocrlf` is set to
        `input` for the path.

It suggests to this coder that core.autocrlf is not even looked at when 
crlf=input.

> So it is perfectly valid and normal for a cross-platform minded project 
> to use the crlf atttribute to say "These files are text" and expect them 
> to be checked out with LF endings on POSIX while making sure they are 
> checked out with CRLF on Windows.  Adding CR at the end of line for such 
> files on POSIX systems is positively a wrong thing to do in such a case.
> 
> Projects like the kernel that originate from LF side of the world may not
> bother marking things as such, though.

I fully agree.

However, if you want to avoid CRs to _enter_ the repository, when you have 
a lot of binary files tracked, you _do_ want to force all repositories to 
crlf=input.

Now, if you look at the patch, you will see that it _only_ touches 
crlf_to_git(), but not only for crlf=input, but also for crlf=true.

I maintain that this respects the law of least surprise, namely that if 
you set the attribute crlf=true, and some person forgets to set 
core.autocrlf=true, at _check in_ CRs are stripped, but at _check out_, no 
CR is added (as the person did not ask for core.autocrlf, but that should 
not punish all the others who do not want to have CRs in the repository).

But yes, the commit message, and the oneline in particular are severely 
lacking.

Tomorrow,
Dscho
