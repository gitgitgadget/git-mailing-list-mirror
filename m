From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: git-svn: t9155 fails against subversion 1.7.0
Date: Thu, 10 Nov 2011 07:02:13 +0100
Message-ID: <op.v4pu1zcq0aolir@keputer>
References: <op.v4neh4q20aolir@keputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 10 07:02:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RONiV-0000Eb-0B
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 07:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754Ab1KJGCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 01:02:18 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56899 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab1KJGCR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 01:02:17 -0500
Received: by eye27 with SMTP id 27so2101481eye.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 22:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=wFQFJJIF24LVNBj/muazNj8wud146+NT2icU3jiJYkA=;
        b=qDCzr7PKcDCXoiJ2g6AVJayPH4qPuIwXchAaON4ZxPcmP+NF/5UMeHRSRdd6v077e4
         cPhEAKZfKgI65Gxp2vtpz9a1ozq5bFwkB2Q/qY9mgo3KKxuVf05SUyQpe4+PgDzzBCHF
         HQbo3QCQTqlAwcItirNRWlLfVRotmym83f+4s=
Received: by 10.14.15.86 with SMTP id e62mr227639eee.77.1320904935726;
        Wed, 09 Nov 2011 22:02:15 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id o4sm19623268eeb.0.2011.11.09.22.02.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 22:02:14 -0800 (PST)
In-Reply-To: <op.v4neh4q20aolir@keputer>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185188>

I missed $gmane/184644 in my search for this issue.


On Tue, 08 Nov 2011 23:09:30 +0100, Frans Klaver <fransklaver@gmail.com>  
wrote:

> For kicks I decided to run the tests and noticed that on master  
> t9155-git-svn-fetch-deleted-tag fails against svn 1.7.0. We hit an  
> assertion in subversion's dirent_uri.c, stating that we don't provide a  
> canonical url. I haven't tested against other subversion versions. I  
> dare assume that this issue doesn't arise on earlier versions. It  
> probably won't affect a lot of users right now, but it will in the  
> future.
>
> Here's some verbose test output:
> expecting success:
> 	git svn init --stdlayout "$svnrepo" git_project &&
> 	cd git_project &&
> 	git svn fetch &&
>
> 	git diff --exit-code mybranch:trunk/subdir/file tags/mytag:file &&
> 	git diff --exit-code master:subdir/file tags/mytag^:file
>
> Initialized empty Git repository in /home/frans/devsw/git/t/trash  
> directory.t9155-git-svn-fetch-deleted-tag/git_project/.git/
> svn: E235000: In file 'subversion/libsvn_subr/dirent_uri.c' line 2291:  
> assertion failed (svn_uri_is_canonical(url, pool))
> error: git-svn died of signal 6
> not ok - 2 fetch deleted tags from same revision with checksum error
>
> I've been trying to debug and got down to:
> Git::SVN::Ra::new(/home/frans/devsw/git/git-svn:5496):
> 5496:		my $self = SVN::Ra->new(url => escape_url($url), auth => $baton,
> 5497:		                      config => $config,
> 5498:				      pool => SVN::Pool->new,
> 5499:		                      auth_provider_callbacks => $callbacks);
> ...
> SVN::Ra::new(/usr/lib/perl5/vendor_perl/5.12.4/i686-linux/SVN/Ra.pm:529):
> 529:	    $self->{session} = SVN::_Ra::svn_ra_open($self->{url},  
> $callback, $self->{config} || {}, $pool);
>    DB<3> p $self->{url}
> file:///home/frans/devsw/git/t/trash  
> directory.t9155-git-svn-fetch-deleted-tag/svnrepo
>
> The url looks like that throughout the stack (as far as I've seen), so  
> if it is wrong, it is probably wrong at top-level. Hope someone with a  
> bit more experience knows how to deal with this.
>
> Thanks,
> Frans


-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
