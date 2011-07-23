From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFC: Should git gc/repack respect .git/refs/replace?
Date: Sat, 23 Jul 2011 02:22:24 -0700 (PDT)
Message-ID: <m3ipqts671.fsf@localhost.localdomain>
References: <CAH3AnrqDbebODK-A90msoB9JXUwDHKKtQAQo5VdXZ=k8bxzkYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Jakub Narebski <jnareb@gmail.com> Christian Couder" 
	<chriscool@tuxfamily.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 11:22:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkYPn-0002tE-HK
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 11:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab1GWJW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 05:22:28 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:60957 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004Ab1GWJW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 05:22:26 -0400
Received: by fxd18 with SMTP id 18so6369506fxd.11
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=XRtj11bB0DhrucAq54KUhSBalA7sHLBowiHjtUrCPCE=;
        b=QCyL4Cej9LAih6gPjDQ2BKMvUlTRL4K/KWs276c0FYYusz7ccPJt2BsFzVSEAFHP9V
         lxPgqZmrs18thO5ldeYay3+W08fKG713/AkGBNGb0i/JLCsGKCvwuuJYTR79cbRL75GR
         ESO5OPzXeVNpKG97JhwacuOFJZaDzYYVzfMd4=
Received: by 10.223.43.1 with SMTP id u1mr3574291fae.38.1311412945288;
        Sat, 23 Jul 2011 02:22:25 -0700 (PDT)
Received: from localhost.localdomain (abvt94.neoplus.adsl.tpnet.pl [83.8.217.94])
        by mx.google.com with ESMTPS id a24sm2524122fak.12.2011.07.23.02.22.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 02:22:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6N9LnnD031043;
	Sat, 23 Jul 2011 11:22:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6N9LcTd031033;
	Sat, 23 Jul 2011 11:21:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAH3AnrqDbebODK-A90msoB9JXUwDHKKtQAQo5VdXZ=k8bxzkYQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177683>

Jon Seymour <jon.seymour@gmail.com> writes:

> I recently damaged a USB drive containing an archive of a finished project.
> 
> I am able to paper over a week of missing history by using the git
> replace mechanism, so that git rev-list now works as expected.
> 
> When I run git gc or git repack, I get the following:
> 
>    error: Could not read 023a1d5d3977420ba041cb556c0eee17c326aeb6
>    fatal: Failed to traverse parents of commit
> 44d578ea81f7a90989e2ee3c676f50e3aff7071f
> 
> where 0bbded9a764d9f4c8dc27b778f70d044df65f65f is one of the missing
> commits I replaced with:
> 
>    git replace 023a1d5d3977420ba041cb556c0eee17c326aeb6
> 238d237db9137b4eaf96f1d554bf2668729b9b93
> 
> Is this expected behaviour? I had assumed that git repack would
> respect the topology implied by git replace.

This is the expected behavior. 

Replace mechanism is meant to be transferable and safe wrt. repacking.
Therefore repack should not remove commits hidden by replacement
objects, otherwise if you push to repository instance that doesn't
have replace refs, you would get corrupt repository.  

As replace mechanism uses ordinary refs, therefore replaced object are
safe against repacking / pruning and transferrable in the same way as
other refs.


If you want paper over missing history, you need to use GRAFTS, not
replace objects.

> 
> Some other differences:
> 
>     git cat-file commit 023a1d5d3977420ba041cb556c0eee17c326aeb6
> 
> produces the expected output (that is the same as git cat-file commit
> 238d237db9137b4eaf96f1d554bf2668729b9b93), but
> 
>    git cat-file commit -t 023a1d5d3977420ba041cb556c0eee17c326aeb6

Errr... isn't it

     git cat-file -t 023a1d5d3977420ba041cb556c0eee17c326aeb6

> 
> fails with:
> 
>    error: unable to find 023a1d5d3977420ba041cb556c0eee17c326aeb6
>    fatal: git cat-file 023a1d5d3977420ba041cb556c0eee17c326aeb6: bad file

Hmmm... that looks like bug, assuming that you didn't make mistake in
writing command.

BTW. do git-cat-file respect replace object, or is it only git-show
that respect them?
 
> In my view, it seems reasonable that git repack should tolerate repos
> that have replace references in them otherwise you can never recover
> unused space.

Replace are not meant for this.  You can use grafts instead, but they
are not transferable in-band, so forget about sharing repository if
you do surgery on it like that...

-- 
Jakub Narebski
