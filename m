Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121C939B973
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449115; cv=none; b=X2LfU/S/TFwXBiXZlJNDylkEFGJFJX72pJtRqWRgKBFh9reZcHWBBZRAaKYcLx4JFIGiYKffihJwH2PfKvRWEYIVUD8pvNBrSpo6xzCsk+c0V0/ZyNYIzXazrfd4zphcRlRVr7VFxFoDpL7mhhmebTe0GD+IdzFOnhGBPQQhDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449115; c=relaxed/simple;
	bh=R9SsHyUtzzNQMDBM+aX6688B6WDeLTyFwoPuuLxKSl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTeEmSx+ma++u6jQGFppHKoPXdGzqUkI+aRfbq2ZRYcLPj4Rjpe2kI0zHWjNDzwUbc6/RVDqUtQwntsdi0eqInJ/wRluJONAtdATdHxFjpM3hI5vVF6HazHEpez9qSMdUMVqdht12Q8zDp1LsVUrN0rLO8/Sqrvp+xKTWUW5Vug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Mmc9sHri; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Mmc9sHri"
Received: (qmail 485796 invoked by uid 106); 29 Apr 2026 07:51:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=R9SsHyUtzzNQMDBM+aX6688B6WDeLTyFwoPuuLxKSl8=; b=Mmc9sHriMthHDDs/qZRXabSJY3D0ApCLdsLF5HxmNatOd4YJOaFlpXGvGGws8/7A/CbmspU3Ovs2ukSAdPr6sm6GAAZ6Da+vVKwJ+fYwVqjQG+v9HKfMIeo16i9NF0V0sYu7QjLsxrvgY/DJ3FVctRp8xj5JDXlfcNmMvE40rzIMTJfaGZ1i+Ey7MDxEPyYGsf2A5BNUAvUTbyi12CnyUI8XCpLTvO8Ih8b+f0GfJgQzIedv9S7UD4mNbRgztQ7ieji8nsBQvkBR4hjd0hkYwbqxYbw3UfGGbHfYXX0AQL45DPTjWWoMj7EXGm1AsyMgvSa5LKe+mVEq1Y2N6WDK/w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Apr 2026 07:51:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1099610 invoked by uid 111); 29 Apr 2026 07:51:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Apr 2026 03:51:51 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 Apr 2026 03:51:50 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 14/16] repack: implement incremental MIDX repacking
Message-ID: <20260429075150.GA1267476@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
 <93e152fb6aa3bbd450d46c6cdd219dfef14d41fc.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93e152fb6aa3bbd450d46c6cdd219dfef14d41fc.1776803827.git.me@ttaylorr.com>

On Tue, Apr 21, 2026 at 04:37:54PM -0400, Taylor Blau wrote:

>  static int repack_fill_midx_stdin_packs(struct child_process *cmd,
> -					struct string_list *include)
> +					struct string_list *include,
> +					struct string_list *out)
>  {
>  	struct string_list_item *item;
>  	FILE *in;
>  	int ret;
>  
>  	cmd->in = -1;
> +	if (out)
> +		cmd->out = -1;

We are already piping to the sub-command, and now we will read the
output. Looks like we do them sequentially:

> @@ -312,6 +319,17 @@ static int repack_fill_midx_stdin_packs(struct child_process *cmd,
>  		fprintf(in, "%s\n", item->string);
>  	fclose(in);
>  
> +	if (out) {
> +		struct strbuf buf = STRBUF_INIT;
> +		FILE *outf = xfdopen(cmd->out, "r");
> +
> +		while (strbuf_getline(&buf, outf) != EOF)
> +			string_list_append(out, buf.buf);
> +		strbuf_release(&buf);
> +
> +		fclose(outf);
> +	}

Is it possible to deadlock here where we block writing to the child, but
the child is blocked trying to write back to us. It's probably quite
unlikely as it implies both pipe buffers are filled up (and we are
counting packs and midx hashes here, neither of which we'd expect to be
too numerous).

Using pipe_command() would solve this, but it also might be impossible
to trigger if the child reads all input before generating any output. I
_think_ that's the case looking at cmd_multi_pack_index_write(). So
we're OK, but you might want to double check.

> +static int midx_compaction_step_exec_compact(struct midx_compaction_step *step,
> +					     struct repack_write_midx_opts *opts)
> +{
> [...]
> +	ret = start_command(&cmd);
> +	if (ret)
> +		goto out;

OK, if we get an error here we'll jump to "out", but run-command.c will
have cleaned up everything about "cmd" that we need.

But later...

> +	out = xfdopen(cmd.out, "r");
> +	while (strbuf_getline_lf(&buf, out) != EOF) {
> +		if (step->csum) {
> +			ret = error(_("unexpected MIDX output: '%s'"), buf.buf);
> +			goto out;
> +		}

...here we jump to "out" but the command is left running. I guess it
will eventually get SIGPIPE when we fclose(out), but of course we won't
wait() for it and we're probably leaking some memory, too.

> +	}
> +
> +	ret = finish_command(&cmd);
> +
> +out:
> +	if (out)
> +		fclose(out);
> +	strbuf_release(&buf);

It would be nice if we had an idempotent version of finish_command(),
that would do nothing when the program was already done. But I don't
think we do. We don't even clear cmd->pid when we finish the command, so
you can't even do something like:

  out:
  if (cmd->pid)
	finish_command(&cmd);

So probably that "goto out" in the loop needs to call fclose() and
finish_command() itself.

-Peff
