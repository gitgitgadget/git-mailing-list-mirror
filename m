From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git-send-pack segfaulting on DebianPPC (was: Re: cg-clone, tag objects and cg-push/git-push don't play nice)
Date: Thu, 20 Oct 2005 09:56:35 +1300
Message-ID: <46a038f90510191356w56b78413p6b9fe5b67fc9ee74@mail.gmail.com>
References: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com>
	 <Pine.LNX.4.64.0510190724000.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:58:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESKzH-0003AL-Td
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 22:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVJSU4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 16:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVJSU4h
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 16:56:37 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:7533 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751319AbVJSU4g convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 16:56:36 -0400
Received: by qproxy.gmail.com with SMTP id v40so185602qbe
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 13:56:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bYBWWbiUmwZaZtimSCFWJKIK9G7nVcOanjg/yOD0388HqWpb27+kBBtEQBYdM260tH5WyNixjZvlXsOvZVYYPFn1wHzsN4PBVnD51ccKU5Ez9x1pf+1FoE63JCAOEg9k3xmWzzvZ2mDHsdriU51uuG+xuSiDPIk5RNVhn9v4VvI=
Received: by 10.65.188.4 with SMTP id q4mr887116qbp;
        Wed, 19 Oct 2005 13:56:35 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 19 Oct 2005 13:56:35 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510190724000.3369@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10307>

On 10/20/05, Linus Torvalds <torvalds@osdl.org> wrote:
> Interesting.
>
> As you say, I'm obviously testing on ppc all the time, and if
> git-fetch-pack has problems on ppc, I haven't seen them. And I fetch a
> lot.
>
> It might be just the repo you're using. I can't test, since I obviously
> cannot ssh into the repo you pointed at (I tried to see if you had a
> git-daemon running, but no such luck).

Ok -- I seem to be wrong in blaming PPC, so it's back to cg-fetch, and
I think I have a patch that does the right thing.

To recap: repo is slightly broken because cg-fetch has fetched tag
objects, but hasn't followed them through to the commit objects they
refer to.

Internally cg-fetch is actually using git-ssh-fetch (I misreported it
using git-fetch-pack), which is working correctly. However, cg-fetch
attempts to optimize the fetch process, by not calling git-ssh-fetch
if it has the tagobj that the ref points to. How those tag objects get
there without commits in the first place I don't know. So I've removed
the optimization and life is much better.

There is a second bug during the tag fetch. Some of the references
(created by git-cvsimport) are multiline, and break cg-fetch. It's
probably a bug in git-cvsimport, but I'm fixing cg-fetch to use head
-n1 instead of cat. I'll deal with git-cvsimport later.

On this broken-ish repo, git-fetch-pack segfaults as I've reported.
Running it under strace shows that it dies walking the local repo,
trying to find a missing commit. Unlikely that this is PPC only ;-)

cheers,



martin
