From: Junio C Hamano <gitster@pobox.com>
Subject: Re: post-update hook
Date: Thu, 13 Nov 2008 09:08:50 -0800
Message-ID: <7v7i77h7tp.fsf@gitster.siamese.dyndns.org>
References: <b9fd99020811130753o13c5aa0cj79126a502d449cde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jeremy Ramer" <jdramer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 18:11:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0fiV-0001NO-GD
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 18:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbYKMRJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 12:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbYKMRJh
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 12:09:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbYKMRJg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 12:09:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 195B17D369;
	Thu, 13 Nov 2008 12:09:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 03F6C7D35F; Thu,
 13 Nov 2008 12:08:56 -0500 (EST)
In-Reply-To: <b9fd99020811130753o13c5aa0cj79126a502d449cde@mail.gmail.com>
 (Jeremy Ramer's message of "Thu, 13 Nov 2008 08:53:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D7E68DA0-B1A5-11DD-9BB9-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100888>

"Jeremy Ramer" <jdramer@gmail.com> writes:

> ...  I tried editting
> the post-update hook as follows
>
> #!/bin/sh
> echo Update changes...
> git checkout master .
>
> but it does not seem to make any difference.

By above do you mean you do not even see "Update changes...", or do you
mean you do see that message but "checkout"  does not seem to do anything?

I notice that you said you "tried _editing_"; did you also enable it?

If you enabled it, you would see "Update changes..." but notice that "git
checkout master" reports modifications.  Try adding "-f" between "checkout"
and "master".

> ...  Am I missing something
> in the way post-update works?

That, or in the way "checkout" works.

By the way, this is one reason why pushing directly into the checked out
branch of a non-bare repository is not optimal.  A recommended practice is
to make the automation pretend as if you did a pull from the remote,

> ...  It would be really nice to get this
> working so I don't have to log into each remote and do a pull.

without actually having to log into each remote and run "pull" there.

 * Realize that if you did go to the remote and run "pull", then the
   change from the local machine is copied (via the underlying "fetch"
   that is run by "pull") in "remotes/origin/master", not to the branch
   "master".  And then the result is merged.

   IOW, 

	remote$ git pull

   when fully spelled out, is:

	remote$ git fetch local1 master:remotes/origin/master
        remote$ git merge remotes/origin/master

   That is, "master" branch tip from local1 goes to remote branch
   "origin/master" at remote1, and it is merged to whatever is checked
   out.

 * Arrange that if you push from local1 to remote1, the above
   automatically happens, in post-update hook.  So

   (1) Do not push into 'master'; IOW, do not:

	local1$ git push remote1 master:master ;# BAD

       Instead, push into the remotes/origin/master, to mimic _as if you
       fetched in the opposite direction_, like so:

	local1$ git push remote1 master:refs/remotes/origin/master

       Notice that this corresponds to what happens in the "git fetch"
       phase if you pulled in the reverse.  So all the hook needs to do is
       to merge.

   (2) Arrange post-update on the remote end to run the merge, when a push
       came to "origin/master", something like:

	#!/bin/sh
        case " $* " in
        *' refs/remotes/origin/master '*)
        	cd .. ;# you would be in .git -- go to the root of tree
                git merge refs/remotes/origin/master
                ;;
	esac

        I didn't test this, though...

The advantage of doing it this way is that you can configure it so that it
does not matter in which direction you actually work.  When you _do_ have
to go to the remote side to get the changes from local (perhaps on some
emergency that keeps you at remote), you can do a "git pull local" and you
can expect that the exact same thing as what your post-update script
ordinarily does happens.
