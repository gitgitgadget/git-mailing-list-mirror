From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make the exit code of add_file_to_index actually useful
Date: Tue, 13 May 2008 00:48:44 +0200
Message-ID: <20080512224844.GI3128@steel.home>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <alpine.LSU.1.00.0803021555500.22527@racer.site> <7vtzjpoye6.fsf@gitster.siamese.dyndns.org> <20080512175654.GB3128@steel.home> <7vzlqvxt1p.fsf@gitster.siamese.dyndns.org> <20080512205414.GH3128@steel.home> <7viqxjxj0h.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 00:49:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvgpu-0008Vo-Rk
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 00:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911AbYELWss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 18:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755881AbYELWss
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 18:48:48 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:27885 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865AbYELWsr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 18:48:47 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+BInc
Received: from tigra.home (Fab5c.f.strato-dslnet.de [195.4.171.92])
	by post.webmailer.de (mrclete mo27) (RZmta 16.34)
	with ESMTP id k0091ak4CMBWCi ; Tue, 13 May 2008 00:48:45 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 37DE1277BD;
	Tue, 13 May 2008 00:48:45 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0C40C56D28; Tue, 13 May 2008 00:48:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7viqxjxj0h.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81962>

Junio C Hamano, Tue, May 13, 2008 00:19:42 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> >> Why is this even needed to begin with?  I am aware of Dirk's original
> >> issue discussed elsewhere, but we try fairly hard to be A-O-N when we can
> >> afford to, and this option deliberately breaks it.  What is the real
> >> reason why such an unreadable (either for privilege or for I/O error)
> >> file should not live in .gitignore?
> >
> > Another program keeps the file open. There is an exclusive mode for
> > opening files, which locks the files for everyone. I believe it is
> > even default mode, unless selected otherwise.
> 
> I would understand there can be some files that cannot be read.  But when
> there is such a file, why is it Ok to ignore an error to update the
> contents from that file if/when the user asks to index the current
> contents, provided if the contents of that file is to be tracked?  Isn't
> it the true cause of the problem that the file is being tracked but it
> shouldn't?

No, I don't think so. Consider "git add dir/". It is _not_ 1 (one)
operation. It is many operations (add every file in the "dir/"). Why
should all of them be considered failed just because the third file
from the bottom could not be read (and the user may have not even seen
it, because it wasn't there before, like a temporary file from Excel).
And for a user (for me, at least) "git add" is an intermediate
operation anyway: there'll be a review in form "git status" or "git
commit" afterwards. And there was a clear (sadly invisible with
--verbose) warning regarding some file having problems.

> >> Now when somebody either forgets to check the return value from this
> >> function, or deliberately ignores it, the resulting index will not match
> >> what the code is told to update it with.
> >
> > I think I got them all in the current code...
> 
> Not checking the return code from this function that now diagnoses and
> returns error code is a bug as you said, and the codebase after your patch
> may not have that bug.
> 
> But mistakes happen.
> 
> That is why I am asking why it is Ok to sometimes ignore the error to
> begin with.  If we do not need to ignore this condition, then new callers
> have one less thing to worry about, and we would have one less cause of an
> unnecessary bug.

For the reasons outlined? Where the user is in a situation when he has
to override the safety checks. Just because it is more convenient to
type --ignore-errors than edit .gitignore and add there a whimsical
patterns like "~*.xls", which one day have to be overridden because
that project got an excel file which begins with "~"?

I am not suggesting making it default. And actually, the last patch,
with a config for add.ignore-errors option, better be ignored - it was
just too simple to code up. I never used the option. I had cases for
--ignore-errors, sadly.
