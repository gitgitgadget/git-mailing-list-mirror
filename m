From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/WIP v3 04/31] am: implement patch queue mechanism
Date: Wed, 24 Jun 2015 16:59:48 +0200
Organization: gmx
Message-ID: <6560adbc8b1842dd369628980f1264c3@www.dscho.org>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
 <1434626743-8552-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 17:01:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7mAk-0002s4-EQ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 17:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbbFXPBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 11:01:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:56651 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753848AbbFXO7v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 10:59:51 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M3zT0-1YpQDn0p86-00rVc4; Wed, 24 Jun 2015 16:59:49
 +0200
In-Reply-To: <1434626743-8552-5-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Op1KeSMxLVNioBq4ZmtfU78jq9KOWQFM1zS9+BzIFUGaOAxmFUB
 Px+MjLYchLdrhfwVNIIidZ9PblkRRyhv8Xmu14N+7d0XAax8U1z4ol229/xgodCVTS6Qn20
 pdL69XM4HEzaCCuMehot6knzlf2hA/jH+3VZYwPxhSUUTPEZK4d4SZ1Hoy2dB0P9F/DsTF/
 UmBFmW+YlGZl97DiUfUHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kX4obYQmABM=:J2zjtH2wfp6JndfTzZl9m7
 vwLLcusi5YEpji2JMnWn7CWIhiA5OUFpgK3sdIWQjFGhU1dh1D+2n8CHfC81qCvDfCMQSuKI8
 TWNpswpSUzpUgBkttDrn3xZ/wx3/dR5TXgez2Wui5vUUsUwP3SrGCgVdSQNyrFhki3L6BuN2D
 5UdTD3N34qsuSLj+8bOjyPrRhccPjMGFBkXT/ON2L6Z4G+jGbb8Iigekey64QtllVX9NkBeXM
 6xgNjMyBLVNpkAkzHhnv0Ow02QPRgp9QKq+myCt4tn/1zArcl0zj9wzYjTRANQwnNZuAhGqjJ
 bc6IxBqSqG2d+z8S8BFZ0bQY2OAAgKk743q3A602g/b7zzcDOODFvwFpctV/ZUIpu90VWlOy0
 FpVDWB3muKH6qJsfFk2pbZmKcaj33IUXmJs5Cvlkpb/Gat5Wpbeh/7ALMLOSgkeqeM0dj5x8M
 iCiV/buAC91BcUHebNVBJrQQ9QuKuj2fB5Is4OxiY+PNBr/nHzyf3jX5W1tgfVOCTejqH7uqX
 sR/PnliWco0d9gVcdtk13YJCM5KXeYTNLIEmTStrHIt54Ba5SOf1hpYf0F0GeQ/2xFdg6+FPl
 WCjAeqyUDBbbT00rUKt66jOw2Hr6b4MQLBCR1tXSwaR4ri7PFnlp/mMpU6wzynE5cbIuNQ7LZ
 yYPD1rQdnD6FEoPgIfsdMK4HNaQUGLcO2BZfvFL06BRJP5V/2hT9TumyNhRc200AP1rI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272552>

Hi Paul,

On 2015-06-18 13:25, Paul Tan wrote:

> diff --git a/builtin/am.c b/builtin/am.c
> index dbc8836..af68c51 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -6,6 +6,158 @@
>  #include "cache.h"
>  #include "builtin.h"
>  #include "exec_cmd.h"
> +#include "parse-options.h"
> +#include "dir.h"
> +
> +struct am_state {
> +	/* state directory path */
> +	struct strbuf dir;
> +
> +	/* current and last patch numbers, 1-indexed */
> +	int cur;
> +	int last;
> +};
> +
> +/**
> + * Initializes am_state with the default values.
> + */
> +static void am_state_init(struct am_state *state)
> +{
> +	memset(state, 0, sizeof(*state));
> +
> +	strbuf_init(&state->dir, 0);
> +}

With strbufs, we use the initializer STRBUF_INIT. How about using

#define AM_STATE_INIT { STRBUF_INIT, 0, 0 }

here?

> +/**
> + * Reads the contents of `file`. The third argument can be used to give a hint
> + * about the file size, to avoid reallocs. Returns number of bytes read on
> + * success, -1 if the file does not exist. If trim is set, trailing whitespace
> + * will be removed from the file contents.
> + */
> +static int read_state_file(struct strbuf *sb, const char *file,
> size_t hint, int trim)
> +{
> +	strbuf_reset(sb);
> +	if (strbuf_read_file(sb, file, hint) >= 0) {
> +		if (trim)
> +			strbuf_trim(sb);
> +
> +		return sb->len;
> +	}
> +
> +	if (errno == ENOENT)
> +		return -1;
> +
> +	die_errno(_("could not read '%s'"), file);
> +}

A couple of thoughts:

- why not reuse the strbuf by making it a part of the am_state()? That way, you can allocate, say, 1024 bytes (should be plenty enough for most of our operations) and just reuse them in all of the functions. We will not make any of this multi-threaded anyway, I don't think.

- Given that we only read short files all the time, why not skip the hint parameter? Especially if we reuse the strbuf, it should be good enough to allocate a reasonable buffer first and then just assume that we do not have to reallocate it all that often anyway.

- Since we only read files from the state directory, why not pass the basename as parameter? That way we can avoid calling `am_path()` explicitly over and over again (and yours truly cannot forget to call `am_path()` in future patches).

- If you agree with these suggestions, the signature would become something like

static void read_state_file(struct am_state *state, const char *basename, int trim);

> +/**
> + * Remove the am_state directory.
> + */
> +static void am_destroy(const struct am_state *state)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	strbuf_addstr(&sb, state->dir.buf);
> +	remove_dir_recursively(&sb, 0);
> +	strbuf_release(&sb);
> +}

Given that `remove_dir_recursively()` has to reset the strbuf with the directory's path to the original value before it returns (because it recurses into itself, therefore the value *has* to be reset when returning), we can just call

    remove_dir_recursively(&state->dir, 0);

and do not need another temporary strbuf.

> +/**
> + * Increments the patch pointer, and cleans am_state for the application of the
> + * next patch.
> + */
> +static void am_next(struct am_state *state)
> +{
> +	state->cur++;
> +	write_file(am_path(state, "next"), 1, "%d", state->cur);
> +}

Locking and re-checking the contents of "next" before writing the incremented value would probably be a little too paranoid...

(Just saying it out loud, the current code is fine by me.)

Ciao,
Dscho
