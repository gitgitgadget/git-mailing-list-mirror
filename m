Received: from mail.light-speed.de (mail.light-speed.de [85.214.38.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD6E2FE060
	for <git@vger.kernel.org>; Sun, 24 May 2026 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.38.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779666226; cv=none; b=Aco2BSwqhIOUhxya2DvyjcHyqqiWkDOrRXiXJEwXnYAGUV2h+HMgvvylz4OIUKQJ9LK6Ff7G5H9X/T+yiJi1GJBK89gp/FdveerU5993+bZoCSqBgoXI30x1a9/OFck4DjIASeqbwcLQ2m77Xi8rjUJnneyGkVma213T6tzqLEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779666226; c=relaxed/simple;
	bh=mNwADyPuklNYfvBTlZ1BUAz2gUTV59gBXkEDYIHWN68=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=akRZtchn/mbSmis3DitUWslEZYl/0GCWeUsqlCjPGcMfirj84QEvM1cgk0X+WwTs5ZxaXg7iSa23Kfvo2JHPnVTiDHLDus5RSju5GzzmRNA95Jt7/hW9o7K8e61NLN6eQmVlbz3LhwSDACKx8QLFE1QWE01ioAsGAN9d//kNW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=light-speed.de; spf=pass smtp.mailfrom=light-speed.de; dkim=pass (1024-bit key) header.d=light-speed.de header.i=@light-speed.de header.b=xE+DulxR; arc=none smtp.client-ip=85.214.38.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=light-speed.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=light-speed.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=light-speed.de header.i=@light-speed.de header.b="xE+DulxR"
Received: from smtpclient.apple (122-151-128-174.sta.wbroadband.net.au [122.151.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.light-speed.de (Postfix) with ESMTPSA id B5C373D49413
	for <git@vger.kernel.org>; Mon, 25 May 2026 01:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=light-speed.de;
	s=mail; t=1779666127;
	bh=NOKv332l4lGq3lcHUsAe/TQx9h/MPDDVo0YPGmrpt6w=;
	h=From:Subject:Date:To;
	b=xE+DulxRHFDBG94TO9aOhN9mxlon3N1NppOAuM0DbtXH47SLGPnHTiBxLvVExZdUw
	 yKt1nbnptCfo4QDVfEFUZ5nve/Wo/er8OTrntFuUvQC97Eo30FkeWru1XeUPKAceqp
	 cIJioznVmArYw3WCspSxTPWq6IIk9YXwwSp/FOZY=
From: =?utf-8?Q?Jens_Tr=C3=B6ger?= <jens.troeger@light-speed.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.21\))
Subject: How does git track history overwrites?
Message-Id: <089615C1-6526-4ADC-926A-6A232F330DA2@light-speed.de>
Date: Mon, 25 May 2026 09:41:50 +1000
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.700.6.1.21)

Hello,

I=E2=80=99m looking for details and some clarification on a `git fetch` =
behavior I observed, but can=E2=80=99t quite explain. More context is in =
this Github comment:

  =
https://github.com/jenstroeger/python-package-template/pull/1190#discussio=
n_r3288253713

but it boils down to this:

  /tmp/bla > git -c protocol.version=3D2 fetch origin =
dda8db18cfc68df532abf33b185ecd12d5b7b326 --depth=3D1

It seems that sha dda8db1 (tag 1.20.0 previously pointed at it) was =
replaced due to a suspected history overwrite with fda7769 (tag 1.20.0 =
now points at it) and git figures that out:

  ...

  =46rom https://github.com/adamchainz/blacken-docs
  * branch dda8db18cfc68df532abf33b185ecd12d5b7b326 -> FETCH_HEAD

And then:

  /tmp/bla > git checkout FETCH_HEAD
  Note: switching to 'FETCH_HEAD=E2=80=99

  ...

  HEAD is now at fda7769 Version 1.20.0

And:

  /tmp/bla > cat .git/HEAD=20
  fda77690955e9b63c6687d8806bafd56a526e45f
  /tmp/bla > cat .git/FETCH_HEAD=20
  dda8db18cfc68df532abf33b185ecd12d5b7b326 =
'dda8db18cfc68df532abf33b185ecd12d5b7b326' of =
https://github.com/adamchainz/blacken-docs

I=E2=80=99d like to understand the details some more, and how I could =
manually make that connection?

Thank you!
Jens

