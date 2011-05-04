From: Jeff King <peff@peff.net>
Subject: Re: [Tagging Commits] feedback / discussion request
Date: Wed, 4 May 2011 04:42:13 -0400
Message-ID: <20110504084212.GB8512@sigill.intra.peff.net>
References: <BANLkTik5-Ygh0YwN=j+ibLhP6==ots_MXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Richard Peterson <richard@rcpeterson.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:42:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHXf6-0006Ju-4T
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 10:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab1EDImT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 04:42:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47232
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564Ab1EDImQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 04:42:16 -0400
Received: (qmail 16181 invoked by uid 107); 4 May 2011 08:44:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 May 2011 04:44:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2011 04:42:13 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTik5-Ygh0YwN=j+ibLhP6==ots_MXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172724>

On Tue, May 03, 2011 at 07:36:51PM -0400, Richard Peterson wrote:

> Here are some possible semantics you could assign to signing a commit hash:
> 
> * Making a verifiable claim of authorship of a commit
> * Making a verifiable claim to have reviewed a commit or set of commits
> * Making a verifiable claim to have approved a commit or set of commits for
> some purpose
> * Making some other verifiable claim about a commit TBD by your workflow
> * Making a verifiable claim to have reviewed or approved the entire tree
> under the commit

Yeah, all of those make sense in certain workflows. But with the
exception of authorship verification, they are not things you would want
to do at _commit_ time, but rather something you say later about a
commit. So I think fundamentally you are not interested in adding
signatures to git commits themselves, but rather about making statements
about commits that happen to be signed. Which is good, because your
problem is much easier. :)

The nice thing is that git gives you a stable, cryptographically
verifiable identifier for the commit. So all you have to do is mention
it along with some metadata, sign it, and then store it somewhere.

The first two parts can be as simple as something like:

  (git rev-parse --verify HEAD
   echo "I reviewed this and it meets some standard X."
  ) | gpg --sign

where probably you would want to define some kind of parsable metadata
format for your particular workflow.

For storage, you basically have three options:

  1. Somewhere completely outside of git. There's no reason this needs
     to be stored in git at all, depending on your workflow. It may be
     simpler to keep it in some database related to your review system
     (in fact, you may not doing anything cryptographic at all, but
     merely have a separate review system with a central database that
     mentions commits by sha1).

  2. In git tags. You can already do this with:

       git tag -s -m "I reviewed this" HEAD

     But tags aren't a good fit for a workflow that signs every commit
     (some of them perhaps even multiple times!). You end up with lots
     of tag refs.

  3. In git notes. You can do something like:

       (git rev-parse --verify HEAD
        echo "I reviewed this"
       ) | gpg --sign -a |
       git notes add -F - HEAD

     though you'd probably want to be a little more complex, and handle
     lists of signed notes for each commit. And you may want to store
     these in a separate notes ref from the default one.

     The advantage of notes are that they are designed for lots of
     per-commit storage, and can be accessed fairly efficiently.

So now you have your review storage system (or authorship, or whatever
metadata you want to stick in there). You can peek at it manually, of
course, when you suspect something is not right. But you probably also
want to do automatic things, like making sure nothing goes into some
branch "foo" that isn't signed with an authorship note.

Assuming you are storing with git notes (if you are using some external
system, replace the call to git-notes below with whatever database
lookup you would want), you could use a pre-receive hook that did
something like:

  git rev-list $old..$new |
  while read commit; do
    git notes show $commit >tmp
    gpg --verify tmp >data 2>siginfo || die "$commit: signature is bad"
    # ugh, is there really no better way to get this info from gpg?
    perl -lne 'print $1 if /Good signature from "(.*)"/ siginfo >signer
    git show --format="%an <%ae>" $commit >author
    cmp author signer || die "$commit: signer and committer don't match"
    test "`head -n 1 data`" = $commit ||
      die "$commit: signed commit does not match"
  done

And obviously that is hacked together and you would want something more
robust, and you'd need to handle the web of trust for the signing keys
somehow (though I think that is external to this script, and is about
setting up the desired keyring). But I hope it gives a sense of what you
can do. You could also replace gpg completely with something like
openssl using x.509 certs, if that makes more sense to your
organization.

Developers would have to make a note and push their notes tree first,
and then push their actual commits into a branch (and you might want to
do some verification on the notes they push, like checking that entries
for commit $X actually contains signatures for $X, or that the signer
identity matches some ssh credential, or that the pusher isn't deleting
any signatures or erasing note history).

I suspect you already thought through some of this already. But I wanted
to start with first principles, because I really don't think this is a
_git_ problem as much as it is a _workflow_ problem. So it's important
to first define the workflow you want, and then think about how git can
help. Stable commit identifiers already provide much of the basis. I
think notes provide a nice storage format that is efficient and
push-able to other repos (though in a centralized shop, some other
database might make sense, too). What really remains to be done is:

  1. Define the metadata format that encapsulates what you want to say
     about commits.

  2. Write scripts to help developers and reviewers make these notes,
     and verify them.  Write hooks to implement policy on letting
     commits into certain branches, as above.

And both of those happen outside of git (though if you write them in a
generic enough form, I'm sure people on the list would be very happy to
see them shared).

> There are 200 developers working on a financial trading system, and each of
> them has the opportunity to slip malicious code into the project. When the
> final release is prepared, the project lead signs the tip commit, thus
> signing the whole tree. Now it is discovered that someone did slip some
> malicious code in.  How do you audit the system? Could higher levels of
> individual accountability have discouraged this scenario?

I like this example. It shows that signing a commit is not really
meaningful by itself; you have to understand the semantics of that
signature (and maybe they're included as comments in the tag object, or
maybe it is assumed by your organization's workflow).

In the case of the kernel, Linus signing a commit with a tag implicitly
means "I think what is in this tree and everything before it is good, so
you should feel comfortable using it" (or at least insofar as you trust
Linus).

But it doesn't have to be that way. Your project lead signing may mean
"this is good and we should ship it". But developers signing commits may
simply mean "I promise that I wrote the changes between this commit's
tree and its parent". Those are all signatures of commits, but they mean
very different things; the key is adding metadata to know which is
which.

> I've seen it argued that a proper SSH setup and user management are the key.
> These are good for security and access control, but not for some durable
> form of accountability.

Right. You are trusting the server's records, not cryptography. The main
advantage is that it's efficient and easy to set up. :)

> It seems that creating a signed tag is the same as signing a commit.  There
> are a few problems, though.  Tags don't provide a secure means of asserting
> the type of signature being applied to the commit hash. That is - is the
> hash signed because someone is claiming authorship? Because they are
> asserting the integrity of the entire tree? Because they have reviewed the
> code? Because they reviewed a certain subset of the tree? Of course there's
> also the issue that tags live in a cluttered namespace. Signing a commit is
> essentially a different thing from providing a name for a commit. Using tags
> just to sign commits requires a glut of tag names.

Again, metadata. Say what you mean in the free-form content of the tag.
For the kernel, there is nothing to be said. Linus signing tags has a
well-known meaning in the community. But in an organization signing for
a lot of different reasons, you would want the signed data to say why it
was signed.

> I propose expanding the concept of tags, or alternately creating a new
> concept which subsumes the existing tag concept. I'll call this new concept
> a "sig" for the purposes of this discussion. The concept of a sig cross-cuts
> the concept of a tag.
> 
> A tag signs the commit hash. A sig signs a SHA1-based absolute commit
> reference with a (possibly null) string concatenated to it. For instance, a
> sig might sign the following string:

A tag can already include arbitrary data.

In fact, tags basically do what you want already; it's just that storing
one tag ref per commit is going to be ugly. It might make sense to
replace the ad-hoc gpg signatures I used in my examples above with tag
objects, and then store the tag object in the notes tree.

> "0b9deecf625677cf44058a42c2abd7add5167e81^0 author"
> which would mean that the signor is claiming authorship of that individual
> commit. (Suggestions for notating a single commit are welcome. "^0" seemed
> natural.)

See? You're defining metadata now. :)

> * What on earth does it mean to tag a range of commits? With commit ranges
> being siggable, and tags containing sigs, what does it mean to tag a range
> of 10 commits, for instance? Is that desirable? Does it make any sense
> whatsoever? Does it hurt anything if it happens?

It's slightly more efficient. If I wrote 10 commits, I can either sign
each individually saying "I wrote this", or I can make a single
signature showing them all. The tradeoff is that parsing and verifying
metadata becomes a lot more complex. But crytographically speaking, a
range is not ambiguous;

> * Performance? I think it would be extremely quick to verify a bunch of
> sigs, but I don't know. Maybe I'm not thinking clearly about it.
> Fortunately, sigs can be ignored entirely and need not affect things.

Compared to usual git operations, no, it's not quick. But you don't have
to verify all the time. You can verify commits when they enter your
repo, or when you're interested in some aspect of them, or when you
suspect something fishy is going on. You don't have to do it on every
rev-list.

-Peff
