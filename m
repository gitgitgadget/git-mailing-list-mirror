From: Marcin Owsiany <marcin@owsiany.pl>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Mon, 25 Jun 2012 08:41:25 +0100
Message-ID: <20120625074125.GM3125@beczulka>
References: <20120624220835.GA4762@beczulka>
 <20120625041659.GA5785@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jun 25 10:05:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj4Ij-0004r6-Uo
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 10:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab2FYIF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 04:05:26 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:58955 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab2FYIFW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 04:05:22 -0400
Received: by wgbds11 with SMTP id ds11so2448885wgb.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 01:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=/4tEQ1UI+R0dDJc9m1hrH1MBeWkA5YN/pZDMBr4WzTc=;
        b=iPcb9wtKSRd9wTGPVFGSQl1LiJ08IA7o5w8QN/ZcenotWsW9a1ncK15ZueesuVzSUd
         VhnyjqJBi15FoIZ8NguuOi09/LqBKOPNZ0M27vYz5KvKKfJ1BrmCTGva7/hz4GUExNYb
         gWClundyij4UWvz2EeQb4dy1giGmP/bs3py5HPFDbEC6JkGxv++dannFMR5K2DaGLaSW
         4jz//Hp2Uc6b3+MLy1ojmcvXXeg1oJtm1EPDXSJHJ1xH+/UDx1d8BL4mUZPJGg0BjcZp
         5k6tW+IdtwxkIhW3PVCp2d64qE3KwrTgGP8IEWaqEnQKD1Z+Qzr3D+NF3N8h69mv6+fE
         4bcA==
Received: by 10.216.211.131 with SMTP id w3mr5613906weo.163.1340611520187;
        Mon, 25 Jun 2012 01:05:20 -0700 (PDT)
Received: from beczulka (dhcp-172-26-143-156.dub.corp.google.com [172.26.143.156])
        by mx.google.com with ESMTPS id bc2sm31482141wib.0.2012.06.25.01.05.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 01:05:19 -0700 (PDT)
Received: from mowsiany by beczulka with local (Exim 4.71)
	(envelope-from <marcin@owsiany.pl>)
	id 1Sj3vJ-0006Lt-CC; Mon, 25 Jun 2012 08:41:25 +0100
Content-Disposition: inline
In-Reply-To: <20120625041659.GA5785@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQlixr/Luv3EeV0liyuyORBXn95TLVqHSVawkNfAUrsqK4v6iuQXo5/VaMFPqksqYBw+UFKm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200560>

On Mon, Jun 25, 2012 at 04:16:59AM +0000, Eric Wong wrote:
> Marcin Owsiany <marcin@owsiany.pl> wrote:
> > git-svn insists on creating the "master" head (unless it exists) on every
> > "fetch". While it is useful that it gets created initially (users expect this
> > git convention), some users find it annoying that it gets recreated, especially
> > when they would like the git branch names to follow SVN repository branch
> > names. More background in
> > http://thread.gmane.org/gmane.comp.version-control.git/115030
> > 
> > Make git-svn skip the "master" creation if there is another head ref pointing
> > to the same place. This means "master" does get created on initial "clone" but
> > does not get recreated once a user deletes it.
> 
> Sounds reasonable to me.  Thanks for following up on this after all this
> time :)

My TODO list is really long, and there is so little time :-)

> > Signed-off-by: Marcin Owsiany <marcin@owsiany.pl>
> > ---
> >  git-svn.perl |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 0b074c4..90f3d06 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1613,6 +1613,8 @@ sub post_fetch_checkout {
> >  	}
> >  
> >  	my $valid_head = verify_ref('HEAD^0');
> > +	my @heads_commits = eval { command(qw(show-ref --heads --hash)) };
> > +	return if $valid_head and grep { $_ eq $valid_head } @heads_commits;
> 
> I (and I believe most git hackers) prefer C-style "&&" for boolean
> expressions:
> 
> 	return if $valid_head && grep { $_ eq $valid_head } @heads_commits;
> 
> "and" is lower precedence and best reserved for control flow:
> 
> 	-f $file and print "File: $file exists!\n";
> 
> There's no logical difference in this case, but "&&" is probably easier for
> C programmers to read.
> 
> I'll just swap "and" for "&&" and push unless there's any objection from
> you.

Sounds fine.

-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 2048R/02F946FC  35E9 1344 9F77 5F43 13DD  6423 DBF4 80C6 02F9 46FC

"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
