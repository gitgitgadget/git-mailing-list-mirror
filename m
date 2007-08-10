From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 09 Aug 2007 22:55:27 -0700
Message-ID: <7vy7gkue5s.fsf@assigned-by-dhcp.cox.net>
References: <20070809163026.GD568@mbox.bz>
	<alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
	<7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net>
	<7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
	<20070809165218.9b76ebf7.seanlkml@sympatico.ca>
	<alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
	<7vtzr8wemb.fsf@assigned-by-dhcp.cox.net>
	<7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708091734210.25146@woody.linux-foundation.org>
	<7vhcn8w6sw.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708091754150.25146@woody.linux-foundation.org>
	<7v643ovyli.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 07:55:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJNTB-0002Nv-Pu
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 07:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbXHJFza (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 01:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbXHJFza
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 01:55:30 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:58736 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbXHJFz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 01:55:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070810055528.CTWI1335.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 10 Aug 2007 01:55:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a5vT1X00B1kojtg0000000; Fri, 10 Aug 2007 01:55:28 -0400
In-Reply-To: <7v643ovyli.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 09 Aug 2007 20:48:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55507>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> (I didn't test it, though, maybe I missed something).
>
> I do not think the change affects the normal codepath.  The
> one-liner patch to git-commit.sh touches the codepath that
> updates the index used only to write out the partial commit, and
> losing the cached stat info from that index does not matter, as
> that index is removed immediately after writing the tree out and
> is never compared with working tree as far as I can tell.

FWIW, moe's script with and without two patches gives these
numbers for me.

      with patches                      without patches
----------------------------------------------------------------
# git init                          | # git init			       
Initialized empty Git repository in | Initialized empty Git repository in  
                                    | 				       
real    0m0.029s                    | real    0m0.004s		       
user    0m0.000s                    | user    0m0.000s		       
sys     0m0.008s                    | sys     0m0.004s		       
# git add .                         | # git add .			       
                                    | 				       
real    0m2.947s                    | real    0m3.038s		       
user    0m0.808s                    | user    0m0.876s		       
sys     0m2.120s                    | sys     0m1.996s		       
# git commit -a                     | # git commit -a		       
                                    | 				       
real    0m4.537s                    | real    0m4.674s		       
user    0m1.980s                    | user    0m1.888s		       
sys     0m2.356s                    | sys     0m2.332s		       
# git status (three times)          | # git status (three times)	       
# On branch master                  | # On branch master		       
nothing to commit (working directory| nothing to commit (working directory 
                                    | 				       
real    0m0.718s                    | real    0m17.323s		       
user    0m0.300s                    | user    0m16.913s		       
sys     0m0.416s                    | sys     0m0.396s		       
# On branch master                  | # On branch master		       
nothing to commit (working directory| nothing to commit (working directory 
                                    | 				       
real    0m0.707s                    | real    0m16.994s		       
user    0m0.312s                    | user    0m16.573s		       
sys     0m0.400s                    | sys     0m0.416s		       
# On branch master                  | # On branch master		       
nothing to commit (working directory| nothing to commit (working directory 
                                    | 				       
real    0m0.720s                    | real    0m18.042s		       
user    0m0.344s                    | user    0m17.633s		       
sys     0m0.376s                    | sys     0m0.408s		       
# git commit (one path)             | # git commit (one path)	       
Created commit 3483df5: expose the t| Created commit ced664f: expose the t 
 1 files changed, 1 insertions(+), 1|  1 files changed, 1 insertions(+), 1 
                                    | 				       
real    0m3.057s                    | real    0m38.130s		       
user    0m0.888s                    | user    0m37.458s		       
sys     0m0.712s                    | sys     0m0.616s                     
----------------------------------------------------------------
