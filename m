Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37487126F14
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331621; cv=none; b=TTttUdOKr3i+w/W1oCoYucvJ65rh/uQB5gWT6rxd9U/gut1nsslzg05W6dShbxCZfoCejcsf/3bRnmzOgXRmNsfgeeZiLGyhcIr0TgAtttpOZXF2bRH5ggLVClXKDg3npyREkpFMcNa8VJA7gC9ALUQjOU1e1ojjaNsEvS3EuDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331621; c=relaxed/simple;
	bh=WOzyarsPaSX+IF2ugP0y9GBpFVXn8+fxaKmlws5Dh8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j+dDv60yRTHhbr5NYDWuK4kU0THpr9+91AYfXrtm9csI0aggP7k7MiOBFmh7jQAq3MrGlVYVglyERYtIWgukOaFE9jQMNqvM15Y28lruvfR243nBn3P47x8fdtp7/XJy1HLn2NYstIR5cA6QmhwIIERy+LO7vYzzOTwNKklwRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pqh/HFTh; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pqh/HFTh"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BFE6C1D8398;
	Wed,  7 Feb 2024 13:46:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=W
	OzyarsPaSX+IF2ugP0y9GBpFVXn8+fxaKmlws5Dh8M=; b=pqh/HFThMgSVWF7kc
	lRRVi601F7WeF2NiAcXzvtpaWDv7f14JNEh/NdGvH7Q1QBtUZygD2nKSFgrlGAEB
	7NcCo3M52ji3d90NyxRjpjkRr5ZPjQB6zefKjCuVJxYIWyaSGYXhuGytqTB5dl8g
	/t43rP/ddoMxOPLppyb83W6mSc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B59641D8397;
	Wed,  7 Feb 2024 13:46:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15E791D8396;
	Wed,  7 Feb 2024 13:46:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Sergey Kosukhin <skosukhin@gmail.com>
Subject: [PATCH] tag: fix sign_buffer() call to create a signed tag
Date: Wed, 07 Feb 2024 10:46:54 -0800
Message-ID: <xmqq4jek9ko1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 446C4768-C5E9-11EE-BBD7-25B3960A682E-77302942!pb-smtp2.pobox.com

The command "git tag -s" internally calls sign_buffer() to make a
cryptographic signature using the chosen backend like GPG and SSH.
The internal helper functions used by "git tag" implementation seem
to use a "negative return values are errors, zero or positive return
values are not" convention, and there are places (e.g., verify_tag()
that calls gpg_verify_tag()) that these internal helper functions
translate return values that signal errors to conform to this
convention, but do_sign() that calls sign_buffer() forgets to do so.

Fix it, so that a failed call to sign_buffer() that can return the
exit status from pipe_command() will not be overlooked.

Reported-by: Sergey Kosukhin <skosukhin@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * We alternatively could fix individual sign_buffer() backend that
   signals an error with a positive value (sign_buffer_ssh() in this
   case) to return a negative value, but this would hopefully be
   more future-proof.

 builtin/tag.c   | 2 +-
 gpg-interface.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 3918eacbb5..b28ead06ea 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -176,7 +176,7 @@ static int verify_tag(const char *name, const char *ref UNUSED,
 
 static int do_sign(struct strbuf *buffer)
 {
-	return sign_buffer(buffer, buffer, get_signing_key());
+	return sign_buffer(buffer, buffer, get_signing_key()) ? -1 : 0;
 }
 
 static const char tag_template[] =
diff --git a/gpg-interface.h b/gpg-interface.h
index 143cdc1c02..7cd98161f7 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -66,7 +66,7 @@ size_t parse_signed_buffer(const char *buf, size_t size);
  * Create a detached signature for the contents of "buffer" and append
  * it after "signature"; "buffer" and "signature" can be the same
  * strbuf instance, which would cause the detached signature appended
- * at the end.
+ * at the end.  Returns 0 on success, non-zero on failure.
  */
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 		const char *signing_key);
-- 
2.43.0-561-g235986be82

