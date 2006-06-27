From: fork0@t-online.de (Alex Riesen)
Subject: Re: CFT: merge-recursive in C
Date: Tue, 27 Jun 2006 02:17:32 +0200
Message-ID: <20060627001732.GC3121@steel.home>
References: <20060626233838.GA3121@steel.home> <Pine.LNX.4.64.0606261652350.3927@g5.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 02:17:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv1HB-0003K8-2H
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 02:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWF0ARw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 20:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWF0ARw
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 20:17:52 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:65246 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030240AbWF0ARv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 20:17:51 -0400
Received: from fwd29.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1Fv1Gv-0004A1-01; Tue, 27 Jun 2006 02:17:41 +0200
Received: from tigra.home (VrPBF-ZcgeCsd7pr9w4IxjdWePswOixLZo9et6FQctoMwfvXIlNu0K@[84.160.112.192]) by fwd29.sul.t-online.de
	with esmtp id 1Fv1Gn-1gibke0; Tue, 27 Jun 2006 02:17:33 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 28888277B5;
	Tue, 27 Jun 2006 02:17:33 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Fv1Gm-0000z9-Vl; Tue, 27 Jun 2006 02:17:32 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606261652350.3927@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-ID: VrPBF-ZcgeCsd7pr9w4IxjdWePswOixLZo9et6FQctoMwfvXIlNu0K
X-TOI-MSGID: 31feed44-f218-43e6-ab37-04ed78a051e9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22700>

Linus Torvalds, Tue, Jun 27, 2006 01:54:18 +0200:
> > 
> > To my deep disappointment, it didn't work out as good as I hoped: one
> > program I see most often and for longest time in the process list
> > (git-diff-tree) is a too complex thing to be put directly into
> > merge-recursive.c, so any help in this direction will be greatly
> > appreciated.
> 
> Are you sure?
> 
> git-diff-tree is one of the simplest git operations. We've got absolutely 
> _tons_ of infrastructure in place to do it efficiently, since it's done 
> all over the map (a "git-rev-list" with path limiting will do a diff-tree 
> against all the commits).
> 
> Some of the interfaces might be a bit non-obvious, but the diff stuff was 
> some of the first ones to be libified exactly because they end up being so 
> fundamental.
> 

That (non-obvious) was actually the problem here. I needed a diff-tree
without any output on stdout, with "-M" (rename detection). The
precise command I gave up to implement was:

  git-diff-tree -M --diff-filter=R -r -z <tree1> <tree2>

I stopped somewhere around diff_tree, being confused by show_entry.
I took a look at it again, and it seem that show_entry does not
actually "show" anything but calls diff_options->add_remove, right?
So I could define my callback, setup the options (which I certanly can
find after looking closer and longer at builtin-diff-tree.c) and wrap
diff_options with my own struct (I need to pass arguments to the
callback reentrantly: it is a recursive algorithm).

Well, it wasn't that clear (unless I missed something by a mile) last
week... But thanks for you suspicions, they actually forced me to look
at diff-tree again. Will do ... unless (I hope) someone beats me to it.

Bye!
