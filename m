From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-mv work in subdirectories, too
Date: Fri, 25 Nov 2005 18:45:52 -0800
Message-ID: <7vmzjsdt3z.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511251236060.30796@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 03:47:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efq4j-0007HX-E8
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 03:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVKZCpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 21:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVKZCpz
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 21:45:55 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7629 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932172AbVKZCpy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 21:45:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126024555.XSOS25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 25 Nov 2005 21:45:55 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511251236060.30796@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 25 Nov 2005 12:36:35 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12763>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Turns out, all git programs git-mv uses are capable of operating in
> a subdirectory just fine. So don't complain about it.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> ---
>
> 	I am no Perl guru, so this might not be the best way to go
> 	about it. Also, if people agree, I would like to remove the
> 	extra check for GIT_DIR validity, since git-rev-parse --git-dir
> 	does that already.

I think that sounds sane.  You need to grab the exit status from
`git-rev-parse --git-dir`, so the patch would become something
like the attached.  I haven't seriously used git-mv myself, so
somebody needs to test it, and if it actually works and Ack on
it, please.

---

diff --git a/git-mv.perl b/git-mv.perl
index bf54c38..6dda333 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -33,15 +33,9 @@ EOT
 	exit(1);
 }
 
-# Sanity checks:
-my $GIT_DIR = $ENV{'GIT_DIR'} || ".git";
-
-unless ( -d $GIT_DIR && -d $GIT_DIR . "/objects" && 
-	-d $GIT_DIR . "/objects/" && -d $GIT_DIR . "/refs") {
-    print "Git repository not found.";
-    usage();
-}
-
+my $GIT_DIR = `git rev-parse --git-dir`;
+exit 1 if $?; # rev-parse would have given "not a git dir" message.
+chomp($GIT_DIR);
 
 our ($opt_n, $opt_f, $opt_h, $opt_k, $opt_v);
 getopts("hnfkv") || usage;
