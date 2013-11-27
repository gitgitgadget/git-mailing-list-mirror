From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule recursion in git-archive
Date: Wed, 27 Nov 2013 11:43:44 -0800
Message-ID: <xmqqzjopsk9b.fsf@gitster.dls.corp.google.com>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
	<5294BB97.7010707@web.de>
	<xmqqmwkqvmck.fsf@gitster.dls.corp.google.com>
	<9AB10474-6DEF-4FFD-B6B3-ED2AB21424AC@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nick Townsend <nick.townsend@mac.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 20:43:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vll1d-0007p0-0l
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 20:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab3K0Tnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 14:43:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63305 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab3K0Tns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 14:43:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DF1E54455;
	Wed, 27 Nov 2013 14:43:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ArrDHJ79KsXrYEKDmJAyQOGbiPw=; b=vg0Pzs
	DwqH9L1Z9hYQmCsVqmyxU/L5aGm132FjRjP7F4AvcFAKtcDC0uxllj49JY37bDYL
	GCE1LPmSz0Hc6CnU1+kHAJRLmFA2O5+pVtBJHKl/ccmIJm8UgeFAMMUZU9d0+g8T
	GQ/890GRM/LmeacfTk4roNerc4Fk7P/c4k+ro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NFZpKwrTuECzbx4XcuxnvTGYZ+lWTevF
	nF/CASIfeRDEiVF6MxWyrdMZN04j3vFBCWAd/8AHD9u6yD5bD1uWWwf3J/e1N3ol
	hw6Xz0DJAwNeEX+OHUopZfl2wGyCTbMoGK10ma+2Ki5Vt5VYiojHwWz++1rCyllN
	PTbdzAeC6yw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 605C854454;
	Wed, 27 Nov 2013 14:43:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CBED54453;
	Wed, 27 Nov 2013 14:43:46 -0500 (EST)
In-Reply-To: <9AB10474-6DEF-4FFD-B6B3-ED2AB21424AC@mac.com> (Nick Townsend's
	message of "Tue, 26 Nov 2013 19:55:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3AE5118C-579C-11E3-A768-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238458>

Nick Townsend <nick.townsend@mac.com> writes:

> On 26 Nov 2013, at 14:18, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Even if the code is run inside a repository with a working tree,
>> when producing a tarball out of an ancient commit that had a
>> submodule not at its current location, --recurse-submodules option
>> should do the right thing, so asking for working tree location of
>> that submodule to find its repository is wrong, I think.  It may
>> happen to find one if the archived revision is close enough to what
>> is currently checked out, but that may not necessarily be the case.
>> 
>> At that point when the code discovers an S_ISGITLINK entry, it
>> should have both a pathname to the submodule relative to the
>> toplevel and the commit object name bound to that submodule
>> location.  What it should do, when it does not find the repository
>> at the given path (maybe because there is no working tree, or the
>> sudmodule directory has moved over time) is roughly:
>> 
>> - Read from .gitmodules at the top-level from the tree it is
>>   creating the tarball out of;
>> 
>> - Find "submodule.$name.path" entry that records that path to the
>>   submodule; and then
>> 
>> - Using that $name, find the stashed-away location of the submodule
>>   repository in $GIT_DIR/modules/$name.
>> 
>> or something like that.
>> 
>> This is a related tangent, but when used in a repository that people
>> often use as their remote, the repository discovery may have to
>> interact with the relative URL.  People often ship .gitmodules with
>> 
>> 	[submodule "bar"]
>>        	URL = ../bar.git
>> 		path = barDir
>> 
>> for a top-level project "foo" that can be cloned thusly:
>> 
>> 	git clone git://site.xz/foo.git
>> 
>> and host bar.git to be clonable with
>> 
>> 	git clone git://site.xz/bar.git barDir/
>> 
>> inside the working tree of the foo project.  In such a case, when
>> "archive --recurse-submodules" is running, it would find the
>> repository for the "bar" submodule at "../bar.git", I would think.
>> 
>> So this part needs a bit more thought, I am afraid.
>
> I see that there is a lot of potential complexity around setting up a submodule:

No question about it.

> * The .gitmodules file can be dirty (easy to flag, but should we
> allow archive to proceed?)

As we are discussing "archive", which takes a tree object from the
top-level project that is recorded in the object database, the
information _about_ the submodule in question should come from the
given tree being archived.  There is no reason for the .gitmodules
file that happens to be sitting in the working tree of the top-level
project to be involved in the decision, so its dirtyness should not
matter, I think.  If the tree being archived has a submodule whose
name is "kernel" at path "linux/" (relative to the top-level
project), its repository should be at .git/modules/kernel in the
layout recent git-submodule prepares, and we should find that
path-and-name mapping from .gitmodules recorded in that tree object
we are archiving. The version that happens to be checked out to the
working tree may have moved the submodule to a new path "linux-3.0/"
and "linux-3.0/.git" may have "gitdir: .git/modules/kernel" in it,
but when archiving a tree that has the submodule at "linux/", it
would not help---we would not know to look at "linux-3.0/.git" to
learn that information anyway because .gitmodules in the working
tree would say that the submodule at path "linux-3.0/" is with name
"kernel", and would not tell us anything about "linux/".

> * Users can mess with settings both prior to git submodule init
> and before git submodule update.

I think this is irrelevant for exactly the same reason as above.

What makes this tricker, however, is how to deal with an old-style
repository, where the submodule repositories are embedded in the
working tree that happens to be checked out.  In that case, we may
have to read .gitmodules from two places, i.e.

 (1) We are archiving a tree with a submodule at "linux/";

 (2) We read .gitmodules from that tree and learn that the submodule
     has name "kernel";

 (3) There is no ".git/modules/kernel" because the repository uses
     the old layout (if the user never was interested in this
     submodule, .git/modules/kernel may also be missing, and we
     should tell these two cases apart by checking .git/config to
     see if a corresponding entry for the "kernel" submodule exists
     there);

 (4) In a repository that uses the old layout, there must be the
     repository somewhere embedded in the current working tree (this
     inability to remove is why we use the new layout these days).
     We can learn where it is by looking at .gitmodules in the
     working tree---map the name "kernel" we learned earlier, and
     map it to the current path ("linux-3.0/" if you have been
     following this example so far).

And in that fallback context, I would say that reading from a dirty
(or "messed with by the user") .gitmodules is the right thing to
do.  Perhaps the user may be in the process of moving the submodule
in his working tree with

    $ mv linux-3.0 linux-3.2
    $ git config -f .gitmodules submodule.kernel.path linux-3.2

but hasn't committed the change yet.

> For those reasons I deliberately decided not to reproduce the
> above logic all by myself.

As I already hinted, I agree that the "how to find the location of
submodule repository, given a particular tree in the top-level
project the submodule belongs to and the path to the submodule in
question" deserves a separate thread to discuss with area experts.
