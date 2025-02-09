Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C795143888
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739091492; cv=none; b=PSiSdOmZ7IJaW/KhaaLl2jPlyvHfJbQN7w8/30fZm+R3CuVhcP+sgnbAC5cYlEUY/mPGMMEg4L72TkTVWua9yKP+MwUhnVAKpY4pFGaxuQK0fc47SltXy5aabCMEH8EgeZUaVMqSbmKQViJ4nCsB/h1MemNuevop+mqP7VKyp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739091492; c=relaxed/simple;
	bh=Zy7vTwnhAF4X0N7pdkAa7u6qKEXJ7z73DDWuzdI/KI4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBLkklK0MilI7imgugcD/tStffFMDY3yLgKytPkA7xKzpGLhmxer3DauynL7hSxfSp7rMTqspLCQJLVFXUrNidTW6+ZKT256DZwDlFNitdW0JJZxvLt8nlXI/MS/clOrX0McsNc0g8KLO4SWVOAXw6EOMvO7izxYlqv9XJi+pX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1th38g-005GDq-Of; Sun, 09 Feb 2025 09:58:06 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id C335160117; Sun,  9 Feb 2025 09:57:56 +0100 (CET)
Date: Sun, 9 Feb 2025 09:57:56 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250209085756.GL30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de>
 <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de>
 <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <ba65ce17-8768-4d60-aec6-badd12930b81@gmail.com>
 <CABPp-BGwZ029Y8Kfr2kkGiUDZ613kxS81JXzk36V85=77KcYfA@mail.gmail.com>
 <20250208232651.GJ30202@raven.inka.de>
 <CABPp-BEzOWVa5zqOMuUSH5xCJ+CUk6sJnLhE5OdnDiNR0U9jfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEzOWVa5zqOMuUSH5xCJ+CUk6sJnLhE5OdnDiNR0U9jfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Feb 08, 2025 at 11:21:12PM -0800, Elijah Newren wrote:
> On Sat, Feb 8, 2025 at 3:28 PM Josef Wolf <jw@raven.inka.de> wrote:

> > > ahah, so it is passed via environment variable to the subprocess.
> >
> > I find this to be confusing: the primary call should not need this parameter,
> > since it is invoked from HEAD anyway.
> 
> No, the primary call I think would need the parameter too; it changes
> HEAD immediately when it starts rebasing, and continues changing it
> with each commit it rebases; since it's operating on older versions,
> by default it'd likely pick the .gitattributes from those older
> versions as it goes.

OK. I see...

> > Everything else gets it via env-vars.
> > I'd assume this variable will also be passed to the commands which are invoked
> > by the -x switch?
> 
> Yes, I was surprised Phillip's command with --attr-source on the
> outer-level git invocation worked until I discovered that the code
> indeed sets the environment variable (which subprocesses, like those
> created by the --exec/-x switch, will inherit).  So, yes, the -x
> switch stuff seems to inherit that environment variable that the
> primary call sets in response to that parameter.

Umm... OK... This means that specifying --attr-source to the commands for the
-x switch is wrong, since they have a different HEAD?

-- 
Josef Wolf
jw@raven.inka.de
