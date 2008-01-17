From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import.c: don't try to commit marks file if write failed
Date: Thu, 17 Jan 2008 09:57:35 -0800
Message-ID: <7vmyr4jpww.fsf@gitster.siamese.dyndns.org>
References: <7vk5m9kvf7.fsf@gitster.siamese.dyndns.org>
	<478F893A.6050105@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 18:58:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZ0j-0002Gd-Vl
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 18:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbYAQR5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 12:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbYAQR5n
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 12:57:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbYAQR5m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 12:57:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 712521CC8;
	Thu, 17 Jan 2008 12:57:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BE7AD1CC2;
	Thu, 17 Jan 2008 12:57:37 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70883>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> We also move the assignment of -1 to the lock file descriptor
> up, so that rollback_lock_file() can be called safely after a
> possible attempt to fclose(). This matches the contents of
> the 'if' statement just above testing success of fdopen().
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---

Shawn, could you lend an extra set of eyeballs on this one
please?  It looks sane to me but obviously you are more familiar
with the code.

> Since we forget the lock file descriptor there is a chance
> that we will leave the file open if a write error occurs. We'll
> still delete the file. I don't think it's worth bending
> over backwards to make sure the file is closed on this failure.
>
> -brandon
>
>
>  fast-import.c |   24 ++++++++++++++++--------
>  1 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index 3609c24..4cf5092 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1545,19 +1545,27 @@ static void dump_marks(void)
>  		return;
>  	}
>  
> -	dump_marks_helper(f, 0, marks);
> -	if (ferror(f) || fclose(f))
> -		failure |= error("Unable to write marks file %s: %s",
> -			mark_file, strerror(errno));
>  	/*
> -	 * Since the lock file was fdopen()'ed and then fclose()'ed above,
> -	 * assign -1 to the lock file descriptor so that commit_lock_file()
> +	 * Since the lock file was fdopen()'ed, it should not be close()'ed.
> +	 * Assign -1 to the lock file descriptor so that commit_lock_file()
>  	 * won't try to close() it.
>  	 */
>  	mark_lock.fd = -1;
> -	if (commit_lock_file(&mark_lock))
> -		failure |= error("Unable to write commit file %s: %s",
> +
> +	dump_marks_helper(f, 0, marks);
> +	if (ferror(f) || fclose(f)) {
> +		rollback_lock_file(&mark_lock);
> +		failure |= error("Unable to write marks file %s: %s",
>  			mark_file, strerror(errno));
> +		return;
> +	}
> +
> +	if (commit_lock_file(&mark_lock)) {
> +		rollback_lock_file(&mark_lock);
> +		failure |= error("Unable to commit marks file %s: %s",
> +			mark_file, strerror(errno));
> +		return;
> +	}
>  }
>  
>  static int read_next_command(void)
> -- 
> 1.5.4.rc3.17.gb63a4
