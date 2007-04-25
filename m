From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix handle leak in write_tree
Date: Wed, 25 Apr 2007 22:59:30 +0200
Message-ID: <20070425205930.GF30061@steel.home>
References: <20070423194925.GA5163@steel.home> <7vps5u9wsk.fsf@assigned-by-dhcp.cox.net> <81b0412b0704240230x3a5b473k5da3d45d9c997c3b@mail.gmail.com> <7vps5u86bn.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 22:59:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgoaP-0000cm-1L
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 22:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbXDYU7d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 16:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422770AbXDYU7d
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 16:59:33 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:43982 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbXDYU7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 16:59:32 -0400
Received: from tigra.home (Fac4b.f.strato-dslnet.de [195.4.172.75])
	by post.webmailer.de (klopstock mo17) (RZmta 5.6)
	with ESMTP id E0744cj3PJXnfy ; Wed, 25 Apr 2007 22:59:30 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 716EE277BD;
	Wed, 25 Apr 2007 22:59:30 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 50CAFBDDE; Wed, 25 Apr 2007 22:59:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vps5u86bn.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFqtlg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45573>

Junio C Hamano, Tue, Apr 24, 2007 11:33:48 +0200:
> 
> > ... Isn't such kind of resource control _generally_ nicer to implement
> > in the top levels of a program?
> 
> In theory perhaps, but my understanding of our use of atexit()
> is to clean them up in situations beyond the control of the top
> levels of a program, most notably upon exit on signal.
> 

struct git_context;
/* or whatever is the latest name for the repo bookeeping is.
   It have to be passed to every git-related function anyway. */

struct lock_file *open_index_locked(struct git_context *, int die_on_error);
int commit_index_locked(struct git_context *, struct lock_file *);
... and so on.

Then let the top level call something like

    git_cleanup(struct git_context *);

in its _own_ signal or atexit handlers. If it didn't setup the
handlers, than perhaps it did want it so (leaving tempfiles behind is
sometimes done on purpose). Or it _is_ a bug, but then it is clear:
you have to cleanup, and you do git's part of cleanup with
git_cleanup.
