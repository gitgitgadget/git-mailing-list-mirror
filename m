From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] disable post-checkout test on Cygwin
Date: Tue, 17 Mar 2009 21:28:18 +0100
Message-ID: <20090317202818.GA13458@blimp.localdomain>
References: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com> <7vprggqeh2.fsf@gitster.siamese.dyndns.org> <49BFD6DD.1010800@viscovery.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	layer <layer@known.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 17 21:30:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljfvc-0002s9-93
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 21:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbZCQU2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 16:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbZCQU2e
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 16:28:34 -0400
Received: from mout2.freenet.de ([195.4.92.92]:45579 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbZCQU2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 16:28:33 -0400
Received: from [195.4.92.21] (helo=11.mx.freenet.de)
	by mout2.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #76)
	id 1Ljfth-0002mn-3f; Tue, 17 Mar 2009 21:28:25 +0100
Received: from x6d6d.x.pppool.de ([89.59.109.109]:42997 helo=tigra.home)
	by 11.mx.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 587) (Exim 4.69 #76)
	id 1Ljftg-0002LL-IV; Tue, 17 Mar 2009 21:28:25 +0100
Received: from blimp.localdomain (blimp.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 954A4277D8;
	Tue, 17 Mar 2009 21:28:18 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 506BA36D27; Tue, 17 Mar 2009 21:28:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49BFD6DD.1010800@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113522>

Johannes Sixt, Tue, Mar 17, 2009 17:59:09 +0100:
> Junio C Hamano schrieb:
> > Alex Riesen <raa.lkml@gmail.com> writes:
> > 
> >> It is broken because of the tricks we have to play with
> >> lstat to get the bearable perfomance out of the call.
> >> Sadly, it disables access to Cygwin's executable attribute,
> >> which Windows filesystems do not have at all.
> > 
> > Hmm, perhaps when checking hooks to see if they are executable, Cygwin
> > port should avoid using the "tricks"?  Compared to paths inside the
> > worktree the number of hooks is a lot smaller, no?
> 
> Hmm. Nowadays, we run hooks through run_hook() in run_command.c. It uses

The problem is that copy_templates_1 does an lstat on the files in
templates directory and gets 0666 mode (regular file, non-exec) for
executable file under current Cygwin port. The st_mode of that lstat
is passed to copy_file mentioned, which is useless now as we use the
Win32 version of lstat, which doesn't do x-bit.

> access(..., X_OK), not lstat(). We don't play games with access(), do we?
> 

access(..., X_OK) will return -1.
