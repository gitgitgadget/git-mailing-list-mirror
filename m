From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC/WIP] Pluggable reference backends
Date: Mon, 10 Mar 2014 12:00:32 +0100
Message-ID: <531D9B50.5030404@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 12:01:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMxx6-0002YN-E3
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 12:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbaCJLAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 07:00:40 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63204 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753101AbaCJLAh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 07:00:37 -0400
X-AuditID: 12074414-f79d96d000002d2b-32-531d9b54bc95
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 86.0B.11563.45B9D135; Mon, 10 Mar 2014 07:00:36 -0400 (EDT)
Received: from [192.168.69.148] (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2AB0XFO021007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 07:00:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqBsyWzbY4PI+RYud6yQsuq50M1nM
	u7uLyeJHSw+zxcfOBcwOrB47Z91l97j08jubx8dny9k9nvXuYfT4vEkugDWK2yYpsaQsODM9
	T98ugTtj6c2ZrAWH3Ss2X+hlaWB8b9HFyMEhIWAi8XJlQhcjJ5ApJnHh3nq2LkYuDiGBy4wS
	d2+eZodwzjNJfJt3mRmkildAW+LinTYWEJtFQFVi4/uHYHE2AV2JRT3NTCC2qECwxOrLD1gg
	6gUlTs58AmaLANXsenYVbAOzQC+jxLuWo2ANwgL6Eg+//2KFuEhcoqcxCCTMLKAj8a7vATOE
	LS+x/e0c5gmM/LOQjJ2FpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RS
	U0o3MUJCWWQH45GTcocYBTgYlXh4M17LBAuxJpYVV+YeYpTkYFIS5a2YLhssxJeUn1KZkVic
	EV9UmpNafIhRgoNZSYR38zSgHG9KYmVValE+TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQimKwM
	B4eSBG/hDKBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBExhcDYxIkxQO0twSk
	nbe4IDEXKArReopRl+N2269PjEIsefl5qVLivBGzgIoEQIoySvPgVsAS1ytGcaCPhXl1Qap4
	gEkPbtIroCVMQEuaj0uBLClJREhJNTBqTL5XnN/VKHDaV7Ro6Yxd9299Ohwxc/VzN/f5y2xs
	1q8Qc2F3nnZveZS8tuGPCyeajG55VgVvt2p6bH1Qcv6mtG1nlAsk5u5yEEoMPlT2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243726>

I have started working on pluggable ref backends.  In this email I
would like to share my plans and solicit feedback.

(This morning I removed this project from the GSoC ideas page, because
it is unfair to ask a student to shoot at a moving target.)

Why?
====

Currently, the reference- and reflog-handling code in Git is too
coupled to the rest of the system.  There are too many places that
know, for example, the difference between loose and packed refs, or
that loose references are stored as files directly under
$GIT_DIR/refs/heads/, or the locking protocols that have to be adhered
to when managing references.  This tight coupling, in turn, makes it
nearly impossible to experiment with alternate reference storage
schemes.

But there is a lot of potential to use alternate reference storage
schemes to fix some currently-unfixable problems, and to implement
some cool new features.

Unfixable problems
------------------

The on-disk format that we currently use to store references makes
some problems impossible to fix:

* It is impossible to get a self-consistent snapshot of all references
  at a given moment in time.  This makes it impossible, even in
  principle, to do object pruning in a 100% race-free way.  (Our
  current workaround of not deleting objects that are less than two
  weeks works in most cases but, aside from being ugly, has holes.

* There are awkward filesystem-imposed constraints on reference
  naming, for example:

  * D/F conflicts (I): it is not possible to have branches named
    "my-feature" and "my-feature/base" at the same time.

  * D/F conflicts (II): it is not possible to have reflogs for
    branches named "my-feature" and "my-feature/base" at the same
    time.  This leads to the problem that it is not, in general,
    possible to retain reflogs for branches that have been deleted.

  * There are additional constraints on reference names depending on
    the filesystem used to store them.  For example, a Git repository
    on a case-insensitive filesystem fails in confusing ways if there
    are two loose references whose names differ only in case; however,
    packed references differing in case might work for a while.  Also,
    reference names that include Unicode characters can have their
    normalization form changed if they are written on Mac OS.

* The packed-refs file has to be rewritten whenever a packed reference
  is deleted.  It might be nice to write 0{40} to a loose reference
  file to indicate that the reference has been deleted, but that would
  open the way for more D/F conflicts.)

Wild new ideas
--------------

So, I would like to reorganize the Git code to allow pluggable
reference backends.  If we had this, we could try out ideas like

* Retain the idea of loose/packed references, but encode loose
  reference names using a portable naming scheme before storing them
  to the filesystem; maybe something like

      refs/heads/Foo.42 -> refs.dir/heads.dir/%46oo%2e42
      logs/refs/heads/Foo.42 -> refs.dir/heads.dir/%46oo%2e42.log

  Yes, it looks uglier.  But users shouldn't be looking in these
  directories anyway.  This single change would prevent D/F conflicts,
  allow a reference to be deleted by writing 0{40} to its loose
  reference file, allow reflogs to be kept for deleted refs, and
  remove the problem of filesystem-dependent naming constraints.

* Store references in a SQLite database, to get correct transaction
  handling.

* Store references directly in the Git object database.

* Implement repository "groups" that share a common object database
  and also a common reference store.  Each repository in a group would
  get a sub-namespace in the shared database, and store its references
  in names like "refs/member/$MEMBERID/refs/heads/...".  The member
  repos would act like restricted views of the shared database.  This
  would be like a combination between alternates (with lowered risk of
  corruption) and gitnamespaces(7) (but usable for all git commands).

* Reference transactions that can be used across multiple Git
  commands.  Imagine,

      export GIT_TRANSACTION=$(git transaction begin)
      trap 'git transaction rollback' ERR
      git foo ...
      git bar ...
      git baz ...
      if ! git transaction commit
      then
          # Transaction failed; all references rolled back
      else
          # Transaction succeeded; all references updated atomically
      fi
      trap '' ERR
      unset GIT_TRANSACTION

  The "GIT_TRANSACTION" environment variable would tell git to read
  from the usual references, overridden with any reference changes
  that have occurred during the transaction, but write any changes
  (including both old and new values) to the transaction.  The command
  "git transaction commit" would verify that the old values listed in
  the transaction still agree with the current values, and then make
  all of the changes atomically.

  Such transactions could also be broadcast to mirrors when they are
  committed to keep multiple Git repositories in sync.

* One alternate backend might even be a shim that delegates to libgit2
  to do the actual reading/writing of references.  Then new backends
  could be implemented in libgit2 to allow both git and libgit2 to
  benefit.


The plan
========

It is currently not possible to experiment with any of these things
because of the tight coupling between the reference code and the rest
of git. The goal of this project is first to choke the interactions
down to a coherent interface, and second to make the implementation
selectable at runtime.  The implementation of specific alternate
backends will hopefully follow.

quagga references
-----------------

The overriding task is to isolate the reference-handling code; i.e.,
make sure that only code within refs.c touches git references, and
that the refs API provides all of the features that other code needs
to do its work.

So as a whimsical first milestone, I want to make it possible to
choose a different directory name for storing references and reflogs
by changing one #define statement in refs.c.  The goal is to get the
test suite to run correctly regardless of how this variable is set,
which would be a pretty good check that all reference-handling code
paths go though the refs API.  For no special reason I've been using
"quagga" as the new place, so references go to "$GIT_DIR/quagga/HEAD",
"$GIT_DIR/quagga/refs/heads/master", etc.  (Of course we wouldn't
actually *change* this name; it is only for testing purposes.)  I've
started working on this but there is a lot of code to change
(including test code).

Reference transactions
----------------------

I want to orient the new reference API as much as possible around
transactions.  I think a transaction is a flexible abstraction that
should be implementable by any backend (albeit not always with 100%
ACID compliance) and will allow a couple of existing races to be
fixed.

So as a first step, I will soon submit a patch series that starts
fleshing out the concept of a ref_transaction, and rewrites "git
update-ref --stdin" to use the new API.  For now, ref_transaction will
only be usable within a single git command invocation, but I want to
leave the way open to the GIT_TRANSACTION idea mentioned above.


Transition
==========

The current project is only to isolate the reference-handling code and
make it, in principle, exchangeable with another implementation.  It
doesn't require any transition.

Moreover, the changes will improve the modularity of the Git code, and
will be beneficial purely on those grounds.

When/if alternate backends are implemented, then the transition will
have to be handled on a case-by-case basis.  How references are stored
is mostly a decision internal to a single repository.  Any new
repository storage formats should be supported *in addition to* the
traditional storage scheme, to prevent the need for a flag day when
all repositories have to be converted simultaneously.

Git hosters [1] will be likely to take advantage of alternate
reference backends pretty easily, because they know which tools touch
their repositories and need only update those tools.  It is expected
that alternate reference backends will be useful for hosters even if
they don't become practical for end-users.

For end-users it is important that their repository be readable by all
of the tools that they use.  So if we want to make a new format a
viable option for normal Git users (let alone make it the new default
format), some coordination will be needed between all of the
commonly-used Git implementations (git-core, libgit2, JGit, and maybe
Dulwich, Grit, ...).  Whether or not this happens in real life depends
on how advantageous the hypothetical new format is to Git users and is
beyond the scope of this proposal.

Michael

[1] Full discloser: this includes my employer, GitHub.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
