Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111571B4F3A
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622412; cv=none; b=DlcUP/MBzoEiNSw+ovKmKO6NItmow9htjjPF6vzR45lh9tdCclynpSrDskAUcl78nUrmzW2kigho7hSe1vVAtQlY1sTisHpMAzG5A1Ry1O6HzOpJz3Fkgu+zbFAU5AXudarShi39GrUWTiVq+JN0lSEs0WqDHuKVt/WZuJbFMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622412; c=relaxed/simple;
	bh=SfRrWbSEHtmtcgGWRoPpKSDrGwCMjEtx7ptcVi1AuDw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=CnpHF+KSirXL7aMPwdgQlENVvtCsQgYAndbxScvi2+ME1+/HWPeOCQwtK/kZfLHpP37YVU/4aXxXaCtgTNn+N8awBpM4dKPRfD92Mv65pUuhLtJY3V4ACUTPppwKqww8DUf1HiOW2VcjuS2Ay74yNTgsxeL5o1TzUJSdVlablHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org; spf=pass smtp.mailfrom=swagemakers.org; dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b=E+dR8yuX; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b="E+dR8yuX"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swagemakers.org;
	s=key1; t=1736622406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfPaaFWn2zDfcF80GAX+6K53B0vtiki3ujqRwLfvPh8=;
	b=E+dR8yuXA2ibI2XaQn0gyDin9bfxbck0vJM/uTb9A24JWRPF8lyb4aUHDhXyDbW9pwtVDW
	yJGOLKCToM5/wIpQ40WUjq5YP5hldeYiN02kouHKtCVUC1Tbg6JieADrNY3U7eRFBlrsJM
	KgVo29gchZdZj1HyLEJUUR3CWMfcO5U=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jan 2025 20:06:41 +0100
Message-Id: <D6ZH9HE0N3X8.350NMMZ6IY8QA@swagemakers.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Julian Swagemakers" <julian@swagemakers.org>
To: "M Hickford" <mirth.hickford@gmail.com>
Cc: <git@vger.kernel.org>, <wiagn233@outlook.com>,
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] send-email: implement SMTP bearer authentication
References: <20250107194953.2104-1-mirth.hickford@gmail.com>
In-Reply-To: <20250107194953.2104-1-mirth.hickford@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Mirth, thanks for taking a look and testing.

> Please could you add instructions how to test it?

Sure, below you can find steps which can be used for testing.

   # requirement git-credentials-oauth installed

   # build patched git
   git clone https://git.kernel.org/pub/scm/git/git.git tmp_git
   cd tmp_git
   curl https://lore.kernel.org/git/20240225103413.9845-1-julian@swagemaker=
s.org/raw |git am
   make

   # backup gitconfig
   mv ~/.gitconfig{,_backup}

   # create minimal gitconfig
   cat << EOF >> ~/.gitconfig

   [credential]
      helper =3D cache --timeout 7200
      helper =3D oauth
   [credential "smtp://smtp.gmail.com:587"]
      oauthClientId =3D 406964657835-aq8lmia8j95dhl1a2bvharmfk3t1hgqj.apps.=
googleusercontent.com
      oauthClientSecret =3D kSmqreRr0qwBWJgbf5Y-PjSU
      oauthScopes =3D https://mail.google.com/
      oauthAuthURL =3D https://accounts.google.com/o/oauth2/auth
      oauthTokenURL =3D https://oauth2.googleapis.com/token
   [user]
      email =3D you@example.com
      name =3D Your Name

   EOF

   # create email to send
   cat << EOF >> message.txt
   Subject: test email from git

   Hay from git

   EOF

   # update PATH to use patched git
   export PATH=3D"${PWD}:${PATH}"

   # confirm you are using the correct git version, should look
   # something like `git version 2.48.0.rc2.32.g5adec67521`
   git --version

   git send-email \
    --to=3Demail@example.com \
    --smtp-auth=3DXOAUTH2 \
    --smtp-encryption=3Dtls \
    --smtp-server-port=3D587 \
    --smtp-server=3Dsmtp.gmail.com \
    --smtp-debug=3D1 \
    --smtp-user=3Dyou@example.com \
    message.txt

    # now the browser should open with the oauth flow.

> Which servers have you tested?

I've tested this with gmail using a consumer google account as well as a
managed google account and with the office settings I've tested
office365.

> Looking at the debug information, it looks like the SMTP command "AUTH
> XOAUTH2 <base64>" was corrupted by a space at column 241. Exactly one
> base64 string should follow "AUTH XOAUTH2 ", no spaces.

I can also see a space in the debug output, but the position depends on
my terminal size, and it is not interfering with authentication in my
case. I think it is caused by output formatting of the debug statement
and not the source of the issue you are having.

If you have a coded auth string you can use openssl client directly
to test it.

   openssl s_client -starttls smtp -connect smtp.gmail.com:587

   AUTH XOAUTH2 auth_sting

If you have the xoauth2 access token you can create the auth string with

   echo -n -e "user=3D${EMAIL}\x01auth=3DBearer ${TOKEN}\x01\x01" | base64 =
-w0

If that does not help, can you give me some more details on your setup?
Then I'll try to reproduce the problem.

I've tested the steps above on Arch Linux with Perl v5.40.0, and
Ubuntu with Perl v5.38.2.

Regards Julian

