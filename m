Received: from donotpassgo.dyslexicfish.net (donotpassgo.dyslexicfish.net [209.250.224.51])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5C14A4C6
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.250.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471369; cv=none; b=hAhnKfiZ4Kr5ouJ8e2VP/eWImW5w/ZWGKN/R/+KkxtgNxgQRH74RAqBEBi62Hwaw0b2qSWzNJP48j1lwrlzJjNahZ+fvPU1TiJQoAHVuTDgUYDNPbBq2953zi3qExfaw1ZN0R/BoOrEl1SUmaDmUJ77lG+vtJBpx0qNiVf7eq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471369; c=relaxed/simple;
	bh=LhNTIA/X5UenKjac4gVsvS9TklPAxeJvnjYnculoA6U=;
	h=From:Message-Id:Date:To:Cc:Subject:References:In-Reply-To:
	 MIME-Version:Content-Type; b=YSJvcupu2mSa8ktXZAjdH7ZhYSoXs9SVSVzfy2Gt+oy+2hHqhgVNPB+1nvIXi/f3Z0fcSPKLR9BtaP5+NydbxaUFHXnPqevl9zwyVJn5yvXqOjggrUFlWukRz5kNG4uQwqMGoQE/wuFHysSQGPjAKIF1yodJSGtrki1yG8jgNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=catflap.org; spf=pass smtp.mailfrom=catflap.org; arc=none smtp.client-ip=209.250.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=catflap.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catflap.org
X-Catflap-Envelope-From: <jamie@donotpassgo.dyslexicfish.net>
Received: from donotpassgo.dyslexicfish.net (donotpassgo.dyslexicfish.net [209.250.224.51])
	by donotpassgo.dyslexicfish.net (8.14.5/8.14.5) with ESMTP id 4710FHxw018149;
	Thu, 1 Aug 2024 01:15:17 +0100 (BST)
	(envelope-from jamie@donotpassgo.dyslexicfish.net)
Received: (from jamie@localhost)
	by donotpassgo.dyslexicfish.net (8.14.5/8.14.5/Submit) id 4710FGtf018148;
	Thu, 1 Aug 2024 01:15:16 +0100 (BST)
	(envelope-from jamie)
From: Jamie Landeg-Jones <jamie@catflap.org>
Message-Id: <202408010015.4710FGtf018148@donotpassgo.dyslexicfish.net>
Date: Thu, 01 Aug 2024 01:15:16 +0100
Organization: Dyslexic Fish
To: Johannes.Schindelin@gmx.de, jamie@catflap.org, gitster@pobox.com,
        drankinatty@gmail.com
Cc: msuchanek@suse.de, git@vger.kernel.org
Subject: [SOLVED] Re: Local git server can't serve https until repos owned by http, can't serve ssh unless repos owned by user after 2.45.1
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
 <xmqq8qz376fb.fsf@gitster.g> <20240617211513.GM19642@kitsune.suse.cz>
 <20240625072419.GU19642@kitsune.suse.cz> <xmqqr0cl6lxl.fsf@gitster.g>
 <202407260038.46Q0ctEV083266@donotpassgo.dyslexicfish.net>
 <5747ba0d-7268-4538-9705-11650a7d6e35@gmail.com>
 <202407280346.46S3khd9005129@donotpassgo.dyslexicfish.net>
 <0ae914c6-70be-44b8-a6b8-53f0b15d5674@gmail.com>
In-Reply-To: <0ae914c6-70be-44b8-a6b8-53f0b15d5674@gmail.com>
User-Agent: Heirloom mailx 12.4 7/29/08
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.7 (donotpassgo.dyslexicfish.net [209.250.224.51]); Thu, 01 Aug 2024 01:15:17 +0100 (BST)

"David C. Rankin" <drankinatty@gmail.com> wrote:

>    I'd be happy if the docs were just updated with a concise explanation of 
> how to support both ssh and https to the same repo running under Apache -- if 
> that is doable.

Hi. I've done some investigating, and have discovered what the problem is (with
my setup, at least)

It only tries to access /etc/gitconfig (or /usr/local/etc/gitconfig) - putting
the rules in there allow it to work, but with the caveat mentioned by an
earlier poster - you need to add a path of "." as well as the required
directories. (or enable everything with a path of "*")

Now, I don't want to do that globally: "*" it's too risky, and I haven't
delved deep enough to determine if "." is a security risk too.

However, there is a better solution:

The problem is, the environment variable HOME isn't defined when the http
server calls cgi-http-backend.

I actually have an intermediate script that is called by httpd, that itself
execs git-http-backend, so all I needed to do was add the line

export HOME=/.../git-web-user/

before the exec, and it now works as expected, picking up .gitconfig from the
.../git-web-user/ directory.

If you call git-http-backend directly, you may be able to set the environment
variable in the httpd config. If not, just create an intermediate script,
something like

#!/bin/sh
export HOME=...
exec <path-to-git-http-backend>

, and change http to call that.

Now, I don't think that if not set, git should determine HOME itself (from
the password file etc.), as someone may want that disabled for other reasons,
HOWEVER, this should really be documented.

So, in my mind, the fix is to fix the "." directory requirement, and document
the potential need to set HOME.

Ler me know if this works for you!

Cheers, Jamie

