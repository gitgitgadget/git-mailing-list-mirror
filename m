From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] gitweb: speed up project listing on large work trees by limiting find depth
Date: Wed, 17 Oct 2007 00:27:24 -0400
Message-ID: <20071017042724.GU13801@spearce.org>
References: <1192592725-28143-1-git-send-email-git@vicaya.com> <20071017040028.GT13801@spearce.org> <6B74E96C-37ED-4D6A-8A98-C90B61EFA181@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pasky@suse.cz
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 06:27:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii0VR-0007W5-LG
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 06:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbXJQE13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 00:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbXJQE12
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 00:27:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55845 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbXJQE12 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 00:27:28 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ii0VC-0003VE-OT; Wed, 17 Oct 2007 00:27:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BBB3820FBAE; Wed, 17 Oct 2007 00:27:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <6B74E96C-37ED-4D6A-8A98-C90B61EFA181@vicaya.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61329>

Luke Lu <git@vicaya.com> wrote:
> On Oct 16, 2007, at 9:00 PM, Shawn O. Pearce wrote:
> >
> >Thanks.  I'm squashing this into your patch.  I'm not sure what
> >the impact is of altering $File::Find::name in the middle of the
> >find algorithm and I'm not sure we want to figure that out later.
> >We found out the hard way today that altering a non-local'd $_
> >in the function is what was causing the breakage.
> 
> This is generally a good advice. But tr!/!! doesn't alter the string  
> at all (OK, replicates it), unless you use the /d option. tr/stuff//  
> is an idiom to count stuff. Check perldoc perlop for details. I don't  
> think it's necessary.

Oh.  Yea, I see what you mean now.  So the bug was really that you
were matching on $_ not $File::Find::name.  But according to perldoc
File::Find $_ and $File::Find::name are the same when no_chdir =>
1 which your patch also sets.  So I'm really not seeing how the
updated version fixes the bug.
 
> >diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> >index 48e21da..9f47c3f 100755
> >--- a/gitweb/gitweb.perl
> >+++ b/gitweb/gitweb.perl
> >@@ -1525,7 +1525,8 @@ sub git_get_projects_list {
> > 				# only directories can be git repositories
> > 				return unless (-d $_);
> > 				# don't traverse too deep (Find is super 
> > 				slow on os x)
> >-				if (($File::Find::name =~ tr!/!!) - 
> >$pfxdepth >  $project_maxdepth) {
> >+				local $_ = $File::Find::name;
> >+				if (tr!/!! - $pfxdepth > $project_maxdepth) {
> > 					$File::Find::prune = 1;
> > 					return;
> > 				}

-- 
Shawn.
