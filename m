From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FETCH_HEAD question
Date: Mon, 16 Feb 2009 21:36:29 -0800
Message-ID: <7veixxaale.fsf@gitster.siamese.dyndns.org>
References: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 06:39:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZIgN-0000md-5F
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 06:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbZBQFgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 00:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbZBQFgl
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 00:36:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbZBQFgk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 00:36:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 810969ADB3;
	Tue, 17 Feb 2009 00:36:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5A4A19ADB2; Tue,
 17 Feb 2009 00:36:36 -0500 (EST)
In-Reply-To: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>
 (Jay Soffian's message of "Mon, 16 Feb 2009 23:43:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F32C2C28-FCB4-11DD-9204-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110309>

Jay Soffian <jaysoffian@gmail.com> writes:

> I did this the other day out of mild curiosity:
>
> $ git fetch
> $ git merge FETCH_HEAD
>
> Which did something, but not something that was at all useful. It
> merges in the first ref listed in FETCH_HEAD. It does not appear to be
> an accident that it does this, as git merge has special treatment for
> FETCH_HEAD to generate the merge message.

"git pull" internally invokes "git fetch" to learn the tips of branches
the invoking user is interested in.  "git fetch" downloads the necessary
objects to complete the ancestry chain from local refs to these tips of
branches, and then uses FETCH_HEAD to communicate which commit object
these branches point at, and at the same time which lines in the file
describe the commits that need to be merged into the current HEAD by
marking lines with not-for-merge markers ("cat .git/FETCH_HEAD" to see how
it is done), back to the invoking "git pull".  "git pull" then inspects
this file to decide which commit object to pass to "git merge".

This division of labor makes sense because "git fetch" knows more about
the user preference ("remotes.*.fetch" and "branch.*.merge" configuration
items, .git/remotes/* files, and .git/branches/* files are inspected by
the command).  

The rule initially was that the first non-wildcard Pull: rule in remotes/*
file specifies the commits to be merged or something, and over time, the
system learned the more elaborate per-branch settings via branch.*.merge
variables, but the idea has always been that you cannot just grab the
first line of FETCH_HEAD and expect that is what you want to merge.  At
least you need to omit the ones that are marked not-for-merge (see how it
is done by "git-pull.sh" with a simple sed script), even though
"FETCH_HEAD" can be used as an extended SHA-1 to name the commit object
recorded on the first line in the file.

Having said that, being able to directly use FETCH_HEAD as an extended
SHA-1 is often useful when somebody asks an integrator to pull one-shot
with git-request-pull.  Upon receiving such a request, the integrator can
say:

	$ git fetch git://repo.or.cz/his.git for-linus
        $ git log -p ..FETCH_HEAD ;# to inspect
        $ git merge FETCH_HEAD

to take advantage of the fact that the commit object name that appears at
the beginning of resulting FETCH_HEAD file is actually the commit we would
want, because by definition FETCH_HEAD records only one commit when we are
fetching only one branch.

Incidentally, such a command line to explicitly fetch one single branch is
interpreted by "git fetch" to mean that you are interested in merging the
tip of the fetched branch, and the first line of the resulting FETCH_HEAD
file is not marked with not-for-merge.  Therefore,

	$ git pull git://repo.or.cz/his.git for-linus

would also work regardless of what you have in .git/config file.
