From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to stop sharing objects between repositories
Date: Sun, 16 Aug 2009 12:16:22 -0700
Message-ID: <7vmy5z603d.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
 <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
 <20090816122842.GA942@sigill.intra.peff.net>
 <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
 <20090816135703.GA31638@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Jensen <jon@endpoint.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 16 21:16:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MclDb-0002yw-Nn
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 21:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbZHPTQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 15:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753642AbZHPTQb
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 15:16:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbZHPTQa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 15:16:30 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 47F2CD3B5;
	Sun, 16 Aug 2009 15:16:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 548E2D3B4; Sun, 16 Aug
 2009 15:16:25 -0400 (EDT)
In-Reply-To: <20090816135703.GA31638@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 16 Aug 2009 09\:57\:03 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E1C281E-8A99-11DE-9A4D-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126067>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] docs: mention how to break alternates dependency
>
> A user who has created a repository dependency by using "git
> clone -s" does not necessarily know where to look to find
> out how to break that dependency. Let's mention it right
> under "-s", where they are most likely to find it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-clone.txt |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index b14de6c..87fa687 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -72,6 +72,11 @@ These objects may be removed by normal git operations (such as 'git-commit')
>  which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
>  If these objects are removed and were referenced by the cloned repository,
>  then the cloned repository will become corrupt.
> ++
> +To break the dependency of the cloned repository to the source
> +repository, run `git repack -a` in the cloned repository, which will
> +create a new pack in that repository with all referenced objects,
> +including those in the source repository.

After reading this, two points come to my mind.  They may or may not be
issues.

 (1) Such a user does not necessarily know a casual "git repack -a" breaks
     the dependency, defeating the -s option s/he deliberately used in
     order to save disk space in the first place.  Perhaps we can reword
     this further to kill two penguins with a single stone?

	Note that the pack resulting from running `git repack -a` in the
	repository cloned with the `-s` option will include objects that
	are borrowed from the source repository.  It essentially breaks
	the dependency created by cloning with the `-s` option by copying
	the objects from the source repository.  To keep borrowing from
	the source repository to save disk space, do not use `repack -a`.

     We should suggest an alternative immediately after this sentence,
     e.g. "Instead, use `repack -l`" or something, but somebody should
     check if it is a valid/viable alternative.

 (2) IIRC, "git gc --auto" runs "repack -A".  What is its effect with
     respect to this dependency between object stores?  I suspect it would
     also break the dependency, but if so, is it a good thing?  Perhaps
     should we change it to use a version that keeps the dependency
     instead?
