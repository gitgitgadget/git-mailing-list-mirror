From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/WIP v3 06/31] am: detect mbox patches
Date: Wed, 24 Jun 2015 17:10:27 +0200
Organization: gmx
Message-ID: <334feea4cee88d06a10a7363956d2bfe@www.dscho.org>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
 <1434626743-8552-7-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 17:10:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7mJw-000233-Bj
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 17:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbbFXPKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 11:10:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:52233 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753208AbbFXPKa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 11:10:30 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MhRI2-1ZTB3e02kc-00Mdko; Wed, 24 Jun 2015 17:10:28
 +0200
In-Reply-To: <1434626743-8552-7-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:q0PJIqB4dqXw6er0ZnKeZ+CGWGgxi1RMyoP66tzBNgKQsK0zMAh
 kOOAQ3D5jzarUQhbEJoELw5SAboJ/DHOBlJ6v4JXc0wQyTkN/eUiMzdjUpAfU2ZkmRH/GVC
 2b8+rFDR1RBLsixUzLGQvu5hv+iHkW3nMk6/8T3+CXUg+6ipNet4RxCQESJRRWF0+BvaVKi
 EJIJXrr1pVP8mKUbjPuIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qw3AWCvSHrs=:r7fFHGGg/yLwgps2ssrCJZ
 idguCSlMxLCej3BF/uU6hqtPe4yCTkXX2JW6V3MzhY86xEQlGRg7USnte14P1QIj+0RmDgIrv
 gl+0pic4pBNgzClcSI3PPvpGOh/AVEdIwiOb/Rt0H3Xws74BhbTm5Q22TAikd7bknpH6/+fRz
 Nz3mtiY6/UJy6hPUu7rOZnAkMbEincq+fUbt7d7wgo37TlLQwrkyyFydqHACrLVmlGfICEr01
 CliOF+2/jwIl2dWqDQypxjNhtU0b+5ChSwP1vl/uJ0B7Vutg4RLy+I2O1IpeRreDRIWY2keRR
 EisyWDIUKBynYLl3pp38Dy3w9Coq/DRL/sc8c70iR5gfXV+Oh/l9iBWlpcSth5SXGptwQPTiW
 c88H8S1VkADSRqTtPy0WBYRJCUEHCpmLXkqJqAWLQIXhtDjW7/e7d4JeJVmm9JpOfTkbWQzmn
 A0cLQV+mPzOAvib+PQ7KjAUUFHUJfr/4PXjVqeDN+nKpxnfRGp3J61VIrlskr65NRS7wrabZI
 xAqtCmjEI22SDDuesISEZuBqUls+L5DToDbHYapjYDTG+rBQFpwcKjSkXvqSDUVRTzHdMVifV
 l5/QRdPNteVNRW0XGdeabvWBx1h7gUteGxBPkaCJt0tbnKowK7ThBhE3GQHdeaL2ohcNe0LlZ
 jvf/ap4UQUiGwan63aKqg2PGbicYSusdUMcjsKjLt6jarEI/hnU5EzgZ4pk5dodlvgr4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272553>

Hi Paul,

On 2015-06-18 13:25, Paul Tan wrote:

> diff --git a/builtin/am.c b/builtin/am.c
> index e9a3687..7b97ea8 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -121,6 +121,96 @@ static void am_destroy(const struct am_state *state)
>  	strbuf_release(&sb);
>  }
>  
> +/*
> + * Returns 1 if the file looks like a piece of email a-la RFC2822, 0 otherwise.
> + * We check this by grabbing all the non-indented lines and seeing if they look
> + * like they begin with valid header field names.
> + */
> +static int is_email(const char *filename)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	FILE *fp = xfopen(filename, "r");
> +	int ret = 1;
> +
> +	while (!strbuf_getline(&sb, fp, '\n')) {
> +		const char *x;
> +
> +		strbuf_rtrim(&sb);
> +
> +		if (!sb.len)
> +			break; /* End of header */
> +
> +		/* Ignore indented folded lines */
> +		if (*sb.buf == '\t' || *sb.buf == ' ')
> +			continue;
> +
> +		/* It's a header if it matches the regexp "^[!-9;-~]+:" */

Why not just compile a regex and use it here? We use regexes elsewhere anyway...

> +/**
> + * Attempts to detect the patch_format of the patches contained in `paths`,
> + * returning the PATCH_FORMAT_* enum value. Returns PATCH_FORMAT_UNKNOWN if
> + * detection fails.
> + */
> +static int detect_patch_format(struct string_list *paths)
> +{
> +	enum patch_format ret = PATCH_FORMAT_UNKNOWN;
> +	struct strbuf l1 = STRBUF_INIT;
> +	struct strbuf l2 = STRBUF_INIT;
> +	struct strbuf l3 = STRBUF_INIT;
> +	FILE *fp;
> +
> +	/*
> +	 * We default to mbox format if input is from stdin and for directories
> +	 */
> +	if (!paths->nr || !strcmp(paths->items->string, "-") ||
> +	    is_directory(paths->items->string)) {
> +		ret = PATCH_FORMAT_MBOX;
> +		goto done;
> +	}
> +
> +	/*
> +	 * Otherwise, check the first 3 lines of the first patch, starting
> +	 * from the first non-blank line, to try to detect its format.
> +	 */
> +	fp = xfopen(paths->items->string, "r");
> +	while (!strbuf_getline(&l1, fp, '\n')) {
> +		strbuf_trim(&l1);
> +		if (l1.len)
> +			break;
> +	}
> +	strbuf_getline(&l2, fp, '\n');

We should test the return value of `strbuf_getline()`; if EOF was reached already, `strbuf_getwholeline()` does not touch the strbuf. I know, the strbuf is still initialized empty here, but it is too easy to forget when changing this code.

> +	strbuf_trim(&l2);
> +	strbuf_getline(&l3, fp, '\n');
> +	strbuf_trim(&l3);
> +	fclose(fp);
> +
> +	if (starts_with(l1.buf, "From ") || starts_with(l1.buf, "From: "))
> +		ret = PATCH_FORMAT_MBOX;

Hmm. We can test that earlier and return without reading from the file any further, I think.

> +	else if (l1.len && l2.len && l3.len && is_email(paths->items->string))
> +		ret = PATCH_FORMAT_MBOX;

Maybe we can do better than this by folding the `is_email() function into this here function, reusing the same strbuf to read the lines and keeping track of the email header lines we saw... I would really like to avoid opening the same file twice just to figure out whether it is in email format.

The rest looks very nice!
Dscho
