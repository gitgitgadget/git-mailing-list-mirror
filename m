Received: from mail.thalheim.io (mail.thalheim.io [95.217.199.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFDA200127
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.199.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323226; cv=none; b=pqm/1vjepVJOswNg0td+1qOxMZcCxk8Z812WK+cB4VMsGZwlhn95LWnjCSSBap2D70SzEPgoCpnwnlHu0q/T8JPEeON1LLGpl9pymkHkL4kiJ1sHguGmJCnMNXAkIuTW6BHder2AtFhSUkkB+Kc4t2kaPGAsDbHMAO0qTJr5acs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323226; c=relaxed/simple;
	bh=cHXq0CQBeYsmhRDvQ39cJnT7JLW3qRoVNMIXDqrTa5s=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=G877WvUZ8onFoYhw7NxYX5Qn5Ur35HjL242+0Tl6UcoOcktNz2PGOCjfy0cSvQV8QqUbDXKXVO2wlcH4D4SFgT6zqLN9LQJDl7O4T5YeFbxXjCKk0x9sJmuOWRpzSW/DS1giT5gWmd1PbMupCvy8QewQv4o1/s6jWJ04ac8KyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io; spf=pass smtp.mailfrom=thalheim.io; dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b=AwfWMiiP; arc=none smtp.client-ip=95.217.199.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalheim.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b="AwfWMiiP"
Received: from mail.thalheim.io (eve.i [IPv6:2a01:4f9:4a:42e8::1])
	by mail.thalheim.io (Postfix) with ESMTPSA id 74EC4153E151;
	Thu, 19 Jun 2025 08:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalheim.io; s=default;
	t=1750323215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y1hragbUSrv1WaSKBuG53vhF6Oc4nMXc9oZ9Cvjnghk=;
	b=AwfWMiiPccutWtmPr0OVbzD/iuyR4z27J6KX9te0xEEjjerIGd5bmhQmlhFgy321WngDsu
	22vQ1ppg+ogpummS+a8Gt1C1kEdzRVRIVHuUe/U443N+ReBHCBdCsm3OKBF9c67pFjp8ZQ
	d4oFkpXRW/8/e9IqGsji8UDUgYNiJlI=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joerg@higgsboson.tk smtp.mailfrom=joerg@thalheim.io
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Jun 2025 08:53:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "=?utf-8?B?SsO2cmcgVGhhbGhlaW0=?=" <joerg@thalheim.io>
Message-ID: <8af387d5007b15cce49c924104d0e88522812e42@thalheim.io>
TLS-Required: No
Subject: [PATCH] imap-send: improve error messages for missing configuration
To: git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>

The error message 'no imap store specified' was confusing because
it referred to 'store' when the actual missing configuration was
'imap.folder'. Similarly, the host error message provided no
guidance on how to fix the issue.

Improve both error messages to:
- Clearly state what configuration is missing
- Provide hints showing the exact git config commands needed
- Include examples of typical values

This helps users quickly understand and resolve configuration issues
when using git imap-send.

Signed-off-by: J=C3=B6rg Thalheim <joerg@thalheim.io>
---
 imap-send.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 2e812f5a6e..a2d6f6d3f6 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1539,13 +1539,17 @@ int cmd_main(int argc, const char **argv)
 		server.port =3D server.use_ssl ? 993 : 143;
=20
=20	if (!server.folder) {
-		fprintf(stderr, "no imap store specified\n");
+		fprintf(stderr, "error: no imap folder specified\n");
+		fprintf(stderr, "hint: set the target folder with 'git config imap.fol=
der <folder>'\n");
+		fprintf(stderr, "      (e.g., 'git config imap.folder Drafts')\n");
 		ret =3D 1;
 		goto out;
 	}
 	if (!server.host) {
 		if (!server.tunnel) {
-			fprintf(stderr, "no imap host specified\n");
+			fprintf(stderr, "error: no imap host specified\n");
+			fprintf(stderr, "hint: set the imap host with 'git config imap.host <=
host>'\n");
+			fprintf(stderr, "      (e.g., 'git config imap.host imaps://imap.exam=
ple.com')\n");
 			ret =3D 1;
 			goto out;
 		}
--=20
2.49.0
