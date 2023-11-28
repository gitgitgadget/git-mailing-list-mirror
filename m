Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082CCD63
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:04:47 -0800 (PST)
Received: (qmail 5763 invoked by uid 109); 28 Nov 2023 19:04:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Nov 2023 19:04:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13218 invoked by uid 111); 28 Nov 2023 19:04:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Nov 2023 14:04:48 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 28 Nov 2023 14:04:46 -0500
From: Jeff King <peff@peff.net>
To: Adam Majer <adamm@zombino.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Message-ID: <20231128190446.GA10477@coredump.intra.peff.net>
References: <20231117203253.21143-1-adamm@zombino.com>
 <20231128142845.11523-1-adamm@zombino.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231128142845.11523-1-adamm@zombino.com>

On Tue, Nov 28, 2023 at 03:28:45PM +0100, Adam Majer wrote:

> In a garbage collected bare git repository, the refs/ subdirectory is
> empty.  In use-cases when such a repository is directly added into
> another repository, it no longer is detected as valid. Git doesn't
> preserve empty paths so refs/ subdirectory is not present. Simply
> creating an empty refs/ subdirectory fixes this problem.

I understand your use case, but I still have a vague feeling that this
is bending some assumptions in a way that may create problems or
confusion later. In particular:

> Looking more carefully, there are two backends to handle various refs in
> git -- the files backend that uses refs/ subdirectory and the
> packed-refs backend that uses packed-refs file. If references are not
> found in refs/ subdirectory (or directory doesn't exist), the
> packed-refs directory will be consulted. Garbage collected repository
> will have all its references in packed-refs file.

This second paragraph doesn't seem totally accurate to me. There are not
really two backends that Git can use. For production use, there is just
one, the "files" backend, which happens to also use packed-refs under
the hood (and a convenient way for the code to structure this was a
subordinate backend). But it has never been possible to have a repo that
just uses packed-refs.

There is also the experimental reftable, of course. And there we have
not yet loosened is_git_directory(), and it has to create an unused
"refs/" directory (there has been some discussion about allowing it to
be an empty file, though no patches have been merged).

So with regards to the loosening in your patch, my questions would be:

  - if we are going to change the rules for repository detection, is
    this where we want to end up? We haven't changed them (yet) for
    reftables. If we are going to do so, should we have a scheme that
    will work for that transition, too? The "refs is an empty file"
    scheme would fix your use case, too (though see below).

  - is the rest of Git ready to handle a missing "refs/" directory? It
    looks like making a ref will auto-create it (since we may have to
    make refs/foo/bar/... anyway).

  - what about other implementations? Your embedded repos will
    presumably not work with libgit2, jgit, etc, until they also get
    similar patches.

  - what about empty repositories? In that case there will be no "refs/"
    file and no "packed-refs" file (such a repository is less likely, of
    course, but it may contain objects but no refs, or the point may be
    to have an empty repo as a test vector). Likewise, it is possible
    for a repository to have an empty "objects" directory (even with a
    non-empty refs directory, if there are only symrefs), and your patch
    doesn't address that.

> To allow the use-case when packed-refs is the only source of refs and
> refs/ subdirectory is simply not present, augment 'is_git_directory()'
> setup function to look for packed-refs file as an alternative to refs/
> subdirectory.

Getting back to your use case, I'd suggest one of:

  - do the usual "touch refs/.gitignore" trick to explicitly track the
    empty directory. It looks like the ref code will ignore this (we
    don't allow ref names to start with "." in a path component)

  - whatever is consuming the embedded repos could "mkdir -p refs
    objects" as needed. This is a minor pain, but I think in the long
    term we are moving to a world where you have to explicitly do
    "GIT_DIR=$PWD/embedded.git" to access an embedded bare repo. So
    they're already special and require some setup; adding an extra step
    may not be so bad.

Now it may be that neither of those solutions is acceptable for various
reasons. But it is probably worth detailing those reasons in your commit
message.

-Peff
