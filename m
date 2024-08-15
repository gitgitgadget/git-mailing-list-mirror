Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990317C995
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732637; cv=none; b=RvGMs95Pjm5N8bKsin35RKjinRoB0r0XYjljRWzFXmQ0ReyjV++KbipDQG62IDGFI4mT4woy3kmzn3aiOiQdpCm/vJH94PhAlWyXf6EBLlh2f8ZJ0E7EHs/vL7wSRNvwr5HIJLrAgO38/l1ziLLEiKUkXDq+17lth3tzYap4NeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732637; c=relaxed/simple;
	bh=3kEwt/6rzg5QIbPUluyYOubfknWvVo/iczaqCjbWg7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgtOGdB1HZoUn2rQHAJJctSgobY1vgfk4gKo+Dj5P4rElgNtYj95gPVbIUKrgdP9+UQRLiCn6ydQIAy+78qIEShelkqnsFOu1Rtyr6xB81Is9TSfUyJcDOglRCYcr4fMyOL8kXkXLPir0LqZujyC/1hhh0+sfZW8GoWTo0F9hKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Wl74M6vLXz5vS1
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 16:37:07 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4Wl74B1kBQzRpKv;
	Thu, 15 Aug 2024 16:36:58 +0200 (CEST)
Message-ID: <152246bb-0f38-491d-80b9-ed029010f29f@kdbg.org>
Date: Thu, 15 Aug 2024 16:36:57 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] git-gui: strip comments and consecutive empty lines
 from commit messages
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Brian Lyles <brianmlyles@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>, Sean Allred
 <allred.sean@gmail.com>, git@vger.kernel.org
References: <20240813090631.1133049-1-oswald.buddenhagen@gmx.de>
 <20240813090631.1133049-2-oswald.buddenhagen@gmx.de>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20240813090631.1133049-2-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 13.08.24 um 11:06 schrieb Oswald Buddenhagen:
> This is also known as "washing". This is consistent with the behavior of
> interactive git commit, which we should emulate as closely as possible
> to avoid usability problems. This way commit message templates and
> prepare hooks can be used properly, and comments from conflicted rebases
> and merges are cleaned up without having to introduce special handling
> for them.
> 
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> 
> ---
> 
> Cc: Johannes Sixt <j6t@kdbg.org>
> Cc: Brian Lyles <brianmlyles@gmail.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: Eric Sunshine <sunshine@sunshineco.com>
> Cc: Sean Allred <allred.sean@gmail.com>
> ---
>  git-gui/lib/commit.tcl | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
> index 11379f8ad3..f00a634624 100644
> --- a/git-gui/lib/commit.tcl
> +++ b/git-gui/lib/commit.tcl
> @@ -209,6 +209,10 @@ You must stage at least 1 file before you can commit.
>  	#
>  	set msg [string trim [$ui_comm get 1.0 end]]
>  	regsub -all -line {[ \t\r]+$} $msg {} msg
> +	# Strip comment lines
> +	regsub -all {(^|\n)#[^\n]*} $msg {\1} msg
> +	# Compress consecutive empty lines
> +	regsub -all {\n{3,}} $msg "\n\n" msg
>  	if {$msg eq {}} {
>  		error_popup [mc "Please supply a commit message.
>  

I'm still not convinced that it is appropriate to silently edit a
message entered by the user.

Nevertheless, I will pick up this series for these reasons:

Firstly, during an interactive rebase Git GUI has no way to inform the
user that the commit message is a union of messages of squash- and
fixup-commits except by presenting the comments that git-rebase inserted
in the commit message. Stripping these comments before the user can see
them would be a disservice. Consequently, they should be helped in the
way that this patch does.

Secondly, there is already precedent in b9a43869c9f9 ("git-gui: remove
lines starting with the comment character", 2021-02-03), which invoked
git-stripspace. This commit was reverted later by c0698df0579a for
technical reasons (incompatibilities with macOS). So it seems that a
majority thinks this is the right way to go forward.

Further work would be welcome, though. The comment character can be
configured and should not be hard-coded. The commit cited above shows
how it can be implemented.

Three more instances of `$ui_comm get` exist, which trim whitespace in
various ways. Each should be inspected whether it still does the right
thing.

All of these can be follow-up patchs, of course.

-- Hannes

