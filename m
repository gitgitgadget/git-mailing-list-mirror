From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Allow PERL_PATH="/usr/bin/env perl"
Date: Thu, 3 May 2007 17:26:18 -0400
Message-ID: <20070503212618.GC16538@spearce.org>
References: <463A472D.5000007@larsen.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Bryan Larsen <bryan@larsen.st>
X-From: git-owner@vger.kernel.org Thu May 03 23:26:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjioq-0006fq-My
	for gcvg-git@gmane.org; Thu, 03 May 2007 23:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767419AbXECV0Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 17:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767430AbXECV0Z
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 17:26:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41067 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767419AbXECV0W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 17:26:22 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HjioW-0006B6-4G; Thu, 03 May 2007 17:26:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 026DC20FBAE; Thu,  3 May 2007 17:26:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <463A472D.5000007@larsen.st>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46109>

Bryan Larsen <bryan@larsen.st> wrote:
> The perl scripts start with "#!/usr/bin/perl".  There is a mechanism 
> PERL_PATH in the Makefile to change this, but it currently doesn't work 
> with PERL_PATH="/usr/bin/env perl".  This is causing problems in 
> MacPorts, where we wish to work with the MacPorts perl if it is 
> installed, but fall back to the system perl if it isn't.
> 
> Signed-off-by: Bryan Larsen <bryan@larsen.st>
> ---
>  perl/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/perl/Makefile b/perl/Makefile
> index 17d004e..2832cb4 100644
> --- a/perl/Makefile
> +++ b/perl/Makefile
> @@ -33,7 +33,7 @@ $(makfile): ../GIT-CFLAGS Makefile
>         echo '  echo $(instdir_SQ)' >> $@
>  else
>  $(makfile): Makefile.PL ../GIT-CFLAGS
> -       '$(PERL_PATH_SQ)' $< PREFIX='$(prefix_SQ)'
> +       $(PERL_PATH_SQ) $< PREFIX='$(prefix_SQ)'
>  endif

This will break if someone actually had ' in their PERL_PATH:

	PERL_PATH="/path'to'perl"

as PERL_PATH_SQ tries to close the single quoted string you don't
open anymore.  That is because it is defined to be PERL_PATH,
but with all ' replaced by '\''.

This change also breaks for anyone who had spaces in their PERL_PATH.

Can I ask why you can't just supply a small wrapper shellscript
with MacPorts

	cat >perl <<EOF
	#!/bin/sh
	exec env perl "$@"
	EOF
	chmod a+x perl

?  Or better yet, supply Git the correct Perl path?  If/when we ever
go to native Perl libraries again a Git Perl library compiled for
the system perl may not work later when the user installs a newer
MacPorts perl.  Switching automatically to the MacPorts perl without
recompiling the native extensions is a little evil...

-- 
Shawn.
