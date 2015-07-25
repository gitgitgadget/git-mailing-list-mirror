From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Question about git filter-branch with signed commits
Date: Sat, 25 Jul 2015 15:50:03 -0700
Message-ID: <CA+P7+xo+0cb38qjAJwrOtRahDwWgSvG+-5-6XAF6BpRSvnMXgw@mail.gmail.com>
References: <5085A037-0E20-4FA4-B553-E54345F4FAA5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Adam Liter <adam.liter@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 00:50:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJ8Gx-0006H4-QE
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 00:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbbGYWuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2015 18:50:23 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33331 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939AbbGYWuX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2015 18:50:23 -0400
Received: by igbpg9 with SMTP id pg9so57969934igb.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JqwlXwRP+2XGKKk7afZ7F6xWgu3E2alPzED1J47nuRA=;
        b=Ku/UxsMHHzQdSjZuAOu2vOY7edJ6EhpZjVNPq5hgq3C/RVxL5kjrKilyvTW8b70n6t
         edSlacR5jI2khl2Ibz2aTliG89TcU3zCYW911+1E9rwKuijq5ff6ua8ST4jcwSQgxAh6
         2RXY96rESiTn8fGP0qyKql0LYHyUc94eoADD9lcMXKqTwXmp8RFj89XOxE13mGQLAxsB
         P/W548mgYLBR8JdZrZ2uxThDXRniickuknlHGF+bH+44xDaswuqlwJeTIqXjnVQEb20y
         8AhSMfikSXhhf7+Kdi2VOoBXn4Hu/Bjl5A4HZQzZUlmQQbnBLAnjwxSOB5yBLazEkn+N
         H9eA==
X-Received: by 10.107.6.231 with SMTP id f100mr31194033ioi.61.1437864622497;
 Sat, 25 Jul 2015 15:50:22 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Sat, 25 Jul 2015 15:50:03 -0700 (PDT)
In-Reply-To: <5085A037-0E20-4FA4-B553-E54345F4FAA5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274623>

On Sat, Jul 25, 2015 at 1:17 PM, Adam Liter <adam.liter@gmail.com> wrote:
> Hello,
>
> I'm trying to clean up the commit history of a git repository by removing
> certain files. The repository contains signed commits, and when I try to use
> git filter-branch, the PGP signature is converted to the first line of the
> commit message.
>

It should be possible to craft a filter that removes the signatures
entirely. It is not possible to craft a filter-branch which retains
the signatures in any *valid* form, though you could re-create new
signatures assuming you have all the private keys (ie: you're the one
who signed all the commits).

You can't keep the signatures alone, because then they wouldn't be
valid, since the data they signed is not the same now. Normally
signatures are used so that you can verify "yes, so-and-so is the
person who did this thing and no one else could have faked it).

> Is this the expected behavior? If so, is there something that I can do to
> prevent this from happening?

I'm not sure why it's putting the first line at the top of the commit.

>
> I'm using git v. 2.4.6. I tried reducing the behavior to a simple case. I
> asked about this on Stack Overflow
> (http://stackoverflow.com/q/31552774/2571049), but the question hasn't
> really gotten any uptake, so I thought I would try asking here too.
>
> In trying to reproduce the behavior in a minimal way, I did the following:
>
> mkdir pgp-git-test
> cd pgp-git-test
> git init
> touch a.txt
> git add a.txt
> git commit -m "Add a.txt" -S
> touch b.txt
> git add b.txt
> git commit -m "Add b.txt" -S
> git filter-branch --index-filter 'git rm --cached --ignore-unmatch a.txt'
> --prune-empty HEAD
> git log --oneline --decorate
> b4efdf0 (HEAD -> master)  iQIcBAABCgAGBQJVrvqHAAoJ [...] -----END PGP
> SIGNATURE-----
> 9f82e63  iQIcBAABCgAGBQJVrvp7AAoJ [...]  -----END PGP SIGNATURE-----
>
> As can be seen after running git log --oneline --decorate, the PGP signature
> has become the first line of the commit. The rest of the commit message is
> still there, but it's on a line below the PGP signature.
>
> How can I prevent this from happening when using git filter-branch?

You probably need to run all the commits through a filter first which
strips out all signature info, and then re-write the commits to remove
the file. You can't leave the signatures in there alone, as they would
no longer be valid, and people who try to verify them would fail.

>
> Also, one thing that I was a bit surprised about when trying to create this
> minimal example is that the first commit is still there. Does anyone know
> why the commit history still contains the first commit, since the first
> commit only involved the file a.txt and since I passed --prune-empty to git
> filter-branch? Shouldn't this commit have been eliminated from the log?
>

I'm not sure about this part, sorry.

> Thanks in advance for the help! I'm relatively new to git, so apologies for
> bugging you all if this is a trivial error on my part. Thanks!
>
> Best,
> Adam Liter

Regards,
Jake
