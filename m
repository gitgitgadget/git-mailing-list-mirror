From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow fetching references from any namespace
Date: Sat, 12 May 2007 09:40:49 +0200
Message-ID: <20070512074049.GA2410@steel.home>
References: <20070511203522.GA2741@steel.home> <7vlkfv9j3c.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 09:41:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmmDr-0002MA-89
	for gcvg-git@gmane.org; Sat, 12 May 2007 09:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931AbXELHky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 03:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755547AbXELHky
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 03:40:54 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:18266 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbXELHkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 03:40:53 -0400
Received: from tigra.home (Fca9f.f.strato-dslnet.de [195.4.202.159])
	by post.webmailer.de (mrclete mo7) (RZmta 6.1)
	with ESMTP id R04a2ej4C6SIwI ; Sat, 12 May 2007 09:40:49 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BE8F2277BD;
	Sat, 12 May 2007 09:40:49 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4F906D171; Sat, 12 May 2007 09:40:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vlkfv9j3c.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTvzl3c=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47026>

Junio C Hamano, Fri, May 11, 2007 22:54:47 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > not only from the three defined: heads, tags and remotes.
> >
> > Noticed when I tried to fetch the references created by git-p4-import.bat:
> > they are placed into separate namespace (refs/p4import/, to avoid showing
> > them in git-branch output). As canon_refs_list_for_fetch always prepended
> > refs/heads/ it was impossible, and annoying: it worked before. Normally,
> > the p4import references are useless anywhere but in the directory managed
> > by perforce, but in this special case the cloned directory was supposed
> > to be a backup, including the p4import branch: it keeps information about
> > where the imported perforce state came from.
> 
> Have no objection to the patch itself, but mind pointing out
> where we broke it (I suspect it is around 1.5.0)?
> 

Maybe even much earlier. According to

    git log -p --decorate -- git-fetch-script git-parse-remote-script

    commit ac4b0cff00b7629657e61a1d6e1f1a1250d03198
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Sat Aug 20 02:52:24 2005 -0700

	[PATCH] Start adding the $GIT_DIR/remotes/ support.

    +canon_refs_list_for_fetch () {
    +       for ref
    +       do
    +               expr "$ref" : '.*:' >/dev/null || ref="${ref}:"
    +               remote=$(expr "$ref" : '\([^:]*\):')
    +               local=$(expr "$ref" : '[^:]*:\(.*\)')
    +               case "$remote" in
    +               '') remote=HEAD ;;
    +               *) remote="refs/heads/$remote" ;;
    +               esac
    +               case "$local" in
    +               '') local= ;;
    +               *) local="refs/heads/$local" ;;
    +               esac
    +               echo "${remote}:${local}"
    +       done
    +}

it was this way since at least Aug 2005.
