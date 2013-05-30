From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] git-gui: fix file name handling with non-empty prefix
Date: Thu, 30 May 2013 16:55:02 +0100
Message-ID: <20130530155502.GE17475@serenity.lan>
References: <264998b2b2201b7d6ab9bfa8b5518f712b3a6a08.1367069056.git.john@keeping.me.uk>
 <20130427141839.GF472@serenity.lan>
 <518EF86D.3060207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 17:55:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui5CL-0005V9-JB
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 17:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757594Ab3E3PzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 11:55:17 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:37855 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757536Ab3E3PzO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 11:55:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id F1BB722F72;
	Thu, 30 May 2013 16:55:13 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8dJkLpKVpMQ9; Thu, 30 May 2013 16:55:12 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 3A61A230E0;
	Thu, 30 May 2013 16:55:04 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <518EF86D.3060207@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226016>

In the hope that the Pat Thoyts who just posted in another thread from a
GMail address is the same one that maintains git-gui, let's see if that
address works...

On Sat, May 11, 2013 at 10:03:25PM -0400, Andrew Wong wrote:
> Sorry for the late reply. I was able to reproduce the problem that you
> were describing a while ago. And your patch indeed fixes it. It's a much
> more elegant way of dealing with the "absolute vs relative" path problem
> that I was trying to fix.
> 
> Thanks!
> 
> As for Pat, I'm not sure wha'ts going on with his email address. It was
> working back in October, and his username still seems to be active over
> at SourceForge... let's see if this email reaches him.
> 
> Here's a link for his reference just in case he missed your original email:
> http://thread.gmane.org/gmane.comp.version-control.git/222646
> 
> 
> On 04/27/13 10:18, John Keeping wrote:
> > I got a bounce with "550 no such user" for Pat's email address when
> > sending this.  Does anyone have more up-to-date contact details?  Or is
> > it just SourceForge being broken?
> >
> > On Sat, Apr 27, 2013 at 02:24:16PM +0100, John Keeping wrote:
> >> Commit e3d06ca (git-gui: Detect full path when parsing arguments -
> >> 2012-10-02) fixed the handling of absolute paths passed to the browser
> >> and blame subcommands by checking whether the file exists without the
> >> prefix before prepending the prefix and checking again.  Since we have
> >> chdir'd to the top level of the working tree before doing this, this
> >> does not work if a file with the same name exists in a subdirectory and
> >> at the top level (for example Makefile in git.git's t/ directory).
> >>
> >> Instead of doing this, revert that patch and fix absolute path issue by
> >> using "file join" to prepend the prefix to the supplied path.  This will
> >> correctly handle absolute paths by skipping the prefix in that case.
> >>
> >> Signed-off-by: John Keeping <john@keeping.me.uk>
> >> ---
> >>  git-gui.sh | 14 +++-----------
> >>  1 file changed, 3 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/git-gui.sh b/git-gui.sh
> >> index e133331..a94ad7f 100755
> >> --- a/git-gui.sh
> >> +++ b/git-gui.sh
> >> @@ -3003,19 +3003,11 @@ blame {
> >>  	set jump_spec {}
> >>  	set is_path 0
> >>  	foreach a $argv {
> >> -		if {[file exists $a]} {
> >> -			if {$path ne {}} usage
> >> -			set path [normalize_relpath $a]
> >> -			break
> >> -		} elseif {[file exists $_prefix$a]} {
> >> -			if {$path ne {}} usage
> >> -			set path [normalize_relpath $_prefix$a]
> >> -			break
> >> -		}
> >> +		set p [file join $_prefix $a]
> >>  
> >> -		if {$is_path} {
> >> +		if {$is_path || [file exists $p]} {
> >>  			if {$path ne {}} usage
> >> -			set path [normalize_relpath $_prefix$a]
> >> +			set path [normalize_relpath $p]
> >>  			break
> >>  		} elseif {$a eq {--}} {
> >>  			if {$path ne {}} {
> >> -- 
> >> 1.8.3.rc0.149.g98a72f2.dirty
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
