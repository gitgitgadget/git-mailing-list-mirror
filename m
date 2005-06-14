From: James Purser <purserj@winnsw.com.au>
Subject: Re: [PATCH] Adding Correct Useage Notification and -h Help flag
Date: Tue, 14 Jun 2005 12:28:13 +1000
Message-ID: <1118716092.8712.14.camel@localhost.localdomain>
References: <1118713641.8712.10.camel@localhost.localdomain>
	 <7vmzptbrsg.fsf@assigned-by-dhcp.cox.net>
Reply-To: purserj@winnsw.com.au
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jun 14 04:23:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di15Z-0000Ui-0S
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 04:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVFNC21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 22:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVFNC21
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 22:28:27 -0400
Received: from 202-3-193-131.hdsl.ddaustralia.com.au ([202.3.193.131]:60167
	"HELO mail.winnsw.com.au") by vger.kernel.org with SMTP
	id S261392AbVFNC2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 22:28:16 -0400
Received: from RICOHPHOTO ([156.43.201.143])
        by mail.winnsw.com.au (WIN Server 1) with ESMTP id CPJ38469
        for <git@vger.kernel.org>; Tue, 14 Jun 2005 12:27:36 +1000
To: git@vger.kernel.org
In-Reply-To: <7vmzptbrsg.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thanks for the tips, I shall submit a new patch along these lines when I
get home from work tonight.

On Tue, 2005-06-14 at 12:23, Junio C Hamano wrote:
> >>Added a couple of lines to the git wrapper. Includes Correct
> >>Useage and available scripts
> 
> I like the general direction of making "git" wrapper novice
> friendly, but have some suggestions to the implementation.
> 
>  (0) Do not mention that only certain subset is accessible.
>      Just saying "Available commands are:" would be enough, and
>      would not leave the end user wondering what he is missing.
> 
>  (1) Instead of explicitly checking for -h, you may want to
>      structure it like this:
> 
>          #!/bin/sh
> 
>          cmd="git-$1-script";
>          shift;
>          exec $cmd "$@";
>          echo "Usage: git <subcommand> [<param>...]"
>          echo 'Available commands are:"
>          git bar
> 	 git foo
>          ...
>          '
>          exit 1
> 
>      Alternatively, you could say:
> 
>          #!/bin/sh
> 
>          case "$1" in
>          -h)
>              echo "Usage: git <subcommand> [<param>...]"
>              echo 'Available commands are:
>          git bar
> 	 git foo
>          ...
>          '
>              exit 0 ;;
> 	 esac
> 
>          cmd="git-$1-script";
>          shift;
>          exec $cmd "$@";
> 	 git -h
>          exit 1
> 
>  (2) Maintaining the list of commands by hand in git script
>      itself have an advantage that you _could_ describe the
>      options and parameters they take, but you are not doing
>      that in your patch (hint, hint).
> 
>      If all you give is the list of subcommand names, have
>      git.in as a source file, and create the "list of available
>      commands" from the Makefile, like this:
> 
>      === Makefile ===
>      ...
>      git : git.in
>          /bin/sh ls -1 git-*-script | \
>          sed -e 's/git-\(.*\)-script/git \1/' >.git-cmd-list
>          sed -e '/@@LIST_OF_COMMANDS@@/{s/.*//;r .git-cmd-list;}' <$@.in >$@
>          rm -f .git-cmd-list
> 
>      === git.in ===
>      #!/bin/sh
> 
>      cmd="git-$1-script";
>      shift;
>      exec $cmd "$@";
>      echo "Usage: git <subcommand> [<param>...]"
>      echo 'Available commands are:
>      @@LIST_OF_COMMANDS@@
>      '
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
James Purser
Winnet Developer
+61 2 4223 4131
http://www.winnet.com.au

