From: Junio C Hamano <junkio@cox.net>
Subject: backward compatible changes to format-patch, rebase, cherry and fetch
Date: Sun, 07 Aug 2005 14:54:08 -0700
Message-ID: <7vhde1pg5b.fsf@assigned-by-dhcp.cox.net>
References: <20050807205342.8497.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 23:55:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1t6b-0008UT-3T
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 23:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbVHGVyL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 17:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbVHGVyL
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 17:54:11 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:26336 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1752858AbVHGVyK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 17:54:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050807215409.YIZN12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 Aug 2005 17:54:09 -0400
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050807205342.8497.qmail@web26304.mail.ukl.yahoo.com> (Marco
	Costalba's message of "Sun, 7 Aug 2005 13:53:42 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marco Costalba <mcostalba@yahoo.it> writes:

> A suggestion I would like to present is if can be useful a
> kind of scheduling/list of planned compatibility break features so
>  that developers can know in advance when and what will break
>  their stuff and users can know when they will need to upgrade.

Yes, that is a valid concern.  Fortunately this is the only
backward incompatible thing I currently see on the horizon.

Here are the list of things I am currently thinking about
updating.

 - The format-patch, rebase and cherry parameters you already
   know about.  I do not think the "ugly" two parameter
   compromise is too much baggage to keep around, so my original
   plan was not to break the backward compatibility.

 - Fetch and pull.  Currently git fetch (and git pull) takes the
   following forms:

    $ git fetch <remote>
    $ git fetch <remote> <head>
    $ git fetch <remote> tag <tag>

   I am planning to update it to take:

    $ git fetch <remote> <refspec>...

   but in a backward compatible way.

   <refspec> can take the following forms:

    - A <refspec> of form "<src>:<dst>" is to fetch the objects
      needed for the remote ref that matches <src>, and if <dst>
      is not empty, store it to the local that matches <dst>.
      The same rule as "git push" applies for <dst>.  <src> can
      be either a ref pattern or the SHA1 object name.  If <src>
      is not an SHA1 object name, and it does not match exactly
      one remote ref, it is an error.

    - "tag" followed by <next> is just an old way of saying
      "refs/tags/<next>:refs/tags/<next>"; this mimics the
      current behaviour of the third form above and means "fetch
      that tag and store it under the same name".

    - A single token <refspec> without colon is a shorthand for
      "<refspec>:"  That is, "fetch that ref but do not store
      anywhere".

    - when there is no <refspec> specified

      - if <remote> is the name of a file under
        $GIT_DIR/branches/ (i.e. a shorthand without trailing
        path), then it is the same as giving a single <refspec>
        "<remote-name>:refs/heads/<remote>" on the command line,
        where <remote-name> is the remote branch name (defaults
        to HEAD, but can be overridden by .git/branches/<remote>
        file having the URL fragment notation).  That is, "fetch
        that branch head and store it in refs/heads/<remote>".

      - otherwise, it is the same as giving a single <refspec>
        that is "HEAD:".

    The SHA1 object names of fetched refs are stored in FETCH_HEAD
    [*1*], one name per line.  There will be an empty line for the
    ref that was not available on the remote end.

  I have pull enhancements that takes more than one remote refs
  in mind, but that will not be in the immediate future.  What
  will happen when the above fetch enhancement happens is that
  pull will accept the same set of parameters as the updated
  fetch does, runs the fetch, but refuses to run resolve when
  more than one remote ref is involved.  When resolve is updated
  to do an octopus (or a king ghidorah), this restriction can be
  lifted without breaking backward compatibility.

[Footnote]
*1* git-fetch-pack most likely will just output SHA1 to its
standard output like Linus suggested earlier.
