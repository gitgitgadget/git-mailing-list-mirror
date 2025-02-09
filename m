Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150BF9FE
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739113812; cv=none; b=APYhoO53q54abAKj3X8sRSsy6NAeoJ/R3zHKYsMSyPnzGh8WJhUnvZZ0xR2K/ezutgawsCT5j1lsj7yPykUwYWD0ci4ou5yVnbyxlHeVDKMMPOZthFbCWpktVwxDAekYU6hB7TkiiZN/EULBM4wigUeU8dA06T3Gu5q6K+HGnXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739113812; c=relaxed/simple;
	bh=DdFoa069VAvm88zmXsKHpshTD+za27SoKR1FArvIvCw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anMHhHYEycnQhE8unPmLy4ll0tAK2KnkDGiRLlJ7NK4XyOpB4iB0nTqz83mS09PSCW35ydmNyBvTNnQbmFgHI8+T3w5rhg8kwxvCr0zvUNND47DnrTRyJxkaOVda7G/CwKmAO1YB0s6j+xzqqvhplyauUfA5vbH+OO9LX70i8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1th8we-005P0t-Lb; Sun, 09 Feb 2025 16:10:04 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 499BA60117; Sun,  9 Feb 2025 16:09:24 +0100 (CET)
Date: Sun, 9 Feb 2025 16:09:24 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250209150924.GN30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de>
 <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de>
 <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <20250208205709.GH30202@raven.inka.de>
 <20250209092514.GM30202@raven.inka.de>
 <20250209111406.GA12069@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250209111406.GA12069@tb-raspi4>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hello Torsten,

On Sun, Feb 09, 2025 at 12:14:06PM +0100, Torsten Bögershausen wrote:
> On Sun, Feb 09, 2025 at 10:25:14AM +0100, Josef Wolf wrote:

> > This application stores the bulk of the data as text files and XML files with
> > CRLF. But there are also some binary files. So I set gitattributes like this:
> >
> >    # Catch bulk as text=crlf, rely on git to detect binary
> >    */*     text=auto eol=crlf
> > 
> This looks a little bit strange to me.

This should match all files in directories one level deeper than the directory
where .gitattributes live:

   If there is a separator at the beginning or middle (or both) of the pattern,
   then the pattern is relative to the directory level of the particular
   .gitignore file itself.

> What happens if you replace "*/*" with "*" like this.
> *     text=auto eol=crlf

Same result, but when I commit .gitattributes, I get a warning that git will
do lf->crl conversion. But even after commit, no conversion is done and
git-ls-files still shows:

   i/lf    w/lf    attr/text=auto eol=crlf gt8/ETS/Projekte/.gitignore

Only after removal followed by "git reset --hard", I get:

   i/lf    w/lfcr  attr/text=auto eol=crlf gt8/ETS/Projekte/.gitignore

> >    #
> >    # those are known to be text=crlf
> >    */B     text eol=crlf
> >    */P-*   text eol=crlf
> Same here. What is B ? Is it a directory ?

No. It is one of the XML files I want to smudge+clean

-- 
Josef Wolf
jw@raven.inka.de
