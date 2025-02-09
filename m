Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017271487FE
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739093173; cv=none; b=GnLnG9PJFs/ygrVa1bstiIVMhThp1KdjzdjcnzS8Oihw0l7VXMR/+8kMbC6qCL3xMZ+DY+ircBaw42H4zXcwM5epWc0Ts+ajZJDZJ1Z0KfYJWUGFE7ZCGQ75XX9RwDJy85OCDjY88iExS27fuS0NzTraMznUKykvjgqv3vycSUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739093173; c=relaxed/simple;
	bh=LreGhMkIeN/w3CHGRKly6/DOBHfO/4EfzpXy6Ohrhmo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwjKAEiE6xoG3y4Lt/EQL/Dark4T589d6btsMqjD9YMhdIESAIcIq0h67UvSaYirV8NaXm6yKCaHaj7+TH2tULE9hPcFXQiB0NYdUxH4IWD63O45UsJWVeBn+ff7piOm4+xrrktIEraglwzZ402Pcpka+VMcErOJckOB4jAKz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1th3Zm-005Gxa-N1; Sun, 09 Feb 2025 10:26:06 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 67C6460117; Sun,  9 Feb 2025 10:25:14 +0100 (CET)
Date: Sun, 9 Feb 2025 10:25:14 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250209092514.GM30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de>
 <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de>
 <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de>
 <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <20250208205709.GH30202@raven.inka.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208205709.GH30202@raven.inka.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Feb 08, 2025 at 09:57:09PM +0100, Josef Wolf wrote:

I just stumbled over another wirdeness:

> Oh, have I mentioned that I am not only about line endings? Yes, I mentioned
> it in the very first mail. In addition to line endings, I am also about XML
> files from a proprietary application which reorders the XML-elements into a
> random order every time it ist run. So the clean-filter needs to sort the
> XML elements into some "canonical" order.

This application stores the bulk of the data as text files and XML files with
CRLF. But there are also some binary files. So I set gitattributes like this:

   # Catch bulk as text=crlf, rely on git to detect binary
   */*     text=auto eol=crlf
   #
   # those are known to be text=crlf
   */B     text eol=crlf
   */P-*   text eol=crlf
   #
   # smudge-clean filter
   */B     filter=etsfile
   */P-*   filter=etsfile
   #
   # files I dont't want to touch (mostly binaries)
   */*.dll       -filter -text
   */*.ver       -filter -text
   */*.lang      -filter -text
   */*.store     -filter -text
   */*.ets5hash  -filter -text

But "git ls-files --eol" gives me this:

     i/lf    w/lf    attr/text eol=crlf      gt8/ETS/Projekte/P-0113/B

Why is git ignoring my explicit CRLF setting?

This is on linux and on Windows+MSYS2. I don't have $GIT_DIR/info/attributes
and ~/.gitconfig also doesn't specify any line ending things

-- 
Josef Wolf
jw@raven.inka.de
