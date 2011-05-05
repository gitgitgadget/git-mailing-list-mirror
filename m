From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Private/public branches/repos workflow
Date: Thu, 05 May 2011 11:14:43 -0700
Message-ID: <7v4o598164.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=TLeePH0JDvnE0XPiCzXFxid9BWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jerome Martin <tramjoe.merin@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 20:14:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI34k-0001NR-NI
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601Ab1EESOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:14:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab1EESOw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:14:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 671B25F21;
	Thu,  5 May 2011 14:16:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lpaVuYN4diiH7KvphcaMSoydj9E=; b=v5vAP0
	dNv4DjkOsUzFZk5S8jSFEYhkMCK2Xh61i2lZfFgEdqdPuWt8Akqzt7HPlwJe612F
	PVT6qHiTsurCkSW9qrhMl1qEuVw3ADRm02JHr6KntLkPLxte8YfDZ3ak+3FwE2Gx
	vAaznw6K1GNSVoHXilV/n/vgAqXqUgRLPgsr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R97D3+KrULxrFu5mWOSkYqPAOWXccp7J
	a1Uz92sjQUxePAKoj2b2JfF1AI5XW/Dtx2pt4MZWUovABf2mpGer0qMqeZKW9Gzg
	NGyypyKQcBToYyCD19qEf083jiH47OXvOD88xMBYe/aHPoV9M2xU5DeGyI92bGR9
	g7SbUEFYViE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E8B75F1D;
	Thu,  5 May 2011 14:16:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 134695F1C; Thu,  5 May 2011
 14:16:48 -0400 (EDT)
In-Reply-To: <BANLkTi=TLeePH0JDvnE0XPiCzXFxid9BWQ@mail.gmail.com> (Jerome
 Martin's message of "Thu, 5 May 2011 17:16:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9CD8270-7743-11E0-B7F6-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172864>

Jerome Martin <tramjoe.merin@gmail.com> writes:

> I have an application that lives in a git tree. That application is a
> commercial product, but we have decided to dual-licence it and release
> an open-source version of it, along with all further commits to it.
> Preparatory work for this has been done, and I now have two (let's
> ignore the other) branches in my git tree, 'public' and 'private'.
>
> The problem is, I cannot simply push the public branch on a public
> repository, because the history contains a lot of stuff that are not
> to be publicly released.

To do this properly without heavy cherry-picking, you would need a lot of
discipline.  Not just "you" as an integrator, but everybody in your
development organization who has an access to the 'private' branch.

What you have is something like this:

                   O   public

 ...---x---x---x---X   private

where X is the tip of private branch that contains unreleasable stuff,
while O is the tip of public branch, a redacted version fit for releasing
to the general public.  The former has a lot of history behind it, commits
marked with 'x' that you are ashamed of showing to the public ;-), while
the latter does not have any history behind it (the initial code dump).

Of course, if you build some feature that is not proprietary directly on
top of X and make a commit 'a', and try to merge that to the public
branch, the resulting history will become this, pulling all the history
behind X:
                    O----*   public
                        /
 ...---x---x---x---X---a   private

Unlike "merge tracking" tacked on to some other systems, a merge in git is
a statement you make: "I looked at all the histories behind all the
commits I am merging, and decided that this tree I am recording as the
merge suits the purpose of my branch better than any of the parents".
Merging 'a' is not "The change between a's parent and a was cherry picked
onto this branch" (i.e. what mergeinfo records for SVN).  In short, if you
want to keep your x's private, you have to promise yourself that you will
never ever merge private to public.

        Side note.  This is exactly a same discipline for managing the
        maintenance track for the released version and the development
        track for the next release in the open source world.  You queue
        fixes to the maintenance track, and you may merge the maintenance
        to the development, but you never merge the development track to
        the maintenance, because you do not want to pull new features from
        the development branch into the bugfix only branch.

First of all, you would do this once before making any changes:

    $ git checkout private
    $ git merge -s ours public

This will create a new commit at the tip of private, that records that all
the histories of public is now contained in private, but the recorded
state (i.e. the tree) is identical to that of X.  Let's call this commit S
(it is a merge that synchronizes two independent histories):

                     O   public
                      \
 ...---x---x---x---X---S   private

Then, from here on, your developers have a choice to make whenever
starting to work on a new thing, be it a bugfix or a feature.

If the change will _never_ be released to the public, you can continue
building on your private branch.

                     O   public
                      \
 ...---x---x---x---X---S---x---x   private

On the other hand, if it will _eventually_ be merged to the public, then
you fork a topic branch from public, build it on that branch:

                       a---a---a---a  feature-A
                      /
                     O---o---o---o  public
                      \
 ...---x---x---x---X---S---x---x   private

and merge it to public:

                       a---a---a---a  feature-A
                      /             \   
                     O---o---o---o---*  public
                      \
 ...---x---x---x---X---S---x---x   private

I depicted such a topic as "feature-A" that consists of four commits 'a'
in the pictures above.  Since you made the initial merge S, open source
world may have added three commits 'o' to improve your system and you also
have a few more commits 'x' that are secret.

The private branch can take the result of the work done on the topic
branch, either by merging public wholesale:

                       a---a---a---a  feature-A
                      /             \   
                     O---o---o---o---*  public
                      \               \ 
 ...---x---x---x---X---S---x---x-------*  private

in which case you will also get the open source improvements 'o', or by
merging that particular topic alone:

                       a---a---a---a...    feature-A
                      /             \  . 
                     O---o---o---o---*  .  public
                      \                  .
 ...---x---x---x---X---S---x---x----------*  private

in which case your private branch will not (yet) have the three 'o' open
source improvements.

Note that you may consider some of your features "differentiating edge"
that you may want to keep private for one year and then release it to the
public.  In such a case, you can even choose to merge feature-A to private
first:

                       a---a---a---a...    feature-A
                      /                . 
                     O---o---o---o      .  public
                      \                  .
 ...---x---x---x---X---S---x---x----------*  private

and after a year, you can merge it to public to arrive at the previous
picture.
