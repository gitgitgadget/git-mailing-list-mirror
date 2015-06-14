From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v2 07/19] am: extract patch, message and authorship with git-mailinfo
Date: Sun, 14 Jun 2015 15:10:24 -0700
Message-ID: <xmqqvbeqkkkv.fsf@gitster.dls.corp.google.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
	<1434018125-31804-8-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 00:10:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4G6p-0005WH-Uj
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 00:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbbFNWK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 18:10:28 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36488 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbFNWK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 18:10:26 -0400
Received: by igbiq7 with SMTP id iq7so6239189igb.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 15:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pDdsrn4AXk5wjbu+J+q3R3wpWNs99UtNqRg3UKdYilQ=;
        b=x4dW+AR27D26xcAQhJgRWp39ADl12LOMAd4BbtMguLEaohoZ+T18Jd0z4F+8Npu511
         tVvRuVXW8Yi5TIZFKYU39ojzeB6HEqepfDpV8T76w/uoMRnrmgQ39L+hzdsf4VS+rRfp
         ckKFWkfgGvESCbFGcz5WT6BiG2dm2/ylGgA/YET0HLXcehxh5quFH79B6EqwePX46xqz
         k/jGSl+17nzIJpxfPIBsmEu/5HdnhDWPitz592cj0TodBF+GvK6cGZu0EIEYwSo+CX6W
         DugiHprFq55e+uDq1GC4JzK5hVNCELAiZ1behJJbomrnXeWSQLuXf/huJpr8K/tI1cHw
         XoyQ==
X-Received: by 10.107.135.95 with SMTP id j92mr2563343iod.91.1434319825967;
        Sun, 14 Jun 2015 15:10:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8cf8:478e:8162:753f])
        by mx.google.com with ESMTPSA id f82sm1017285ioj.37.2015.06.14.15.10.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jun 2015 15:10:25 -0700 (PDT)
In-Reply-To: <1434018125-31804-8-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Thu, 11 Jun 2015 18:21:53 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271654>

Paul Tan <pyokagan@gmail.com> writes:

> For the purpose of applying the patch and committing the results,
> implement extracting the patch data, commit message and authorship from
> an e-mail message using git-mailinfo.
>
> git-mailinfo is run as a separate process, but ideally in the future,
> we should be be able to access its functionality directly without
> spawning a new process.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     v2
>     
>     * use die_errno()
>     
>     * use '%*d' as the format specifier for msgnum()
>
>  builtin/am.c | 228 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 228 insertions(+)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 7379b97..a1db474 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -9,6 +9,23 @@
>  #include "parse-options.h"
>  #include "dir.h"
>  #include "run-command.h"
> +#include "quote.h"
> +
> +/**
> + * Returns 1 if the file is empty or does not exist, 0 otherwise.
> + */
> +static int is_empty_file(const char *filename)
> +{
> +	struct stat st;
> +
> +	if (stat(filename, &st) < 0) {
> +		if (errno == ENOENT)
> +			return 1;
> +		die_errno(_("could not stat %s"), filename);
> +	}
> +
> +	return !st.st_size;
> +}
>  
>  enum patch_format {
>  	PATCH_FORMAT_UNKNOWN = 0,
> @@ -23,6 +40,12 @@ struct am_state {
>  	int cur;
>  	int last;
>  
> +	/* commit message and metadata */
> +	struct strbuf author_name;
> +	struct strbuf author_email;
> +	struct strbuf author_date;
> +	struct strbuf msg;
> +
>  	/* number of digits in patch filename */
>  	int prec;
>  };
> @@ -35,6 +58,10 @@ static void am_state_init(struct am_state *state)
>  	memset(state, 0, sizeof(*state));
>  
>  	strbuf_init(&state->dir, 0);
> +	strbuf_init(&state->author_name, 0);
> +	strbuf_init(&state->author_email, 0);
> +	strbuf_init(&state->author_date, 0);
> +	strbuf_init(&state->msg, 0);
>  	state->prec = 4;
>  }
>  
> @@ -44,6 +71,10 @@ static void am_state_init(struct am_state *state)
>  static void am_state_release(struct am_state *state)
>  {
>  	strbuf_release(&state->dir);
> +	strbuf_release(&state->author_name);
> +	strbuf_release(&state->author_email);
> +	strbuf_release(&state->author_date);
> +	strbuf_release(&state->msg);
>  }
>  
>  /**
> @@ -93,6 +124,95 @@ static int read_state_file(struct strbuf *sb, const char *file, size_t hint, int
>  }
>  
>  /**
> + * Parses the "author script" `filename`, and sets state->author_name,
> + * state->author_email and state->author_date accordingly. We are strict with
> + * our parsing, as the author script is supposed to be eval'd, and loosely
> + * parsing it may not give the results the user expects.
> + *
> + * The author script is of the format:
> + *
> + * 	GIT_AUTHOR_NAME='$author_name'

It seems that you have SP * SP TAB GIT_AUTHOR_... here; lose SP
before the TAB?

> +	if (!skip_prefix(sb.buf, "GIT_AUTHOR_NAME=", (const char**) &value))

Style:

	if (!skip_prefix(sb.buf, "GIT_AUTHOR_NAME=", (const char **)&value))
