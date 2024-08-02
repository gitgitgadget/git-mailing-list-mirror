Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E9200CB
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 05:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722576828; cv=none; b=hd44kuVmA1u5zI+/CNr/N0rwVQHI/JoGiXMoRGG0raZHFagQVZYUVIUExIXnxdY4IrIMkOj+ivVg3W+sOTouRNacUqta0uv+K9Cy+uyasY87eG2ObtIKbA2W5+I98J0yxbd0yKqw6Nkgt8HrqvK1YPgareuvoENckHEkzW1ua8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722576828; c=relaxed/simple;
	bh=NBLJhahL5OcXQ/OKdH9SmKbVE33nVwJOvzkoXAmT1X4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QI8kK1GrO3H5tbdcosG1uR5PzU+R1KN/uNi+oERlRZ5+GGqE1Yj66jnN7Xw3thsiU+iyY2kJxtQUyYyeUIiREtNN+/HqCTWo/szOGv1Ioae3fRg9GGhHxbNw0ysM9oZ7HgZnbpt1CvQSSD1b4WWFts7W8GqgHwl5P23Jk61DOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HlADjwK0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HlADjwK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF1FC32782;
	Fri,  2 Aug 2024 05:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722576827;
	bh=NBLJhahL5OcXQ/OKdH9SmKbVE33nVwJOvzkoXAmT1X4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HlADjwK0hzfoWZfyvFL+/kPjT2bK97g1PoYPM0kX7uez+nzbuWopUoLm1wW91qZbW
	 qTYRZN70DtLfMJvQ/r3WEWbc/zUWXpen51/+VrN/SvJ60vxr7nMsqSC76hLj07UUEm
	 SrrF/w9UiEHkGCz1W+rxkQ0ulJMZ8224Odr0bKN4=
Date: Thu, 1 Aug 2024 22:33:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: quiltimport mode detection oddity
Message-Id: <20240801223347.f3ecc32d6afebcd2e42cc3f7@linux-foundation.org>
In-Reply-To: <20240802035121.GB1246312@coredump.intra.peff.net>
References: <20240801155702.70242c31d476c46c84ee11a3@linux-foundation.org>
	<xmqqed77hifn.fsf@gitster.g>
	<20240801180706.933d797b0ae5744fdcdf47d2@linux-foundation.org>
	<20240802035121.GB1246312@coredump.intra.peff.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Aug 2024 23:51:21 -0400 Jeff King <peff@peff.net> wrote:

> On Thu, Aug 01, 2024 at 06:07:06PM -0700, Andrew Morton wrote:
> 
> > > So, the patch removes autoconf.h file from that directory.  The
> > > "extended header" part between "diff --git" and "--- a/..." has
> > > "deleted file mode 100664" and that is where the warning comes.
> > 
> > yup yup.  The patch says "remove this file which has mode 100664".
> > 
> > The file has mode 100664.
> > 
> > quiltimport says it had mode 100644.  Incorrectly, I suggest.
> 
> It's definitely a weird case. Git does not record full modes, but just
> cares about the execute bit. So it normalizes modes for regular files to
> 100644 or 100755. You can see that with a simple example:
> 
>   git init
>   echo foo >file
>   chmod 664 file
>   git add file
>   git commit -m 'add file'
> 
>   git ls-files -s
> 
>   cat >patch <<\EOF
>   diff --git a/file b/file
>   deleted file mode 100664
>   --- a/file
>   +++ /dev/null
>   @@ -1 +0,0 @@
>   -foo
>   EOF
>   ls -l file
>   git apply patch
> 
> Even though the filesystem has 100664, the index records 100644 (which
> you can see from the "ls-files" output). And then when we apply the
> patch, we get the "file has type 100644, expected 100664" message.

OK.

> AFAICT, it has been that way forever (I tried as far back as git 1.6.6).
> So this is nothing new, and I don't think Git would ever produce a patch
> that said "file mode 100664" itself (I'm assuming in your case the patch
> is coming from quilt).

yup.

> Alternatively (or maybe in addition), I wonder if quilt should similarly
> canonicalize the mode.

I'll hard code 100644 ;)

> generated elsewhere, but normal patches don't have modes in them at all.
> The "deleted file mode" line is git-ism, so here we have something which
> is implementing the git line in a (slightly) incompatible way.

yup, thanks.
