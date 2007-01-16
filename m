From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Solaris 5.8 returns ENOTDIR for inappropriate renames.
Date: Mon, 15 Jan 2007 18:56:22 -0800
Message-ID: <7vslebznl5.fsf@assigned-by-dhcp.cox.net>
References: <17433.1168911059@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 03:56:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6eV1-00038Z-LX
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 03:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbXAPC4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 21:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbXAPC4Y
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 21:56:24 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:63215 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbXAPC4X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 21:56:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070116025622.DHVO19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Mon, 15 Jan 2007 21:56:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id BevV1W00a1kojtg0000000; Mon, 15 Jan 2007 21:55:30 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <17433.1168911059@lotus.CS.Berkeley.EDU> (Jason Riedy's message
	of "Mon, 15 Jan 2007 17:30:59 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36913>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> The reflog code clears empty directories when rename returns
> either EISDIR or ENOTDIR.  Seems to be the only place.
>
> Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>
> ---
>    Haven't been keeping up with the list, so I apologize if I've
>    missed discussions related to these changes.
>
>  refs.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 689ac50..851b573 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -837,7 +837,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
>  
>   retry:
>  	if (log && rename(git_path("tmp-renamed-log"), git_path("logs/%s", newref))) {
> -		if (errno==EISDIR) {
> +		if (errno==EISDIR || errno==ENOTDIR) {
>  			if (remove_empty_directories(git_path("logs/%s", newref))) {
>  				error("Directory not empty: logs/%s", newref);
>  				goto rollback;

Sorry, I do not understand.

Before this codepath, we have done safe_create_directories() and
should have already errored out if the parent directory of
"logs/$newref" couldn't have been created for whatever reason.
So when this rename fails, we have a file ".git/tmp-renamed-log"
and a directory ".git/logs/foo", and we are trying to rename the
former to ".git/logs/foo/bar".

Now ".git/logs/foo/bar" might already exist as a directory, and
this error path is attempting to catch EISDIR that comes out
from it (and in that case, if there is nothing but empty
directories in the hierarchy under .git/logs/foo/bar, we 
remove them and retry).

Does Solaris give ENOTDIR in such a case?
