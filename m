From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4/3] Fold get_merge_bases_clean() into get_merge_bases()
Date: Sun, 2 Jul 2006 09:43:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607020935460.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
 <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
 <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
 <20060702094938.GA10944@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 02 18:44:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx53S-00011x-SJ
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 18:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbWGBQoP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 12:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbWGBQoP
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 12:44:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932668AbWGBQoO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 12:44:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k62GhpnW015289
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Jul 2006 09:43:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k62GhjsN010847;
	Sun, 2 Jul 2006 09:43:48 -0700
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20060702094938.GA10944@lsrfire.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23106>



On Sun, 2 Jul 2006, Rene Scharfe wrote:
>
> Due to popular request ;-), change get_merge_bases() to be able to
> clean up after itself if needed by adding a cleanup parameter.

Btw, I think the symmetric thing is still wrong.

Try this:

	git rev-list ^HEAD~1 HEAD...HEAD~2

which _should_ return just HEAD ("HEAD...HEAD~2" should basically expand 
into "HEAD HEAD~2 ^HEAD~2")

I haven't actually tested your patch, but I think it returns HEAD and 
HEAD~1.

The reason? You clear UNINTERESTING as part of clear_commit_marks(), so 
HEAD~1, which was marked thus by the user, gets cleared of its mark as 
part of the get_merge_bases() invocation.

I suspect the only way to fix that is to make "get_merge_bases()" not use 
UNINTERESTING at all, but instead just explicitly use something like

	(obj.flags & (LEFT | RIGHT)) == (LEFT | RIGHT)

instead.

			Linus
