Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03D8C3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 23:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjAOXdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 18:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjAOXdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 18:33:12 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCDE76BB
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 15:33:11 -0800 (PST)
Received: (qmail 9318 invoked by uid 109); 15 Jan 2023 23:33:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Jan 2023 23:33:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25230 invoked by uid 111); 15 Jan 2023 23:33:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Jan 2023 18:33:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 15 Jan 2023 18:33:09 -0500
From:   Jeff King <peff@peff.net>
To:     Crls <kaploceh@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org
Subject: Re: ctrl-z ignored by git; creates blobs from non-existent repos
Message-ID: <Y8SNNeQ3fQdrf5Fi@coredump.intra.peff.net>
References: <632d051b-d81b-b35d-0641-c2488a124810@gmail.com>
 <Y8Qfj32h89hq5UD6@mit.edu>
 <Y8SCZvMu7DZZH1Pl@localhost.my.domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8SCZvMu7DZZH1Pl@localhost.my.domain>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2023 at 05:47:02PM -0500, Crls wrote:

> > Now, when you type ^Z, the git processes are stopped --- but the
> > objects are created already.
> 
> The directories exist not because ^Z is used, but because by the time
> git-clone prompts for a username, git is already set on what to do
> next. Correct? in other words, the process is shoved down my throat.
> Or the user's throat in this case. Or going by another analogy, it
> certainly sounds as if I meant: «Git, please git-clone such and such
> repo, but let me fix just a typo on the repo name before submitting
> it, pretty please» and then Git replies: «too late for that
> chick-a-doodle» and there it goes. It injects blobs all over (well,
> not all over but on the dir specified).

I don't know what you mean by "blobs" here, since we fail to download
any Git objects at all, let alone blobs. But yes, Git creates the local
repository, and then tries to fetch into it. So the directory is created
before it even contacts the remote server at all, and you will see the
same behavior whether the repository exists or not. And then if an error
occurs, it will rolls back by deleting the newly-created repository.

It _could_ be possible to contact the server first, and only when things
looked successful-ish, to create the local repository. But:

  1. The clone command is simply not written that way, and converting it
     now would be tricky. The clone command's view of the world is that
     it makes a new repository, sets up config, etc, then fetches into
     it.

  2. It would not fix all cases anyway. At some point we have to say
     "this looks close enough to success to create the directory", but
     things can still go wrong after that.

Now if you have a problem with the rollback, there might be a bug there.
But it sounds like you are simply stopping the process and not letting
it finish. It should roll back even if it receives a signal death, but
^Z is stopping the job and putting it in limbo. If it hurts, don't do it
(or use "fg" or "bg" to let it finish).

> > So what's going on is that github.com is not returning a non-existent
> > repo error; it's prompting for a username/password, as _if_ the
> > repository exists.  That's presumably to prevent disclosing
> > information as to whether or not a private repository exists or not.
> 
> I agree with you there. Coincidentally speaking, why does a username
> warrants a prompt from git, is simply beyond me. I mean, that is
> certainly the more far-fetched reasoning of implementation I've read
> in a long long time.
> 
> Can you git-clone a user? What about the user's settings? What about
> the remainder its gpg tokens and so forth? In other words, if a user's
> repo is not found, why even prompting for a username? The latter, that
> is, the user's repo, is redundant,  when the prompt is clearly asking
> for a username, and not a repo.

Huh? GitHub cannot tell you whether you have access to a repository (or,
for privacy reasons of the owner of the hypothetical repository, whether
a repository of that name might exist) unless you authenticate. So it
returns an HTTP 401. Your authentication in this case requires a
username and password. Git asks for the username first, then the
password.

Is there something else you think GitHub should be returning there? Or
something else you think Git should do with an HTTP 401?

-Peff
