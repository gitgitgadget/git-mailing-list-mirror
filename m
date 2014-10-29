From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Regression and failure to clone/fetch with new code Re: git-svn
 performance
Date: Wed, 29 Oct 2014 19:23:52 +0000
Message-ID: <20141029192352.GA32032@dcvr.yhbt.net>
References: <1414474807.30075.YahooMailBasic@web172303.mail.ir2.yahoo.com>
 <1414539214.3654.YahooMailBasic@web172306.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 20:23:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjYqc-0008WI-ND
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 20:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbaJ2TXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 15:23:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48621 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbaJ2TXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 15:23:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id AAD3E1F7C9;
	Wed, 29 Oct 2014 19:23:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414539214.3654.YahooMailBasic@web172306.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> Hi, I patched my system git with the recent git-svn improvements, and just use
> it for general use; so theses are the patches, against 2.1.0.
> 
> 0001-git-svn-only-look-at-the-new-parts-of-svn-mergeinfo.patch
> 0002-git-svn-only-look-at-the-root-path-for-svn-mergeinfo.patch
> 0003-git-svn-reduce-check_cherry_pick-cache-overhead.patch
> 0004-git-svn-cache-only-mergeinfo-revisions.patch
> 0005-git-svn-remove-mergeinfo-rev-caching.patch
> 0006-git-svn.txt-advertise-pushurl-with-dcommit.patch
> 0007-git-svn-reload-RA-every-log-window-size.patch
> 0008-git-svn-remove-unnecessary-DESTROY-override.patch
> 0009-git-svn-save-a-little-memory-as-fetch-progresses.patch
> 0010-git-svn-disable-_rev_list-memoization.patch
> 
> trying to do this:
> git svn clone http://www.virtualbox.org/svn/vbox/trunk vbox
> 
> (there is no publicly visible branches, so it is just a straight-forward single-branch clone).
> 
> aborts with 
> 
> ---------------
> 	M	src/VBox/Main/HostImpl.cpp
> Incorrect parameters given: Could not convert '%ld' into a number at /usr/share/perl5/vendor_perl/Git/SVN.pm line 1711.
> 
> $ git svn fetch --all
> Index mismatch: d6c75bc195b1daad647322e2cc025bd31265c6b9 != 3927d05f6ab037fcf2b4d964c9633efade037d1b
> rereading a65b5fc0077c2fa80a344833b65ac19ff4ae88b6
> 	M	src/VBox/Main/HostImpl.cpp
> Incorrect parameters given: Could not convert '%ld' into a number at /usr/share/perl5/vendor_perl/Git/SVN.pm line 1711.
> ----------------
> 
> I have never seen such behavior before, and seeing as the lines indicated are in
> a routine called "mergeinfo_changes", and recently added/changed by
> quite a few of the patches, I started reverting from the back in this order: #5, #4, #2, #1 
> and tried again between each revert. And it finally allows me to fetch again after
> reverting #1.

Me neither, this is new bug to me.  I cannot reproduce it, either.  Which
revision did you hit this on?  I completed your vbox trunk clone without
any problems on my side (Debian i386, SVN 1.6.17).

Can you try the following to dump out the parameters passed to
mergeinfo_changes?

--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1695,8 +1695,10 @@ sub parents_exclude {
 }
 
 # Compute what's new in svn:mergeinfo.
+use Data::Dumper;
 sub mergeinfo_changes {
 	my ($self, $old_path, $old_rev, $path, $rev, $mergeinfo_prop) = @_;
+	print STDERR Dumper(\@_);
 	my %minfo = map {split ":", $_ } split "\n", $mergeinfo_prop;
 	my $old_minfo = {};
 

Btw, I missed part of your other email, but no, I never maintained any
Chinese packages in Debian.

> I don't see any %ld close by, but presumably this is enough information for somebody else
> to try. The platform is linux x86_64. (mostly fedora 20 but with a lot of additional
> changes like a newer gnome than shipped, etc so probably not really fc20) 
> 
