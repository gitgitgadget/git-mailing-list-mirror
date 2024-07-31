Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD245005
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411757; cv=none; b=L07a+EJ+xreUMG1HFAh6BD/Mbbk0lQN+tb+UPQ0gSyxvtFkgdUG7H2Hp0hVPbKtoxoPnLA0p6ARNDI6kzeqx4cTkgNC0j9VpxmrU8ClrCE8sueKEx/4iAbZ5dHnYISjm5mLQY7IOT5KoW9TOVcB8iECScLYutQO6UDW1rgO5S9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411757; c=relaxed/simple;
	bh=A3d7EP5GnKw5S2tZSsmtKCJEZRgowiqka38J/S2gjzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxvgHfjWGQV/+Xy1y8VZQNYXrw8wEcMVax0xDWw/sx++hd/4P73xtEaquOhG4DUTUYCFRKYNC9xVjKGRJtG2H7pgjXbnZJEMHJPtCkeB5Xt/Kbe2oXWcQCBC+9C7iwnddOQIJFPmt6Q1MfHSO9nj3p8wJEVWMOzJ53tQZy1HDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4878 invoked by uid 109); 31 Jul 2024 07:42:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Jul 2024 07:42:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18359 invoked by uid 111); 31 Jul 2024 07:42:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2024 03:42:33 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 31 Jul 2024 03:42:28 -0400
From: Jeff King <peff@peff.net>
To: Hong Jiang <ilford@gmail.com>
Cc: Bo Anderson <mail@boanderson.me>, git@vger.kernel.org
Subject: Re: [patch] credential-osxkeychain: Clear username_buffer before
 getting the converted C string.
Message-ID: <20240731074228.GC595974@coredump.intra.peff.net>
References: <CAEcKSiyo3dyNpGkE_FWE-Y710RV0H3EytM2psC=+by=4wP5qpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEcKSiyo3dyNpGkE_FWE-Y710RV0H3EytM2psC=+by=4wP5qpg@mail.gmail.com>

On Wed, Jul 31, 2024 at 11:41:23AM +0800, Hong Jiang wrote:

> So it looks like that git_credential_out has invalid UTF-8 byte
> sequence. I print it after the system_command "git":
> 
> password=gho_SHADOWED
> username=jdp1024��`
> F�
> capability[]=state
> state[]=osxkeychain:seen=1
> 
> and
> 
> echo "protocol=https\nhost=github.com\n" | git credential-osxkeychain get
> 
> reproduced the problem.

Hmm. That does look like it could be uninitialized memory (assuming you
don't have those garbage characters in the keychain storage).

> So I made the patch, which zeros the username_buf before retrieving
> the converted C string.

If that helps, then that implies that the string we are getting is not
NUL-terminated. But...

> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index 6ce22a28ed..89cd575bd5 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -137,6 +137,7 @@ static void find_username_in_item(CFDictionaryRef item)
>   buffer_len = CFStringGetMaximumSizeForEncoding(
>   CFStringGetLength(account_ref), ENCODING) + 1;
>   username_buf = xmalloc(buffer_len);
> + memset(username_buf, 0, buffer_len);
>   if (CFStringGetCString(account_ref,
>   username_buf,
>   buffer_len,

...we are getting it by calling CFStringGetCString(). I don't know
anything about the OS API here, and I don't have a system to test on.
But according to the documentation at:

  https://developer.apple.com/documentation/corefoundation/1542721-cfstringgetcstring

it should return a NUL-terminated string.

Hrm. Just looking at the code, here's a wild hypothesis: the problem
could be not that the buffer is not NUL-terminated, but that after the
NUL it contains junk, and we print that junk. That is, the code looks
like this:

          /* If we can't get a CString pointer then
           * we need to allocate our own buffer */
          buffer_len = CFStringGetMaximumSizeForEncoding(
                          CFStringGetLength(account_ref), ENCODING) + 1;
          username_buf = xmalloc(buffer_len);
          if (CFStringGetCString(account_ref,
                                  username_buf,
                                  buffer_len,
                                  ENCODING)) {
                  write_item("username", username_buf, buffer_len - 1);
          }

So we asked the system for the _maximum_ size that the string could be
(and added one for the NUL). Then we got the string, and we printed out
the _whole_ buffer, not just the string up to the NUL. And your fix
"works" because NULs end up getting ignored on the read side (or at
least cause ruby not to complain about bogus utf8).

If that hypothesis is true, then the fix is more like:

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 6ce22a28ed..1c8310d7fe 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -141,7 +141,7 @@ static void find_username_in_item(CFDictionaryRef item)
 				username_buf,
 				buffer_len,
 				ENCODING)) {
-		write_item("username", username_buf, buffer_len - 1);
+		write_item("username", username_buf, strlen(username_buf));
 	}
 	free(username_buf);
 }

But somebody with a functioning macOS system would need to check whether
any of what I just said is true. This code comes from 9abe31f5f1
(osxkeychain: replace deprecated SecKeychain API, 2024-02-17). Adding
the author to the CC.

-Peff
