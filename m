From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn: git svn dcommit doesn't handle network failure
Date: Fri, 8 Jan 2010 19:00:58 -0600
Message-ID: <20100109010058.GA11922@progeny.tock>
References: <20091122112434.29914.59452.reportbug@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brice Goglin <bgoglin@debian.org>,
	557477-forwarded@bugs.debian.org, 557477@bugs.debian.org,
	git@vger.kernel.org, Alex Vandiver <alex@chmrr.net>,
	Pedro Melo <melo@simplicidade.org>, Sam Vilain <sam@vilain.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 09 02:01:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTPhW-0007n5-8M
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 02:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab0AIBBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 20:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483Ab0AIBBE
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 20:01:04 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:51751 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab0AIBBD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 20:01:03 -0500
Received: by gxk3 with SMTP id 3so9057789gxk.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 17:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=79/51v9yMR1bqR+JtmXu9QAKOPc+UbLaNenU9cLxQbY=;
        b=rFepTM3Vaa9kg98gqYrDvXH1s/IflR2y+VOanhvHUT0f0NQxkhF1rqvRM65q5fN1OA
         4SWHt0h+KlYGoFrFSEtmpV9c+kpTDCCTYqONR3Bwgl2PygJdkbJ71BM2KmOsBy2ah3s7
         nhibx9mMflACIvFRkZnBu+lbCIildUIE8X9pY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GMZc1KNMryTomeyle2fyWUIWBpexeRTBtMCpDEEoMAJwpVuqvwJ6saodFP3NEB9yQn
         gFelbqTJUJKJsHyUUJzg/VJp7bMd/1FQIbTqBOAxDgVdScIXFq4Lgl/RuojllwJTfcAI
         HRuQIZcVdneuXw+vpt/YjohNadFxAl+eWFicY=
Received: by 10.101.21.13 with SMTP id y13mr16783078ani.72.1262998862433;
        Fri, 08 Jan 2010 17:01:02 -0800 (PST)
Received: from progeny.tock (wireless-197-12.uchicago.edu [128.135.197.12])
        by mx.google.com with ESMTPS id 23sm20731iwn.7.2010.01.08.17.01.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Jan 2010 17:01:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091122112434.29914.59452.reportbug@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136505>

Hi Eric,

'git svn dcommit' does not seem to have any error recovery built in,
so the user is put in a not-great situation if the network cable is
pulled in the middle, as in the report below.

See also <http://thread.gmane.org/gmane.comp.version-control.git/70458>

Ideally, it would be nice if users could pretend that each push of
a single commit is an atomic operation that rewrites the corresponding
local commit at the same time.  In other words, to clean up we might
unapply the unpushed patch, then run rebase_cmd().

What do you think?

Brice Goglin wrote:

> Package: git-svn
> Version: 1:1.6.5-1
> Severity: important
> 
> Hello,
> 
> If the network fails during dcommit, git svn gets totally screwed up.
> It will give you the prompt back with HEAD pointing to the last SVN-pushed
> commit, and the next one applied and not git-committed.
> 
> $ git svn dcommit
> Committing to svn+ssh://bgoglin@scm.gforge.inria.fr/svn/knem/branches/rma ...
> 	M	common/knem_io.h
> Committed r237
> 	M	common/knem_io.h
> r237 = f839e16b94052f8b71aa4b66124b37a8337182e0 (refs/remotes/rma)
> No changes between current HEAD and refs/remotes/rma
> Resetting to the latest refs/remotes/rma
> Unstaged changes after reset:
> M	common/knem_io.h
> M	driver/linux/knem_main.c
> ssh: connect to host scm.gforge.inria.fr port 22: Connection timed out
> Use of uninitialized value in concatenation (.) or string at /usr/lib/perl5/SVN/Core.pm line 584.
> Network connection closed unexpectedly:  at /usr/lib/git-core/git-svn line 557
> 
> 
> Now the only way I found to solve this mess is to git-reset --hard,
> git checkout the old HEAD again, and git svn dcommit the remaining stuff.
> 
> The big problem is that I don't see any easy way to find the old HEAD.
> I had to look back in my terminal history in case there's still the output
> of a git log showing the old HEAD commitid.
> 
> I don't know how dcommit works internally, but my feeling is that it
> should go to a new temporary branch during dcommit. This way, we would
> just have to checkout the non-temporary branch on failure. For now,
> I do it manually in case the SVN server fails again, but that's really
> annoying.
> 
> thanks,
> Brice
