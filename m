From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/WIP v3 07/31] am: extract patch, message and authorship
 with git-mailinfo
Date: Wed, 24 Jun 2015 18:36:16 +0200
Organization: gmx
Message-ID: <72c470f3a6890dfcb66f1439383d2278@www.dscho.org>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
 <1434626743-8552-8-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 18:36:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7nez-00054x-Dx
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 18:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbbFXQgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 12:36:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:57575 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbbFXQgT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 12:36:19 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LiDrv-1YlPPu0C6F-00nRk3; Wed, 24 Jun 2015 18:36:17
 +0200
In-Reply-To: <1434626743-8552-8-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:UH+wdlInMBD+JX/rdZmo9sLURqOxBQriA+xYel6KJh6EJuu9Uki
 wm8+8iJgW+/jmXUINDIiYyy4bJh/Ono3rIFI8RLkJBKXv8Jwc4+E9J/3FkvsFvveCtuBFpA
 g5dA50qwOqPyehHkrshdomp8kgE6MGOLa0Nkj3h7a84TUKJh4pRpuiErv23lY2jbILj5m/D
 sig9FfgdN228SKmeA2QGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PpjeVkw0jWM=:pzLf8KOq6ls3DOqux6CzYC
 laYatRiL7dxsGznGERVyEPE1evlp51Z9GwCyQ5n0rltiavAjsEmrG+4fMayXf2g8bzHTnKBY2
 nhoXKpPdfyGFHF+MOeK0mmNOJOB4318EswhqUbU5+4c4lKaRtHPHbZw4Fme77ibi0nXZgrqbY
 3GUZvzU+It2H+raJedD6Sv0yAkVId6pJkGzY2Yvj09Yxj1V7Mvp9WsyzgheGzqIj5YTj4CeGp
 BfBl0/AdRiU7b9/Di5pOkchkBQrl7kJbPJrjkWBX9Fg2sPkzXGCWgmx7ahRjZGqpQFhgI0MDU
 V7QL4rhZy0ETQ6WSMXXyn9Xk7uoT1pAg+800IkPeIQhK3LnWgTNDpm+EFwmcLC7kfkwlCo3Mj
 dnyE58xbkBE2VCG/YMJNGds2gjSqEEvUVv+r4+o2iVWnNkn+alnL4N2vQxTLsNPxBuVl2Gwvg
 FLy99Zl1hbFKycb4zQHk+LkWmWQJYgnckjkv9KyOLvq2mguJXiX2kSvXcyBpbaXJdaW0dYupi
 Cl4wlwr5xOYt3Bnk9cTUjm4MY5c8L07SaZrWK4UWBJUDQvojT/5bGTgUVQp7dBaGmIl2MUMIr
 jWweVL2E/Q9sCT/vmjytM6i1nd0GD/S2cjC5dkvfCNOmJRHVnMX5qE4vxOTH+Ry8HreHS0WXK
 jiOV857yo3fGMvgudhYl04Y71Xpo4UGQjZ16dcmZRZxy1zLPWGk8hHBRCQlcSBU3fQj0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272564>

Hi Paul,

On 2015-06-18 13:25, Paul Tan wrote:

> diff --git a/builtin/am.c b/builtin/am.c
> index 7b97ea8..d6434e4 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -94,6 +126,105 @@ static int read_state_file(struct strbuf *sb,
> const char *file, size_t hint, int
>  }
>  
>  /**
> + * Reads a KEY=VALUE shell variable assignment from fp, and returns the VALUE
> + * in `value`. VALUE must be a quoted string, and the KEY must match `key`.
> + * Returns 0 on success, -1 on failure.
> + *
> + * This is used by read_author_script() to read the GIT_AUTHOR_* variables from
> + * the author-script.
> + */
> +static int read_shell_var(struct strbuf *value, FILE *fp, const char *key)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	char *str;
> +
> +	if (strbuf_getline(&sb, fp, '\n'))
> +		return -1;
> +
> +	if (!skip_prefix(sb.buf, key, (const char **)&str))
> +		return -1;
> +
> +	if (!skip_prefix(str, "=", (const char **)&str))
> +		return -1;
> +
> +	str = sq_dequote(str);
> +	if (!str)
> +		return -1;
> +
> +	strbuf_reset(value);
> +	strbuf_addstr(value, str);
> +
> +	strbuf_release(&sb);
> +
> +	return 0;
> +}

How about using `strbuf_remove()` and keeping `str` as `const char *`? I also think we can fold it into the `read_author_script()` function and make it more resilient with regards to the order of the variables. Something like this:

static int read_author_script(struct am_state *state)
{
	struct strbuf sb = STRBUF_INIT;
	const char *filename = am_path(state, "author-script");
	FILE *fp = fopen(filename, "r");
	if (!fp) {
		if (errno == ENOENT)
			return 0;
		die_errno(_("could not open '%s' for reading"), filename);
	}

	while (!strbuf_getline(&sb, fp, '\n')) {
		char *equal = strchr(sb.buf, '='), **var;

		if (!equal) {
error:
			fclose(fp);
			return -1;
		}
		*equal = '\0';
		if (!strcmp(sb.buf, "GIT_AUTHOR_NAME"))
			var = &state->author_name;
		else if (!strcmp(sb.buf, "GIT_AUTHOR_EMAIL"))
			var = &state->author_email;
		else if (!strcmp(sb.buf, "GIT_AUTHOR_DATE"))
			var = &state->author_date;
		else
			goto error;
		*var = xstrdup(sq_dequote(equal + 1));
	}

	fclose(fp);
	return -1;
}

If you follow my earlier suggestion to keep a strbuf inside the am_state, you could reuse that here, too.

> +/**
> + * Saves state->author_name, state->author_email and state->author_date in
> + * `filename` as an "author script", which is the format used by git-am.sh.
> + */
> +static void write_author_script(const struct am_state *state)
> +{
> +	static const char fmt[] = "GIT_AUTHOR_NAME=%s\n"
> +		"GIT_AUTHOR_EMAIL=%s\n"
> +		"GIT_AUTHOR_DATE=%s\n";
> +	struct strbuf author_name = STRBUF_INIT;
> +	struct strbuf author_email = STRBUF_INIT;
> +	struct strbuf author_date = STRBUF_INIT;
> +
> +	sq_quote_buf(&author_name, state->author_name.buf);
> +	sq_quote_buf(&author_email, state->author_email.buf);
> +	sq_quote_buf(&author_date, state->author_date.buf);

The `sq_quote_buf()` function does not call `strbuf_reset()`. Therefore you could just use a single strbuf to construct the entire three lines and then write that out. Again, if you follow my suggestion to keep a "scratch pad" strbuf in am_state, you could reuse that.

That scratch pad could come in handy in a couple of other places in the rest of this patch.

Ciao,
Dscho
