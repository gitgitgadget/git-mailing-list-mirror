From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Fri, 14 Mar 2008 08:29:47 -0700 (PDT)
Message-ID: <m38x0lxr1k.fsf@localhost.localdomain>
References: <20080313231413.27966.3383.stgit@rover>
	<76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Petr Baudis" <pasky@suse.cz>, "Junio C Hamano" <junkio@cox.net>,
	git@vger.kernel.org
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 16:30:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaBrf-0003v7-QN
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 16:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbYCNP3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 11:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbYCNP3w
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 11:29:52 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:57172 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbYCNP3v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 11:29:51 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2410703rvb.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=ZqP2fav5vqofZqOMeKvd0iOPdtgYgc2rzQgrpnDC238=;
        b=gfHGaeMaElEz44hwHJhWzKFFbn7/bdNgAgpg4cqX2E3XAVzNVjYZB/BuXTbCur1Xa9PDaAC2jUyGuU0uTM9QjyWdZasd28673v41Dw149+tKYLFAopH3ZOFHG/RqpCQxZkHEMbwB0vhUVqGqH5fFGEw3GbeBkGd1w7bko5pFR98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=kkGkgO4zmdiQzASsEfYhpxDPf5+gECNmJ/VPxazT+Idm6IptbV414oEEl42CqrqVe5EZPegA60EMYT/uNpAA3M1LlnJEW8GKnReIfzBUTQPBs8JcUyOX3eum8PdW20d0sZKdum2AuFh2u86owXoT3VUXOpwkus43wwhqBl3SfWM=
Received: by 10.141.211.13 with SMTP id n13mr6607410rvq.12.1205508588312;
        Fri, 14 Mar 2008 08:29:48 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.191.199])
        by mx.google.com with ESMTPS id l20sm556040uga.62.2008.03.14.08.29.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 08:29:47 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2EFTTP5027419;
	Fri, 14 Mar 2008 16:29:29 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2EFTR7l027416;
	Fri, 14 Mar 2008 16:29:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77245>

"Jay Soffian" <jaysoffian@gmail.com> writes:

> On Thu, Mar 13, 2008 at 7:14 PM, Petr Baudis <pasky@suse.cz> wrote:
> 
> ...
> 
> >  +               if ($cache_lifetime and -f $cache_file) {
> >  +                       # Postpone timeout by two minutes so that we get
> >  +                       # enough time to do our job.
> >  +                       my $time = time() - $cache_lifetime + 120;
> >  +                       utime $time, $time, $cache_file;
> >  +               }
> 
> Race condition. I don't see any locking. Nothing keeps multiple
> instances from regenerating the cache concurrently...
> 
> >  +               @projects = git_get_projects_details($projlist, $check_forks);
> >  +               if ($cache_lifetime and open (my $fd, '>'.$cache_file)) {
> 
> ...and then clobbering each other here. You have two choices:
> 
> 1) Use a lock file for the critical section.
> 
> 2) Assume the race condition is rare enough, but you still need to
> account for it. In that case, you want to write to a temporary file
> and then rename to the cache file name. The rename is atomic, so
> though N instances of gitweb may regenerate the cache (at some
> CPU/IO overhead), at least the cache file won't get corrupted.

What should the code for this look like? Like below?

        use File::Temp;
        
        my ($fh, $temp_file) = tempfile();
        ...
        close $fh;
        rename $temp_file, $cache_file;


-- 
Jakub Narebski
Poland
ShadeHawk on #git
