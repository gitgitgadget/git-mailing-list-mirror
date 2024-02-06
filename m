Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685FF1B94E
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254743; cv=none; b=Lb0dzvFWnfJPtt9ekro2MgCJv2DEXqj8pe0zSxUt3Ok7S2uP5818EoPZ+y7gnt8dxTFVXuwF9rREVzikUVBWWLiLonEYpgKInuHDMjZ59YtLgecrnotDI8Zd43A+0EMkufdIctthnAVQMsVbxnaeOyUMZ/ikdsootR4bfrcAFaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254743; c=relaxed/simple;
	bh=5+rnhnJuh3Bi1dLh7Mse9WK0tZNeh62FJs8t8oTtw60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bVAvxl22ISM9B9noXFGayPEDegSjhVyLpEjY7EMNiZ/XkjjB9cgL07wzp2VsW0yTaPny3A8afVvUpapF0UYaXCqhr6uxUOYBwOGAdAGV8/oUq5isorShXEg2/H8c0Kl+gDfKRgpdQJXZUUrIDGp9FKgmVu/cE55qxWCat9U6lW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NV3H+Oyu; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NV3H+Oyu"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AF87E2294A;
	Tue,  6 Feb 2024 16:25:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5+rnhnJuh3Bi1dLh7Mse9WK0tZNeh62FJs8t8o
	Ttw60=; b=NV3H+OyueJ0KSTdiu8aOOF7ivAM5+fUmWqJYZpPK7pm85ndja5PUvw
	AO5SsOeydOhgwpEcyv+F/17UAqASC3wHUqcxMCgPKWn+mC5GMJejrUuIte4r3Vjw
	nrSAC8fWGRy9Esm4FTNMExZ1kPTvdXkfjdFlamolm+pveuYlIIJ7o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A8A3F22949;
	Tue,  6 Feb 2024 16:25:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12BEB22948;
	Tue,  6 Feb 2024 16:25:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sergey Kosukhin <skosukhin@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Wrong exit code on failed SSH signing
In-Reply-To: <CAGMF1KiFNnr1nFBg2+mRqiurXpxOOXAcoWc0GciRKDoWzpJSkA@mail.gmail.com>
	(Sergey Kosukhin's message of "Tue, 6 Feb 2024 17:24:01 +0100")
References: <CAGMF1KiFNnr1nFBg2+mRqiurXpxOOXAcoWc0GciRKDoWzpJSkA@mail.gmail.com>
Date: Tue, 06 Feb 2024 13:25:36 -0800
Message-ID: <xmqqy1bxffov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 458E0E14-C536-11EE-A4D2-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Sergey Kosukhin <skosukhin@gmail.com> writes:

> There seems to be a bug in the sign_buffer_ssh function in
> gpg-interface.c: a possible exit code of ssh-keygen is 255, which is
> returned as-is by sign_buffer_ssh. The problem is that, for example,
> the function build_tag_object in builtin/tag.c considers only negative
> values as a failure. Since 255 >= 0, the error message "unable to sign
> the tag" is not emitted and git exits normally with zero exit code. It
> might be enough to return -1 in sign_buffer_ssh if ret is not zero.

Thanks for noticing and an excellent initial diagnosis.

There are three callers of sign_buffer():

 - send-pack.c:generate_push_cert() lets the user sign the push
   certificate, and non-zero return from sign_buffer() is a sign
   that we failed to sign.

 - commit.c:sign_with_header() lets the user sign a commit object,
   and non-zero return from sign_buffer() is taken as an error.

 - builtin/tag.c:do_sign() calls sign_buffer() and propagates the
   return value to its caller, which assumes that positive return
   values are not errors.

It seems to me that what needs fixing is the last caller.  Perhaps
inside "git tag" implementation, there is a local convention that
errors are signaled with negative values, and that is fine, but then
builtin/tag.c:do_sign() should be doing the same translation as
builtin/tag.c:verify_tag() does, I would say.

The latter calls gpg_verify_tag() and upon non-zero return,
translates that to a return of -1 to its caller, like so:

        static int verify_tag(const char *name, const char *ref UNUSED,
                              const struct object_id *oid, void *cb_data)
        {
                int flags;
                struct ref_format *format = cb_data;
                flags = GPG_VERIFY_VERBOSE;

                if (format->format)
                        flags = GPG_VERIFY_OMIT_STATUS;

                if (gpg_verify_tag(oid, name, flags))
                        return -1;

                ...

So perhaps something like this with a proper log message would be a
better fix?

 builtin/tag.c   | 2 +-
 gpg-interface.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git c/builtin/tag.c w/builtin/tag.c
index f036cf32f5..37473ac21f 100644
--- c/builtin/tag.c
+++ w/builtin/tag.c
@@ -153,7 +153,7 @@ static int verify_tag(const char *name, const char *ref UNUSED,
 
 static int do_sign(struct strbuf *buffer)
 {
-	return sign_buffer(buffer, buffer, get_signing_key());
+	return sign_buffer(buffer, buffer, get_signing_key()) ? -1 : 0;
 }
 
 static const char tag_template[] =
diff --git c/gpg-interface.h w/gpg-interface.h
index 143cdc1c02..7cd98161f7 100644
--- c/gpg-interface.h
+++ w/gpg-interface.h
@@ -66,7 +66,7 @@ size_t parse_signed_buffer(const char *buf, size_t size);
  * Create a detached signature for the contents of "buffer" and append
  * it after "signature"; "buffer" and "signature" can be the same
  * strbuf instance, which would cause the detached signature appended
- * at the end.
+ * at the end.  Returns 0 on success, non-zero on failure.
  */
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 		const char *signing_key);
