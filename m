From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 8 May 2005 17:25:29 +0200
Message-ID: <20050508152529.GU9495@pasky.ji.cz>
References: <1115564550.9031.96.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 17:19:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUnYf-0003ss-7h
	for gcvg-git@gmane.org; Sun, 08 May 2005 17:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVEHPZr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 11:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbVEHPZr
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 11:25:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45271 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262884AbVEHPZb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 11:25:31 -0400
Received: (qmail 22370 invoked by uid 2001); 8 May 2005 15:25:29 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115564550.9031.96.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 05:02:30PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Petr,

Hi,

> this is a modified version of my patch that integrates the your latest
> modifications to cg-commit and also fixes the cleanup of the temporary
> files when we abort the operation.

...and I've just pushed more modifications. I'm so evil.

> [PATCH] Make use of external editor work like CVS
> 
> The lines starting with `CG:' should be a trailer and not at the top
> of the message presented in the editor. Also extend the number of `-'
> up to 74 characters so that people know when they should start a new
> line. If it's not a merge and no commit text is given as parameter
> then add an extra empty line at the top. And don't forget to take
> care of the temporary files when a commit is unneeded or canceled.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

What is so special about 74 columns? Why not 75 (fmt default), or 72
(emails)?

Also, I'd prefer the empty line to be always there in front of the CG:
stuff (two empty lines in case of merge - I want to encourage people to
keep possible details w.r.t. the merge separated by an empty line from
the merge information), and when reading it back cg-commit should strip
any trailing empty lines.

> Index: cg-commit
> ===================================================================
> --- 8bb38f8bfdc7411460c300c811da1987173f412f/cg-commit  (mode:100755)
> +++ be440e169fa3b5ec5450fa9574cd8789b0e3ab20/cg-commit  (mode:100755)
>  if [ "$merging" ]; then
> -	echo -n 'Merge with ' >>$LOGMSG
> -	[ "$msgs" ] && echo -n 'Merge with '
> +	echo -n "Merge with " >>$LOGMSG
> +	[ "$msgs" ] && echo -n "Merge with "

We aren't too consistent about this anyway now, so you might as well
let it not clutter your patch. ;-)

>  cp $LOGMSG $LOGMSG2
>  if tty -s; then
>  	if ! [ "$msgs" ]; then
> -		${EDITOR:-vi} $LOGMSG2
> -		[ $LOGMSG2 -nt $LOGMSG ] || die 'Commit message not modified, commit aborted'
> +		${EDITOR:-vi} $LOGMSG
> +		if [ ! $LOGMSG -nt $LOGMSG2 ]; then
> +			rm $LOGMSG $LOGMSG2
> +			die 'Commit message not modified, commit aborted.'
> +		fi
>  	fi
>  else
> -	cat >>$LOGMSG2
> +	cat >>$LOGMSG
>  fi
> -grep -v ^CG: $LOGMSG2 >$LOGMSG
> -rm $LOGMSG2
> +grep -v ^CG: $LOGMSG >$LOGMSG2
> +mv $LOGMSG2 $LOGMSG

Why are you messing with the $LOGMSG variables here?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
