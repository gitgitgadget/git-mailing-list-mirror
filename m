From: karsten.blees@dcon.de
Subject: Re: [msysGit] [PATCH] fix deletion of .git/objects sub-directories in
 git-prune/repack
Date: Tue, 6 Mar 2012 22:30:40 +0100
Message-ID: <OFBC9E02C9.526DB40C-ONC12579B9.00726ECA-C12579B9.00763181@dcon.de>
References: <7v4nu1scsl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	kusmabite@gmail.com, msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Stefan Naewe <stefan.naewe@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 22:31:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S51yK-0001QT-71
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 22:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752Ab2CFVa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 16:30:59 -0500
Received: from mail.dcon.de ([77.244.111.98]:14361 "EHLO MAIL.DCON.DE"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755550Ab2CFVa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 16:30:58 -0500
In-Reply-To: <7v4nu1scsl.fsf@alter.siamese.dyndns.org>
X-Mailer: Lotus Notes Release 7.0.3 September 26, 2007
X-MIMETrack: Serialize by Router on DCON14/DCon(Release 7.0.3FP1|February 24, 2008) at
 06.03.2012 22:30:35,
	Serialize complete at 06.03.2012 22:30:35
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192399>

Junio C Hamano <gitster@pobox.com> wrote on 06.03.2012 21:19:06:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> >> diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
> >> index f9463de..a834417 100644
> >> --- a/builtin/prune-packed.c
> >> +++ b/builtin/prune-packed.c
> >> @@ -36,7 +36,6 @@ static void prune_dir(int i, DIR *dir, char 
*pathname, 
> >> int len, int opts)
> >>                 display_progress(progress, i + 1);
> >>         }
> >>         pathname[len] = 0;
> >> -       rmdir(pathname);
> >
> > After moving the rmdir() away from prune_dir(), the truncation of the
> > pathname does not logically belong here anymore. It should be moved 
with
> > the rmdir(). Looks good otherwise.
> 
> I agree that it is better to have the NUL termination close to where
> it actually matters.
> 

The pathname is extended in prune_dir, so I think it should be reset there
as well; moving it to prune_packed_objects would be quite obscure:

d = opendir(pathname);
prune_dir(d, pathname);
pathname[len] = 0;
rmdir(pathname);


OT: While looking at the code I just stumbled across this immediately
above the patch (prune-packed.c line 32ff):

                memcpy(pathname + len, de->d_name, 38);
                if (opts & DRY_RUN)
                        printf("rm -f %s\n", pathname);
                else
                        unlink_or_warn(pathname);

Shouldn't this be memcpy(..., 39) (i.e. including '\0')?

> Do you want me to take it after locally fixing it up, or do you
> prefer to feed this as part of msysgit related updates to me later?

The msysgit queue is quite long, and I think it makes sense to fast-track 
this one.
