From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Wed, 14 Mar 2012 10:48:03 -0400
Message-ID: <20120314144802.GA3558@gmail.com>
References: <20120313232256.GA49626@democracyinaction.org>
 <7vobrzst7n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 15:55:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7pbT-0003nY-PI
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 15:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759208Ab2CNOy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 10:54:58 -0400
Received: from mail-fa0-f46.google.com ([209.85.161.46]:52205 "EHLO
	mail-fa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab2CNOy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 10:54:57 -0400
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Mar 2012 10:54:57 EDT
Received: by faas1 with SMTP id s1so323782faa.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 07:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Vm8/cKrNnv3MWIcygqR2xmp4atfvPKZZwmgo30xSgG4=;
        b=LGiJ+LYuZ/KjOrAU/EzSq0pEmC8rgObUcjLQAxG7WkhdrGm+VT5JUL36sCmmv6sdrI
         aurdAE88D6ZMa5ioC0DKMmQNs3IBUoXtbUycSwqJdhoWzvfTAn2e5R0xBdz2r8k61GHP
         OS0F/zPsrDrBxmQjtouZ6rSRCceeYl8KjGjzSz2dKEQJHUi8o65ACz3T9W6cJhft9YAw
         LTgsvc7pOEBfp3r5O7CdbkF/8dPSURMIqB9eYx3zdmWwRsVZzVwBL/jr1GUbZJqWg/Bt
         5s6sXcalVw42jT+hwhBNMpzqU91ZDU353IPE2iC+by2USB7N+Eh95fNfTKGThlojhS5e
         TJhw==
Received: by 10.224.215.10 with SMTP id hc10mr3388727qab.28.1331736485662;
        Wed, 14 Mar 2012 07:48:05 -0700 (PDT)
Received: from gmail.com ([216.55.38.246])
        by mx.google.com with ESMTPS id o8sm9244456qan.11.2012.03.14.07.48.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 07:48:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vobrzst7n.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193121>

On Tue, Mar 13, 2012 at 09:27:08PM -0700, Junio C Hamano wrote:
> An off-topic administrivia. Please do not try to deflect responses meant
> for you by setting Mail-Followup-To.

Thanks for catching this. Truth be told I downloaded a command line MUA
specifically to send this patch and read in others from this list. I've
been wrestling with the config and will wrestle it further.

> Christopher Tiwald <christiwald@gmail.com> writes:
> 
> > Pushing a non-fast-forward update to a remote repository will result in
> > an error, but the hint text doesn't provide the correct resolution in
> > every case. Three scenarios may arise depending on your workflow, each
> > with a different resolution:
> 
> Are we sure there are only three, or is this just "we do not say anything
> concrete, but at least we know common three cases, and there may be more"?
> 
> I am mostly interested in making sure that we do not give a bad advice.
> Giving an advice that is mostly accurate and relevant for 95% of the time
> is perfectly fine, as long as following the advice in the remaining 5%
> does not result in a disaster.
> 
> > 1) If you push a non-fast-forward update to HEAD, you should merge
> > remote changes with 'git pull' before pushing again.
> 
> You said "to HEAD", but I think you meant the case you push your current
> branch (i.e. HEAD) to update any ref on the other side.  In other words,
> the push does not have to be "*to*" HEAD over there.  Am I mistaken?
> 
> > 3) If you push with explicit ref matching (e.g. 'git push ... topic:topic')
> > while checked out on another branch (e.g. 'master'), the correct
> > resolution is checking out the local branch, issuing git pull, and
> > merging remote changes before pushing again.
> 
> Or you may have misspelled the source side of the refspec and tried to
> push a wrong branch.
> 
> > Make nonfastforward an enum and teach transport.c to detect the
> > scenarios described above. Give situation-specific resolution advice
> > when pushes are rejected due to non-fast-forward updates. Finally,
> > update other instances of nonfastforward to use the proper enum option.
> 
> I think the overall direction of the implemention is good, modulo minor
> design nits.
> 
>  * I do not particularly find NONFASTFORWARD_NONE that is defined to be 0
>    a useful readability measure. Plain vanilla constant 0 says that there
>    is nothing magical going on to the readers clearly already.
> 
>  * Also NONFASTFORWARD_FROTZ is way too long.  Wouldn't NONFF_FROTZ be
>    sufficient and clear?

These notes make sense and I will reroll v2 with them in mind, as well
as the other comments about the advice wording, sign-off line, and making
nonfastforward a switch, not quoted here.

>  * I can see there are three kinds of advices, but I do not see why users
>    need to acknowledge that they understand them one by one with separate
>    advice configuration.  Isn't it better to have only one variable, "OK,
>    I know how to deal with a failed push due to non-fast-forward"?
> 
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index c081657..50d9249 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -158,6 +158,21 @@ advice.*::
> >  		Advice shown when you used linkgit:git-checkout[1] to
> >  		move to the detach HEAD state, to instruct how to create
> >  		a local branch after the fact.
> > +	pullBeforePush::
> > +		Advice shown when you ran linkgit:git-push[1] and pushed
> > +		a non-fast-forward update to HEAD, instructing you to
> > +		linkgit:git-pull[1] before pushing again.
> > +	useUpstream::
> > +		Advice to set 'push.default' to 'upstream' when you ran
> > +		linkgit:git-push[1] and pushed 'matching refs' by default
> > +		(i.e. you did not have any explicit refspec on the command
> > +		line, and no 'push.default' configuration was set) and it
> > +		resulted in a non-fast-forward error.
> > +	checkoutPullPush::
> > +		Advice shown when you ran linkgit:git-push[1] and pushed
> > +		a non-fast-forward update to a non-HEAD branch, instructing
> > +		you to checkout the branch and run linkgit:git-pull[1]
> > +		before pushing again.
> 
> I would prefer to see these consolidated into a single advice.pushNonFF
> variable, but I may be missing why it could be a good idea to allow them
> turned off selectively.

After mulling over it, I tend to agree with this, but will address
further down the thread.

> Also, shouldn't we be doing this only when err is true, or is it too
> defensive?

This was an oversight on my part. Given that the current error message
has been in place since 07436e4 in 2009 and doesn't seem to have caused
trouble (other than it not being applicable in some 'git push'
situations), I'll move the code in v2.

Thanks for the comments. They are much appreciated.

--
Christopher Tiwald
