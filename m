From: skillzero@gmail.com
Subject: Re: Best way to re-do a CVS repository with git?
Date: Sat, 19 Apr 2008 12:47:31 -0700
Message-ID: <2729632a0804191247t4458067etfc1627a533a84376@mail.gmail.com>
References: <2729632a0804161937w168aba8ahee742e182e50b4e7@mail.gmail.com>
	 <m3wsmuqmmp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:48:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnJ2x-0005pG-Fk
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 21:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbYDSTrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 15:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754769AbYDSTrd
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 15:47:33 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:46847 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbYDSTrc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 15:47:32 -0400
Received: by wa-out-1112.google.com with SMTP id m16so1830911waf.23
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 12:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LmbI7uz6vwya2IUL01KN+EVQDEg7Mnw7DSk0zwc6PjA=;
        b=PD8WOyFRteP/yBjeSRTL8acteGU+/vzVp7ZoNjT2ev6HZlCX7NxV4GbqwjVoOadzCGqrQTDrh5kNWJ9f1LzHQYD6Rdsn1xserHZGz5v6Xq4goDhf9yXDkc9vFz9P9lER51eKJ+Yp87T3Q5Fv3rYvh1TbeNJUcShXl+BdZmcmWB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X7uBDIpEHSvqJzFygAPsTAk2Gr5awYm0x+kVlTmQKORE8qz79UPzlSoR/BPXNHAju43tPFgQavDHSJVsVkCYR16L948IM36vLSMolRVtmayk3V3CLfRb1OEflvS+bhfhdZQeB4Dq/CSkmQKgxMtL1yR3oVltPkYV126wb8pRn8Y=
Received: by 10.114.191.1 with SMTP id o1mr4120137waf.117.1208634451921;
        Sat, 19 Apr 2008 12:47:31 -0700 (PDT)
Received: by 10.114.193.9 with HTTP; Sat, 19 Apr 2008 12:47:31 -0700 (PDT)
In-Reply-To: <m3wsmuqmmp.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79919>

On Sat, Apr 19, 2008 at 1:23 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> I think that such setup would be best managed by creating Git
> repository for each piece, and "integration" repositories, one for
> apps people, and one for firmware people, using submodule support in
> Git.

> Tagging entire release would be tagging in "integration" repository,
> the one using submodules.

Thanks for the info. git submodules seem like the right direction. But
unless I'm misreading the tutorial, using submodules would require
each user to know about and maintain every super module that might use
each submodule. For example, if you had:

moduleA
	fileA.txt
moduleB
	fileB.txt
moduleC
	fileC.txt

super1
	moduleA
	moduleC

super2
	moduleB
	moduleC

super3
	moduleA
	moduleC

I commit a change in fileA.txt (in moduleA). I now have to commit
moduleA to super1 and then commit moduleA to super3. Otherwise, super1
and super3 would still refer to the previous commit of moduleA. That's
a good amount of extra work (I can imagine there may being dozens of
super projects referring to a certain submodule).

But there's a more serious problem in my case because not all users
have access to all repositories. For example, if I have access to
super1, but not super3 (I may not even know super3 exists), I won't be
able to update super3. Now super3 is in a weird state: it has moduleA
as a submodule, but it refers to an older revision of moduleA.
Somebody with access to super3 has to know that moduleA has changes
that haven't been included in super3 and manually pull them.

Or am I just misunderstand how submodules work? It seems to me that
the super module could use a more abstract link: the super repository
would refer to a branch name (e.g. master). Then when I do a git pull
from super1, it would see it contains moduleA on branch "master" and
would pull down the latest "master" branch from moduleA without ever
having to commit moduleA to super1 or super3.

This is probably harder than it sounds, but it would seem to eliminate
the need to know anything about super modules (except initially when
the super repository is created). I just commit to moduleA and the
next time somebody pulls from super1 or super3, they get the change
automatically.
