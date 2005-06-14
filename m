From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Adding Correct Useage Notification and -h Help flag
Date: Mon, 13 Jun 2005 19:23:11 -0700
Message-ID: <7vmzptbrsg.fsf@assigned-by-dhcp.cox.net>
References: <1118713641.8712.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 04:20:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di11g-00007x-J0
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 04:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVFNCYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 22:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVFNCYP
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 22:24:15 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:26838 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261383AbVFNCXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 22:23:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050614022310.EBKT22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Jun 2005 22:23:10 -0400
To: purserj@winnsw.com.au
In-Reply-To: <1118713641.8712.10.camel@localhost.localdomain> (James
 Purser's message of "Tue, 14 Jun 2005 11:47:22 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


>>Added a couple of lines to the git wrapper. Includes Correct
>>Useage and available scripts

I like the general direction of making "git" wrapper novice
friendly, but have some suggestions to the implementation.

 (0) Do not mention that only certain subset is accessible.
     Just saying "Available commands are:" would be enough, and
     would not leave the end user wondering what he is missing.

 (1) Instead of explicitly checking for -h, you may want to
     structure it like this:

         #!/bin/sh

         cmd="git-$1-script";
         shift;
         exec $cmd "$@";
         echo "Usage: git <subcommand> [<param>...]"
         echo 'Available commands are:"
         git bar
	 git foo
         ...
         '
         exit 1

     Alternatively, you could say:

         #!/bin/sh

         case "$1" in
         -h)
             echo "Usage: git <subcommand> [<param>...]"
             echo 'Available commands are:
         git bar
	 git foo
         ...
         '
             exit 0 ;;
	 esac

         cmd="git-$1-script";
         shift;
         exec $cmd "$@";
	 git -h
         exit 1

 (2) Maintaining the list of commands by hand in git script
     itself have an advantage that you _could_ describe the
     options and parameters they take, but you are not doing
     that in your patch (hint, hint).

     If all you give is the list of subcommand names, have
     git.in as a source file, and create the "list of available
     commands" from the Makefile, like this:

     === Makefile ===
     ...
     git : git.in
         /bin/sh ls -1 git-*-script | \
         sed -e 's/git-\(.*\)-script/git \1/' >.git-cmd-list
         sed -e '/@@LIST_OF_COMMANDS@@/{s/.*//;r .git-cmd-list;}' <$@.in >$@
         rm -f .git-cmd-list

     === git.in ===
     #!/bin/sh

     cmd="git-$1-script";
     shift;
     exec $cmd "$@";
     echo "Usage: git <subcommand> [<param>...]"
     echo 'Available commands are:
     @@LIST_OF_COMMANDS@@
     '

