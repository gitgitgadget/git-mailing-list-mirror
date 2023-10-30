Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D34199B0
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737AEAB
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:43:08 -0700 (PDT)
Received: (qmail 3712 invoked by uid 109); 30 Oct 2023 17:43:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Oct 2023 17:43:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13490 invoked by uid 111); 30 Oct 2023 17:43:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Oct 2023 13:43:08 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Oct 2023 13:43:07 -0400
From: Jeff King <peff@peff.net>
To: Sheik <sahibzone@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Repository cloned using SSH does not respect bare repository
 initial branch
Message-ID: <20231030174307.GA854621@coredump.intra.peff.net>
References: <63eb269e-72b9-4830-98fc-aeef8b8180d7@gmail.com>
 <20231030093605.GE84866@coredump.intra.peff.net>
 <b310e254-f6d3-4715-b042-341bf5a98bbc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b310e254-f6d3-4715-b042-341bf5a98bbc@gmail.com>

On Tue, Oct 31, 2023 at 02:24:46AM +1100, Sheik wrote:

> Server version is same as client (v2.42.0) as I ran these commands all on
> the same machine.

OK. The next thing I'd check is running both commands with:

  GIT_TRACE_PACKET=1 git clone ...

to see the protocol trace, and how it differs between the two. What I
suspect you may see is that the local clone is using the "v2" protocol
(a capabilities report, followed by "ls-refs", which mentions the symref
value of HEAD), and the ssh one uses the older "v0" (it goes straight to
the ref advertisement).

Quoting from 59e1205d16 (ls-refs: report unborn targets of symrefs,
2021-02-05), the commit I mentioned before:

    This change is only for protocol v2. A similar change for protocol
    v0 would require independent protocol design (there being no
    analogous position to signal support for "unborn") and client-side
    plumbing of the data required, so the scope of this patch set is
    limited to protocol v2.

So in v0 the server doesn't pass back sufficient information for the
client to know about the name of the unborn HEAD branch.

If that's the culprit, the next question of course is why we'd do v2
locally versus v0 overssh. And that probably has to do with how we
trigger the protocol upgrade. To see if the server supports v2, the
client passes extra information "out of band". For git-over-http, this
happens in an extra HTTP header. For local repositories, it happens in
an environment variable ($GIT_PROTOCOL). For git-over-ssh it happens in
that sameenvironment variable, which we instruct the ssh client to pass
using "-o SendEnv". But:

  1. If your ssh client doesn't look like openssh, we don't know if it
     supports "-o" and may skip it. See the discussion in ssh.variant in
     "git help config".

  2. Some servers need to be configured to allow the client to set
     environment variables. In the case of openssh, you'd want a line
     like this in your sshd_config file:

       AcceptEnv GIT_PROTOCOL

Of the two, I'd guess that the second one is more likely to be your
problem (since you're running Linux, where openssh is the norm).

-Peff
