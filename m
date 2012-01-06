From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] clone: allow detached checkout when --branch takes a tag
Date: Fri, 6 Jan 2012 14:35:21 +0700
Message-ID: <CACsJy8B2FGzQ2FFAx2wJohmkWe41+UETx6FZFwLNGY2fb74ZNg@mail.gmail.com>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com> <7v7h16nmpy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 08:36:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rj4LK-0003YG-QL
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 08:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468Ab2AFHfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 02:35:54 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46299 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab2AFHfx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 02:35:53 -0500
Received: by eaad14 with SMTP id d14so816833eaa.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 23:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qFShqBtpJVlwQ0srys/EX0LjEZN7WvOJgIhRT0/4Iz8=;
        b=chjbtKHbG0tZtf0nPsInwL5+HuSkBCifPLYd837xf8XXtEcRf+xCZBvRgq3bdRXjfO
         IT0G9UuTDl7oULJRvvyXfSBYzkLZNOrPTPFCB+H0BpNTe/3LfT5kTubBIN9YPIxRqQVa
         C5voYCjA4o579SBz2K2l3XYbDm4fawl4iS/LE=
Received: by 10.204.9.218 with SMTP id m26mr2134698bkm.44.1325835352150; Thu,
 05 Jan 2012 23:35:52 -0800 (PST)
Received: by 10.204.32.197 with HTTP; Thu, 5 Jan 2012 23:35:21 -0800 (PST)
In-Reply-To: <7v7h16nmpy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188014>

2012/1/5 Junio C Hamano <gitster@pobox.com>:
> Also, the user is likely to want to fetch and integrate from the origin
> with his own history. How should "git pull" and "git fetch" work in the
> resulting repository? What should the remote.origin.* look like?

fetch should behave the same regardless this patch. remote.origin.*
looks exactly the same. Branch tracking is not set up so pull works
half way.

> You clone a single lineage of the history, either shallowly or fully,
> either starting at the tip of one single branch or a named tag.
>
> What is the expected use scenario of a resulting repository of this new
> feature? As this is creating a repository, not a tarball extract, you
> certainly would want the user to build further history in the resulting
> repository, and it would need a real branch at some point, preferably
> before any new commit is made. Which makes me think that the only reason
> we would use a detached HEAD would be because we cannot decide what name
> to give to that single branch and make it the responsibility of the user
> to run "git checkout -b $whatever" as the first thing.

We can still commit with detached HEAD but I guess it's not
recommended. For a quick, throwaway repository, it's probably OK.

> I think the real cause of the above is because this patch and its previous
> companion patch conflate the meaning of the "--branch" option with the
> purpose of specifying which lineage of the history to copy. The option is
> described to name the local branch that is checked out, instead of using
> the the same name the remote's primary branch. But these patches abuse the
> option to name something different at the same time---the endpoint of the
> single lineage to be copied.
>
> These two may often be the same, and use of "clone --branch=master" in
> such a case would mean that you want to name the local branch of the final
> checkout to be "master" _and_ the endpoint of the single lineage you are
> copying is also their "master".
>
> But the "tag" extension proposed with this change is different.
>
> You are specifying an endpoint of the single lineage with the option that
> is different from any of the branches at the origin, and because you used
> the "--branch" option for that purpose, you lost the way to specify the
> primary thing the option wanted to express: what the name of the resulting
> checkout should be.
>
> Perhaps something like "clone --branch=master --$endpoint=v1.7.8" that
> says "I want a clone of the repository limited to a single lineage, whose
> history ends at the commit pointed by the v1.7.8 tag, and name the local
> checkout my master branch" be more appropriate?

Branch naming is a local thing. Maybe we could get away with always
name it "master" if fetched from a tag. Branch tracking is not set up
in this case, so if they want to follow up with upstream, they have to
do some more themselves (including renaming "master" to something else
for less confusion with upstream "master"). New option is not easily
discovered, while "git branch -r master foo" is quite easy.
-- 
Duy
