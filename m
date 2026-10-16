Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E442C17A3
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 03:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120490; cv=none; b=I5TaawkA0qw18bTSCzksa+NIgRPg+svZ0XaKRHLRMCG9m5VSUwTqVoFDCW/lD1K0vR+TSduH1f75ThqaFUAyhTNpgDkV/dc9+xLyXF0Vk1D9KFMzU9MVGr5K238JyqDSAGkwtsaR3n8k06SE8HZyirPsQKVrLn1gl5N7KrV3sJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120490; c=relaxed/simple;
	bh=TC/8ZT+Vq2UWeyWs7/PKF+SFXLRhHZLTXpoT09hBles=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC3e0LIRZOtx+gwWGBHIrSEX7PBarXvdL3aJq+Yvk6sysFtVEr7mA7CZnUTJWHTWk7KEQhxjuEaCpHVf14IlUeMYB7jwmTW6xU86fxV5hgkhxDKXGOFa/XG0VFrG5YlDwe/Fm/Y2mQMKmyWExOSbD+4QEm2rCkP/wKOg3IC8Sco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IUCzCV9s; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IUCzCV9s"
Received: (qmail 78182 invoked by uid 106); 16 Oct 2026 03:14:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TC/8ZT+Vq2UWeyWs7/PKF+SFXLRhHZLTXpoT09hBles=; b=IUCzCV9s8nhxv3Zjx37jrC+Lm+EMBpFAuXZABgntV+efgzWHmsqIk7b3DpnKycgBeOj/Fl8jUL4+N5Xl08GDV+IJ/kj8a7oMpDdbwwiUe2ZUdyZg4C+x159xSLQZ7XlP+5pCAZnfAUD033pNkUY//C6rYaJYF+FiyX0yiUYkJrfRpQDJUKWfABR0uQfuUDhEWEmCyb+hfvXMsS/UXRF0etl7DAgfZGhN5V4vvt1ShlXjKFrypHXJyHAk2q4tBrXac9zzYCDYFr9EGf8q0/6zZV6KfK1kmf4PPBORYojcR5yW8/S3RI/cwF3x/sQpZjDHGQGUJyom+Grxyy1sPn7N/w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Oct 2026 03:14:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 58996 invoked by uid 111); 16 Oct 2026 03:14:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2026 23:14:43 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Oct 2026 23:14:39 -0400
From: Jeff King <peff@peff.net>
To: Igor Wiedler <iwiedler@gitlab.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, jltobler@gmail.com
Subject: Re: [PATCH v2 2/2] odb: ignore refs of shallow and grafted alternates
Message-ID: <20261016031439.GA3437448@coredump.intra.peff.net>
References: <20261014103507.35317-1-iwiedler@gitlab.com>
 <20261014181134.56220-3-iwiedler@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014181134.56220-3-iwiedler@gitlab.com>

On Wed, Oct 14, 2026 at 08:11:34PM +0200, Igor Wiedler wrote:

> +test_expect_success 'refs of a shallow alternate are ignored' '
> +	git clone --depth=1 "file://$TRASH_DIRECTORY" "$TRASH_DIRECTORY/shallow" &&
> +	test_commit -C "$TRASH_DIRECTORY/shallow" shallow-only &&
> +	git -C "$TRASH_DIRECTORY/shallow" rev-parse HEAD >shallow-tip &&
> +	cp .git/objects/info/alternates alternates.bak &&
> +	test_when_finished "mv alternates.bak .git/objects/info/alternates" &&
> +	echo "$TRASH_DIRECTORY/shallow/.git/objects" >>.git/objects/info/alternates &&
> +	git cat-file -e $(cat shallow-tip) &&
> +	git rev-list --remotes=origin >expect &&
> +	git rev-list --alternate-refs >actual &&
> +	test_cmp expect actual
> +'

This seemed to fail the windows ci job with cat-file reporting:

  error: unable to normalize alternate object path: /d/a/git/git/t/trash directory.t5618-alternate-refs/shallow/.git/objects

Just a guess, but it might be the Windows vs POSIX path thing? So
perhaps something like this would work, but I didn't test it:

diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
index 9c3862709a..e5dce85cff 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -76,7 +76,7 @@ test_expect_success 'refs of a shallow alternate are ignored' '
 	git -C "$TRASH_DIRECTORY/shallow" rev-parse HEAD >shallow-tip &&
 	cp .git/objects/info/alternates alternates.bak &&
 	test_when_finished "mv alternates.bak .git/objects/info/alternates" &&
-	echo "$TRASH_DIRECTORY/shallow/.git/objects" >>.git/objects/info/alternates &&
+	echo "$(pwd)/shallow/.git/objects" >>.git/objects/info/alternates &&
 	git cat-file -e $(cat shallow-tip) &&
 	git rev-list --remotes=origin >expect &&
 	git rev-list --alternate-refs >actual &&

Alternatively, we could actually clone "shallow" with --reference or
--shared, which would let Git write the alternates file itself (but
would mean running rev-list, etc, in a subrepo).

We also mention $TRASH_DIRECTORY in some other spots. I think they are
not a problem, but usually we assume that tests start in the trash
directory and don't change directory (at least not outside of a
subshell). So as a matter of style, we can probably make all of those
relative paths.

Also, a very minor style nit, but we tend to use environment variables
instead of files for holding values. So all together, perhaps (again,
only lightly tested):

diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
index 9c3862709a..5ac981c5a0 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -71,13 +71,13 @@ test_expect_success 'connectivity check of a deepening fetch excludes alternate
 '
 
 test_expect_success 'refs of a shallow alternate are ignored' '
-	git clone --depth=1 "file://$TRASH_DIRECTORY" "$TRASH_DIRECTORY/shallow" &&
-	test_commit -C "$TRASH_DIRECTORY/shallow" shallow-only &&
-	git -C "$TRASH_DIRECTORY/shallow" rev-parse HEAD >shallow-tip &&
+	git clone --depth=1 --no-local . shallow &&
+	test_commit -C shallow shallow-only &&
+	shallow_tip=$(git -C shallow rev-parse HEAD) &&
 	cp .git/objects/info/alternates alternates.bak &&
 	test_when_finished "mv alternates.bak .git/objects/info/alternates" &&
-	echo "$TRASH_DIRECTORY/shallow/.git/objects" >>.git/objects/info/alternates &&
-	git cat-file -e $(cat shallow-tip) &&
+	echo "$(pwd)/shallow/.git/objects" >>.git/objects/info/alternates &&
+	git cat-file -e $shallow_tip &&
 	git rev-list --remotes=origin >expect &&
 	git rev-list --alternate-refs >actual &&
 	test_cmp expect actual

-Peff
