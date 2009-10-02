From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/2] do not mangle short options which take arguments
Date: Fri, 2 Oct 2009 09:36:28 +0200
Message-ID: <20091002073628.GA9444@localhost>
References: <20090925233226.GC14660@spearce.org> <20091001201648.GA12175@localhost> <20091002061159.GA24892@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 02 09:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtcgx-0007R6-Lg
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 09:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999AbZJBHg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 03:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755894AbZJBHgZ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 03:36:25 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:40968 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbZJBHgX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 03:36:23 -0400
Received: by fxm27 with SMTP id 27so758171fxm.17
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=odHhcduwV63I3758EtZZmKJIwBYpHtnyjhz9wuczM3Q=;
        b=lBcvYeOFaxiMvtdos+3TvWCbkZ6ozkmmgFk30MDBM4gCCX87kuRl8+vjd7/CGKk7z8
         XUX77ZDBvWCE1PYycYj4m366H13URoPttUwljrS7+Y9YxdaHssnGr0cD021LXKrzgAr1
         CUuS6h6TjECkwIBvvzr8qRHSpy9+7PO1pb7eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=J/N4A1K8dcAxmyhzMBdSd72HMv1YL3+ILtMBtS3W3LADxFmOyM8I5kmIv8XSXqOniA
         9brlPIEiPkitWbGVd3rGLJZ5YRTuiXYMa6P+T6I1DRB/LQKluFJG8Gy3XMqO/yKX49mE
         WBQVAO+NFYb0X+p7eLQpoJcbyhurc8+ohRQ3I=
Received: by 10.204.8.155 with SMTP id h27mr883797bkh.55.1254468986538;
        Fri, 02 Oct 2009 00:36:26 -0700 (PDT)
Received: from darc.lan (p549A5168.dip.t-dialin.net [84.154.81.104])
        by mx.google.com with ESMTPS id 20sm1088750bwz.114.2009.10.02.00.36.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 00:36:24 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Mtcgm-0004At-Ee; Fri, 02 Oct 2009 09:36:28 +0200
Content-Disposition: inline
In-Reply-To: <20091002061159.GA24892@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129422>

On Fri, Oct 02, 2009 at 02:11:59AM -0400, Jeff King wrote:

> I thought the proposal was to disallow just cuddling of the value when
> the switch was combined with others. So you would disallow "git commit
> -ammend" but it would still be legal to do "git commit -am foo". Your
> patch disallows the latter.

Yes, that syntax looks reasonable. I expect this to be more involved, so I
will rework the patch once we agree on whether or not we want it at all.

> To be honest, I am not sure that even the more restricted proposal is
> that good an idea. You are introducing a heuristic to guess at what is a
> typo or error from the user; when your guess is wrong, the user will be
> annoyed (doubly so if it is buried deep in a script, which this change
> will also impact).

Yes, that can happen. On the other hand, the "-ammend" typo actually did
happen. And what I'm even more worried about are ambiguities like

  $ git commit -uno <path>
  $ git commit -nou <path>

which are interpreted as one of

  $ git commit --untracked-files=no <path>
  $ git commit --untracked-files --no-verify --only <path>

depending only on the order of the switches. I was actually surprised that I
could find an example so easily. But the fact alone that it's possible feels
like an accident waiting to happen.

> On the other hand, the cuddled value already has some DWYM magic (it
> recognizes -amend), so it is already a little bit unsafe to use

Well, an error message is a lot safer than executing something you did not
intend.

> So I don't feel _too_ strongly. I am just concerned that we are
> introducing some DWYM magic that is not really going to help many people
> out, and is just going to make understanding the rules for option
> parsing more complex, and introduce the possibility (albeit slim) of
> breaking people's scripts and trained fingers.

But it makes the rules simpler, because it removes ambiguities such as the
one above.

Yes, we deliberately allow users to shoot themselves in the foot. But they
should have to use at least a long option to do it.

Clemens
