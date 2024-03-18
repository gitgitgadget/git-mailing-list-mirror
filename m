Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8DB2C850
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751781; cv=none; b=r8XbZ3Qjq/q4g91EagSHtRBXZSlnRO8/+rPgiiHk8ti/qnQg0sahJJ3ND0UOWvgNPGV99uBrHgq54YfY+TMet9cgMKv+FVWjRo3NmhDfwnPpxUFaXofnP4+r7MhFZRn4rAXJD6fNnc6WXf9PTdqzEez0zkmGluOfUKnYeO/CbmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751781; c=relaxed/simple;
	bh=qqJCyyoOxyyzLClY8yIHXhz8kKh56nJbr+L6slct39A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RU2nGydf1WxLW9v7m7abSTAHdFW/PBYyCHBkuoY3NwpCPc4cP2HKkZXdTWg7v1RREEE6znRJFcnme+zL26h8uTZcikXKSrQwR3jo5jz/7S8vNttV5QvnrZ5ZD0oA1xrhHniHr52ooGlAsIEQrp6tJkHuDnrXjHypanciQ1N6TmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9003 invoked by uid 109); 18 Mar 2024 08:49:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Mar 2024 08:49:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26692 invoked by uid 111); 18 Mar 2024 08:49:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Mar 2024 04:49:42 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Mar 2024 04:49:37 -0400
From: Jeff King <peff@peff.net>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc/gitremote-helpers: match object-format option
 docs to code
Message-ID: <20240318084937.GB602575@coredump.intra.peff.net>
References: <20240307084735.GA2072130@coredump.intra.peff.net>
 <20240307085632.GB2072294@coredump.intra.peff.net>
 <Zeo9oAkL6kxZRugN@tapette.crustytoothpaste.net>
 <20240312074513.GA47852@coredump.intra.peff.net>
 <ZfIWkJieqcPv5jA8@tapette.crustytoothpaste.net>
 <87ttl99e0b.fsf@gmail.froward.int.ebiederm.org>
 <ZfNqVowQBy47_92m@tapette.crustytoothpaste.net>
 <87msqzo63f.fsf@gmail.froward.int.ebiederm.org>
 <20240316060427.GB32145@coredump.intra.peff.net>
 <87v85k4mcp.fsf@gmail.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v85k4mcp.fsf@gmail.froward.int.ebiederm.org>

On Sun, Mar 17, 2024 at 03:47:18PM -0500, Eric W. Biederman wrote:

> >   - the docs say "object-format true", but the code just says
> >     "object-format". They're semantically equivalent, so it's just a
> >     minor syntax issue.
> 
> I am a bit confused on this point after having read the code.  It
> appears that when "object-format" is sent remote-curl
> experiences "object-format true".

Right, this is due to this code in remote-curl.c:

                  } else if (skip_prefix(buf.buf, "option ", &arg)) {
                          char *value = strchr(arg, ' ');
                          int result;
  
                          if (value)
                                  *value++ = '\0';
                          else
                                  value = "true";

which goes way back to the beginning of remote-curl, even though I don't
think Git ever sends a value-less option. Anyway, that's presumably why
nobody noticed that "option object-format" is unusual.

> Assuming remote-curl is the only remote helper that currently implements
> the object-format capability.  I think we ant to fix transport-helper to
> send "object-format true" just to be consistent with all of the other
> options.

We could be breaking third-party helpers that we don't know about. Of
course, those helpers would have to have ignored the documentation. And
I suspect they simply don't exist, or somebody would have showed up and
asked about it (coupled with how new and relatively obscure the hash
algorithm work has been so far).

So maybe we can get away with fixing it now. We should definitely break
it out into its own patch so we can decide independently, though.

> >   - the docs say that Git may write "object-format sha256" to the
> >     helper, but the code will never do that.
> 
> It looks like remote_curl will get confused in that case when it
> processes "object-format sha256" as well.  As it stores that value in
> options.hash_algo, which in all other cases is used to store what the
> hash algorithm computed from the remote side.

Yeah, it ends up in the same variable. I _suspect_ it would simply be
overwritten by the remote repo's idea of the hash. I'm not sure if
that's a bug (if the specific algorithm given by the main process is
supposed to take precedence) or a feature (if it's just a suggestion,
and then the helper says "tough luck, the remote is using sha1"). It's
hard to tell because Git never sends it. ;)

> As I read things the happy path for most connections is either going to
> turn into git protocol v2, git-fast-export, or git-fast-import.
> Unless I am misunderstanding something all of those will bypass
> the code paths the remote helper object-format capability affects.
> It is only when the remote helper send "fallback" during connect
> that the remote helper format capability might be used.

Yeah, I suspect that is true for remote-curl. It may not be for other
helpers which don't support "connect".

> The only practical need I can imagine for this is if the client
> is going to send oids before asking the remote side what it's oids
> are.  The only case I can imagine doing this is the initial push
> of a repository.

Hmm, I _think_ we are OK there in practice. Even if there are no refs on
the remote repo (running git-receive-pack), it will still issue a
capability line with its object-format. And then the helper (say,
remote-curl) will report that back to the caller (git-push) who might
say "hey, wait, there's a mismatch". And indeed, it seems to work in
practice with remote-curl, where the push yields:

  fatal: the receiving end does not support this repository's hash algorithm

In theory I suppose Git could directly issue a "push" command to the
helper (which would then specify oids along with refs to push) without
ever issuing "list for-push" (which is what causes the helper to contact
the remote to discover and report back the object format). But it
doesn't do that, and I don't see why it ever would.

This is all neglecting dumb protocols that don't even know how to figure
out the object format of the other side, but I think that's an
orthogonal problem. Either it remains unsolved, or whatever solution we
come up with then gets pushed back over the transport-helper protocol in
the same way.

> My sense is that unless we can find a current case that was overlooked
> during the initial conversion we should remove "object-format
> <hash-function>" support from the code and the documentation.

Yeah, if you don't have any plans to use it for interop work, then I
think we can declare it useless. I'll rework my patch series a bit to
remove the useless sending-side code, and then add a patch on top to
switch the "true" syntax as discussed above.

> Looking at the code in transport-helper.c:push_refs it appears the one
> use case I can think of is explicitly not supported. The code says:
> >	if (!remote_refs) {
> >		fprintf(stderr,
> >			_("No refs in common and none specified; doing nothing.\n"
> >			  "Perhaps you should specify a branch.\n"));
> >		return 0;
> >	}

That only triggers if you didn't ask to push anything. You might have a
sha256 ref locally and say "git push origin my-branch", and then we'd
need to communicate the ref/oid combo for my-branch to the helper. But
as above, I think by that point the helper will have discovered and
reported back the object-format to push.

> Mostly it deletes and simplifies code, but I found one case where
> a malfunctioning remote helper could confuse us, so I added a check
> to ensure :object-format is sent when we expect it to be sent.

That's probably a reasonable thing to check. We should update the docs
to indicate that it's required to send back ":object-format" if the
helper negotiated that capability. I'll add a patch to do that.

> Does that jive with how you are reading the situation?

Yep, I think I have a good sense how to proceed. It may be a day or so
before I produce a series. Thanks for the discussion!

-Peff
