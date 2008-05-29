From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 6/5] NUL hack to create_file()
Date: Thu, 29 May 2008 11:55:56 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805291145230.19665@iabervon.org>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com> <1212020246-26480-2-git-send-email-gitster@pobox.com> <1212020246-26480-3-git-send-email-gitster@pobox.com> <1212020246-26480-4-git-send-email-gitster@pobox.com> <1212020246-26480-5-git-send-email-gitster@pobox.com>
 <1212020246-26480-6-git-send-email-gitster@pobox.com> <1212020246-26480-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 17:57:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1kUo-0002Yn-KJ
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 17:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbYE2P4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 11:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbYE2P4B
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 11:56:01 -0400
Received: from iabervon.org ([66.92.72.58]:36087 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752961AbYE2P4A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 11:56:00 -0400
Received: (qmail 28128 invoked by uid 1000); 29 May 2008 15:55:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 May 2008 15:55:56 -0000
In-Reply-To: <1212020246-26480-7-git-send-email-gitster@pobox.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83212>

On Wed, 28 May 2008, Junio C Hamano wrote:

> This is not meant for application to the mainline.  It allows your git to
> refuse to create a blob whose name is "nul".

I assume this is so you can test git's response to a defective filesystem 
without actually having a defective filesystem?

> ---
>  entry.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/entry.c b/entry.c
> index 222aaa3..d24b803 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -81,6 +81,14 @@ static void remove_subtree(const char *path)
>  
>  static int create_file(const char *path, unsigned int mode)
>  {
> +	if (1) {
> +		size_t len = strlen(path);
> +		if (3 <= len && !strcmp(path + len - 3, "nul") &&
> +		    (3 == len || path[len - 4] == '/')) {
> +			errno = EPERM;

Shouldn't this be EEXIST? I think the issue is that the first exists for 
the purpose of open() but not for anything else we've done up to this 
point.

> +			return -1;
> +		}
> +	}
>  	mode = (mode & 0100) ? 0777 : 0666;
>  	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
>  }
> -- 
> 1.5.6.rc0.43.g823ea
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
