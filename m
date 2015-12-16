From: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
Subject: Re: [PATCH] rebase: add --verify-signatures
Date: Wed, 16 Dec 2015 14:39:15 +0100
Message-ID: <20151216133915.GA3586@blarch>
References: <20151210130228.GA22641@netblarch.tu-darmstadt.de>
 <xmqq37vai0ev.fsf@gitster.mtv.corp.google.com>
 <xmqqy4d2gjw6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 13:22:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9B6X-0005Gu-UQ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 13:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933781AbbLPMWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 07:22:47 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37808 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933927AbbLPMWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 07:22:45 -0500
Received: by mail-wm0-f54.google.com with SMTP id n186so68371062wmn.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 04:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qUG/wlEHaKTT6jgpmWvIsLODO8QycCtIqlRxd4nCfQQ=;
        b=HTYViQDzn6F4XheujoZZCDKF9+Mr58wcZKSfwBMMj19AqxYlM4IWDnjY2ba08ndGP3
         nSOuUiPFrlUIs4l0ZBh0vynrd07dW0ONVl2MVJ0dZIGd7gv+tk4bgiadwqrhoKVvEGKJ
         jK+pVL9othm/GWzlt4cp9RyxUFcEybKQHxajZ5fqAvqqTfD/lS6VALpGZJhWVqv9fU6Z
         GhZ9aQU998MQ+6Ct40QD631XypbLUs9F1sY+wWsgd6z0x0h8JAdgq/fyPFkNBAQeYqe7
         AMoZyzO3c/rzwRifcTIduOlrsf5g2wDD3aVzrvBB7+NvyLM4zzUKPBlu4CXPe9k8IqGo
         fcgw==
X-Received: by 10.28.45.72 with SMTP id t69mr11887481wmt.32.1450268563677;
        Wed, 16 Dec 2015 04:22:43 -0800 (PST)
Received: from blarch (dslb-088-069-062-066.088.069.pools.vodafone-ip.de. [88.69.62.66])
        by smtp.gmail.com with ESMTPSA id dl8sm5813145wjb.29.2015.12.16.04.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2015 04:22:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqy4d2gjw6.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282550>

On Thu, Dec 10, 2015 at 11:53:45AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Alexander 'z33ky' Hirsch <1zeeky@gmail.com> writes:
> >
> >> +	if test -n "$rebase_root"
> >> +	then
> >> +		foreign_revisions="$orig_head..$onto"
> >> +	else
> >> +		foreign_revisions="$orig_head..${restrict_revision-$upstream}"
> >> +	fi
> >> +
> >> +	for cmt in $(git rev-list --reverse "$foreign_revisions")
> >> +	do
> >> +		if ! git log -1 --pretty=format:'%G?%n%GS' "$cmt" |
> >
> > I do not think this matches what the corresponding option in "git
> > merge" does, where the only tips of the histories being merged are
> > checked.

Oh, indeed. I saw the loop in merge.c and by brain went there without
any further thought. This would be easy to fix though.

> Having said that, I somehow doubt that verify-signatures is a
> feature that is desirable in a workflow around "pull --rebase" in
> the larger picture.  If you step back a bit, in a "merge" based
> workflow, you are the keeper of the sanity, cleanliness, and all the
> good things in the authoritative history when doing a "git pull".
> That is why you would want to validate what gets merged from another
> place and in that context having --verify-signatures may make sense
> (and it might even make more sense if the code did so for all new
> commits, not just the tip, but that is a separate topic).  If the
> validation fails, you would tell the owner of that side branch you
> just attempted to pull from to get her act together before asking to
> be pulled again.  There is a clear path to make further progress
> after the validation fails.
> 
> In a workflow that is built around "pull --rebase", you are _given_
> the authoritative history with all the good things from another
> place and then you rebuild your own work on top of it.  The sanity
> and cleanliness of what you built on top is given, and rejecting it
> at that point would not help you make further progress in any way,
> as that is a published history that is shared and more authoritative
> than what you have.

Well, the rejection would not refer to the work you put on top, but to
the commits you want to base your work on.
If validation fails, then an empty commit that is signed can be
committed on top of the previously unsigned branch if commit rewriting
is not allowed.

> Hence, while I 100% agree with Brian's "it is not there because
> nobody bothered to add the corresponding option on the rebase side",
> I do not necessarily think "nobody bothered" is the same as "they
> were too lazy"--perhaps some people thought about doing it, and then
> decided not to, because the option made no sense when they stepped
> back to look at the larger picture.

That's why I was asking in my first mail if such an addition would make
sense. I don't really have an agenda or a pressing need for this
feature, I just noticed that a `git pull --rebase --verify-signatures`
did not complain when it looked like it ought to.
If this patch gets rejected then I will propose one which makes git-pull
warn, or even error, when both --rebase and --verify-signatures is
passed.

Regards,
Alexander Hirsch
