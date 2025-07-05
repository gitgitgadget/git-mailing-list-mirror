Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA071BF58
	for <git@vger.kernel.org>; Sat,  5 Jul 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751743277; cv=none; b=Mno+vYyH7UQCaGoTTR13NIdCpTSgq4dFhZMYZdganyg8M/0RH+5oCPsw72rDEgHHVCYVA7Tzt7nzsaAZLH4sBCfMZJfJnOC69bei1uThiEbSzn01M+FxvnQzeWRwiFgpBw0geWaoYHhjEAUfoc/bAsyLzaEgg6eRd3vpbwxy+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751743277; c=relaxed/simple;
	bh=pOqe0M6B4082fQhjKTA/c53kigdKCoCXks31UrdFh+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6NIjgyc6GTBdWUS9AR10Gg6JOrhhb5+orYVE3kvTcMcF1Zhi7ZA5moWdR6zuvqDqIeMziCe1buW8r5deWhlaTO8JseCqjCedxX+DASIOqyfNNclKklP1/NW9beC8L3SReFLIGjH/4Yy4YpE3faFpDu0A6Spx5oRLRtHQfcFDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LW5qDlrC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LW5qDlrC"
Received: (qmail 24500 invoked by uid 109); 5 Jul 2025 19:21:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pOqe0M6B4082fQhjKTA/c53kigdKCoCXks31UrdFh+U=; b=LW5qDlrCUpQGxMsxB4/RXhoMYwbw3I3aCnc5uZ5imuJtEfcHh2mzG8srL6zuU5iMw1qm+gjgV4m6TlQg3JB+ygNHErEXaLusTElKYwse6rrnOlYX5KI9LoQM553R5hG55dEs6UoY3uXFYm5tXMZPYlUZCesvQK+IfUH33xKxgnAPcgz6/t5YbrNAY4O1LneRn2GglWasN3PRwFotnOlbi91ceOhS9rTB4zQDplHZ8T5C8Dn+DcY0wAvZwzGRFmJlqTpArvgCXYJIgrI1inDZ3eScFd33v7gVa9op/iH3uZ2X61KlshcNiB72h/N+0jY3McZEF9CRtkLBwdXPuUOI8A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 05 Jul 2025 19:21:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4919 invoked by uid 111); 5 Jul 2025 19:21:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Jul 2025 15:21:15 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 5 Jul 2025 15:21:13 -0400
From: Jeff King <peff@peff.net>
To: redoste <redoste@redoste.xyz>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Fabian Stelzer <fs@gigacodes.de>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] ssh signing: don't detach the filename strbuf from
 key_file tempfile
Message-ID: <20250705192113.GB2496172@coredump.intra.peff.net>
References: <20250704230829.29696-1-redoste@redoste.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250704230829.29696-1-redoste@redoste.xyz>

On Sat, Jul 05, 2025 at 01:08:28AM +0200, redoste wrote:

> Detaching the filename string from the tempfile structure used to cause
> delete_tempfile() to fail and the temporary file was not cleaned up.

Good catch. I can reproduce this easily with:

  git -c gpg.format=ssh \
      -c user.signingkey=key::does-not-exist \
      commit --allow-empty -S -m foo

which creates /tmp/.git_signing_key_tmp* and never cleans it up.

I wonder if it is worth adding a test, or if it would be too weirdly
focused on this obscure case to be very useful against future
regressions.

> Signed-off-by: redoste <redoste@redoste.xyz>

We look for a real name in the sign-off trailer, since it indicates an
acceptance of the DCO and the ability to legally contribute the patch to
the project. See the section of Documentation/SubmittingPatches starting
with the '[[dco]]'. Or here:

  https://git-scm.com/docs/SubmittingPatches#sign-off

Looking at your web page, it looks like you may prefer not to associate
your online identity with a legal name. I can't remember if we've dealt
with this before. I'm adding brian to the cc, who has given a lot of
thought to naming and privacy issues.

(In this particular case, I suspect the patch is trivial enough not to
even be copyright-able, so we may be able to just let it go in this
instance.)


The patch itself looks good:

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 0896458de5..bdcc8c2a2e 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -1048,7 +1048,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
>  				    key_file->filename.buf);
>  			goto out;
>  		}
> -		ssh_signing_key_file = strbuf_detach(&key_file->filename, NULL);
> +		ssh_signing_key_file = xstrdup(key_file->filename.buf);
>  	} else {
>  		/* We assume a file */
>  		ssh_signing_key_file = interpolate_path(signing_key, 1);

I think we could avoid even xstrdup() here and just use the key_file
pointer directly (it lasts until the end of the function, which is all
we need). But the call to interpolate_path() on the other side of
conditional does always allocate, so we'd need extra book-keeping to
decide whether to free or not. The extra copy is worth it to keep the
code simpler.


One other thing I noticed while looking at this function: the tempfile
deletion code should be OK with a NULL entry (that is considered an
"inactive" tempfile). So:

diff --git a/gpg-interface.c b/gpg-interface.c
index 0896458de5..fc48f93e11 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1102,10 +1102,8 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 	remove_cr_after(signature, bottom);
 
 out:
-	if (key_file)
-		delete_tempfile(&key_file);
-	if (buffer_file)
-		delete_tempfile(&buffer_file);
+	delete_tempfile(&key_file);
+	delete_tempfile(&buffer_file);
 	if (ssh_signature_filename.len)
 		unlink_or_warn(ssh_signature_filename.buf);
 	strbuf_release(&signer_stderr);

would simplify the code a little bit. But it may not be worth worrying
too much about (and is certainly orthogonal to your patch).

-Peff
