From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-annotate efficiency
Date: Fri, 24 Feb 2006 14:42:31 -0500
Message-ID: <20060224194231.GA18691@mythryan2.michonline.com>
References: <118833cc0602240737i42acdc90sb8f93dde1a1bc035@mail.gmail.com> <118833cc0602241000p4e4c8017u3e3afe76fbbd75a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 20:43:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCiqj-0004u7-2J
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 20:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWBXTn3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 14:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWBXTn3
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 14:43:29 -0500
Received: from mail.autoweb.net ([198.172.237.26]:33705 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S932440AbWBXTn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 14:43:29 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FCiqd-0000sM-4e; Fri, 24 Feb 2006 14:43:28 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FCiqX-0005Az-My; Fri, 24 Feb 2006 14:43:21 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FCiq8-00061u-8J; Fri, 24 Feb 2006 14:42:56 -0500
To: Morten Welinder <mwelinder@gmail.com>
Content-Disposition: inline
In-Reply-To: <118833cc0602241000p4e4c8017u3e3afe76fbbd75a4@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16731>

On Fri, Feb 24, 2006 at 01:00:24PM -0500, Morten Welinder wrote:
> It looks like handle_rev is seeing the same revisions over and over again.
> I don't know why that would be, but the following patch just skips dups.
> I have no idea if it is right, though.

Merges.

a--b--c--d--f
   \-g--h--/

It would do f,d,c,b,a + f,h,g,b,a

So yes, this fix is correct, and Junio, I'll be doing some changes this
weekend and send it along with a few other things.

(On a medium-sized test tree at work with 3500 commits in the tree, 37
on the main Makefile (6 merges), this cuts the annotate time from 10s to a little
over 2, so it's, umm, very worthwhile.)

> 
> Morten
> 
> 
> diff --git a/git-annotate.perl b/git-annotate.perl
> index 3800c46..a5e2d86 100755
> --- a/git-annotate.perl
> +++ b/git-annotate.perl
> @@ -117,7 +117,10 @@ sub init_claim {
> 
>  sub handle_rev {
>         my $i = 0;
> +       my %seen = ();
>         while (my $rev = shift @revqueue) {
> +               next if $seen{$rev};
> +               $seen{$rev} = 1;
> 
>                 my %revinfo = git_commit_info($rev);
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Ryan Anderson
  sometimes Pug Majere
