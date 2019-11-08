Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17C41F454
	for <e@80x24.org>; Fri,  8 Nov 2019 12:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfKHMpk (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 07:45:40 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196]:49575 "EHLO
        smtp1.lauterbach.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfKHMpk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 07:45:40 -0500
Received: (qmail 10516 invoked by uid 484); 8 Nov 2019 12:45:37 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.10.40 by smtp1.lauterbach.com (envelope-from <ingo.rohloff@lauterbach.com>, uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.10.40):. 
 Processed in 0.084829 secs); 08 Nov 2019 12:45:37 -0000
Received: from unknown (HELO ingpc3.intern.lauterbach.com) (Authenticated_SSL:irohloff@[10.2.10.40])
          (envelope-sender <ingo.rohloff@lauterbach.com>)
          by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <gitster@pobox.com>; 8 Nov 2019 12:45:37 -0000
Date:   Fri, 8 Nov 2019 13:45:36 +0100
From:   Ingo Rohloff <ingo.rohloff@lauterbach.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: Forbid to create local branches with confusing
 names
Message-ID: <20191108134536.43d6e476@ingpc3.intern.lauterbach.com>
In-Reply-To: <xmqq36ezoz6i.fsf@gitster-ct.c.googlers.com>
References: <20191106165628.28563-1-ingo.rohloff@lauterbach.com>
        <xmqqftj0qkzm.fsf@gitster-ct.c.googlers.com>
        <20191107135409.13fa0336@ingpc3.intern.lauterbach.com>
        <xmqq36ezoz6i.fsf@gitster-ct.c.googlers.com>
Organization: Lauterbach GmbH
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Junio,

> > I think I did not explain the intention that well.
> > What I basically want to avoid is a situation in which there is
> > no way at all to refer unambiguously to a particular reference.  
> 
> Hmph, I thought this was a solved problem, but maybe I am still
> misunderstanding you.

You are right, this is partly solved: 
Deleting such a reference to a local branch is always possible.
But these kind of problems are not solved fully.

To explain my issue more concisely:
I start in any "regular" git repository.
   Regular ==  Repository was cloned from somewhere so a remote
   named "origin" and a remote-tracking branch named "origin/master"
   do exist. 

I fire off the following four commands
(Yes: This is malicious and stupid ;-))

   git checkout master
   git branch origin/master
   git branch remotes/origin/master
   git branch refs/remotes/origin/master

git does not complain at all here.

Then I try the following three commands.

   git branch somework origin/master
      warning: refname 'origin/master' is ambiguous.
      fatal: Ambiguous object name: 'origin/master'.

   git branch somework remotes/origin/master
      warning: refname 'remotes/origin/master' is ambiguous.
      fatal: Ambiguous object name: 'remotes/origin/master'.

   git branch somework refs/remotes/origin/master
      warning: refname 'refs/remotes/origin/master' is ambiguous.
      fatal: Ambiguous object name: 'refs/remotes/origin/master'.


QUESTION: 
I think I am lost now. That's where I might have overlooked something ?



I might continue with (this is the solved case):

   git branch -d refs/remotes/origin/master
      Deleted branch refs/remotes/origin/master (was 3454f30).

Sounds rather scary (because this sounds like you deleted a 
remote-tracking branch), but actually does the right thing I guess.
(The command deletes refs/heads/refs/remotes/origin/master)


After which this succeeds:

   git branch somework refs/remotes/origin/master
      Branch 'somework' set up to track remote branch 'master' from 'origin'.




PATCH:
Make this fail:

   git branch refs/remotes/origin/master
      fatal: Invalid new branch name: 'refs/remotes/origin/master'

This avoids the failure for 

   git branch somework refs/remotes/origin/master


and to avoid very similar issues make these fail too:

   git tag -m "a tag" refs/remotes/origin/master
      fatal: Invalid new tag name: 'refs/remotes/origin/master'

   git remote add refs/heads ssh://ds1/home/irohloff/git/gcc_build.git
      fatal: Invalid new remote name: 'refs/heads'


All of these examples use really pathological names for tags/remotes/branches.
I cannot believe that anyone wants to do this intentionally.

QUESTION:
Are there more user created, command line specified refnames 
in addition to tags/remotes/branches ?




If you have time:

Some more background.
The whole idea behind the patch: 
Make sure "refs/" is a "unique" prefix, which only
appears as ".git/refs/".
This should ensure that "refs/" only matches
to the very first entry from:
	static const char *ref_rev_parse_rules[] = {
		"%.*s",
		"refs/%.*s",
		"refs/tags/%.*s",
		"refs/heads/%.*s",
		"refs/remotes/%.*s",
		"refs/remotes/%.*s/HEAD",
		NULL
	};  

So goal: Make sure
  refs/refs/*          does not exist
  refs/tags/refs/*     does not exist
  refs/heads/refs/*    does not exist
  refs/remotes/refs/*  does not exist

To avoid the existence of refs/remotes/refs/* it is necessary to 
also prohibit a standalone "refs" as remote name (not just "refs/*");
and to handle that more easily I also prohibit a standalone "refs"
for tags and branches.

Of course you might still create all these nasty subdirs with plumbing.
I try to avoid that this is done with porcelain.
(At least that's as far as I understand git terminology.)
Of course future git extensions might try to create something like
  .git/refs/refs/*
but since these extensions are reviewed, I guess it is easy to nudge
authors of extensions (like git-svn, git-bisect, ...) to NOT do this.

so long
  Ingo


PS: 
I really think per default more prefixes than just "refs/" should
be forbidden when creating tags/remotes/branches.
But I also agree with you that this is much less straight forward
(Which prefixes to forbid ? Config option ? How much does this break ? ...).
As far as I can tell tags/remotes/branches, which 
are called "refs/*" or "refs" are completely pathological; 
I think unconditionally forbidding to create these kind of 
refnames for tags/remotes/branches with porcelain is OK.

BTW: This is also quite confusing 
(but does not really hurt and is consistent with what you described)

   git branch -r -d refs/remotes/origin/master
      error: remote-tracking branch 'refs/remotes/origin/master' not found.

What is meant here is I think

   remote-tracking branch 'refs/remotes/refs/remotes/origin/master' not found.
