From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments on recursive merge..
Date: Tue, 8 Nov 2005 17:22:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511081716450.3247@g5.osdl.org>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
 <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051108210211.GA23265@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
 <20051108223609.GA4805@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
 <20051109003236.GA30496@pasky.or.cz> <Pine.LNX.4.64.0511081646160.3247@g5.osdl.org>
 <7vlkzyd4aq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:23:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZefP-0007mA-Mi
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 02:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbVKIBWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 20:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030495AbVKIBWW
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 20:22:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38083 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030491AbVKIBWV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 20:22:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA91MGnO005184
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 8 Nov 2005 17:22:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA91MF6Q032480;
	Tue, 8 Nov 2005 17:22:15 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkzyd4aq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11379>



On Tue, 8 Nov 2005, Junio C Hamano wrote:
> 
> I did show-branch soon after we worked on those pathlogical
> merge-base fix, so I would be a bit surprised if I did it
> without using all the knowledge from that exercise, but I do not
> remember offhand.  The core logic should be simple
> generalization of two-head merge-base to N heads.

Hmm.

Look at the "join_revs()" logic, and tell me I'm crazy.

It does:

	struct commit *commit = pop_one_commit(list_p);
	int still_interesting = !!interesting(*list_p);

in that order: it looks whether there are any interesting commits left 
_after_ it has popped the top-of-stack.

Which means that "still_interesting" can go down to zero if we just popped 
the last interesting thing off the stack.

Which seems wrong, because the thing we just popped off the stack could 
easily itself be interesting (in fact, it should be so, 99% of the time), 
and can cause other interesting commits to be populated back onto the 
list. So the "still_interesting" flag seems to be wrongly computed: the 
way it is computed now, it's meaningless.

In contrast, the "merge_base()" thing does

	while (interesting(list)) {
		..
	}

which means that we really will walk the list until there is nothing 
interesting left. Which is admittedly expensive, but it was how we got rid 
of the pathological case.

But maybe I'm just missing something really subtle. Maybe git-show-branch 
does some really clever optimization that is valid.

		Linus
