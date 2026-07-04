Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE30390204
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783155550; cv=none; b=s/oToZMci8EHsWOZxI3ONWBbzygDvx4HVdNc4dvwnYf421298OaY12Bdrx7uTVgL8LivC6TXEvcaqxkf5p2t8uxE7RGKy0prkLomdk7ampvtE/Og5EvRFa8v1SWr02KrZmup5ufQ8ePMsB0qUsfuYBZVkyvBQDDBeAMJE1m8RGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783155550; c=relaxed/simple;
	bh=BbdaKUWx+nxXb1pdEiX1ShlEujbx7f+OeZ+A8mqlsW0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DBC1dKsmYxCobTe/5lH3p/JDnXq+J5wH2oxKvFRtlJAIa20j/Q2GONQ5JLdED0d3hCDqf9MMYlmjmd8pdybhEswocj1gpZnv1rvOL3XEq6YG89/DvulJ6Zpt/2rMSusScPgX+T2/OUPc/299ExpsfybWtgHYudzK4/7TkxE6+MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=NKWqgtiY; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="NKWqgtiY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783155543; x=1783760343;
	i=johannes.schindelin@gmx.de;
	bh=piMHxA3iUcSR4Yxv9O+x+4J+EMKM9Awp33V2cLRQZvA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NKWqgtiY2GDKE32jDTk1FXGxt3Xr7zO4zuthBxyTYk64FMP6KqVD0quSYdiM40Fe
	 VcmiTMJ4tB4GBq40liQxtZn237mUJyRJryMJOL6jDj3kbEaYg2mdKtXP7VxBLbaW9
	 B1PCWfRZ0E1w7RkzrktfVQFM/AZlM0AHuuIgL/v5trwxRY7q1qZ08zsZp5/4FozWG
	 mlnGjiRyNgV9D7nk/GBuyE1IjbQCVSHWdOiG4KGQSyciSljl655DdKhLBvim/3RnR
	 mgFH7qDQAQFfHntfprtXeSPHYWdm/unpCLgCJ0M6mQQHir0W+f6XLSNA6Q8pyvI35
	 QSSuPRHDL40ZX4qdNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYv3-1wvwb60Y15-011lKZ; Sat, 04
 Jul 2026 10:59:03 +0200
Date: Sat, 4 Jul 2026 10:59:05 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 08/13] submodule: fix cwd leak in
 get_superproject_working_tree()
In-Reply-To: <akTINO_S_NgWbGxG@pks.im>
Message-ID: <7ab4ffc7-aade-45fc-5456-b57eb32a3276@gmx.de>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com> <6a43f952417259c23ca456c547b0e4587a0ce6fa.1782889472.git.gitgitgadget@gmail.com> <akTINO_S_NgWbGxG@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:XDIRXv/Ar0f0UebDOVcSettzi85WMZbGPxZyFKftbPYNmfAX/Sr
 p+3lI0hu6NzFw3vdw1ouMQQsVWEikzqgifoUb3qdmGE5IJcufwQ3x6GM3l1M+zabLT4GD4A
 CZKwafgJbShTIheXfQRbMd0ch27kQpDW/s2sugv6i926CfSYugEcLr/hQdg0lHerqQI+X5l
 x8OwEQCIic9DVz6tU/Jhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s7mIOFpOUTY=;sg+hCabqZ+a/Ird13OD5Vj3gznr
 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
 mC4sRY/Raccjfq0qBA=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 1 Jul 2026, Patrick Steinhardt wrote:

> On Wed, Jul 01, 2026 at 07:04:26AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/submodule.c b/submodule.c
> > index fd91201a92..8ddeebd8af 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -2627,10 +2627,10 @@ int get_superproject_working_tree(struct strbu=
f *buf)
> >  		 * We might have a superproject, but it is harder
> >  		 * to determine.
> >  		 */
> > -		return 0;
> > +		goto out;
> > =20
> >  	if (!strbuf_realpath(&one_up, "../", 0))
> > -		return 0;
> > +		goto out;
> > =20
> >  	subpath =3D relative_path(cwd, one_up.buf, &sb);
> >  	strbuf_release(&one_up);
> > @@ -2693,6 +2693,10 @@ int get_superproject_working_tree(struct strbuf=
 *buf)
> >  		die(_("ls-tree returned unexpected return code %d"), code);
> > =20
> >  	return ret;
> > +
> > +out:
> > +	free(cwd);
> > +	return 0;
> >  }
>=20
> Okay. This is fine, but it feels a bit fragile as we also have a call to
> `free(cwd)` a bit further up. So if somebody were to add a `goto out`
> after that call we'd have a double free. Makes me wonder whether we want
> to have a single exit path for the complete function and then drop the
> other call to free(3p).

Agreed. In v2 the function has a single exit path: all late returns
fall through to the `out:` label, which additionally releases `sb`
and `one_up`.

A side effect worth noting is that consolidation also closes a latent
leak the original had on the `strbuf_realpath(&one_up, "../", 0)`
failure path. `strbuf_realpath_1()` calls `strbuf_reset(resolved)` on
error, which does not free the backing buffer, so `one_up` could
carry a residual allocation that the previous shape never released.

Ciao,
Johannes
