Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AE51AF0DF
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072114; cv=none; b=Frquk0WKwyBdvOd35Pv2AMvnrNAXnMP4Al3pVPMXtmq42s1zhQE9cD0oSXT0CIQ/UZ945p0HYKl0IrgR6Up4GdNcCCkrnK6bd0/MgNFRrV9nLH9rTGiv18HR0rDudjR7hZaVuNG6RnUa2X4hm5yA+ulLj2DXMZQVA1K03+GGCow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072114; c=relaxed/simple;
	bh=Jz4Acg1H+L3VqDFehtVDR6TEjbdDV8bh1inU1Wg3Cyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlI7AIt2t7Jb3Lj+aYnrVj75CDHShenk59SAbbPA0M0BOX04iRSuSnpPHdu2cBiV0iEo0zPAiPyQiA7i5blhHzeUcdlH8RJf2d5pvvwgzb9QldBiG0EYXxGncOioC1Ci9HyLDSS8MhJoOmwELyf1R9rXnyTsJgG2ylcrmOYPXA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=xDXzq9/Y; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="xDXzq9/Y"
Date: Wed, 16 Oct 2024 11:48:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729072105;
	bh=Jz4Acg1H+L3VqDFehtVDR6TEjbdDV8bh1inU1Wg3Cyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:From:Sender:Reply-To:Subject:Date:
	 Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=xDXzq9/YHDhG2PoRF1LFj83D881OL1WEihf5dUoENxtijCtT3f+EM5XxmxsufZPlM
	 SW6mQBRFhwqOjbJYAcSxQIMFEUcNSJmpaoBNvQUc9f/ycPvoQ7XgZfDjKRuiYQbfjt
	 pfdsiBuUHGc8e//ddcSCcCzJvCywh4++nkK6GEFRlwZGpuvECCk8CziXGsepzqPSsQ
	 J3kjR6+qTX/EOAm/qdAWPAD0Bz6FBtpOlIAyabTh0L71mmVwedFV3inlqfylTjTy8s
	 PjC648l8wH6nd5QnszBtrES5p5+ctjZfN0uO+w52SNJBaXbDdplDfpfDxZNw0VJbgm
	 sCM1KLv5KrPZw==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH v2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <w6vzuumbd5vrdluvnheescdgw36teuj6k5anlyiphvpr6slcgc@2gkwe2ye26a6>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241015114826.715158-1-wolf@oriole.systems>
 <Zw9P90_QtiAAH3yz@pks.im>
 <gtdjnvonjodr435wuv2pofnww2pdcd33s22xxz5ypwkpvdythc@vrajz5ttkjbz>
 <Zw9_46fbvbGhjmYw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw9_46fbvbGhjmYw@pks.im>

On 2024-10-16 10:57, Patrick Steinhardt wrote:
> Given that we do set `log.abbrev` I think we should be hitting code
> paths in git-shortlog(1) that use it. `git shortlog --format=%h` for
> example would use `log.abbrev`, wouldn't it? It would be nice to
> figure out whether this can be made to misbehave based on which object
> hash we have in the input.

I dove into the code again and now I'm fairly sure custom formatting is
only ever done when in a repository. shortlog_output() itself, called at
the end of cmd_shortlog(), doesn't do any formatting, only possibly
wrapping the lines already present in the shortlog struct.

That struct is filled either by read_from_stdin() or get_from_rev(). The
latter is only ever called when in a repository:

>	if (!nongit && !rev.pending.nr && isatty(0))
>		add_head_to_pending(&rev);
>	if (rev.pending.nr == 0) {
>		if (isatty(0))
>			fprintf(stderr, _("(reading log message from standard input)\n"));
>		read_from_stdin(&log);
>	}
>	else
>		get_from_rev(&rev, &log);

get_from_rev() handles formatting through shortlog_add_commit(),
directly formatting the commit into the oneline buffer that is later
added to the shortlog struct:

> 	if (!log->summary) {
> 		if (log->user_format)
> 			pretty_print_commit(&ctx, commit, &oneline);
> 		else
> 			repo_format_commit_message(the_repository, commit,
> 						   "%s", &oneline, &ctx);
> 	}
>	oneline_str = oneline.len ? oneline.buf : "<none>";
>
>	insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
>	insert_records_from_format(log, &dups, commit, &ctx, oneline_str);

read_from_stdin(), in comparison, skips all lines from stdin not
matching either "Author: " or "Commit: ", and then adds only the
author/committer name and the subject to its log:

>		const char *v;
>		if (!skip_prefix(ident.buf, match[0], &v) &&
>		    !skip_prefix(ident.buf, match[1], &v))
>			continue;
>		while (strbuf_getline_lf(&oneline, stdin) != EOF &&
>		       oneline.len)
>			; /* discard headers */
>		while (strbuf_getline_lf(&oneline, stdin) != EOF &&
>		       !oneline.len)
>			; /* discard blanks */
>
>		strbuf_reset(&mapped_ident);
>		if (parse_ident(log, &mapped_ident, v) < 0)
>			continue;
>
>		insert_one_record(log, mapped_ident.buf, oneline.buf);

So whilst we parse all the relevant options like --abbrev and --format,
we take a shortcut through read_from_stdin() and never get to apply a
custom format. Commit hashes from stdin are discarded.

I'm not sure a test case for different hash algorithms would test
anything meaningful here, unless the plan in the future is to have
git-shortlog(1) support formatting when reading from stdin.

-- 
Wolf
