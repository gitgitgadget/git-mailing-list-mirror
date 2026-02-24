Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B4C24C692
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923730; cv=none; b=ao1gLTRAFIXQI8ERjNR/m1cJO5Cd/B1l/Ci/lry60BD5uZdkDt38lKwys7Gxr9hiwAk1152qG3Loh6wvbiP/yddbG+RBEj8my0bzBFsFY1lTwCTexplhNITAYqnHlG7IOWiy/gV9UKPfXjEO3OidvNODIssFu7nNF8f6bcWTP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923730; c=relaxed/simple;
	bh=U+UflC1nijLP1KD7+AW38Y/JLU0f5BKygTHribZ8Tzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ma+Hd7wnuTpy8z9wwJ4BdaabaW51PxBGWd5/iKzmvXuEdsR9DmAc9Y1zcWna9TLMHsQaxrKeZWLvxvFaA08bIf7j/HhMy4+u5DD4wt9T6gkUkSi79rSWnrWeR9Z5ZEtxtNAAv8rVzOjDOrp8qZKnFJuxqrE9GEwP2PuTX3PDxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=A5gZPRwn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="A5gZPRwn"
Received: (qmail 59483 invoked by uid 109); 24 Feb 2026 09:02:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=U+UflC1nijLP1KD7+AW38Y/JLU0f5BKygTHribZ8Tzs=; b=A5gZPRwnz432/xbq0RnKKs1hb8CjmHz+Nts0jlyEdjKzz+71wEOM1RZt/EuMIelFL5nWdA7lxpJzkPySD1OoWH2bogvT2CUmDVu+22a/N9FyxrZyyQVkrvOx23ilam5uZG/ESAI5i+kPPK5cd2ZYEtBboPHa26njBt/ZOSuo9tjwpN3vagXPc2Lv9yVA0EFDdij6syz9d92G+RtWorGA+POkKVeIdV/Xt6rixH5dxrJqrK4visCG/G92CP5o5u/UVM32FTmspQOB26560elSocWh+yoTVhj5SWfbLmfETQueW9JtDJXjjivOEZZ8WJIZkDCBl4B2Cid1IZOjHBh1wA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Feb 2026 09:02:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 143035 invoked by uid 111); 24 Feb 2026 09:02:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Feb 2026 04:02:12 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Feb 2026 04:02:07 -0500
From: Jeff King <peff@peff.net>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] format-patch: add ability to use alt cover format
Message-ID: <20260224090207.GB986367@coredump.intra.peff.net>
References: <20260220230633.132213-1-mroik@delayed.space>
 <20260224040400.751247-3-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224040400.751247-3-mroik@delayed.space>

On Tue, Feb 24, 2026 at 05:03:57AM +0100, Mirko Faina wrote:

> +static void generate_commit_list_cover(FILE *cover_file, const char *format, struct commit **list, int n)
> +{

OK, so we're expecting "format" here to be the full format string here
(so "%s" or whatever).

But here...

> +	get_commit_format(format, &rev);

...this isn't quite the function you want to parse it. This function is
more about parsing the --pretty option for git-log, etc. It allows named
formats like "oneline", "medium", and so on, as well as "format:%s" (and
just "%s", as we treat unknown names with a percent as if they had
tformat: prepended).

As a side effect, it sets up the global user_format variable. Which is
horrible and subtle, but a result of historical function interfaces.
I'll get to that at the bottom of this email.

Back to your patch, I guess here:

> +	if (commit_format_is_empty(CMIT_FMT_USERFORMAT))
> +		die(_("invalid format spec"));

you are trying to check if we got a USERFORMAT, versus something else. A
more direct way to check that would be:

  if (rev->commit_format != CMIT_FMT_USERFORMAT)

But if we do not use get_commit_format() in the first place, we don't
need to worry about that. And I guess you used it because of:

> +		pp_commit_easy(CMIT_FMT_USERFORMAT, list[i], &commit_line);

that line, which is using the full-on pretty-print system that git-log,
etc, use. It doesn't really work with CMIT_FMT_USERFORMAT because you
have to set up the global user_format first (for those same historical
reasons).

So I think the entry point you want is repo_format_commit_message(),
which does a one-off custom format into a strbuf without needing a
rev_info, or touching the global user_format, etc.

Something like this:

diff --git a/builtin/log.c b/builtin/log.c
index 5e9e337be4..370367a15a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1326,16 +1326,12 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
 static void generate_commit_list_cover(FILE *cover_file, const char *format, struct commit **list, int n)
 {
 	struct strbuf commit_line = STRBUF_INIT;
-	struct rev_info rev = REV_INFO_INIT;
-
-	strbuf_init(&commit_line, 0);
-	get_commit_format(format, &rev);
-	if (commit_format_is_empty(CMIT_FMT_USERFORMAT))
-		die(_("invalid format spec"));
+	struct pretty_print_context ctx = {0};
 
 	for (int i = n - 1; i >= 0; i--) {
 		strbuf_addf(&commit_line, "[%0*d/%d] ", decimal_width(n), n - i, n);
-		pp_commit_easy(CMIT_FMT_USERFORMAT, list[i], &commit_line);
+		repo_format_commit_message(the_repository, list[i],
+					   format, &commit_line, &ctx);
 		fprintf(cover_file, "%s\n", commit_line.buf);
 		strbuf_reset(&commit_line);
 	}


I think that should make your series do what you want. Now...is the
pretty-print code a horrible minefield of booby traps waiting to spring
on the unwary developer? Yes, it is. ;)

The global user_format thing is there because it was bolted onto the
existing pretty-print code, which used a single enum to store the
format. But that enum isn't enough for a user-format, because we also
have an associated string. The "right" type is probably something like:

  struct commit_format {
	enum cmit_fmt fmt;
	const char *user_format;
  };

But C being what it is, switching all of the functions to that breaks
all of the callers which just want to pass CMIT_FMT_ONELINE or whatever.
So we have sort of a split world, where you can use pp_commit_easy()
with the baked-in formats, and using the custom format code uses a
totally different function.

I think in the long run we probably do need to clean up the global
user_format. Two pieces of code interleaving calls to the pretty-printer
would stomp on each other's formats, for example. We've mostly gotten by
because Git, being organized as a set of small programs, generally has
one "main" output (for git-log, etc) and then any smaller outputs within
a program are done by one-off calls to repo_format_commit_message(),
etc.

-Peff
