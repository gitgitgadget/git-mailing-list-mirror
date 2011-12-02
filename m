From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Thu, 01 Dec 2011 18:59:04 -0800
Message-ID: <1322794744.1673.494.camel@yos>
References: <1322546563.1719.22.camel@yos>
	 <20111129090733.GA22046@sigill.intra.peff.net>
	 <1322603788.1728.190.camel@yos>
	 <20111130062512.GA5317@sigill.intra.peff.net>
	 <1322700075.1710.157.camel@yos>
	 <20111201052615.GA22141@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	spearce@spearce.org, torvalds@linux-foundation.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 02 04:00:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWJMQ-0000Jg-ME
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 04:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756425Ab1LBC7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 21:59:10 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48453 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353Ab1LBC7I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 21:59:08 -0500
Received: by iage36 with SMTP id e36so3436883iag.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 18:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=nCpGXyX7LtrgkrepSRaKh6JmiT4AHDUJfTMcyZWIPek=;
        b=NSeR9+kP78TBvHKC6GYnhBCQqifKBWDiVp0zpU1Dnfvbgzw7+fFGj9SviW1K3bQlVs
         zMfexVeL1n3ZneMmTIuwmLavOiQHMFQdSdL3Y3A7ZONKB3wL0691fXrZi0kMXB9FLRn1
         GXyGFFPyqditSTnXrjvI0gtQ4FUWBCI52W5GI=
Received: by 10.231.64.78 with SMTP id d14mr2601262ibi.56.1322794748153;
        Thu, 01 Dec 2011 18:59:08 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id z10sm28676870ibv.9.2011.12.01.18.59.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Dec 2011 18:59:04 -0800 (PST)
In-Reply-To: <20111201052615.GA22141@sigill.intra.peff.net>
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186209>

On Thu, 2011-12-01 at 00:26 -0500, Jeff King wrote:

> Cryptographically speaking, I think that claim is sound, and you can
> certainly construct attack scenarios where this detection would help.
> However, quantifying the effectiveness is difficult.  What is the
> likelihood of a malicious collided-object replacement being detected
> without your scheme? What is it with it?
> 
> There are many questions that factor into guessing the latter.
> 
> How often does Linus fetch from his own kernel.org repository? He would
> usually push, I would think.  Even if he does fetch, he wouldn't be
> getting the old objects that he already has. I guess this is the reason
> for your digest-of-digests for each commit object sent? 

Yes, - the digest of digests is used to check things that would not be
sent.

>
> But what about
> objects that are no longer in current commits, but are in older ones?

That's a good question, of course. After Linus pushes a commit, he'll
notify others, and if some fetch before the repository is hacked,
they will detect an error on a subsequent fetch.  For fetches, the
server reports a series of commits, and the client responds with 'have'
for those it has, with the CRCs added so the server can check for a
mismatch.  I made minimal changes to fetch-pack.c and upload-pack.c:
just adding the CRC fields to the messages already sent.  The server
asks about more commits than it actually transfers, but all the ones
it asks about are tested.  One could send additional 'have' replies
if necessary (for ones the server didn't mention) but I didn't do
that, partly for simplicity but also because I was looking at the
fetch-pack.c and update-pack.c code for the first time. If desired,
such changes can be added.

I also do some similar checking when a commit is pushed - the server
tells the client the last commit it has and the client will send the
CRCs in its reply to allow the server to cross check those.  I didn't
mention that before because only the latest is really checked. Again,
I just changed a message format (backwards compatible, of course),
but additional checking could be added if desired.

You could also add options to check tips of branches and all commits
that have tags (e.g., a v1.0 tag)  All of that simply requires more
work on commands such as fetch-pack, upload-pack, send-pack and
receive-pack.

> What about the server being more clever about hiding the replacement
> object? E.g., instead of just breaking into kernel.org and inserting a
> replacement object, the attacker runs a malicious git-daemon that
> returns the bogus object to cloners, but the real object to fetchers.

That's really a server-security issue, not a git one.  Perhaps
repositories should be configured so that all the executables are on
read-only partitions.  It's an important question in general of
course, but it is probably useful to distinguish attacks that put
bad data on a server from ones that install new software.

> 
> > It's also possible to write some additional commands to (for example)
> > fetch the SHA-1 hashes and CRCs from all remote repositories you use
> > and compare these to make sure they are all consistent, something that
> > can be run ocassionally.
> 
> But we can already do that. Assume you have an existing repo "foo". To
> verify the copy at git://example.com/foo.git, do a fresh clone to
> "bar", and then compare the objects in "foo" to "bar", either byte-wise
> or by digest.

Of course, but that is an expensive operation - in the case of Git
transferring some 50 MBytes of data per repository.  A command to
fetch the SHA-1 ID and a CRC or message digest for each object would
not only run faster, but should put a much lower load on the server.

Getting back to the birthday attack question (this is an area where
your comments were very useful for me), there's a case I didn't
consider.

Suppose two developers bounce code back and forth by email and one of
them commits it, but the other developer is a bad guy.  The bad guy
would then have had an opportunity to use a birthday attack by sending
back subtly modified code (e.g., changes to how comments are formated,
additional blank lines, etc.)  He can even put a humorous comment at
the end of the file such as "the first 200 Chinese characters I learned"
and then include the Chinese characters (I've tested this with gcc -
the Chinese characters, represented in Unicode, print in an editor and
are ignored by the compiler.)  Unicode is a lot closer to binary data
so you have a lot of bits you can alter in a small amount of space,
with each character requiring multiple bytes to represent it. The
comment will look silly but innocuous.  I think Linus Torvalds once
suggested being suspicious of anything that looked like "line noise"
in a patch.  Non-western unicode characters can serve the same function
but look legitimate, at least to people who don't know the language
and when coupled with some "social engineering" to set expectations.

As an example of how this attack might work, without breaking into a
system, assume two programmers collaborating on a project both have
write-access to the same shared repository.

1. The project is using  Java, with a rule that all classes and methods
that are protected or public be documented (so javadoc can create API
documentation).

2. Programmer A emails some Java source code to programmer B with a
request to edit the comments to improve them or fix any obvious
mistakes.

3. Programmer B fixes the comments, but also creates a modified file
with the same SHA-1 hash as the correct file in order to add some bugs
or security flaws. 

4. Programmer B creates a branch from an earlier version, adds some
tests, puts the contents of the modified file into the directory tree
under an obscure name, adds it and does a commit.  B then pushes it,
creating a new remote branch.

5. Programmer B then tells Programmer A that he'll have the modified
file back quickly, but could he please fetch his new remote branch
and run a test, and answer some questions about what happens as B needs
that information to finish his review of the documentation.

6. Programmer A tells B the results, so B knows that A has fetched the
remote branch, an B then sends A the corrected file (not the modified
one). Programmer A reviews the file, notes that everything seems OK,
specifically that only comments were changed, and runs commit -a
followed by a push.  Because Git tries to be smart, it will (I think)
notice from the SHA-1 hashes and from the remote branches that the
server already has the object so there is no need to send it.

8. Programmer B fetches the changes, deletes his temporary branch, both
locally and on the shared repository.  He tells A that the temporary
branch is deleted so that B should run "git branch update --prune ..."

So what happens?  Hopefully someone finds the problem, either through a
source-code review or some QA testing, but regardless Programmer A may
get the blame as the evidence of any tampering has pretty much been
erased.  In the worst case, a release with a security hole goes out.

Why would Programmer B do that?  Maybe he's leaving the company because
he's hard to work with and is blaming Programmer A for the problem, and
wants to "get back" at Programmer A by harming his career. But in any
case he didn't have to break into the repository to get the effect he
wanted. At least is is extremely hard to do in terms of computational
resources.

Bill
