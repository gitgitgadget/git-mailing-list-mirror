From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Sat, 24 Nov 2007 11:15:19 -0800
Message-ID: <7voddjqwu0.fsf@gitster.siamese.dyndns.org>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
	<8aa486160711220142w25e9c9b6vbafa34a287dde7eb@mail.gmail.com>
	<7v4pfe7g4e.fsf@gitster.siamese.dyndns.org>
	<200711231018.49322.jnareb@gmail.com>
	<7vejehux3y.fsf@gitster.siamese.dyndns.org>
	<8aa486160711230213q6038037epe2cbd0240db8b612@mail.gmail.com>
	<7vabp5uhke.fsf@gitster.siamese.dyndns.org>
	<8aa486160711230734l30a3e907rac5aee11f3518e88@mail.gmail.com>
	<7v63ztuevk.fsf@gitster.siamese.dyndns.org>
	<8aa486160711230839o5db5fca1wc09a834ab3d4f053@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 20:15:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iw0Ti-0001yt-SV
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 20:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbXKXTP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Nov 2007 14:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753594AbXKXTP2
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 14:15:28 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39152 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbXKXTP1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Nov 2007 14:15:27 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B06902EF;
	Sat, 24 Nov 2007 14:15:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EEDE899453;
	Sat, 24 Nov 2007 14:15:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65958>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

> On Nov 23, 2007 5:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Maybe I am missing something from the discussion, but what
>> information loss are you referring to?
>
> Because you create an incremental bundle, so all the objects in the
> old bundle will
> not be in the new bundle. But it can be considered the natural
> behavior of bundles.

It might be natural if you are thinking within the limit of "git
bundle create", but it is not natural for "git push" at all.

I think treating a bundle as if it is a bare repository with a
funny representation wouldn't be so wrong, at least from the
user interface point of view.  IOW, I think it is natural for
these:

	$ git push $remote $refspec
        $ git fetch $remote $refspec

to work as "expected" when $remote is actually a local file that
is a bundle, and in fact, "git fetch" should already work that
way.

What's "expected" for a push?  You push from your repository the
objects needed to complete LHS of given $refspec into the
$remote, and then update the refs in the $remote specified by
the $refspec.  There is no deletion of existing objects from the
$remote.  That is what's expected for a push.

So if you want to implement "pushing into a bundle", the
implementation would be:

  * Find the required objects in the existing bundle.  If the
    bundle file does not exist, it might be natural to treat it
    as if you are pushing into an empty but initialized regular
    repository.  If we choose to do this, for a nonexistent
    bundle file, the set of required objects is an empty set.

  * Find the recorded heads in the existing bundle.  Add or
    replace them with the RHS of $refspecs being pushed to come
    up with the new set of heads for the updated bundle.  We
    would want to perform the ordinary "fast-forward" safety and
    reject a push as needed.

  * If there are HEADs in the updated bundle that the pushing
    repository does not have, fetch them (and their required
    objects) first, as it is necessary for the next step.

  * Run this pipeline in the pushing repository to generate a
    packdata stream:

    $ git rev-list --objects <heads in the updated bundle> \
    	--not <required objects in the bundle> |
      git pack-objects --stdout

    This packdata stream will be the payload of the updated
    bundle.

  * The updated bundle will require the same set of objects as
    the bundle before the update.

This is quite different from the way how the other "transports"
are implemented internally to push into usual repositories, but
that is perfectly fine.  What the end user sees will be
consistent if you implement "push into bundle" that way and that
is what matters.

	Note.  I am not saying that we _should_ allow pushing
	into a bundle to update.  I am just saying that if we
	were to implement "git push" into a bundle, that should
        behave as close as other push transports from the end
	uesr's point of view.

If you want different "object losing" semantics, "git bundle
create" to create a new bundle is already there for you.  You
just shouldn't overload that different semantics to "git push",
because that would confuse users without much gain.
