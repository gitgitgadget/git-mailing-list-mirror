Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB241E867
	for <git@vger.kernel.org>; Sun, 16 Jun 2024 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718536648; cv=none; b=nt7aKJiOu4xuD5smdxQLu9c3Rr+c7sZPx0KR1yJWP3MaA8+/EAFyX6DQsDO4Mf2nBvNEv/FyXbT5/Xe3/qpOPwOlgvkRy4l/th+f6GItaRJf5q843/g2kt34z9DbgbL/y4bFarkVPGASVdtasT3gxuDT6FRQi2VlaKt1eb1d+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718536648; c=relaxed/simple;
	bh=TpQQw/549WRcjEzIaM0wfbl6Q9tD6NtTa6TyMJan+Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=SBGczUDeB9LF/wcxLU2eULZ/djSugjdCj8p7CgDgxpdHr5RMhe1KuABtMVkse+GPD9HIjvK9bldgVUjT0qxuUygxvm08/wte1duxIGilOwRDq7K1ddalwqQCSZ5WBM3VrBvpDHLNXrQaXwdwQmEcG8OIrKxUQB1KFAPeLJxUsuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4W28S42TCcz5tqr
	for <git@vger.kernel.org>; Sun, 16 Jun 2024 12:31:00 +0200 (CEST)
Received: from [192.168.0.105] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4W28Rw0BgMzRnmP;
	Sun, 16 Jun 2024 12:30:51 +0200 (CEST)
Message-ID: <5dd4de8a-255a-4f03-b4d8-fc160b3178e1@kdbg.org>
Date: Sun, 16 Jun 2024 12:30:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix default font scaling
To: Serhii Tereshchenko <serg.partizan@gmail.com>
References: <20240615085345.47278-1-serg.partizan@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20240615085345.47278-1-serg.partizan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 15.06.24 um 10:53 schrieb Serhii Tereshchenko:
> This fixes font scaling for default fonts, where we don't set font
> sizes explicitly.
> 
> Without this, on 4k monitor with text-scaling-factor configured in Gnome,
> labels, buttons and settings are using very small font sizes. (Probably,
> not just Gnome but anything that sets custom DPI).
> 
> Screenshots here: https://twiukraine.com/@partizan/112619567918546426
> 
> Signed-off-by: Serhii Tereshchenko <serg.partizan@gmail.com>

Thank you. I have adjusted the title to read

  git-gui: fix scaled default fonts

to follow the convention.

> ---
>  git-gui.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 8bc8892..23dd82d 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -810,6 +810,16 @@ if {[is_Windows]} {
>  ## config defaults
>  
>  set cursor_ptr arrow
> +
> +# For whatever reason, Tk does not apply font scaling to default fonts,
> +# but applies font scaling when setting size explicitly.
> +# Default -size 10 is still 10, when you look at it with `font actual ...`,
> +# but explicitl -size 10 becomes 10 * scale factor.

I fixed this typo: s/explicitl/explict/

> +# So, we need to configure fonts to use their default font sizes, but scaled.
> +foreach font_name [font names] {
> +	font configure $font_name -size [font actual $font_name -size]
> +}

Have you seen https://wiki.tcl-lang.org/page/font+scaling where [font
configure ...] instead of [font actual ...] is suggested as a preferable
solution? I am not so much into Tcl/Tk that I can judge what is best.

> +
>  font create font_ui
>  if {[lsearch -exact [font names] TkDefaultFont] != -1} {
>  	eval [linsert [font actual TkDefaultFont] 0 font configure font_ui]

My setup does not have a 4k monitor, I run KDE and I do not know if I
have changed a DPI setting. For the test, I have removed the [gui]
sections from my configurations to ensure that the defaults are used.

Under these conditions, this change does not make a difference in how
Git GUI appears. I assume this is the expected outcome, so I take it as
a good sign.

The patch is available as

https://github.com/j6t/git-gui.git st/font-scaling-fix

for others to test. I'd appreciate your feedback.

-- Hannes

