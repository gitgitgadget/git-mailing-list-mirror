From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Storing (hidden) per-commit metadata
Date: Mon, 22 Feb 2010 08:17:48 +0300
Message-ID: <20100222051748.GB10191@dpotapov.dyndns.org>
References: <1266599485.29753.54.camel@ganieda>
 <1266687636-sup-7641@ben-laptop>
 <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
 <20100221063433.GA2840@coredump.intra.peff.net>
 <1266754646.12035.23.camel@ganieda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	Ben Gamari <bgamari@gmail.com>, git <git@vger.kernel.org>
To: Jelmer Vernooij <jelmer@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 07:05:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjQgB-0001iN-Hn
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 06:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab0BVFRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 00:17:53 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:46126 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab0BVFRw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 00:17:52 -0500
Received: by fxm5 with SMTP id 5so2283932fxm.29
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 21:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bjOTsIqny8dwn7eappdI3UKmqlpokurDw6qp6tqplDs=;
        b=IW3htOgArd7nvWu5algqLcHk6yGdhLjy4YkDzyPsys7Sj6fIxi6Yy8jxwY2jxOH3oN
         L4REqdGsJYNF1WxilsGs0DEvQm7glKLvZ3hgPVCVP5JJU5ovKYGK40sj3alkT4PmHaUn
         i1v5RbhYNrDGryHSdgmjVD7v+wAJaS1dMLHJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MTnwi1SeOXYDbi9lJQudCL/phVWWHzX96nocsmf1us157njR4C3Js7IgvuICjDfwMa
         NL2SGlk344dHOm3HjsYPG2aPiq41wq9l6tdAhUWfNW/vjHX9uYZIjc7DeXi1BmTYJceD
         cqCL7ccWBrJcsKjhg0P8IVMHeWXT3+o4PVQsM=
Received: by 10.103.81.20 with SMTP id i20mr3062934mul.21.1266815870856;
        Sun, 21 Feb 2010 21:17:50 -0800 (PST)
Received: from localhost (ppp91-77-227-64.pppoe.mtu-net.ru [91.77.227.64])
        by mx.google.com with ESMTPS id j10sm13402474mue.0.2010.02.21.21.17.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 21:17:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266754646.12035.23.camel@ganieda>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140612>

On Sun, Feb 21, 2010 at 01:17:26PM +0100, Jelmer Vernooij wrote:
> 
> For each file we would need to store:
> 
>  * the Bazaar revision id
>  * any Bazaar revision properties. This is typically a list of URLs of
> bugs that were fixed, name of the branch the commit was on, any
> additional parents, or anything arbitrary set by plugins (e.g. the
> rebase plugin sets 'rebase-of' to the id of the original revision)
>  * For each file that was added or moved around in the revision, a path
> to fileid mapping
>  * Optionally, a list of ghost parent ids and "unusual" revisions for
> each file but these should be rare.
> 
> This is at least a couple of lines of data and in some cases a lot more.
> I would rather avoid confronting git users who don't care about Bazaar
> with it.

The problem with storying this meta data in the commit object is that
any newly created commits in Git will not have this information, and you
probably have to add it later when you export these commits to Bazaar,
which means that the history in Git should be re-written, and Git users
will have to rebase their branches from one commit to another that are
identical except this Bazaar-specific information, which you try to hide
from them. So much for don't care about Bazaar!

In other words, no matter what git-log displays, as long as you put this
meta data wherever it changes commit-id, it is visible to Git users, and
trying to hide this fact is utterly stupid.

There are many ways to store Bazaar data in Git without confronting git
users who don't care about Bazaar with it. For instance, you can create
a separate branch that will hold this meta data.

   master      bzr/master

      /---------o
     o          |
     |          |
     |/---------o
     o          |
     |          |

Commits on bzr/master are fast-forward merges that have the same tree-id
as corresponding commits on master, but the commit message contains
Bazaar specific information. So, if someone does not care about Bazaar,
this is a throw away branch for him. Also, there is no problem to add
Bazaar specific information to any git commit later when it is pushed
to Bazaar. The only problem is if you try to rebase commits that were
pushed to Bazaar, but AFAIK Bazaar does not support overwriting history,
so you cannot expect anything good of this attempt anyway. The published
history should not rebased.


Dmitry
