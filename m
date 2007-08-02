From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 2 Aug 2007 19:44:37 -0400
Message-ID: <9e4733910708021644q6eba0e78gc2c6bcfba4816012@mail.gmail.com>
References: <46AFCF3E.5010805@alum.mit.edu> <f8r09t$qdg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, users@cvs2svn.tigris.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 01:44:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGkLT-00030H-9W
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 01:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478AbXHBXok (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 19:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756613AbXHBXok
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 19:44:40 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:13517 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444AbXHBXoj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 19:44:39 -0400
Received: by rv-out-0910.google.com with SMTP id k20so535483rvb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 16:44:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RjJ5d4vSYjepWURpM8BrznIQLUxiPp4tXZssrO/KKtZTbRlqHtDMb8Lsz8DzDiazENUje9HiTlHgctGTJn7Qg3s69OFmTz60PLFsOUaGS+tv1sHf+IdTZ2L5CLwjdiuQvYO0QDWuRYpYadXWNhB8S1mszaRGNppTrtd+6gWu4PE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VtvyJGjT3b0TWdjn4+1iWk2OLn5gZLok8QNRhH+LrQEDnAc1op5KkW6V/k+Ue/Xm6RnOpNL2AEndc18GU0X4z/kolKM5s0l/P6uqS0XA/x1DLTta04JeVhlLAOErKm/Mzh94BLrRrJQJbdfZhGTBERi6g+YqGUIkM5ZGeRLs7n0=
Received: by 10.115.90.1 with SMTP id s1mr2364986wal.1186098277900;
        Thu, 02 Aug 2007 16:44:37 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Thu, 2 Aug 2007 16:44:37 -0700 (PDT)
In-Reply-To: <f8r09t$qdg$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54645>

On 8/1/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Michael Haggerty wrote:
>
> > I am the maintainer of cvs2svn[1], which is a program for one-time
> > conversions from CVS to Subversion. cvs2svn is very robust against the
> > many peculiarities of CVS and can convert just about every CVS
> > repository we have ever seen.
> >
> > I've been working on a cvs2svn output pass that writes the converted CVS
> > repository directly into git rather than Subversion. The code runs now
> > with at least one repository from our test suite of nasty CVS repositories.
>
> Have you contacted Jon Smirl about his unpublished work on cvs2git,
> cvs2svn based CVS to Git converter?

My converter was derived from Michael's cvs2svn code. The bulk of my
work was converting cvs2svn to output in a format that git-fastimport
could consume. This was all rather straight forward and there was
nothing really interesting in the code.

What it exposed were fundamental issues about the technical
complexities of trying to reconstruct a change set history from CVS
which didn't record all of the needed info.  I was never able to
construct a satisfactory git representation of the Mozilla CVS
repository.  Michael has had a long time to work on the change set
detection code and he's probably added some new strategies.

My code did include a CVS file parser for extracting all the revisions
from the file in a single pass. Doing that is a major performance
benefit.  I believe I posted the code to the cvs2svn mailing list. It
was about 200 lines of code. Forking off cvs a million times to
extract the revisions takes days to run.

Same goes for forking git a million times.git-fastimport uses a pipe
to cvs2svn to avoid forking. git-fastimport also uses a technique from
the database world for bulk import, it imports everything without
indexing it. Indexing is done after the import finishes.

Between parsing the CVS files internally and Shawn's git-fastimport,
it was possible to import Mozilla CVS (2.4G) in about 2 hours and
generate a 450MB pack file. You need 3GB of RAM to do this - if swap
happens the process will take weeks to finish.

> Quote from InterfacesFrontendsAndTools page on GIT wiki[1]:
>
>   cvs2git is the unofficial name of Jon Smirl's modifications to cvs2svn.
>   These modifications allow cvs2svn to generate a data stream which is
>   consumed by Shawn Pearce's git-fast-import (now included in git.git).
>   git-fast-import converts its input stream directly into a Git .pack file,
>   minimizing the amount of IO required on large imports.
>
>   Jon Smirl stopped working on cvs2git[2] because first, Mozilla (which was
>   main target of his work) decided that to not to move to git, and second
>   because of troubles with cvs2svn architecture[*] (which it is based on).
>   Jon Smirl has posted his impressions on working on CVS importer in
>   "Some tips for doing a CVS importer" thread[3].
>
> References:
> -----------
> [1] http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-23858c2cde0cef60443d8e73e6829a95f8e191ef
> [2] http://msgid.gmane.org/9e4733910611190940y147992b8mbdfac5a51f42e0fe@mail.gmail.com
> [3] http://marc.theaimsgroup.com/?t=116405956000001&r=1&w=2
>
> Footnotes:
> ----------
> [*] If I remember correctly authors of cvs2svn were talking about separating
> the code dealing with disentangling CVS repository structure from the part
> translating it into Subversion repository (with its quirks), and the part
> generating Subversion repository.
>
> --
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
