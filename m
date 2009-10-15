From: James Pickens <jepicken@gmail.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD 
	was
Date: Thu, 15 Oct 2009 00:36:33 -0700
Message-ID: <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
	 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
	 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
	 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
	 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
	 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
	 <20091014230934.GC29664@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 09:39:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyKvf-00065o-F4
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 09:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757895AbZJOHhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 03:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757880AbZJOHhL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 03:37:11 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:62054 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757707AbZJOHhK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 03:37:10 -0400
Received: by yxe26 with SMTP id 26so579701yxe.4
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 00:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=5UnOXbEv7kU5JfG3AqtkHJUJ7bjmo+nt9dCkhYG629A=;
        b=bRJEhBldg0PxzXAbmzG5mp38qWljsq1SYQpAzdvOqwIFlBuj34I7Gj6Hm6hZN0HA+F
         HjkRTfB8p8oGgCqRaSsF0e+uhtf9Izv3xoHXLqtsW2x9e1lE5ZlNEjV/zBfHBh8ocwIu
         zl+2It94euEOW2pgE6zEIyv7W4yshnxEL5uas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rAz+kimxNjuyCR75lAtZov7lwjmWTzOZSjzcQYYuScNZvGsKX+5NL7IcAc0YY+OkY7
         4nlPzvwpr/yuZB6v3W74ttapT8rDmXnlIsOH8gEy5EnC7RgPQaAODDsIkrq1+Zi8URBz
         S1ESaQqlgHWVGxitM+ZGCXm1sz5ayeebcKEbI=
Received: by 10.101.128.27 with SMTP id f27mr8343245ann.182.1255592194057; 
	Thu, 15 Oct 2009 00:36:34 -0700 (PDT)
In-Reply-To: <20091014230934.GC29664@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130378>

On Wed, Oct 14, 2009 at 4:09 PM, Jeff King <peff@peff.net> wrote:
> That makes the most sense to me. If "git checkout" could write metadata
> into HEAD (or into DETACH_HEAD, as in Daniel's patch), then checkout
> could record an "ok to commit" bit. And could also be used to change it
> after the fact. E.g.:
>
>  $ git checkout --detach=commit origin/master
>  $ git commit ;# should be ok
>
>  $ git checkout --detach=examine origin/master
>  $ git commit ;# complain
>  $ git checkout --detach=commit HEAD
>  $ git commit ;# ok
>
> I guess something like "rebase" should detach with "ok to commit", since
> it is planning on attaching the commits later. I'm not sure about "git
> bisect". I guess probably it should be "not ok to commit" to be on the
> safe side, and then somebody can "git checkout --detach=commit" if they
> want to.

How about not detaching the head at all if the user checks out any ref, and
reject commits if he checked out a tag or remote branch.  For example:

$ git checkout origin/master
$ git status
# On branch origin/master
$ git commit ;# complain

$ git checkout v1.0.1
$ git status
# On tag v1.0.1
$ git commit ;# complain

$ git checkout v1.0.1^0 ;# detach
$ git commit ;# ok

I think this would help the newbies and wouldn't cost the experts too much.
Checking out anything other than a plain ref would still detach the head, and
commits on a detached head would still be allowed.  Perhaps as an additional
safety feature, Git could refuse to switch away from a detached head if the head
isn't reachable from any ref, and require -f to override:

$ git checkout $sha1
$ git commit
$ git checkout master ;# complain
$ git checkout -f master ;# ok

Maybe I'm missing something and this all can't be done, but it seems simpler
than the other options I've seen in this thread.

James
