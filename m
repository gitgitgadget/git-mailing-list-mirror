From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: Fix error message for push <remote>
 :<branch>
Date: Mon, 18 Feb 2008 13:45:08 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181339470.30505@racer.site>
References: <20080218130726.GA26854@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 18 14:46:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR6Jx-0002tC-Mp
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 14:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbYBRNpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 08:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbYBRNpX
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 08:45:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:39452 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751791AbYBRNpV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 08:45:21 -0500
Received: (qmail invoked by alias); 18 Feb 2008 13:45:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp025) with SMTP; 18 Feb 2008 14:45:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18s/3YrJd8s89RvYHGo/j9TOQNPfoNhfhzz+gc33l
	mxBl5P1EXrfSNv
X-X-Sender: gene099@racer.site
In-Reply-To: <20080218130726.GA26854@localhost>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74288>

Hi,

On Mon, 18 Feb 2008, Clemens Buchacher wrote:

> git http-push <remote> :<branch> currently fails with the error message 
> "cannot happen anymore". Print a more useful error message instead.
> 
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
> 
> We should actually support this feature, of course. Unfortunately, a lot 
> has changed since the version of send-pack which http-push is based on 
> (v1.2.4-398-gaa1dbc9). I think http-push should be updated to reflect 
> these changes at a larger scope. Is there any work going on in this 
> direction?

Nope.  You are the ideal candidate to start, though.

> diff --git a/http-push.c b/http-push.c
> index f9b77d6..8de091f 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -2311,6 +2311,15 @@ int main(int argc, char **argv)
>  
>  		if (!ref->peer_ref)
>  			continue;
> +
> +		if (is_zero_sha1(ref->peer_ref->new_sha1)) {
> +			error("Deleting remote branches via :<branch> is not "
> +				"currently supported by http-push. Use git "
> +				"http-push -d <remote-url> <branch> instead.");
> +			rc = -2;
> +			continue;
> +		}
> +

You forgot to remove the now-obsolete warning...

Besides, why don't you just try to imitate the code for "-d"?  It says

        if (delete_branch) {
                if (delete_remote_branch(refspec[0], force_delete) == -1)
                        fprintf(stderr, "Unable to delete remote branch %s\n",
                                refspec[0]);
                goto cleanup;
        }

So I think something like this should work, at the same place you added 
your code:

		if (is_zero_sha1(ref->peer_ref->new_sha1)) {
			if (delete_remote_branch(ref->peer_ref->name,
					force_delete || ref->force) == -1) {
				error("Could not remove %s",
					ref->peer_ref->name);
				rc = -4;
			}
			continue;
		}

Care to try that?

Ciao,
Dscho
