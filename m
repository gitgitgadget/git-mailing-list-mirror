From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: filter-branch performance
Date: Wed, 10 Dec 2014 14:18:24 +0000
Message-ID: <CAFY1edYYC9TZmLE6b3=QAoTB1zQHi_Y97rHL-5wk5Pbpa_oj_w@mail.gmail.com>
References: <548744F1.9000902@gmx.de>
	<20141209185933.GC31158@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Henning Moll <newsScott@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 15:18:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyi6B-00029x-Gg
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 15:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455AbaLJOS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 09:18:28 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36521 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757415AbaLJOSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 09:18:25 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so6899325iga.15
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 06:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tuZnLAiaEUmyQKW8LIF0uNgdQ7YEwxIt/PoIJqlSbQk=;
        b=OM27AqsiZLyNCl3H+tPuh4tDgGr1T6SiVcF1VtHUnLZSHQEzZapTi8j84N5Jdf2j0p
         8TQWwjIrcWa9Jk5FgEWX3GzNdb4A6PZvgnGyRy5rGX2DmNNc1Q7d2ragg0sD4hcYnltu
         Q9uV2haKHl8/QJBdHHj4ZtPKYDOiA005jdo3vEQrXHhfmzbE2ygoEbnErC78hTZjruL7
         ZDwfzVdk1h7dqokJAOgysff81ub+2WNFl5I42S5aB9XktQv38DT+z2Se4f+bVguAe3Kt
         tedW8uONzvjDQ/p8MCSLlJW799vkYpxMJAexO4IldoxQbwGaopAyZeOT5grmven1bnIb
         DsjA==
X-Received: by 10.50.110.1 with SMTP id hw1mr26280327igb.13.1418221104819;
 Wed, 10 Dec 2014 06:18:24 -0800 (PST)
Received: by 10.64.240.171 with HTTP; Wed, 10 Dec 2014 06:18:24 -0800 (PST)
In-Reply-To: <20141209185933.GC31158@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261212>

On 9 December 2014 at 18:59, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 09, 2014 at 07:52:33PM +0100, Henning Moll wrote:
>> I assume that there is a lot of process forking going on. Could that be the
>> cause?
>
> Yes. filter-branch is a shell scripts, and it is probably running
> multiple git commands per commit it is filtering.
>
>> Any ideas how to further improve?

Depending on how much time you can sink into improving the performance
(versus just allowing the process to run to completion), you could
also look into a non-forking solution, as well as not bothering to
load the commit trees. To me non-forking means putting everything into
the JVM by using JGit, like the BFG does, though libgit2 might also be
an option.

Changing the BFG's code to do the transformation in your script is
absolutely trivial - define a commit-node cleaner like this:

object SetCommitterToAuthor extends CommitNodeCleaner {
  override def fixer(kit: CommitNodeCleaner.Kit) = c =>
c.copy(committer = c.author) // PersonIdent class holds name, email &
time
}

...trivial if you don't mind compiling Scala with SBT that is, and I'm
sure some people do! A DSL for non-Scala people to define their own
BFG scripts would be good, I must get on that some day.

The BFG is generally faster than filter-branch for 3 reasons:

1. No forking - everything stays in the JVM process
2. Embarrassingly parallel algorithm makes good use of multi-core machines
3. Memoization means no Git object (file or folder) is cleaned more than once

In the case of your problem, only the first factor will be noticeably
helpful. Unfortunately commits do need to be cleaned sequentially, as
their hashes depend on the hashes of their parents, and filter-branch
doesn't clean /commits/ more than once, the way it does with files or
folders - so the last 2 reasons in the list won't be significant.

For your specific use case tho', the fact that BFG doesn't load the
file tree at all unless it needs to clean it will also help.

I decided to knock up an egregious hack in the BFG to see what
performance would be like. I ran it against a fairly large repo
(https://github.com/bfg-repo-cleaner-demos/intellij-community-original),
100k commits, stored in /dev/shm, and used the SetCommitterToAuthor
code above. The BFG run completed in 31.7 seconds, you can see the
resulting repo here:

https://github.com/rtyley/intellij-community-set-committer-to-author

I started running the same test some time ago using filter-branch,
unfortunately that test has not completed yet - the BFG appears to be
substantially faster.

Before:
$ git cat-file -p b02bf46c4e93c2e8570910cdd68eb6f4ce21ff81
tree 7a412e49ecdbd966d7efe5fe746ff3ea3b6067d1
parent 8794219e3e84aed3cc8af926ffd74beafa51fb6b
author peter <peter@jetbrains.com> 1370854045 +0200
committer peter <peter@jetbrains.com> 1370854098 +0200

After:
$ git cat-file -p 3adb7b2a5c87320a5a028b6a59a7132c75a6e91c
tree 7a412e49ecdbd966d7efe5fe746ff3ea3b6067d1
parent 5efcdb551789b0d0bb541de9325f09521c5fbcb6
author peter <peter@jetbrains.com> 1370854045 +0200
committer peter <peter@jetbrains.com> 1370854045 +0200 <- time fixed

The relevant code is in:
https://github.com/rtyley/bfg-repo-cleaner/compare/set-committer-to-author
