From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: How to efficiently find where a patch applies?
Date: Thu, 5 May 2011 15:12:05 -0500
Message-ID: <20110505201204.GA31572@nwp-laptop>
References: <20110505181741.GA27251@nwp-laptop>
 <20110505195556.GA1770@sigill.intra.peff.net>
Reply-To: nathan.panike@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 05 22:12:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4u6-0003D8-N4
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab1EEUMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 16:12:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39872 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab1EEUL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 16:11:59 -0400
Received: by iyb14 with SMTP id 14so2114662iyb.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Z7ydq0m+XFfV/AZhA9FJAnGIpbAUL55w2yMliYlKPVk=;
        b=aBIANdESCc8HWUO/BwIVpNpRkaghrEhBcvynoQ29jSuus0YYXfaVS0CSVfSjM/cdhL
         VI+gGHxVZp8UX+hBfvqYjs32U5TMpZbe85LJQJcOxCmLEKJZMu42JWmPHq+tzeet09We
         sHBAH+ywJX7LVXZs472Ux8Mq4FYFbTBFI57As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BVJiuk6KAnPMMYHJKXYj2E7PM8pLd7F1XxZid600v7kM71zszpCql0nStpaZcOEjU5
         6lHn3dRLpvJZZ1JkspyIPUjOZJpr3In5Xgmegxq0SeULqka7qLwCT68FPE+jBw82X6Z2
         doAk0DTixaLNavN3xjKDaIG4VSWUNGOSCZ0XU=
Received: by 10.42.150.132 with SMTP id a4mr1499818icw.199.1304626318587;
        Thu, 05 May 2011 13:11:58 -0700 (PDT)
Received: from localhost ([128.104.153.131])
        by mx.google.com with ESMTPS id c1sm1022802ibe.0.2011.05.05.13.11.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2011 13:11:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110505195556.GA1770@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172903>

On Thu, May 05, 2011 at 03:55:56PM -0400, Jeff King wrote:
> On Thu, May 05, 2011 at 01:17:41PM -0500, Nathan W. Panike wrote:
> 
> > In the past couple weeks, I have had several occasions where a collaborator has
> > sent a patch, which does not have information about where the patch forked from
> > master.  I wrote the following scripts to try to discover where the patch
> > should be applied.  Is there a better way?
> 
> What you have is more or less the best way. As you probably realized,
> there could be any number of commits that match the preimage of the diff
> exactly. So you are not necessarily finding the fork point, but rather
> an appropriate place to apply the patch.

Yes.  I thought there might be some feature of git-apply that would help me,
but now I will stop thinking that.

> 
> I have to wonder, though, whether it is worth the trouble. If you apply
> the patch to your tip, especially using "git am -3", then one of two
> things will happen:
> 
>   1. The patch will apply cleanly. Either because your tip matched the
>      preimage exactly, or because it was close enough and git was able
>      to apply anyway.
> 
>   2. There are conflicts between what you did and what the patch does.
>      In this case, though, what you are doing by searching for the fork
>      point will recreate the history locally that your collaborator has.
>      But when you go to merge their history, you will end up getting the
>      exact same conflicts that you would if you applied to your tip now.
> 

The patches were emailed as raw diffs, not as format-patch messages, so I
thought git-am was not applicable. Also, I was applying the patches to the git
repository on behalf of local colleagues when they ran into problems using
'git-apply'.  I did not want to deal with merge conflicts---my colleagues can
handle the conflicts themselves. So a clean merge was optimal from my
perspective.

> So what is the value in applying their patch to the original fork point?
> It better represents the history of what happened. But if you care about
> that, I wonder if you should just be pulling from them directly via git
> (or if that isn't convenient for some reason, passing around bundles).
> 

Oh, I keep forgetting about bundles.  Next time, I might ask them to send a
bundle rather than a patch or ask them to use format-patch.

> Wow, dynamically generating awk using perl. That's a new one for me. :)

You might say it is awk-ward.

Thanks,

Nathan Panike

> 
> -Peff
