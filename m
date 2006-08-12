From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Better error message when we are unable to lock the index file
Date: Sat, 12 Aug 2006 01:09:44 -0700
Message-ID: <7v4pwiqss7.fsf@assigned-by-dhcp.cox.net>
References: <20060812073756.5442.5498.stgit@c165>
	<7v8xluqt24.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Aug 12 10:09:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBoZ6-0007qW-5i
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 10:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWHLIJr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 04:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWHLIJr
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 04:09:47 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:8618 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932293AbWHLIJq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Aug 2006 04:09:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060812080946.LITU2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Aug 2006 04:09:46 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <7v8xluqt24.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 12 Aug 2006 01:03:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25255>

Junio C Hamano <junkio@cox.net> writes:

> Looking at output from:
>
> 	$ git grep -A 3 hold_lock_file_for_update
>
> I wonder if it might be more consistent to do something like
> this instead.  It removes more lines than it adds ;-).
>
> Most of the callers except the one in refs.c use the function to
> update the index file.  Among the index writers, everybody
> except write-tree dies if they cannot open it for writing.
>
> diff --git a/refs.c b/refs.c
> index 28a9394..564f8a7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -319,7 +319,7 @@ static struct ref_lock *lock_ref_sha1_ba
>  
>  	if (safe_create_leading_directories(lock->ref_file))
>  		die("unable to create directory for %s", lock->ref_file);
> -	lock->lock_fd = hold_lock_file_for_update(lock->lk, lock->ref_file);
> +	lock->lock_fd = hold_lock_file_for_update(lock->lk, lock->ref_file, 0);
>  	if (lock->lock_fd < 0) {
>  		error("Couldn't open lock file %s: %s",
>  		      lock->lk->filename, strerror(errno));

Looking at this part further, it seems that this one could
simply die when it fails -- after all it dies when leading
directories cannot be created, so dying upon failure of
hold_lock_file_for_update() would be consistent ;-).

Which makes write-tree the only odd-man-out.
