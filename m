From: Junio C Hamano <gitster@pobox.com>
Subject: What's next for "signed push"?
Date: Wed, 28 Sep 2011 20:42:27 -0700
Message-ID: <7vfwjgui8s.fsf_-_@alter.siamese.dyndns.org>
References: <20110928075054.GA13727@orbis-terrarum.net>
 <7v62kc1v7m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 05:42:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R97WF-0008Gw-3k
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 05:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab1I2Dmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 23:42:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565Ab1I2Dma (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 23:42:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E32FC5D7F;
	Wed, 28 Sep 2011 23:42:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uw3tspdFnu6mATlVRyC0RLMlGQ4=; b=W0HihR
	KVzZcgjWUbcl5BIxeHSscb+PEzFtHtEefgt3jIpeWGpxtq7WyfsAogrD859yxGcW
	po4zYHLWInijKZXYyDZy/g6eFrQAI6cbwJeNYsfCv/ufFGb2StsuoRMQg/iXXYVI
	mCpBqgd4sRyGM4hj2OKTu9w0q/WQlX3Qj8rHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OOD6vHs6ms3svKvP0I8RXRIO6gDvsd1j
	KjQY/x+O5A5w14TPeKM07cNkm6OoCfHlu5xwCNYXjAo0yKEaUZiWyDMqlkNaPL5X
	NDzny5iLaut+jli3ynYSe+06BL6gcu9nKTn6r6AyTqtyvkfJ2Y0pfLjzapPAnoiT
	N2ke/8zQ+9o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9DD25D7E;
	Wed, 28 Sep 2011 23:42:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 096375D79; Wed, 28 Sep 2011
 23:42:28 -0400 (EDT)
In-Reply-To: <7v62kc1v7m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 28 Sep 2011 09:35:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E1125C4-EA4D-11E0-9ECF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182384>

Junio C Hamano <gitster@pobox.com> writes:

> "Robin H. Johnson" <robbat2@gentoo.org> writes:
>
>> from CVS to Git (we're very close now), we've decided that the signed
>> pushes will provide better security than our plan of previous plan of
>> using signed notes, so we'd like to see signed pushes succeed.
>
> Could you elaborate on your "previous plan" a bit? What is a signed note,
> how would it help validate the authenticity, how do developers interact
> using it and what do you perceive as weaknesses compared to the signed
> push that we discussed a few weeks ago?

I was hoping that I could get another food-for-thought from people who
thought about signed commits before sending this out, but here is my
current thinking (I retitled your "Signed push progress" as there is
nothing to "progress" on without an active discussion).

Originally, I very much wanted to like the approach of v3 that was meant
to be simpler by having the logic to record the signed push certificate
only on the sending end. At the mechanism level, v3 looked simpler to me,
but from the point of view of end users, I doubt that it is simpler than
the approach of v2, where the sender prepares a push record, signs and
sends it, and the receiver records it to its notes tree to publish so that
others can fetch and verify.

Here are some of the issues, from end users' point of view, that v3 would
have that v2 would not, off the top of my head:

 - Unless you are pushing into a repository solely for your own push, you
   have to first fetch the notes ref from where you are about to push to,
   then hope that your push does not conflict with others. If your push is
   rejected for non-fast-forward of the signed-push notes tree (but not
   for your real branches), you would have to rewind the push certificate
   the failed "git push" prepared (you could probably add a patch to the
   v3 to do so automatically, but I haven't looked closely for all
   possible failure cases), run "git fetch", and then run "git push -s"
   again which would create a new push record for you to sign. Because the
   "signed-push" namespace for notes is meant to cover all the branches,
   this will not work on a busy site that uses CVS/SVN style "shared
   central repository" workflow at all.

 - If you are pushing into multiple places, you would somehow need to
   configure your end to keep one signed-push notes tree per remote that
   you intend to push to with signature, to avoid contaminating remote
   repositories of records of your push into other remote repositories.
   It could be worked around by even more code on the sending end, but the
   need for configuring alone is already an additional mental burden.

 - It also was hoped that pre-receive or pre-update hook on the receiving
   end can be used to authenticate and authorize the push itself with the
   approach by v3, but when the check happens, the signed-notes tree to be
   used for verification is not connected to any ref in the refs/notes/
   hierarchy yet (otherwise it won't be pre-* hook). The query interface
   "git notes show" needs to be updated so that it takes not just a ref
   via the GIT_NOTES_REF interface, which is defined to specify a ref
   because some subcommands of "git notes" need to create a new commit and
   update it, but a bare notes tree commit object name [*1*]. We may need
   to update "git notes" (at least "show" subcommand) for the use of
   receiving end; v3 is no longer a simpler "sender only" solution.

I've shown how both v2 and v3 models would look to the end users with
working code, thought about the pros and cons probably longer than anybody
else, and at this point, if I were to choose between the two approaches
[*2*], I am inclined to suggest that we go with the v2 model [*3*].

Either that, or we will see follow-up patches to work around the above
(and there may be others we may later discover) issues from people who
still think v3 is a better approach.

Whether we go with v2 or v3, for people who want to verify the commits
against signed push certificates stored in notes tree:

 - We need a wrapper like "tag --verify".

 - We also need a way to merge these signed pushed certificates [*4*]. I
   think the default notes merge is to concatenate, which would result in
   duplicates of the records that was present in the common ancestor (and
   no, "union" merge is not a safe way to remove these duplicates).

But see footnote *2* below.


[Footnotes]

*1* I wouldn't be surprised if it already worked when you give the object
name of the notes-tree commit to GIT_NOTES_REF when running "git show",
but that is not really a documented interface and working by accident. The
environment variable was designed to take a name of the ref.

*2* I say "if I were to choose between the two" for a reason. It will make
things simpler if we drop "add signature separately to notes" altogether,
and instead adopt a "signed commit" approach.  Embed GPG signature in a
commit object, and allow the receiving end of the "push" to be configured
to reject a push that tries to place a non-signed commit at the tip of a
ref. The same "tip of a ref must be a signed commit" check can be done for
"fetch".

The most attractive part of the "signed commit" approach is that it does
not force Linus to fetch push-signature notes trees from his lieutenants,
and merge them to his push-signature notes tree, which is an unnecessary
chore. The most likely thing to happen, especially under v3 design, would
be that higher level maintainers will not bother to fetch/verify/merge the
signed-push notes trees from their feeders, and the final publishing site
will only have the push certificates from the owner of the repository at
the top-level, without downstream contributors' signature.  The v2 design
already relies on the final verifier to independently collect signed-push
notes from publishing repositories of Linus and all the key repositories
Linus pulled from before verification, which feels more cumbersome, but
the same needs to be done in v3 if the higher level maintainers do not buy
in the fetch/verify/merge overhead for the push-signature notes tree.

If signatures are embeded in the commits themselves, the issue of merging
push-signature notes tree disappears. Whenever the top level maintainer
pulls from his lieutenants, his fetch can (and should) check the signature
of these lieutenants, and their signatures stay in the history the top
level maintainer integrates and eventually pushes out with his own
signature.

As to the embedding of the signature in the commit, I am inclined to put
the lines of GPG detached signature in new header lines, after the
standard tree/parent/author/committer headers, instead of tucking it at
the end of the commit log message text, for multiple reasons:

 - The signature won't clutter output from "git log" and friends if it is
   in the extra header. If we place it at the end of the log message, we
   would need to teach "git log" and friends to strip the signature block
   with an option.

 - Teaching new versions of "git log" and "gitk" to optionally verify and
   show signatures is cleaner if we structurally know where the signature
   block is (instead of scanning in the commit log message).

 - The signature needs to be stripped upon various commit rewriting
   operations, e.g. rebase, filter-branch, etc. They all already ignore
   unknown headers, but if we place signature in the log message, all of
   these tools (and third-party tools) also need to learn how a signature
   block would look like.

 - When we added the optional encoding header, all the tools (both in tree
   and third-party) that acts on the raw commit object should have been
   fixed to ignore headers they do not understand, so it is not like that
   new header would be more likely to break than extra text in the commit.

*3* Honestly speaking, I myself was disturbed by the v2 model where the
signed-push is recorded primarily at the receiver. At the philosophical
level, the approach seems to go very much against the "distributed" nature
of Git. Sending what you want to be committed to the server and having the
server make a commit feels so very SVN/CVS. The usual "push" workflow for
Git users is to fetch first to come close to the other end, integrate your
work to prepare what you push out contains all of what the other end has,
and then pushing the result out, hoping that you are the latest and nobody
else had a chance to update the same thing.

But after thinking about it a bit more, I came to realize that the record
of push is quite unlike the branches you and others work on. First of all,
you are recording what happens at the receiving end, "I updated these refs
to these values in this repository". Making the record at the receiving
end is more natural than writing "I plan to update these refs", sending it
over to a dumb receiver and hoping it will fast-forward.

Don't get me wrong. The offline distributed workflow is a great enabler in
a distributed system like Git. The work you do on your branches can be
fully asynchronous to outside world, and being able to have local history
that can later be merged in order to avoid losing work by others while
still allowing us to be asynchronous is a great thing to have, but the act
of pushing the end result and recording the fact you pushed them into a
repository is inherently a synchronous event---you and the receiving
repository have to be connected when your "push" happens. I do not see a
need to be dogmatic and insist that everything we do is asynchronous.

*4* For the purpose of pushing things out, even with the v3 design, a
pusher does not have to worry about merging the signed-push notes tree
(there is no merge issue for pushers with the v2 model), I think.

"git push -s" will add a push record to the notes tree, and if the result
does not fast forward, "git fetch $remote +refs/notes/signed-push" (or use
per-remote signed-push hierarchy "+refs/notes/$remote/signed-push") that
discards the single failed push record would be all that is needed before
attempting "git push -s" again without losing any information.
