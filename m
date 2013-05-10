From: William Swanson <swansontec@gmail.com>
Subject: Re: Avoiding broken Gitweb links and deleted objects
Date: Fri, 10 May 2013 00:34:07 -0700
Message-ID: <CABjHNoT+Kvm5j4W+c2KOd+0mdu8tPCFDcEAWjxp0OcUXf1t4Lg@mail.gmail.com>
References: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
	<518C8EAC.6000106@viscovery.net>
	<7vzjw349y0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matt McClure <matthewlmcclure@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 09:34:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UahqH-00035G-Tl
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 09:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589Ab3EJHeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 03:34:09 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:62762 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab3EJHeI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 03:34:08 -0400
Received: by mail-wi0-f173.google.com with SMTP id ey16so310479wid.12
        for <git@vger.kernel.org>; Fri, 10 May 2013 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Wu+AXyD022dKAO8J7wegJhPgOSsoLu9RPBLVGaURwBE=;
        b=BYu+EJYxaXR4RE7KV6VjhrqQieEEIVQiHfnbEoDlsDJYs/tiAbyFZTK8zXe+vau58z
         cOo/1vG1zzJdc11AddHhwlFgBmei779WUHvxZWMUh+tO7vxJMXm/vVakys8QU+1GsPbO
         /elvC9+ijH6v34S1U5eGmcxytP6LtT5hRwgYWO3RRa2QPadBhskk0cO4QX5QOeWkG+KX
         X9sVbki6wJqL5u1OIxCV0fVCXm+5K4KeFHpuWa9Q/D7nk0VAIDO/4M5bDzFgWmYzhwRW
         x9lHEjmzHspyIu5ZVqVcw3nMSmZiM0b3Za9b3C+jQnP3oJJrQbvhZMzMUcPBDAUVqaKx
         xnoQ==
X-Received: by 10.180.76.230 with SMTP id n6mr1736041wiw.28.1368171247368;
 Fri, 10 May 2013 00:34:07 -0700 (PDT)
Received: by 10.216.154.135 with HTTP; Fri, 10 May 2013 00:34:07 -0700 (PDT)
In-Reply-To: <7vzjw349y0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223823>

On Thu, May 9, 2013 at 11:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> What's a good strategy for avoiding breaking those links?
>>
>> Do not rebase published history.
>
> All true, but I think we could do a bit "better", although I am
> still on the fence if what I am going to suggest in this message is
> truly "better".
>
> Let me idly speculate and think aloud, "what if".
>
> Imagine that a user runs "git rebase" on a history leading to commit
> X to create an alternate, improved history that leads to commit Y.
> What if we teach "git rebase" to record, perhaps by default, an
> "ours" merge on top of Y that takes the tree state of Y but has X as
> its second parent, and "git log" and its family to ignore such an
> artificial "ours" merge that records a tree that is identical to one
> of its parents, again perhaps by default?  "git log" works more or
> less in such a way already, but we might want to teach other modes
> like --full-history and --simplify-merges to ignore "ours" to hide
> such an artificial merge by default, with an audit option to
> unignore them.
>
> The history transfer will not break, as there is a true ancestry
> that preserves the superseded history leading to X, while in the
> daily use and inspection of the history, such a superseded history
> will not bother the user by default.  When the user really wants to
> see it (e.g. following a stale gitweb link, or with "git log $X"),
> such a superseded side history is still there.
>
> Private history rewriting lets us pretend to be perfect, which is a
> major plus in the distributed workflow Git gives us, and such a mode
> of operation will defeat that in a big way, which might turn out to
> be a major downside, of course.
>
> Also, rebases and filter branches that are done in order to excise
> unwanted objects from the history (committed a password in a file,
> anybody?) need a way to turn it off.

I started working on something like this a few weeks ago, but
eventually came to the conclusion that this information does not
belong in the commit graph itself. You have already identified some of
the same problems I found, so I will not repeat them. In the end, you
either publish everything (including bad things like passwords or
dead-ends), or you leave the the rebase history-preservation feature
turned off all the time and then forget to turn it on when it really
matters.

A better approach, I think, would be to enhance the reflogs to the
point where they can provide this information in a reliable manner.
The Git garbage collector already skips objects mentioned in the
reflogs, so "git reflog expire" just needs to learn how to avoid
deleting topologically-interesting entries like rebases. For a shared
scenario like github, this would prevent the server from expiring
published commits and creating broken links.

Since Git maintains reflogs for all heads, including those in
refs/remotes, this strategy for preserving history also works in a
collaborative environment. Each repository remembers what it has seen,
including rebases from remotes (which appear as "forced updates"). On
the other hand, work-in-progress commits only appear in the local
reflogs, and won't appear in other repositories unless someone pulls
or pushes them.

If it does become necessary to delete some published historical
information (like passwords), it is still possible to delete reflog
entries by hand. They are not part of the object database, so doing
this doesn't break any hashes.

-William
