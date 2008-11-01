From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 17:13:00 -0700
Message-ID: <20081101001300.GE14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <20081031213114.GA21799@artemis.corp> <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl> <20081031232829.GC14786@spearce.org> <7v63n872bs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 01:14:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw48A-00042U-Bi
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 01:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbYKAANE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 20:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbYKAAND
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 20:13:03 -0400
Received: from george.spearce.org ([209.20.77.23]:43685 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbYKAANB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 20:13:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8B5023835F; Sat,  1 Nov 2008 00:13:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v63n872bs.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99687>

Junio C Hamano <gitster@pobox.com> wrote:
> I understand that the apidocs/ is a very early work-in-progress, but
> still, it bothers me that it is unclear to me what lifetime rules are in
> effect on the in-core objects.

Yes, this needs a lot more documentation.

> For example, in C-git, commit objects are
> not just parsed but are modified in place as history is traversed
> (e.g. their flags smudged and their parents simplified).  You have "flags"
> field in commit, which implies to me that the design shares this same
> "modified by processing in-place" assumption.

Yup.  I was assuming the same model, we modify in-place.

> It is great for processing
> efficiency as long as you are a "run once and let exit(3) clean-up" type
> of program, but is quite problematic otherwise.  commit.flags that C-git
> uses for traversal marker purposes, together with "who are parents and
> children of this commit", should probably be kept inside traversal module,
> if you want to make this truly reusable.

Its not efficient to keep this data inside of the "traversal module"
instance (aka what I called git_revp_t).  You really want it inside
of the commit itself (aka git_commit_t).

My thought here is that git_commit_t's are scoped within a given
git_revp_t that was used when they were parsed.  That is:

  git_revp_t *pool_a = git_revp_alloc(db, NULL);
  git_revp_t *pool_b = git_revp_alloc(db, NULL);
  git_oid_t id;
  git_commit_t *commit_a, *commit_b, *commit_c;

  git_oid_mkstr(&id, "3c223b36af9cace4f802a855fbb588b1dccf0648");
  commit_a = git_commit_parse(pool_a, &id);
  commit_b = git_commit_parse(pool_b, &id);
  commit_c = git_commit_parse(pool_a, &id);

  if (commit_a == commit_b)
    die("the world just exploded");
  else
    printf("this was correct behavior\n");

  if (commit_a == commit_c)
    printf("this was correct behavior\n");
  else
    die("the hash table is broken");

To completely different git_revp_t's on the same database yeild
different commit pointers, but successive calls to parse the same
commit in the same pool yield the same pointer.

Certain operations on the pool can cause it to alter its state
in a way that cannot be reversed (e.g. rewrite parents).  In such
cases the caller should free the pool and alloc a new one in order
to issue new traversals against the same object database, but with
the original (or differently rewritten) parent information.

> By the way, I hate git_result_t.  That should be "int", the most natural
> integral type on the platform.

Yea, I'm torn on git_result_t myself.  Some library APIs use their
own result type, but as a typedef off int.

I'm tempted to stick with int for the result type, but I don't
want readers to confuse our result type of 0 == success, <0 ==
failure with some case where we return a signed integral value as
a result of a computation.

I'm also debating the error handling.  Do we return the error
code as the return value from the function, or do we stick it into
some sort of thread-global like classic "errno", or do we ask the
application to pass in a structure to us?

E.g.:

Return code:

  git_result_t r = git_foo_bar(...);
  if (r < 0)
  	die("foo_bar failed: %s", git_strerr(r));

Use an errno:

  if (git_foo_bar(...))
  	die("foo_bar failed: %s", git_strerr(git_errno));

Use a caller allocated struct:

  git_error_t err;
  if (git_foo_bar(..., &err))
  	die("foo_bar failed: %s", git_strerr(&err));

I'm slightly leaning towards the result code approach, as it means
we don't have to mess around with thread local variables.

We don't get to pass back anything more complex than an int (possibly
losing context about parameter values and/or on-disk state we want
to report on), but we also don't have to deal with thread-locals
or some messy "always pass a thread context parameter".

-- 
Shawn.
