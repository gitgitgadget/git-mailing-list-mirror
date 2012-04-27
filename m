From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [RFC/PATCH] Reduce cost of deletion in levenstein distance (4
 -> 3)
Date: Fri, 27 Apr 2012 11:43:42 +0200
Message-ID: <4F9A6A4E.2070808@in.waw.pl>
References: <1335517082-29325-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Apr 27 11:43:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNhiV-00006I-9U
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 11:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760001Ab2D0Jnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 05:43:51 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35608 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913Ab2D0Jnu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 05:43:50 -0400
Received: from zopt1.fuw.edu.pl ([193.0.81.24] helo=[10.33.8.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SNhiO-0002Aj-Ez; Fri, 27 Apr 2012 11:43:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <1335517082-29325-1-git-send-email-Matthieu.Moy@imag.fr>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196461>

On 04/27/2012 10:58 AM, Matthieu Moy wrote:
> Before this patch, a character deletion has the same cost as 2 swaps, or
> 4 additions, so Git prefers suggesting a completely scrambled command
> name to removing a character. For example, "git tags" suggests "stage",
> but not "tag".
> 
> By setting the deletion cost to 3, we keep it higher than swaps or
> additions, but prefer 1 deletion to 2 swaps. "git tags" now suggests
> "tag" in addition to staged.

Hi,
looks sensible, but I wonder if the algorithm shouldn't be tweaked even
further. I understand why 'tags' and 'stage' are similar,
but if I say 'tagz', git proposes (with your change), both 'stage' and
'tag'. 'tag' is one deletion away, but 'stage' requires a deletion and a
replacement, so should loose to 'tag', I think.

Zbyszek

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> The funny thing is: A while ago, I reported that the typo "git tags"
> was not suggesting "git tag" as alternative "did you mean this?". A
> patch was posted and merged:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/101278
> 
> According to the discussion, I it worked for me. But I can't reproduce
> this "works for me" even going back to the version right after the fix
> above.
> 
>  help.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/help.c b/help.c
> index 14eefc9..fdaa90d 100644
> --- a/help.c
> +++ b/help.c
> @@ -334,7 +334,7 @@ const char *help_unknown_cmd(const char *cmd)
>  		}
>  
>  		main_cmds.names[i]->len =
> -			levenshtein(cmd, candidate, 0, 2, 1, 4) + 1;
> +			levenshtein(cmd, candidate, 0, 2, 1, 3) + 1;
>  	}
>  
>  	qsort(main_cmds.names, main_cmds.cnt,
