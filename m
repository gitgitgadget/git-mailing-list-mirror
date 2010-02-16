From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 19:02:09 +0100
Message-ID: <20100216180209.GA1532@book.hvoigt.net>
References: <20100215225001.GA944@book.hvoigt.net> <7vwryet2cw.fsf@alter.siamese.dyndns.org> <7vocjpnc5v.fsf@alter.siamese.dyndns.org> <7vljetlx8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 19:02:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhRkZ-0005kC-Mp
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 19:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757036Ab0BPSCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 13:02:13 -0500
Received: from darksea.de ([83.133.111.250]:57709 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756682Ab0BPSCN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 13:02:13 -0500
Received: (qmail 17394 invoked from network); 16 Feb 2010 19:02:10 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 16 Feb 2010 19:02:10 +0100
Content-Disposition: inline
In-Reply-To: <7vljetlx8r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140133>

On Mon, Feb 15, 2010 at 06:39:48PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Is this the answer to my question?

Sorry I forgot to add a reference to the thread from which the patch
originated: http://groups.google.com/group/msysgit/msg/5da53cf1ccf417cf

> IOW, please try this patch.  I am planning to queue it to 'maint' as part
> of 1.7.0.1 if this is the right solution (which I obviously think it is).

Yes your patch does it correctly I just verified that the segfaults are
gone as well. I think your solution is even nicer than mine. Thanks.

> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Mon, 15 Feb 2010 18:34:28 -0800
> Subject: [PATCH] Fix use of mutex in threaded grep
[...]
> diff --git a/builtin-grep.c b/builtin-grep.c
> index 26d4deb..5c1545e 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -81,8 +81,8 @@ static pthread_mutex_t read_sha1_mutex;
>  
>  #define grep_lock() pthread_mutex_lock(&grep_mutex)
>  #define grep_unlock() pthread_mutex_unlock(&grep_mutex)
> -#define read_sha1_lock() pthread_mutex_lock(&read_sha1_mutex)
> -#define read_sha1_unlock() pthread_mutex_unlock(&read_sha1_mutex)
> +#define read_sha1_lock() do { if (use_threads) pthread_mutex_lock(&read_sha1_mutex); } while (0)
> +#define read_sha1_unlock() do { if (use_threads) pthread_mutex_unlock(&read_sha1_mutex); } while (0)

One minor thing: Would it not be even nicer having the while loop inside
the if clause? E.g like this

#define read_sha1_lock() if (use_threads) do { pthread_mutex_lock(&read_sha1_mutex); } while (0)
#define read_sha1_unlock() if (use_threads) do { pthread_mutex_unlock(&read_sha1_mutex); } while (0)

If the purpose was to force a thread switch it is not necessary when not
using threads.

cheers Heiko
