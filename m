From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Alternates corruption issue
Date: Tue, 31 Jan 2012 16:22:58 -0600
Message-ID: <20120131222258.GG13252@burratino>
References: <1328018729.13744.26.camel@ted>
 <20120131193922.GA31551@sigill.intra.peff.net>
 <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
 <20120131204417.GA30969@sigill.intra.peff.net>
 <20120131214047.GA13547@burratino>
 <20120131214740.GA2465@sigill.intra.peff.net>
 <20120131215501.GF13252@burratino>
 <20120131220510.GA3253@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 31 23:23:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsM6h-0002mu-TR
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 23:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148Ab2AaWXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 17:23:15 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:47027 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab2AaWXO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 17:23:14 -0500
Received: by werb13 with SMTP id b13so457631wer.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jiAQraYCKLyEGt/Clm7NAZHhKAbeoCmN7kz/esrZVSM=;
        b=mJ+6xGYN4kBLua8ZL+1LLi0gn03xNJJ3jgz3sEu2dCKRvJfWZzqDFhmf4oivJF0K/O
         kcVd5c6k6QCvO6wFEw4yxkY7MOV3CNeBjwIW8jLt4qhrWjd2ApIT50wpsVfJpJ8XbamF
         oDGgN6qOYqsImS6f+xY5KvCgQS2IpEaP+TlkU=
Received: by 10.216.139.87 with SMTP id b65mr9419252wej.59.1328048593718;
        Tue, 31 Jan 2012 14:23:13 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q7sm40435013wix.5.2012.01.31.14.23.10
        (version=SSLv3 cipher=OTHER);
        Tue, 31 Jan 2012 14:23:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120131220510.GA3253@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189477>

Jeff King wrote:

> True. But I consider that to make the walk-backwards-from-pwd case
> simply a superset. That is, in (A) we are walking backwards and trying
> to apply the lookup rule from (B) individually to each directory we
> consider (though even that is not entirely true, as we don't look for
> parallel "$PWD.git" directories in the walk).

That parenthesis is important.  Although in a nicer world maybe we
would want some symmetry like this, (A) and (B) really have nothing to
do with each other.

Forgetting the algorithms:

 (A) means "find what repository we are in the worktree for, or,
 barring that, what bare repository we are in".

 (B) means "find which repository the user pointed to.  To be extra
 nice, we allow a '.git' extension to be left out, so the URL used
 doesn't have to include the redundant information that this is a
 git repository, and we even allow pointing to the toplevel of a
 worktree instead of a repository, too."

Notice that the above description does not exactly match the actual
behavior of git.  For example, if someone has a directory layout like
this:

  repo-manipulator/
     .git/
     src/
     testcases/
       repo1.git/
       repo2.git/

and git is run from repo1.git, according to the description above, the
naive user _wanted_ git commands to apply to the toplevel repository.
And in practice, I think that's often true, though changing the
behavior of git to match that would not be worth the downsides.

> I'll admit I don't care that much, though. This is extremely unlikely to
> come up.

I admit part of the reason I care is that just putting "" first would
probably taken care of the more important part of
<http://bugs.debian.org/399041>.

Anyway, thanks for explaining.  Hopefully I can get to this soon and
factor out a common function for get_repo_path and enter_repo to call
so playing with the ordering becomes a little less scary. ;-)

Jonathan
