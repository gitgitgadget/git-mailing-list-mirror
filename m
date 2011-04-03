From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Allow multiple merges to invalid HEAD
Date: Sun, 3 Apr 2011 16:52:46 -0500
Message-ID: <20110403215246.GA6332@elie>
References: <1301813216-19507-1-git-send-email-tnachen@gmail.com>
 <7vlizrg6ef.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timothy Chen <tnachen@gmail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 23:53:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6VEQ-0002gw-5j
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 23:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221Ab1DCVwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 17:52:55 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61967 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab1DCVwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 17:52:54 -0400
Received: by iyb14 with SMTP id 14so5345227iyb.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 14:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MuwwnI2ZCAO3XUckGJS8LrYiwEkbAzZvPD2deg444tU=;
        b=Bzg3vaQsdkCfKWwM3xJ1+ZpKK7y2I3Og7enYTQtuBkmMV9QEsF1fG1inFA4BTtu2+j
         pHenjHic6GAgTpLSs3gcg4WAp7FgbbrzW1JOac+7hXyFgcMBvXG6xCUFPhiAKhxr9pxV
         Mmm/WSayXI87+s4BmSo0+8YIyl6gBGmKO16Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xsBTS6p3BORUal52HKCZTzjvVpQUBvgwlQHYGh8FlB1uYxF6EubEGQdNh4H/dzA9Y9
         Oih7IfF/mwxbsX4kxeddT1VYJEP6BbMtLqMvkKhPyphtQugk1yscJ33aQweKB5FHeXZY
         83ypnAzCbf0py3ywPJBsTiwxlg7v0W42TgkYQ=
Received: by 10.43.45.8 with SMTP id ui8mr9847390icb.197.1301867573821;
        Sun, 03 Apr 2011 14:52:53 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.sbcglobal.net [69.209.53.77])
        by mx.google.com with ESMTPS id i3sm3254507iby.23.2011.04.03.14.52.51
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 14:52:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vlizrg6ef.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170791>

(+cc: Martin, who also requested something like this long ago[1] iirc)
Hi,

The following is only about motivation; I'm ignoring the mechanics for
now.

Junio C Hamano wrote:

> What's the point of being able to do this in the first place?
>
> The _only_ reason "git pull $there $branch" into an unborn branch exists
> is because it feels like
>
> 	$ git clone $there $directory
>
> could be broken down as this command sequence:
>
> 	$ mkdir $directory
>         $ cd $directory
>         $ git init
>         $ git remote add origin $there
> 	$ git fetch
>         $ git pull $there ;# or "git merge origin/master"

I'm to blame for the suggestion, I'm afraid.  

I haven't wanted to be able to "git init && git remote add origin
$there && git fetch && git merge origin/topic-1 origin/topic-2" for a
long time, but there was a time (around 3 years ago, I think) I wanted
it a lot.

In fact I can't remember the details of why.  The facts I remember:

 - /etc was kept in a git repository managed by etckeeper;
 - history was not precious --- it was just a way of understanding the
   final result;
 - the user wasn't sure how to manage topic branches yet.  The usual
   workflow involved

    (1) cherry-picking each automatic commit to an appropriate topic
        branch and writing a sensible description
    (2) bundling the topic branches together with an octopus merge
    (3) diff-ing against the automatically committed latest state to
        see if anything was missing
    (4) force a push.

So I suspect my use case was "start with a bundle of these branches".
I could have (and did) used "git checkout -b" to grab the first one
and merged the rest, but somehow a merge into nothingness seemed more
intuitive.  Remember, this is before the days of checkout --orphan
and rebase -i --everything.

That said.

I doubt the above is a very compelling use case, to justify the
maintenance cost and easily explain in documentation.  I would find
something like the following more compelling:

	Currently git merge has a special case to "pull into
	emptiness", to support the following sequence of commands:

		git init repo
		cd repo
		git remote add origin $url
		git fetch origin
		git merge origin/master

	But it is very much a special case.  It does not support
	octopus merges, --squash, --stat, alternate strategies,
	or any of the rest of merge machinery.

	It would be more intuitive if the above features _did_ work
	where they make sense, and if this essentially worked as
	though performing an ordinary merge with merge base being an
	empty tree that is ancestor of everything.

	Here is a first step --- support for octopus merges.  It
	also makes it easier to support the others, by [...].

> It very much feels like
> "because I can make things more complex", not "because this is an often
> desired missing feature that is a major pain point".

Therefore a good goal would be to make this make the code more simple
at the same time as making the semantics so.

(But also: Tim, please don't feel attached to this topic if you're not
interested in it; there are many more out there.)

Thanks for some useful feedback.
Jonathan

[1] http://bugs.debian.org/432558
