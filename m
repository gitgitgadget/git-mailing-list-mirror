From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] allowing hooks to ignore input?
Date: Sat, 13 Sep 2014 10:19:18 +0200
Message-ID: <5413FE06.1020901@kdbg.org>
References: <xmqqzje48nh4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 10:19:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSiYV-0007Lm-4r
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 10:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbaIMITY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 04:19:24 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:8766 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbaIMITU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 04:19:20 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C9904130058;
	Sat, 13 Sep 2014 10:19:18 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3620F19F364;
	Sat, 13 Sep 2014 10:19:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <xmqqzje48nh4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256955>

Am 13.09.2014 um 00:48 schrieb Junio C Hamano:
> The pre-receive and post-receive hooks were designed to be an
> improvement over old style update and post-update hooks that used to
> take the update information on the command line and were limited by
> the command line length limit.  They take the same information from
> their standard input.  It has been mandatory for these new style
> hooks to consume the update information fully from the standard
> input stream.  Otherwise, they would risk killing the receive-pack
> process via SIGPIPE.
> 
> This is easy, and it has already been done by existing hooks that
> are written correctly, to work around, if a hook does not want to
> look at all the information, by sending its standard input to
> /dev/null (perhaps a niche use of hook might need to know only the
> fact that a push was made, without having to know what objects have
> been pushed to update which refs).
> 
> However, because there is no good way to consistently fail hooks
> that do not consume the input fully, it can lead to a hard to
> diagnose "once in a blue moon" phantom failure.
> 
> I wonder if this "you must consume the input fully", which is a
> mandate that is not enforced strictly, is not helping us to catch
> mistakes in hooks more than it is hurting us.  Perhaps we can do
> something like the attached patch to make it optional for them to
> read the input we feed?
> 
> I dunno.
> 
>  builtin/receive-pack.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 30560a7..9d9d16d 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -17,6 +17,7 @@
>  #include "version.h"
>  #include "tag.h"
>  #include "gpg-interface.h"
> +#include "sigchain.h"
>  
>  static const char receive_pack_usage[] = "git receive-pack <git-dir>";
>  
> @@ -500,6 +501,8 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
>  		return code;
>  	}
>  
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
>  	while (1) {
>  		const char *buf;
>  		size_t n;
> @@ -511,6 +514,9 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
>  	close(proc.in);
>  	if (use_sideband)
>  		finish_async(&muxer);
> +
> +	sigchain_pop(SIGPIPE);
> +
>  	return finish_command(&proc);
>  }

I think this is a good move. Hooks are written by users, who sometimes
are not clueful enough.

But what do our writers do when they fail with EPIPE? Die? If so, this
patch alone is not sufficient.

-- Hannes
