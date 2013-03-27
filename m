From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Composing git repositories
Date: Wed, 27 Mar 2013 17:19:38 +0530
Message-ID: <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 12:50:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKos8-000515-Lh
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 12:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab3C0Lt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 07:49:59 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:47915 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780Ab3C0Lt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 07:49:58 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so7560960ieb.23
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 04:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=iKHxBepuBmtZAUzAkX1TJeR5ST7TpaJzzWCLOmBfqc4=;
        b=o8JhIA3g51R+Ohn0sL2XWcm5nZXaBv/Hff0mPXmr1xgtSU6GPmhdnQti0Tn2pgML9e
         gJyytOp9rGroUdaTv30qWcRSbLX5Y8cvLH6w7CJ1cuYpsQO1yDr5laMhkZgKhvJdoQ2m
         fiGlHyXOfo7WSDwY/OnT//FvbC9VS5kF0rddsFjsO1rGSJPE/AbmNAk9wcEAQrhWwn7f
         atbXPYtg2CZSJYxiGQ3ISBcJSJJYjLD4FnKNjKm6Zgk1RBrzxU2oQJzOT4sCihDbQGqW
         PZW3/Skcy58am3RXP5i+oWPWirfhk9LgviqlqeMUsIL5Dw8/Dypb/SUg8sVUpXuyrv1z
         jJTQ==
X-Received: by 10.50.119.102 with SMTP id kt6mr4141085igb.12.1364384998270;
 Wed, 27 Mar 2013 04:49:58 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 27 Mar 2013 04:49:38 -0700 (PDT)
In-Reply-To: <7vmwtqt8rs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219245>

Junio C Hamano wrote:
> So you have to stash it somewhere.  We could have made it to move
> them to $HOME/.safeplace or somewhere totally unrelated to the
> superproject.  So in that sense, the repositories are *not* owned by
> the superproject in any way.  However, you are working within the
> context of the superproject on the submodule after all, and
> somewhere under $GIT_DIR/ of the superorject is not too wrong a
> place to use as such a safe place.

Thanks for the explanation.  The paths in .git/modules are unnecessary
ugly and unwieldy, especially in the case of multiple levels of
nesting: I'll look into converting it to a flat structure using
<repository name>.git, while handling name conflicts.  I'll also look
into adding a feature to relocate this/ using an object store from an
existing clone.

> Look for floating submodules in the list archive.

The most relevant message thread I could find was [1], back from 2011.
 You argue that floating submodules are Wrong, and that there is no
real usecase for it.

Like I explained earlier, I'm looking at one tool that solves a
superset of the problems mr, repo, submodules, subtrees, and other
tools solve.  I really like the way repo allows me to work on a meta
project like Android or ChromiumOS, but hate that it allows for zero
composition.

To move forward, I have the following design thoughts (elaborating on
my previous email):

1. If .gitmodules is tracked like a normal file, it is absolutely
impossible to tell the possible dependencies of the superproject
without cloning it entirely, and looking at the .gitmodules file in
each of the branches.  Can't we have it as a special ref instead, so I
can `git fetch` just that ref to figure out the dependencies?

2. True composition requires that I be able to specify the entire
manifest (for nested submodules) in the toplevel .gitmodules, or break
it up as I see fit.  This is currently impossible, and brings us back
to #1: the manifest for b/, b/c are in the toplevel repo's special
ref, and I need to fetch c's special ref to figure out what d is (or
error out if no such thing exists).

3. True floating submodules are impossible, because a change in the
submodule means a change in the commit object referenced by the
superproject's tree object; diff-tree will see that some content has
changed in the repository.  We can represent that diff however we want
(using diff.submodule), but we can't change the fact that the change
has to be committed.  Fixing this will require nothing short of
introducing a new kind of object (say "submodule" object which can be
a concrete SHA-1 or point to a ref).

Do you think thinking about these things is worthwhile?  I see more
complaints like [2] as git adoption in the industry increases, but we
have no solution: we can't make git scale to super-large repositories,
and we have no real way to compose smaller repositories.  Hacks like
repo sadden me.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/185164
[2]: http://thread.gmane.org/gmane.comp.version-control.git/189776
