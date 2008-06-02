From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Pushing an --amend-ed commit [and a git-merge-theirs strategy]
Date: Mon, 02 Jun 2008 16:55:53 +0200
Message-ID: <484409F9.5020807@gnu.org>
References: <6B355924-0EA9-4AF8-B051-F17FC4530495@manchester.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Haines <rhaines@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Mon Jun 02 16:56:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3BSu-0004An-1h
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 16:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbYFBOz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 10:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbYFBOz6
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 10:55:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:32398 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbYFBOz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 10:55:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so754747fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=n8tlyyhvD9DGkdxQ17rXzvInazoZP9aiXqErerbfR6Y=;
        b=t8qdFFp0DErTy4JTUQ0PGwhgSAtyACSAQyFkUMEUUvISH/NgoGVsqV3SIyiRNlkHgKGeLhyV9fKm1Jxcge1Ybte4g/k3WlM9uGAHzd2zVhyqRE1fpoUdnTHNGEJ/PTRXxI/uLqHDirGRtP0JbMlVcKYYDu3o60SfZD54b8iAR5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=J/0nSb1n0Uj4tMQFRI9h7GEgTZztmyGwumARha+cPVs4Ib3yiQLnh9vZQuH37x3P7oUIihQog58WOo2C+JYSM9zLA7OFliQHpuyMxzliGWltVR+hx+w+YC7j3NuGCOXln3snRQfak1oaONW1R8bdu/6UXrjwY4P13xxkCoxbi2o=
Received: by 10.86.79.19 with SMTP id c19mr5682221fgb.52.1212418555461;
        Mon, 02 Jun 2008 07:55:55 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id l19sm4419469fgb.7.2008.06.02.07.55.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 07:55:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <6B355924-0EA9-4AF8-B051-F17FC4530495@manchester.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83528>


> 1) Right, changes all done and committed. Push to public repo.
> 2) Bugger, missed out an obvious one-liner in a Makefile. Make change 
> and --amend that last commit.
> 3) Push to public repo again... Ah, "Not a strict subset" error, can't 
> push...
> 
> It's obvious (I think) to me why I get this error - the commit now has a 
> different hash so it looks like it would be the wrong thing to do to 
> allow the push as far as git is concerned. Right?
> 
> So, is it safe to "use the --force" in this instance when pushing? This 
> should just replace the old commit with the --amended commit with no 
> side-effects, shouldn't it?

Yes, but it would screw up other people that pulled from you.

If that's an issue (it most likely is, unless you're just pushing just 
to your own mirror repository), it is better if you do it the other way 
round: adding your commits on top of origin^, starting from the one that 
fixed a typo.  In other words, make the history look like you hadn't 
used --amend.

Do like this: first create git-merge-theirs somewhere in your path; it's 
this three-line script, and it has to have that name.

#! /bin/sh
eval git reset \$$# -- .
git-checkout-index -q -f -a

Don't forget to make it executable. :-)

And here's the magic incantation to be executed on branch master:

git rebase -s theirs --onto origin/master origin/master^ HEAD

Basically, it uses the script created above to place the commits _after_ 
origin/master^ _above_ origin/master.  What the script does is resolve 
conflicts by taking the version in your "master" branch.

To do so, git-merge-theirs uses "git reset" to check out into the index 
the last head passed to it (which we know is the next commit being added 
to the rebase).  Then it extracts the index into the working tree to 
avoid complaints from "git commit" about files not being up-to-date.

There is no builtin git-merge-theirs strategy; if there was one, it 
should make sure that it was only called with two heads, for example.

Anyway, now you can push again.  I suggest however reviewing your commit 
messages and, if necessary, using "git rebase -i origin/master" to edit 
some of them.

Paolo
