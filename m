From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 2/2] git-rebase--interactive: auto amend only edited commit
Date: Tue, 9 Sep 2008 11:30:29 +0400
Message-ID: <20080909073029.GC28210@dpotapov.dyndns.org>
References: <1220906569-26878-1-git-send-email-dpotapov@gmail.com> <1220906569-26878-2-git-send-email-dpotapov@gmail.com> <48C61AF1.1060703@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 09 09:31:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcxhP-0006xl-UQ
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 09:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbYIIHag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 03:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbYIIHag
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 03:30:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:32551 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbYIIHag (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 03:30:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1747719fgg.17
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 00:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=sv9izZSSv3ju3MgiPT69oz1nRVzmA/z2Jwh36GZAooI=;
        b=uQsB7F/n9mOwTIGVybTa+RumC5QK5zp3ifeh9EGfp0X/jzIAlcLRDPIyKUFrqU2LjE
         VVmBeAnnO4O4V7b8S6Ed7sVGIwz1fJOEsG+9q0d2KZH9pw3vg84BuAyeX8uCv9vXJIS8
         5h9GJnLGVE7Felgo3xAomUCPNToqTLgjNWlnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RYSArqImG5eo1DKlcEd2JCPcLdfrXGx/O974+denJKt6Fjhmd25JsJ2xM9Rl0JXmLy
         kCyMHYD9yvWtYoZZs4gX6L0J3MUstTsQpHCsmT2OLsDchhUenmGHv5187TKdnFaDM+Hd
         l7Io2MNFHVqI7KGooLmpzUZDZ2lIQQoLUGIW8=
Received: by 10.86.92.4 with SMTP id p4mr303064fgb.45.1220945434246;
        Tue, 09 Sep 2008 00:30:34 -0700 (PDT)
Received: from localhost ( [85.141.189.164])
        by mx.google.com with ESMTPS id d6sm5504669fga.2.2008.09.09.00.30.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 00:30:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48C61AF1.1060703@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95345>

On Tue, Sep 09, 2008 at 08:42:57AM +0200, Johannes Sixt wrote:
> Dmitry Potapov schrieb:
> > Another problem is that after being stopped at "edit", the user adds new
> > commits. In this case, automatic amend behavior of git rebase triggered
> > by some stage changes causes that not only that the log message of the
> > last commit is lost but that it will contain also wrong Author and Date
> > information.
> > 
> > Therefore, this patch restrict automatic amend only to the situation
> > where HEAD is the commit at which git rebase stop by "edit" command.
> ...
> > @@ -430,6 +430,8 @@ do
> >  			if test -f "$DOTEST"/amend
> >  			then
> >  				amend=$(git rev-parse --verify HEAD)
> > +				test "$amend" = $(cat "$DOTEST"/amend) ||
> > +				die "You have uncommitted changes"
> 
> Doesn't this terse message carry a bit of a "WTF?" factor?

Agreed. However, the current message in the case when you have some
unstaged changes in your working tree is not much better:
  "Working tree is dirty"

> In other
> situations rebase --continue goes into git-commit just fine, but it does
> not under these special conditions. How about this:
> 
> "Will not auto-commit uncommitted changes after you have already committed
> something. Please run 'git commit --amend' yourself."

I don't think this is the right suggestion. In cases that I mentioned above
(and in some others), you may want to run 'git commit' *without* --amend.
Only user may know how those changes should be committed. Giving him/her
a direct instruction to run some specific command will produce the wrong
result in half cases. So, how about this:

"You have uncommitted changes in your working tree. Please, commit them
first and then run 'git rebase --continue' again."

or if you want to describe the cause why auto-commit does not work:

"Will not auto-commit uncommitted changes after you have already committed
something. Please commit them first and then run 'git rebase --continue'
again."

Personally, I believe those words about auto-commit is not very helpful.
Auto-commit-on-edit feature is undocumented. So, those words may be more
confusing than helpful, because the user starts thinking what this auto-
commit means, while the real question here is whether changes should be
committed with --amend or without it.

Dmitry
