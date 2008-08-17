From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 2/7] system_path(): Add prefix computation at runtime if RUNTIME_PREFIX set
Date: Sun, 17 Aug 2008 22:43:09 +0200
Message-ID: <200808172243.09129.johannes.sixt@telecom.at>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de> <1218977083-14526-2-git-send-email-prohaska@zib.de> <1218977083-14526-3-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 22:44:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp6u-0002bK-0i
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbYHQUnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbYHQUnM
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:43:12 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:45245 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbYHQUnM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:43:12 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 7182FBEF90;
	Sun, 17 Aug 2008 22:43:09 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 330431D2A0;
	Sun, 17 Aug 2008 22:43:09 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1218977083-14526-3-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92630>

On Sonntag, 17. August 2008, Steffen Prohaska wrote:
> This commit modifies system_path() to compute the prefix at runtime
> if explicitly requested to do so.  If RUNTIME_PREFIX is defined,
> system_path() tries to strip known directories that executables can
> be located in from the path of the executable.  If the path is
> successfully stripped it is used as the prefix.

An example would be helpful. From your description it is difficult to 
understand what is stripped from where.

> diff --git a/exec_cmd.c b/exec_cmd.c
> index ce6741e..1622481 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -9,11 +9,51 @@ static const char *argv0_path;
>
>  const char *system_path(const char *path)
>  {
> -	if (!is_absolute_path(path) && argv0_path) {
> -		struct strbuf d = STRBUF_INIT;
> -		strbuf_addf(&d, "%s/%s", argv0_path, path);
> -		path = strbuf_detach(&d, NULL);
> +#ifdef RUNTIME_PREFIX
> +	static const char *prefix;
> +
> +	if (!argv0_path) {
> +		fprintf(stderr, "RUNTIME_PREFIX requested for path '%s', "
> +				"but argv0_path not set.\n", path);

If this happens, isn't this a logic error: assert(argv0_path)?

> +		return path;
> +	}
> +
> +	if (!prefix) {
> +		const char *strip[] = {
> +			GIT_EXEC_PATH,
> +			BINDIR,
> +			0
> +		};
> +		const char **s;
> +
> +		for (s = strip; *s; s++) {
> +			const char *sargv = argv0_path + strlen(argv0_path);
> +			const char *ss = *s + strlen(*s);
> +			while (argv0_path < sargv && *s < ss
> +				&& (*sargv == *ss ||
> +				    (is_dir_sep(*sargv) && is_dir_sep(*ss)))) {
> +				sargv--;
> +				ss--;
> +			}
> +			if (*s == ss) {
> +				struct strbuf d = STRBUF_INIT;
> +				strbuf_add(&d, argv0_path, sargv - argv0_path);
> +				prefix = strbuf_detach(&d, NULL);
> +				break;
> +			}
> +		}

Doesn't this do a thing very similar to longest_ancestor_length() (which still 
does not work for Windows paths, yet)?

>  	}
> +
> +	if (!prefix) {
> +		fprintf(stderr, "RUNTIME_PREFIX requested for path '%s', "
> +				"but prefix computation failed.\n", path);

Again a logic error?

> +		return path;
> +	}
> +
> +	struct strbuf d = STRBUF_INIT;
> +	strbuf_addf(&d, "%s/%s", prefix, path);
> +	path = strbuf_detach(&d, NULL);
> +#endif
>  	return path;
>  }
