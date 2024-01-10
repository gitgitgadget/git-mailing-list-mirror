Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105D44389
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16898 invoked by uid 109); 10 Jan 2024 10:23:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jan 2024 10:23:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25575 invoked by uid 111); 10 Jan 2024 10:23:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jan 2024 05:23:41 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jan 2024 05:23:38 -0500
From: Jeff King <peff@peff.net>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/3] Strengthen fsck checks for submodule URLs
Message-ID: <20240110102338.GA16674@coredump.intra.peff.net>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1635.git.1704822817.gitgitgadget@gmail.com>

On Tue, Jan 09, 2024 at 05:53:34PM +0000, Victoria Dye via GitGitGadget wrote:

> While testing 'git fsck' checks on .gitmodules URLs, I noticed that some
> invalid URLs were passing the checks. Digging into it a bit more, the issue
> turned out to be that 'credential_from_url_gently()' parses certain URLs
> (like "http://example.com:something/deeper/path") incorrectly, in a way that
> appeared to return a valid result.

I don't think that checks was ever intended to be an overall URL-quality
check. The reason we used the credential code in the fsck check is that
we were checking for URLs which triggered a specific credential-related
vulnerability.

I don't mind tightening things further as long as:

  1. We are not allowing any cases that the credential code would have
     forbidden (i.e., something that might let the vulnerability slip
     through, since ultimately it is the credential code which will need
     to be protected). You ported over the newline check, which is the
     main thing. It's possible that there is some difference between the
     two parsers that may allow an invalid input to create a newline for
     one but not the other, but having now looked over the code, I don't
     think so.

     And I think one could argue that the security-importance of the
     fsck check has mostly run its course. The real fix was in the
     credential code itself, and the matching fsck change was mostly
     about protecting downstream clients until they were upgraded. Now
     that it's been several years, there's not as much value there.

  2. It is not making it harder for users to work with repositories that
     may contain malformed URLs that _aren't_ vulnerabilities. It sounds
     like the specific cases you found already don't work at all with
     Git, so presumably nobody is using them. By making it an fsck
     check, though, any mistakes that are embedded in history (even if
     they are now corrected) will make it a pain to use the repository
     with sites that enable transfer.fsckObjects.

     My gut feeling is that this is probably OK in practice. If it does
     cause pain, we might consider loosening the fsck.gitmodulesUrl
     severity (under the notion from above that it is no longer a
     critical security check). But if it doesn't cause real-world pain,
     being pickier is probably better (it may save us from a
     vulnerability down the road).

-Peff
