From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how do I resolve this merge manually + mergetool bug
Date: Mon, 23 Feb 2009 22:31:10 -0800
Message-ID: <7vbpssmjm9.fsf@gitster.siamese.dyndns.org>
References: <81bfc67a0902232204y7a1e9a91x6cbf751319664734@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 07:32:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbqqU-0005NY-Kz
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 07:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbZBXGbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 01:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbZBXGbS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 01:31:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbZBXGbS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 01:31:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8FA1B2BCFE;
	Tue, 24 Feb 2009 01:31:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CA71F2BCFB; Tue,
 24 Feb 2009 01:31:11 -0500 (EST)
In-Reply-To: <81bfc67a0902232204y7a1e9a91x6cbf751319664734@mail.gmail.com>
 (Caleb Cushing's message of "Tue, 24 Feb 2009 01:04:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BC27F01C-023C-11DE-83F4-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111220>

Caleb Cushing <xenoterracide@gmail.com> writes:

> #       unmerged:   profiles/package.mask
>
> on the remote package.mask is a file locally it is a directory.
> ...
> git rm :3:profiles/package.mask
> fatal: pathspec ':3:profiles/package.mask' did not match any files

The answer most likely is this but don't do this just yet:

    $ git rm profiles/package.mask

With this, you are saying "For the path profiles/package.mask, the correct
resolution is not to have it".  There is no room for the stage number to
get into the picture when you are talking about the final result.

But I am suspecting that this is because you moved it to somewhere
(perhaps to profiles/package.mask/frotz) while the remote side kept it
intact or modified it in place.  If that is the case, and if the remote
side made an in-place change, you would want to port the change over to
the path you moved the contents to before you actually remove it, so
before running the above "git rm", I would do something like.

    $ git cat-file blob :1:profiles/package.mask >original
    $ git cat-file blob :3:profiles/package.mask >theirs
    $ git cat-file blob profiles/package.mask/frotz >mine
    $ git merge-file mine original theirs
    $ diff -u profiles/package.mask/frotz mine ;# eyeball the merge result
    $ cat mine >profiles/package.mask/frotz

and then finally conclude the merge with:

    $ git rm profiles/package.mask
    $ git add profiles/package.mask/frotz

But if the remote side did not change anything (i.e. original == theirs),
then you do not have to do the file-level merge to update the contents you
moved to a different path.
