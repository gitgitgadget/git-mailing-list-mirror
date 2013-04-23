From: Johan Herland <johan@herland.net>
Subject: Re: git fetch refs and tags
Date: Tue, 23 Apr 2013 13:25:29 +0200
Message-ID: <CALKQrge2vHqA1HitpdJKYQu0KY5+XkFdrN_Gg254gW_ih57o=Q@mail.gmail.com>
References: <1366714421.2899.10.camel@lws-weitzel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, sitaramc@gmail.com
To: J.Weitzel@phytec.de
X-From: git-owner@vger.kernel.org Tue Apr 23 13:25:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUbLx-00018M-CL
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 13:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab3DWLZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 07:25:37 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:54736 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424Ab3DWLZg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 07:25:36 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UUbLp-000CKO-HD
	for git@vger.kernel.org; Tue, 23 Apr 2013 13:25:33 +0200
Received: from mail-ob0-f177.google.com ([209.85.214.177])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UUbLp-000LIf-6t
	for git@vger.kernel.org; Tue, 23 Apr 2013 13:25:33 +0200
Received: by mail-ob0-f177.google.com with SMTP id ef5so397069obb.8
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 04:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=vDdG2OtmdCJ7onrx+dk+rViEUy71iMmOvYgKtMi90i4=;
        b=ZBYFltNz1MeqAc+OhEFKGd8Km/qieMTLhXEgCtNFp91jjJ+WbbLrdM4FF3Eptvu/9q
         RZH0m95Xv32C4EwtRjTsVGTRNyseJJ3e79GeEZVlGJKagjjrWKsIirRz5Rd88J6eWPqF
         KJ+GJB5c6kDKVaRxG9FSfoQQ2SzDqONj7GKnJFfRYBm+0bdRiWFli8hHs7pBwvsB60yA
         Emtzn6yG09hikKWlb5TScnse71i8THRK1KNJbUeGBGnEwRu5W3lkAFLR0gxHXBCz+vC+
         vUBlkNX7drTIw8ai2B3w/zTJ0XxXrNpKgr+kxaJKVgpnBVyJdUzNrEeKpTq04nZvA/lt
         ukvw==
X-Received: by 10.60.60.227 with SMTP id k3mr17005671oer.97.1366716329757;
 Tue, 23 Apr 2013 04:25:29 -0700 (PDT)
Received: by 10.182.210.233 with HTTP; Tue, 23 Apr 2013 04:25:29 -0700 (PDT)
In-Reply-To: <1366714421.2899.10.camel@lws-weitzel>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222143>

On Tue, Apr 23, 2013 at 12:53 PM, Jan Weitzel <J.Weitzel@phytec.de> wrote:
> Hello,
> I have the following problem: I have 2 bare git repositories one has
> several branches and tags.
> If I try this in the second repository:
> git fetch -f ../main.git refs/heads/master:refs/heads/master
> I'm getting also tags from other branches, if I have an old object from
> one of the other branches.
> I would expect to have only tags pointing to master ref. (Although the
> man pages points to the behaviour regarding dangling objects). Is there
> a way to avoid this? I only find --no-tags which results in having no
> tags at all. Or need I git purge to remove the old objects first?
> My goal is to fetch only specific branches and the related tags.

AFAIK, Git should only auto-follow tags that are reachable from the
branches you fetch (in this case master). Are you saying that you get
tags pointing to other history that is NOT reachable from the master
branch? (i.e. are you getting tags for which "git merge-base $tag
master" is not equal to "git rev-parse $tag")?

Re-reading the man page, I do see the following:

"if the repository has objects that are pointed by remote tags that it
does not yet have, then fetch those missing tags. If the other end has
tags that point at branches you are not interested in, you will not
get them."

This can be interpreted as saying that even unreachable objects in
your local repo that are pointed to by some remote tag will cause that
tag to be fetched, and in effect resuscitate the
previously-unreachable object. If this is indeed how it works, I would
be tempted to label this a bug in the auto-following behavior, as it's
probably not what most people would expect. In that case, yes, you
should be able to get your desired behavior by first purging all
unreachable objects. Something like "git gc --prune=now" should do the
job.

Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
