From: karsten.blees@dcon.de
Subject: Re: [msysGit] [PATCH] fix deletion of .git/objects sub-directories in
 git-prune/repack
Date: Wed, 7 Mar 2012 11:50:34 +0100
Message-ID: <OF193C81EB.4E07375C-ONC12579BA.00363763-C12579BA.003B9773@dcon.de>
References: <7vmx7tqu0q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	kusmabite@gmail.com, msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Stefan Naewe <stefan.naewe@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 11:50:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ESR-0000Jp-95
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 11:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270Ab2CGKuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 05:50:54 -0500
Received: from mail.dcon.de ([77.244.111.98]:18855 "EHLO MAIL.DCON.DE"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122Ab2CGKux (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 05:50:53 -0500
In-Reply-To: <7vmx7tqu0q.fsf@alter.siamese.dyndns.org>
X-Mailer: Lotus Notes Release 7.0.3 September 26, 2007
X-MIMETrack: Serialize by Router on DCON14/DCon(Release 7.0.3FP1|February 24, 2008) at
 07.03.2012 11:50:37,
	Serialize complete at 07.03.2012 11:50:37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192435>

Junio C Hamano <gitster@pobox.com> wrote on 06.03.2012 22:49:57:
> karsten.blees@dcon.de writes:
> 
> > Junio C Hamano <gitster@pobox.com> wrote on 06.03.2012 21:19:06:
> >> Johannes Sixt <j6t@kdbg.org> writes:
> >> 
> >> >> diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
> >> >> index f9463de..a834417 100644
> >> >> --- a/builtin/prune-packed.c
> >> >> +++ b/builtin/prune-packed.c
> >> >> @@ -36,7 +36,6 @@ static void prune_dir(int i, DIR *dir, char 
> > *pathname, 
> >> >> int len, int opts)
> >> >>                 display_progress(progress, i + 1);
> >> >>         }
> >> >>         pathname[len] = 0;
> >> >> -       rmdir(pathname);
> >> >
> >> > After moving the rmdir() away from prune_dir(), the truncation of 
the
> >> > pathname does not logically belong here anymore. It should be moved 

> > with
> >> > the rmdir(). Looks good otherwise.
> >> 
> >> I agree that it is better to have the NUL termination close to where
> >> it actually matters.
> >> 
> >
> > The pathname is extended in prune_dir, so I think it should be reset 
there
> > as well; moving it to prune_packed_objects would be quite obscure:
> 
> This depends entirely on how you look at it.
> 
> You can certainly stare at the original code and declare that the
> contract between the caller and the callee was that the caller gives
> pathname[] and len (len+3 for the caller) to the callee, and allows
> the callee to play with the rest of the pathname[] array but expects
> that pathname[] to be properly NUL-terminated when the callee comes
> back.  From that point of view, "pathname[len] = 0" can belong to
> the callee.
> 
> But while you are staring the original code, notice that "expects
> that pathname[] to be NUL-terminated when the callee comes back" is
> not something the caller even depends on.  That expectation starts
> to matter _only_ if you move rmdir(pathname) to the caller.
> 
> That is why I said "where it actually matters."
> 

Well, I just don't like that a function designed to prune a directory
modifies its input parameters as a side effect (it is bad enough that
prune_dir uses the caller's buffer at all). You know, trying to limit
side effects as a general programming principle.

In my opinion, it doesn't matter at all if the caller actually depends on
unmodified parameters or not, it just makes robust APIs that encourage
reuse.

Just my 2 cents, though, prune_packed_objects and prune_dir are so tightly
coupled that it probably doesn't make any difference...(on the other hand,
we have near identical code in prune.c, so thinking about reuse is not so
far fetched)
