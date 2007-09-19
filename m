From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Use xmemdup in many places.
Date: Wed, 19 Sep 2007 01:08:12 -0700
Message-ID: <7v6427qdqr.fsf@gitster.siamese.dyndns.org>
References: <20070917161113.GB460@artemis.corp>
	<20070917161142.D3C9A344A49@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:08:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXubh-00053P-5r
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbXISIIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbXISIIT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:08:19 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbXISIIR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:08:17 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2AD4D13463F;
	Wed, 19 Sep 2007 04:08:36 -0400 (EDT)
In-Reply-To: <20070917161142.D3C9A344A49@madism.org> (Pierre Habouzit's
	message of "Sun, 16 Sep 2007 00:32:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58688>

Pierre Habouzit <madcoder@debian.org> writes:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  attr.c                  |    7 +------
>  builtin-add.c           |    8 ++------
>  builtin-apply.c         |   11 ++---------
>  builtin-fetch--tool.c   |    6 +-----
>  builtin-fmt-merge-msg.c |   17 ++++++-----------
>  builtin-for-each-ref.c  |   40 +++++++++-------------------------------
>  builtin-log.c           |   12 ++----------
>  builtin-ls-files.c      |    9 +--------
>  builtin-mv.c            |    5 +----
>  builtin-revert.c        |    4 +---
>  builtin-shortlog.c      |   11 ++---------
>  commit.c                |   16 ++++++----------
>  connect.c               |    4 +---
>  convert.c               |    7 +------
>  diff.c                  |   13 ++-----------
>  diffcore-order.c        |    7 ++-----
>  fast-import.c           |    4 +---
>  http-push.c             |    9 ++-------
>  imap-send.c             |   20 +++++---------------
>  merge-recursive.c       |   19 ++++---------------
>  refs.c                  |   12 ++++--------
>  sha1_file.c             |   12 +++---------
>  tag.c                   |    4 +---
>  23 files changed, 60 insertions(+), 197 deletions(-)
> ...
> diff --git a/builtin-apply.c b/builtin-apply.c
> index 05011bb..900d0a7 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -293,11 +293,7 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
>  			return def;
>  	}
>  
> -	name = xmalloc(len + 1);
> -	memcpy(name, start, len);
> -	name[len] = 0;
> -	free(def);
> -	return name;
> +	return xmemdup(start, len);
>  }

Did we start leaking "def" here? 

> diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
> index 0afa1c5..287d52a 100644
> --- a/builtin-for-each-ref.c
> +++ b/builtin-for-each-ref.c
> ...
> @@ -305,46 +301,28 @@ static const char *find_wholine(const char *who, int wholen, const char *buf, un
> ...
>  static const char *copy_name(const char *buf)
>  {
> -	const char *eol = strchr(buf, '\n');
> -	const char *eoname = strstr(buf, " <");
> -	char *line;
> -	int len;
> -	if (!(eoname && eol && eoname < eol))
> -		return "";
> -	len = eoname - buf;
> -	line = xmalloc(len + 1);
> -	memcpy(line, buf, len);
> -	line[len] = 0;
> -	return line;
> +	const char *cp;
> +	for (cp = buf; *cp != '\n'; cp++) {
> +		if (!strncmp(cp, " <", 2))
> +			return xmemdup(buf, cp - buf);
> +	}
> +	return "";
>  }

At least the loop should terminate upon (!*cp); if you do not
have '\n' in the buffer what happens?
