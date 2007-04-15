From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] display shortlog after git-commit
Date: Sun, 15 Apr 2007 13:33:55 +0300
Message-ID: <20070415103355.GA12126@mellanox.co.il>
References: <20070404070135.GF31984@mellanox.co.il>
	<7vd52k7dxi.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 12:34:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd23z-0005Db-Fe
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 12:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXDOKeJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 06:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbXDOKeJ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 06:34:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:15607 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbXDOKeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 06:34:07 -0400
Received: by ug-out-1314.google.com with SMTP id 44so872197uga
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 03:34:05 -0700 (PDT)
Received: by 10.67.106.3 with SMTP id i3mr3456808ugm.1176633245751;
        Sun, 15 Apr 2007 03:34:05 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id 50sm5347221ugb.2007.04.15.03.33.51;
        Sun, 15 Apr 2007 03:33:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vd52k7dxi.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44494>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] display shortlog after git-commit
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> >> I actually find it awkward that author/summary information is never
> >> shown during git commit - sometimes one does git commit
> >> on a machine where GIT_AUTHOR_EMAIL has not been setup
> >> correctly, and the result often is mst@mst-desktop.(none).
> 
> That is something that needs to be set up once.  I do not think
> it justifies wasting three more lines (one of them being an
> empty line) per every commit.
> 
> >> Or people sometimes forget that the first line will show up
> >> in the pretty=short summary and the result is that what
> >> ends up being there is just 2 first lines of the long description.
> >>
> >> One has to remember to always do git log --pretty=short
> >> after commit to verify that one did get these details right.
> 
> >> Ideas:
> >> - Maybe have git-commit display shortlog summary for commit just created?
> >
> > Hopefully this will make people fix the git config up and amend their commits themselves.
> > Does this sound like a good idea?

I've been thinking about this idea some more recently.

> Too noisy for a default.

How about only printing out the shortlog summary?

> Maybe protect it with "[user] novice" in .git/config?

OK but [user] novice would have to be set by default then,
otherwise novice won't know he has to enable it :).

> Otherwise
> I think it gets too noisy once you get used to it. 

You are right. How about only doing this only if
the log message is multi-line, and there is no separate summary?

> I think reviewing and fixing is best done in the editor (that's
> why git-commit does not start reading from stdin when it expects
> you to type a log message, but gives you an editor), and
> pointing out a mistake after the fact, while it is probably
> better than not pointing out at all, is not all that useful.  If
> there is no mistake, it is just an added noise, and if there is
> a mistake, the user needs to take another action (i.e. --amend)
> to correct it.
> 
> I think a much better thing you could do is to have a mode that
> the commit log message editor is started with something like
> this...

This would work well for author information, but less well for shortlog.

> 	----------------------------------------------------------------
> 	From: A U Thor <au.thor@example.com>
>         Subject: << the summary of the commit comes here >>
>         
> 	# << more detailed explanations come here >>
> 	# Please enter the commit message for your changes.
>         # (comment lines starting with '#' will not be included)
> 	# On branch 'master'
>         # Changes to be committed:
>         # ...
> 	----------------------------------------------------------------
> 
> and teach git-commit to notice the first paragraph that is
> formatted like RFC2822 headers, and do appropriate things.
> 
> "Something like" this patch, although this time I have these two
> words in quotes because I know the part to unmunge the buffer
> needs more work.
> 
> diff --git a/git-commit.sh b/git-commit.sh
> index 292cf96..d7a7b0b 100755
> --- a/git-commit.sh
> +++ b/git-commit.sh
> @@ -546,10 +546,13 @@ else
>  fi
>  set_reflog_action "$rloga"
>  
> +summary_mark='<< the summary of the commit comes here >>'
>  if test -z "$no_edit"
>  then
>  	{
> +		echo "$summary_mark"
>  		echo ""
> +		echo "# << more detailed explanations come here >>"
>  		echo "# Please enter the commit message for your changes."
>  		echo "# (Comment lines starting with '#' will not be included)"
>  		test -z "$only_include_assumed" || echo "$only_include_assumed"
> @@ -579,7 +582,34 @@ case "$no_edit" in
>  	esac
>  	git-var GIT_AUTHOR_IDENT > /dev/null  || die
>  	git-var GIT_COMMITTER_IDENT > /dev/null  || die
> -	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG"
> +	{
> +		echo "From: $(expr "$(git-var GIT_AUTHOR_IDENT)" : '\(.*>\)')"
> +		sed -e '1s/^/Subject: /' "$GIT_DIR/COMMIT_EDITMSG"
> +		echo ""
> +	} >"$GIT_DIR/COMMIT_EDITMSG+"
> +	mv "$GIT_DIR/COMMIT_EDITMSG+" "$GIT_DIR/COMMIT_EDITMSG"
> +	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG" || exit
> +
> +	AU=$(sed -n -e '
> +		/^$/q
> +		/^From: /{
> +			s///p
> +			q
> +	}' "$GIT_DIR/COMMIT_EDITMSG")
> +	if	test -n "$AU" &&
> +		AN=$(expr "$AU" : '\(.*[^ ]\)  *<') &&
> +		AE=$(expr "$AU" : '.*[^ ]  *<\(.*\)>$')
> +	then
> +		GIT_AUTHOR_NAME=$AN
> +		GIT_AUTHOR_EMAIL=$AE
> +		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
> +	fi
> +	sed -e '
> +		/^From: /d
> +		/^Subject: '"$summary_mark"'/d
> +		s/^Subject: //
> +	' "$GIT_DIR/COMMIT_EDITMSG" >"$GIT_DIR/COMMIT_EDITMSG+"
> +	mv "$GIT_DIR/COMMIT_EDITMSG+" "$GIT_DIR/COMMIT_EDITMSG"
>  	;;
>  esac
 
-- 
MST
