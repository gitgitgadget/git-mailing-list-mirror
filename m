From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Sat, 30 Apr 2005 13:04:10 +0200
Message-ID: <20050430110410.GA25322@lsrfire.ath.cx>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org> <20050429172235.21c1af10.pj@sgi.com> <Pine.LNX.4.58.0504291956030.2296@ppc970.osdl.org> <20050429232922.03057aba.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Sat Apr 30 12:58:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRpg6-0003M6-LS
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 12:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVD3LEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 07:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVD3LEQ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 07:04:16 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:12449 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261192AbVD3LEL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 07:04:11 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 26FCA37B; Sat, 30 Apr 2005 13:04:10 +0200 (CEST)
To: Paul Jackson <pj@sgi.com>, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050429232922.03057aba.pj@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 11:29:22PM -0700, Paul Jackson wrote:
> Linus replied to pj:
> > > Code Sample 2:
> > > ...
> > Didn't change anything for me. Same thing.
> 
> I don't believe you did what I did.
> 
> The source code for bash, both 2.x and 3.x versions, clearly displays a
> simpler error message (no line number or redisplay of your script
> commands) in the case that you set a trap.  And I tested both shells on
> a multiprocessor, to verify that they behaved as I expected, running
> these silly little scripts.

I don't have a multiprocessor and I see the same.  Are you sure it's SMP
dependant?

Your solution (trapping _inside_ the job, too) works for me, btw.  Here's
a patch for cg-log that reduces the clutter to two "Broken pipe" lines
(pun not intended).

Rene


--- cg-log~	2005-04-29 23:43:09.000000000 +0200
+++ cg-log	2005-04-30 12:15:40.000000000 +0200
@@ -16,6 +16,7 @@
 # or id1:id2 representing an (id1;id2] range of commits to show.
 
 . cg-Xlib
+trap exit SIGPIPE
 
 if [ "$1" = "-c" ]; then
 	shift
@@ -47,6 +48,7 @@
 fi
 
 $revls | $revsort | while read time commit parents; do
+	trap exit SIGPIPE
 	[ "$revfmt" = "rev-list" ] && commit="$time"
 	echo $colheader""commit ${commit%:*} $coldefault;
 	cat-file commit $commit | \
