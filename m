From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] git-add won't add foo/.git/bar
Date: Mon, 24 Mar 2008 17:32:18 -0700
Message-ID: <7vve3br6ct.fsf@gitster.siamese.dyndns.org>
References: <fs9f0o$jge$1@ger.gmane.org>
 <Pine.LNX.4.64.0803242359230.24262@kaos.quantumfyre.co.uk>
 <7v1w5zslv5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Gebetsroither <gebi@sbox.tugraz.at>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Mar 25 01:33:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdx6I-0005dS-75
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 01:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbYCYAcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 20:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbYCYAcd
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 20:32:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196AbYCYAcc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 20:32:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3650F21C3;
	Mon, 24 Mar 2008 20:32:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 50A5621C0; Mon, 24 Mar 2008 20:32:27 -0400 (EDT)
In-Reply-To: <7v1w5zslv5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 24 Mar 2008 17:11:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78135>

Junio C Hamano <gitster@pobox.com> writes:

>> Well, git won't allow .git as a element anywhere in the path, when we
>> should only care about the _first_ one - and also, if you use
>> --git-dir=banana then we still check for '.git' ... oops.
>
> That's not how git-dir is supposed to used, so there is no oops.

The only purpose of git-dir is to have $GIT_DIR elsewhere _outside_ the
work tree.

That is, not "git --git-dir=banana", but "git --git-dir=$(pwd)/../banana"
or more typically "git --git-dir=/home/gits/banana.git/" when you are at
the toplevel of your work tree that is unrelated to the named location.

> Also it is false that we should only care about the first one.  Think
> submodules.

Actually, not just "submodules", but even with more traditional "overlayed
checkout" with working in a subdirectory, you would have problems.

You can have another repository in your work tree, and the way we tell
which path belongs to which repository is by finding .git directory in the
hierarchy.  In my work trees of git.git, I have a clone of the repository
itself in Meta/ and have checkout of 'todo' branch, like this:

	/git.git/.git
        	/COPYING
                /Documentation
                /Makefile
                /Meta/.git
                /Meta/Doit
                /Meta/MaintNotes
                /Meta/Make
                ...

In such a layout, you can

	$ cd Meta
        $ edit MaintNotes
        $ git commit

and commit the result to the /git.git/Meta/.git/ repository, while you can

	$ cd Documentation
        $ edit git.txt
        $ git commit

and the result is committed to the main /git.git/.git/ repository.

What this means is that you cannot have .git/ directory anywhere in your
work tree unless the directory that house such a .git directory as its
direct subdirectory (e.g. /git.git/Meta in the above illustration) unless
that hierarchy does not belong to the main repository (e.g. /git.git/).

Having, say Documentation/.git, in the above example is wrong because you
want the file Documentation/git.txt to be part of the main project.

And trying to add Documentation/.git/garbage is doubly wrong.  For one
thing, that path is a place to hold metainformation of the
/git.git/Documentation/.git repository (i.e. not something you can "git
add" to the /git.git/Documentation/.git repository), and because it is
part of /git.git/Documentation/.git repository, it should not even go to
the main project (i.e. not something you can "git add" to the main
/git.git/.git repository either).

A few weeks ago somebody wanted to rename .git and I thought I responded
well enough.  You certainly did not ask CVS or SVN folks to rename the
control directories they sprinkle in your work trees to .cvs or .svn, did
you?  Leave .git alone so that people don't get confused.
