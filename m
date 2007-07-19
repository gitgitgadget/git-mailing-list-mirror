From: Eric Wong <eric@petta-tech.com>
Subject: Re: [PATCH] Proposal for git-svn
Date: Wed, 18 Jul 2007 21:22:55 -0700
Message-ID: <20070719042255.GA17433@muzzle>
References: <FAFA899D-EC45-4313-98ED-2D0A3FF37669@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Jul 19 06:23:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBNXl-0000Pe-ES
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 06:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbXGSEW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 00:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbXGSEW5
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 00:22:57 -0400
Received: from hand.yhbt.net ([66.150.188.102]:45191 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbXGSEW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 00:22:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id DF52A2DC08D;
	Wed, 18 Jul 2007 21:22:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <FAFA899D-EC45-4313-98ED-2D0A3FF37669@lrde.epita.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52932>

Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
> Hello,
> 
> I'm importing many SVN repositories in Git and I ran across a problem:
> ufloat.h has mode 120000but is not a link
> 
> I've read the code and checked-out the revision where the problem  
> occured and it turns out that some stupid user commited a broken  
> symlink and I think that's where the problem came from.  I'm  
> proposing the following trivial change to let git-svn clone continue  
> its work:
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 01c3904..a82baf4 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2555,8 +2555,8 @@ sub close_file {
>                 sysseek($fh, 0, 0) or croak $!;
>                 if ($fb->{mode_b} == 120000) {
>                         sysread($fh, my $buf, 5) == 5 or croak $!;
> -                       $buf eq 'link ' or die "$path has mode 120000",
> -                                              "but is not a link\n";
> +                       $buf eq 'link ' or warn "$path has mode 120000",
> +                                              " but is not a link\n";
>                 }
>                 defined(my $pid = open my $out,'-|') or die "Can't  
> fork: $!\n";
>                 if (!$pid) {
> 
> (I also added a whitespace because "120000but" does not look good :D)
> I checked out the problematic revision in git and I see the broken  
> symlink just like in SVN so I assume this change is correct.

Very strange.  Since $buf didn't have the string "link " in it, did it
have a path name in it?  If so, the sysread() would've advanced the $fh
offset by 5 bytes; causing an even more broken symlink to be added by git.

Would the following be more correct?

--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2552,9 +2552,15 @@ sub close_file {
 		}
 		sysseek($fh, 0, 0) or croak $!;
 		if ($fb->{mode_b} == 120000) {
-			sysread($fh, my $buf, 5) == 5 or croak $!;
-			$buf eq 'link ' or die "$path has mode 120000",
-			                       "but is not a link\n";
+			eval {
+				sysread($fh, my $buf, 5) == 5 or croak $!;
+				$buf eq 'link ' or die "$path has mode 120000",
+						       " but is not a link";
+			};
+			if ($@) {
+				warn "$@\n";
+				sysseek($fh, 0, 0) or croak $!;
+			}
 		}
 		defined(my $pid = open my $out,'-|') or die "Can't fork: $!\n";
 		if (!$pid) {

-- 
Eric Wong
