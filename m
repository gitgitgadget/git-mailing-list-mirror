From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make the exit code of add_file_to_index actually useful
Date: Mon, 12 May 2008 22:54:14 +0200
Message-ID: <20080512205414.GH3128@steel.home>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <alpine.LSU.1.00.0803021555500.22527@racer.site> <7vtzjpoye6.fsf@gitster.siamese.dyndns.org> <20080512175654.GB3128@steel.home> <7vzlqvxt1p.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 22:55:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvf38-0006M7-4g
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbYELUyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbYELUyU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:54:20 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:11771 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbYELUyT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:54:19 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+BInc
Received: from tigra.home (Fab5c.f.strato-dslnet.de [195.4.171.92])
	by post.webmailer.de (mrclete mo4) (RZmta 16.34)
	with ESMTP id h01165k4CHwrjo ; Mon, 12 May 2008 22:54:15 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6CECF277BD;
	Mon, 12 May 2008 22:54:15 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1220456D28; Mon, 12 May 2008 22:54:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vzlqvxt1p.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81948>

Junio C Hamano, Mon, May 12, 2008 20:42:58 +0200:
> >
> > I corrected the series to use die() again and rebased it off current
> > master (65ea3b8c). So it is more compatible with libification (does
> > not hinder it more than previos code) and keep the exit code.
> 
> But you did not answer my question in the part you did not quote, did you?

I believe I did:

Date:	Sun, 2 Mar 2008 22:42:41 +0100
Subject: Re: [PATCH] Make the exit code of add_file_to_index actually useful
Message-ID: <20080302214241.GB13954@steel.home>

Junio C Hamano, Sun, Mar 02, 2008 17:59:13 +0100:
> Why is this even needed to begin with?  I am aware of Dirk's original
> issue discussed elsewhere, but we try fairly hard to be A-O-N when we can
> afford to, and this option deliberately breaks it.  What is the real
> reason why such an unreadable (either for privilege or for I/O error)
> file should not live in .gitignore?

Another program keeps the file open. There is an exclusive mode for
opening files, which locks the files for everyone. I believe it is
even default mode, unless selected otherwise.

> Now when somebody either forgets to check the return value from this
> function, or deliberately ignores it, the resulting index will not match
> what the code is told to update it with.

I think I got them all in the current code:

    $git grep -E 'add_(file_)?to_(index|cache)'
    Documentation/technical/api-in-core-index.txt:* add_file_to_index()
    builtin-add.c:                  if (add_file_to_cache(path, data->flags
    builtin-add.c:          if (add_file_to_cache(dir.entries[i]->name, ver
    builtin-commit.c:                       if (add_to_cache(p->path, &st,
    builtin-mv.c:                   if (add_file_to_cache(path, verbose))
    cache.h:#define add_to_cache(path, st, verbose) add_to_index(&the_index
    cache.h:#define add_file_to_cache(path, verbose) add_file_to_index(&the
    cache.h:extern int add_to_index(struct index_state *, const char *path,
    cache.h:extern int add_file_to_index(struct index_state *, const char *
    read-cache.c:int add_to_index(struct index_state *istate, const char *p
    read-cache.c:int add_file_to_index(struct index_state *istate, const ch
    read-cache.c:   return add_to_index(istate, path, &st, verbose);

Regarding the return value: isn't it very often a bug to ignore them?
Or do you mean to say I should have renamed the function so that old
interface cannot be used accidentally by someone how just knows it
never returns in case of an error?
