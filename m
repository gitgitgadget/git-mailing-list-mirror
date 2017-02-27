Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044011F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 14:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbdB0OTY (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 09:19:24 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:34443 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbdB0OTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 09:19:17 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1ciKuH-0002Rz-Vl; Mon, 27 Feb 2017 13:00:02 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22708.8913.864049.452252@chiark.greenend.org.uk>
Date:   Mon, 27 Feb 2017 13:00:01 +0000
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Cooper <git@lakedaemon.net>,
        ankostis <ankostis@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Joey Hess <id@joeyh.name>
Subject: Transition plan for git to move to a new hash function
In-Reply-To: <20170226215220.jckz6yzgben4zbyz@sigill.intra.peff.net>
References: <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
        <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com>
        <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
        <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com>
        <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>
        <20170226001607.GH11350@io.lakedaemon.net>
        <20170226173810.fp2tqikrm4nzu4uk@genre.crustytoothpaste.net>
        <CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com>
        <CACBZZX6fP_JpL+K3XUnke=4m4gZBLu-Afyz5yJkrRnGXHuhR8A@mail.gmail.com>
        <20170226215220.jckz6yzgben4zbyz@sigill.intra.peff.net>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I said I was working on a transition plan.  Here it is.  This is
obviously a draft for review, and I have no official status in the git
project.  But I have extensive experience of protocol compatibility
engineering, and I hope this will be helpful.

Ian.


Subject: Transition plan for git to move to a new hash function


BASIC PRINCIPLES
================

We run multiple hashes in parallel.  Each object is named by exactly
one hash.  We define that objects with identical content, but named by
different hash functions, are different objects.

Objects of one hash may refer to objects named by a different hash
function to their own.  Preference rules arrange that normally, new
hash objects refer to other new hash objects.

The intention is that for most projects, the existing SHA-1 based
history will be retained and a new history built on top of it.
(Rewriting is also possible but means a per-project hard switch.)

We extend the textual object name syntax to explicitly name the hash
used.  Every program that invokes git or speaks git protocols will
need to understand the extended object name syntax.

Packfiles need to be extended to be able to contain objects named by
new hash functions.  Blob objects with identical contents but named by
different hash functions would ideally share storage.

Safety catches preferent accidental incorporation into a project of
incompatibly-new objects, or additional deprecatedly-old objects.
This allows for incremental deployment.


TEXTUAL SYNTAX
==============

The object name textual syntax is extended.  The new syntax may be
used in all textual git objects and protocols (commits, tags, command
lines, etc.).

We declare that the object name syntax is henceforth
  [A-Z]+[0-9a-z]+ | [0-9a-f]+
and that names [A-Z].* are deprecated as ref name components.

    Rationale:

      Full backwards compatibility (ie, without updating any software
      that calls git) is impossible, because the hash function needs
      to be evident in the name, so the new names must be disjoint
      from all old SHA-1 names.

      We want a short but extensible syntax.  The syntax should impose
      minimal extra requirements on existing git users.  In most
      contexts where existing git users use hashes, ASCII alphanumeric
      object names will fit.  Use of punctuation such as : or even _
      may give trouble to existing users, who are already using
      such things as delimiters.

      In existing deployments, refnames that differ only in case are
      generally avoided (because they are troublesome on
      case-insensitive filesystems).  And conventionally refnames are
      lower case.  So names starting with an upper case letter will be
      disjoint from most existing ref name components.

      (Note that there is no need to write the uppercase letter to a
      filename in the object store; the object store can use a
      different naming scheme.)

      Even though we probably want to keep using hex, it is a good
      idea to reserve the flexibility to use a more compact encoding,
      while not excessively widening the existing permissible
      character set.

Object names using SHA-1 are represented, in text, as at present.

Object names starting with uppercase ASCII letters H or later refer to
new hash functions.  Programs that use `g<objectname>' should ideally
be changed to show `H<hash>' for hash function `H' rather than
`gH<hash>'.)

    Rationale:

      Object names starting with A-F might look like hex.  G is
      reserved because of the way that many programs write
      `g<objectname>'.

      This gives us 19 new hash function values until we have to
      starting using two-letter hash function prefixes, or decide to
      use A-F after all.

New hash names my be abbreviated, by truncation (just like old
hashes).  The hash function indicator letter must be retained.

Initially we define and assign one new hash function (and textual
object name encoding):

  H<hex>    where <hex> is the BLAKE2b hash of the object
            (in lowercase)

    Note:

      If the git project prefers a different new hash function to
      BLAKE2b, that's fine.  This proposal can even cope with two new
      hash functions in parallel.  One could even choose on a
      per-project basis, or switch back and forth.

      It would also be possible to define a multihash object name,
      where the full object name is the concatenation of two different
      hash function values.  One of the hashes would have to be
      preferred for use when a truncated object name is provided by
      the human user.

We also reserve the following syntax for private experiments:
  E[A-Z]+[0-9a-z]+
We declare that public releases of git will never accept such
object names.

Everywhere in the git object formats and git protocols, a new object
name (with hash function indicator) is permitted where an old object
name is permitted.

A single object may refer to other objects the hash function which
names the object itself, or by other hash functions, in any
combination.  During git operations, hash function namespace
boundaries in the object graph are traversed freely.

Two additional restrictions: a tree object may be referenced only by
objects named by the same hash function as the tree object itself;
and, a tree object may reference only blobs named by the same hash
function.


IMPLEMENTATION REQUIREMENTS
===========================

The object store will need to store objects named by new hashes,
alongside SHA-1 objects.

In binary protocols, where a SHA-1 object name in binary form was
previously used, a new codepoint must be allocated in a containing
structure (eg a new typecode).  Usually, the new-format binary object
will have a new typecode and also an additional name hash indicator,
and it may also need a length field (as new hashes may be of different
lengths).

Whenever a new hash function textual syntax is defined, corresponding
binary format codepoint(s) are assigned.

Implementation details such as the binary format and protocol
specifications, object store layout, and so on, are outside the scope
of this transition plan.


WHILE WE ARE HERE
=================

We should audit the git data formats for inextensible parsers.  That
will make future changes (for whatever purpose) much less painful.

Specific instances I'm aware of:

* Permit commits and tags to contain unexpected header lines.  Ie,
  lines matching /^\w+\ / before the first blank like, where the
  keyword is not recognised.  These should be ignored.

* The signed push certificate format may need reviewing to check that
  there is space for extension.

The test suite should contain tests of these extension possibilities.

A registry (a la IANA) should be created for the extensible namespaces
(eg of header keywords).

Since new objects can be received and understood only by new software,
anyway, it will be safe to insert extension info whenever we generate
objects named by new hash functions.


CHOICE OF HASH FUNCTION
=======================

Whenever objects are created, it is necessary to choose the hash
function which will be used to name it.

Hash functions are partially ordered, from `older' to `newer'
(implicitly, from worse to better).  The ordering is configurable.
For details of the defaults, see _Transition Plan_.

Each ref has, optionally, a hash function hint associated with it.
Ie, a dropping in .git which names a particular hash function, with
the intent that the next objects made for that ref ought to use the
specified hash function.


Commits
-------

A commit is made (by default) as new as the newest of
 (i) each of its parents
 (ii) if applicable, the hash function hint for the ref to which the
     new commit is to be written

Implicitly this normally means that if HEAD refers to a new commit,
further new commits will be generated on top of it.

The hash function naming an origin commit is controlled by the hint
left in .git for the ref named by HEAD (or for HEAD itself, if HEAD is
detached) by git checkout --orphan or git init.

At boundaries between old and new history, new commit(s) will refer to
old parent(s).


Tags
----

A tag is created (by default) to by named by the same hash function as
the object to which it refers.


Trees
-----

Trees are only referenced by objects named by the same hash function
as the tree.

To satisfy this rule, occasionally a tree object named by one hash
must be recursively rewritten into an equivalent tree named by another
hash.

When a tree refers to a commit (ie, a gitlink), it may refer to a
commit named by a different hash function.

Trees generated so that they can be referred to by the index, are
named by the hash function which would name the next commit to be made
on HEAD (see `Commits', above)

    Rationale: we want to avoid new commits and tags relying on weak
    hashes.  But we should avoid demanding that commits be rewritten.


Blobs
----

Blobs are normally referred to by trees.  Trees always refer to blobs
named by the tree's own hash function.

Where a blob is created in other circumstances, the caller should
specify the hash function.


Ref hints
---------

As noted above, each ref may also have a hash function hint associated
with it.  The hint records an intent to switch hash function.

The hash hint is (by default) copied, when the ref value is copied.
So for exmple if `git checkout foo' makes refs/heads/foo out of
refs/remotes/origin/foo, it will copy the hash hint (or lack of one)
from refs/remotes/origin/foo.

Likewise, the hash hint is conveyed by `git fetch' (by default) and
can be updated with `git push' (though this is not done by default).

The ref hash hint may be set explicitly.  That is how an individual
branch is upgraded.  git checkout --orphan sets it to the hash which
names (or the hint of) the previous HEAD.

When a commit is made and stored in a ref, the hash hint for that ref
is removed iff hash naming the commit's is the same as the the hint.


CONFIGURATION - OBJECT STORE BEHAVIOUR
======================================

The object store has configuration to specify which hash functions are
enabled.  Each hash function H has a combination of the following
behaviours, according to configuration:

* Collision behaviour:

  What to do if we encounter an object we already have (eg as part of
  a pack, or with hash-object) but with different contents.

  (a) fail: print a scary message and abort operation (on the basis
    that either (i) the source of the colliding object probably
    intended the preimage that they provided, in which case proceeding
    using our own version is wrong, or (ii) the source is conducting
    (or unwittingly facilitating) an attack).

  (b) tolerate: prefer our own data; print a message, but treat
    the reference as referring to our version of the object.

  In both cases we keep a copy of the second preimage in our .git, for
  forensic purposes.

    Rationale:

       This is used as part of a gradual desupport strategy.  Existing
       history in all existing object stores is safe and cannot be
       corrupted or modified by receiving colliding objects.

       New trees which receive their initial data from a trustworthy
       sender over a trustworthy channel will receive correct data.
       Bad object stores or untrustworthy channels could exploit
       collisions, but not in new regions of the history which are
       presumably using new names.  So even with untrustworthy
       distribution channels, the collisons can only affect
       archaeology.

       Merging previously-unrelated histories does introduce a
       collision hazard, but the collision would have had to have been
       introduced while the colliding hash function was still a live
       hash function in at least one of the two projects.


* Hash function enablement:

  Each hash function is in one of the following states:

  (a) enabled: this hash function is good and available for use

  (b) deprecated (in favour of H2): this hash function is
     available for use, but newly created objects will use another
     hash function instead (specifically, when creating an object,
     this has function is not considered as a candidate; if as a
     result there are no candidate hash functions, we use the
     specified replacement H2).

     Existing refs referring to objects with this hash, with no ref
     hint, are treated as having a ref hint specifying H2.  If no H2
     is specified, the newest hash is used.

  (c) disabled: existing objects using this hash function can be
     accessed, but no such objects can be created or received.
     (again, a replacement may be specified).  This is used both
     initially to prevent unintended upgrade, and later to block the
     introduction of vulnerable data generated by badly configured
     clients.

* Preference ordering:

  As mentioned in `CHOICE OF HASH FUNCTION', there is a configured
  order on hash functions.  This order should be consistent with the
  enablement configuration.

Details of precise configuration option names are beyond the scope of
this document.


Remote protocol
---------------

During protocol negotation, a receiver needs to specify what hashes it
understands, and whether it is prepared to see only a partial view.

When the sender is listing its refs, refs naming objects the receiver
cannot understand are either elided (if the receiver is content with a
partial view), or cause an error.


Equality testing
----------------

Note that semantically identical trees (and blobs) may (now) have
different tree objects because those tree objects might use (and be
named by) different hashes.  So (in some contexts at least) tree
comparison cannot any longer be done by comparing object names; rather
an invocation of git diff is needed, or explicit generation of a tree
object named by the right hash.


TRANSITION PLAN
===============

For brevity I will write `SHA' for hashing with SHA-1, using current
unqualified object names, and `BLAKE' for hasing with BLAKE2b, using
H<hex> object names.

Y<n> means `Year <n> after the start of the transition'.
Please adjust timescales to taste.

I will focus on the default configuration as shipped by git upstream,
and the recommended configuration for hosting providers.

Individual projects, and perhaps individual hosting providers, can
make their own choices, if they are willing to set appropriate
configuration (on clients, and servers).


Y0: Implement all of the above.  Test it.

    Default configuration:
       SHA is enabled
       BLAKE is disabled in trees without working trees
       BLAKE is enabled in trees with working trees
       SHA > BLAKE

    Effects:

    Clients are prepared to process BLAKE data, but it is not
    generated by default and cannot be pushed to servers.

    All old git clients still work.

    Early adopters can start using the new hashes, at the cost of
    compatibility.  Projects that want to rewrite history right away
    can do so.  (In both cases, by setting configuration options.)

Y4: BLAKE by default for new projects.
    Conversion enabled for existing projects.
    Old git software is going to start rotting.

    Default configuration change:
       BLAKE > SHA
       BLAKE enabled (even in trees without working trees)

    Suggested multi-project hosting site configuration change:
       Newly created projects should get BLAKE enabled
       Existing projects should retain BLAKE disabled by default
       Button should be provided to start conversion (see below)

    Effects:

    When creating a new working tree, it starts using BLAKE.

    Servers which have been updated will accept BLAKE.

    Servers which have not been updated to Y4's git will need a small
    configuration change (enabling BLAKE) to cope with the new
    projects that are using BLAKE.

    To convert a project, an administrator (or project owner) would
    set BLAKE to enabled, and SHA to deprecated, on the server(s).  On
    the next pull the server will provide ref hints naming BLAKE,
    which will get copied to the client's HEAD.  So the client is
    infected with BLAKE.

    To convert a project branch-by-branch, the administrator would set
    BLAKE to enabled but leave SHA enabled.  Then each branch retains
    its own hash.  A branch can be converted by pushing a BLAKE commit
    to it, or by setting a ref hint on the server (or on the next
    client to push).

Y6: BLAKE by default for all projects
    Existing projects start being converted infectiously.
    It is hard for a project to stop this happening if any of
     their servers are updated.
    Old git software is firmly stuffed.

    Default configuration change
       SHA deprecated in trees without working trees

    Effects:

    Existing projects are, by default, `converted', as described
    above.

Y8: Clients hate SHA
    Clients insist on trying to convert existing projects
    It is very hard to stop this happening.
    Unrepentant servers start being very hard to use.

    Default configuration change
       SHA deprecated (even in trees without working trees)

    Effects:

    Clients will generate only BLAKE.  Hopefully their server will
    accept this!

Y10: Stop accepting new SHA
    No-one can manage to make new SHA commits

    Default configuration change
       SHA disabled in new trees, except during initial
          `clone', `mirror' and similar

    Effects:

    Existing SHA history is retained, and copied to new clients and
    servers.  But established clients and servers reject any newly
    introduced SHA.


-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
