From: "Adam Brewster" <adambrewster@gmail.com>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Tue, 1 Jul 2008 22:12:28 -0400
Message-ID: <c376da900807011912x5a9ad3aaxa04598e0f1416604@mail.gmail.com>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com>
	 <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com>
	 <7vzlp1jh1o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 04:13:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDrqY-0004Z9-NM
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 04:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758672AbYGBCMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 22:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758171AbYGBCM3
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 22:12:29 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:41525 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179AbYGBCM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 22:12:29 -0400
Received: by yw-out-2324.google.com with SMTP id 9so79388ywe.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 19:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6WwOZpD2vnxUjkYPaBg6JFxqj3RcPEPnQw8uhB41OJM=;
        b=BzBc64LLkDz1+nl/iddgZdOmS2bfGP6I6w/l0OUgQ2O4lDmB8Mka/XBRvi3QIGENmn
         weB6XeUSdng/BEE6czgYBDs9Cr9lRgHPUlTuHTbLAdpEnK49chPV8jYdRpY4iZU89tH3
         yMws9LJyQW7s/sud7bMs/5Hsug3MwiLh8xboc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uyGN3oROqgqvmfO5iL8retdZ0ugYVqtl/QWHMhU63BCyEVT8sCNroCiX0p6Yh3Mktx
         bTZmxsFnPibGHPBQoHLn0qGKgsMwAHiLO+toH1t2VLwmC19E9Yl3IDoi+bkxdLu6xZax
         5ngLGrWys3/PLlGDZVvtd3rdMchd4GO2HaMuc=
Received: by 10.151.143.3 with SMTP id v3mr11680855ybn.229.1214964748074;
        Tue, 01 Jul 2008 19:12:28 -0700 (PDT)
Received: by 10.150.205.18 with HTTP; Tue, 1 Jul 2008 19:12:28 -0700 (PDT)
In-Reply-To: <7vzlp1jh1o.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87078>

>
> Well, I have a moderately strong objection to this.
>
> This very much feels like adding a missing feature to "git bundle" command
> itself.  Why isn't it a new option to it?
>

Mostly because this was an easy way to accomplish the same thing.  If
this is popular, then it can be added to git-bundle.

> For that matter, I am not sure how this integrates to a larger workflow.
> You have a site (or more) to "push" your changes to, and you would need to
> remember up to which revisions you have given out bundles to.  To remember
> which site is at what basis level, you would need an extra infrastructure
> than what this separate command offers (and "I'll have a yet another layer
> of wrapper to this script" is not a good answer.  That wrapper can simply
> read the tips from the bundle and record them without your script, and the
> wrapper can use the previously recorded information to use the new bottom
> refs when creating a new bundle again without using your script).

The intent is to use one basis per site, not one per bundle, so the
first iteration is

A$ git-bundle create package.git --all
B$ git-clone package.git package
A$ git-bundle --update siteB < package.git

and thereafter it's

A$ git-bundle siteB | git-bundle create package.git --all --stdin
B$ git-pull
A$ git-bundle --update siteB < package.git

There's no issue of remembering which site is at which basis level,
because each site gets it's own basis.

If you're worried about hundred of sites, this is a bad solution.  I
happen to be worried about three sites, so this works well for me.

>
> Perhaps it would be sufficient to have a new option to git-bundle.  "write
> basis information under this name, so that I can reuse it in the next
> invocation", and "I am not giving the bottom refs to create this bundle;
> read them from the existing basis with this name".  It probably is easiest
> to operate if these two are simply a new single option, like this...
>
> [...]

I agree than git-bundle --basis is a better syntax than git-basis |
git-bundle --stdin.

I do, however, think that creating the bundle and updating the basis
should be two separate steps.  Mostly because the fact that I created
a bundle and planned to install it on another machine does not
guarantee that the resources of that bundle exist on the other
machine.  (I may need to stop for coffee and ... who knows?) Also, in
practice, I always use the intersection of all of my remote bases when
I create a bundle, and I frequently use them in places other than
where I intended.  Yes it's a pain to go back to git-basis --update,
but it's better than trying to git-pull from a bundle that's missing
objects.

Adam
