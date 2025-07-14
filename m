Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103F23C4FF
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511957; cv=none; b=QAMKliwkqmz21UFSqmu6hFb9mzYY2DW67Tt8+8Ba3gexW7jxtE1lo9XYPFaPCNPU7JsWXmoNs8xklmZkTYAixazWPSdCWt4ys2UTtD5yRy2yvG5+lcksGR07Z6F7oIXBq9VbB/YnPh5/W6GJd9in8onVMgfUd3mTGUvMAFv3vUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511957; c=relaxed/simple;
	bh=iD8loS0Krnd/aQ+/7lMmgVcTD0oMLGRARoLw3d4hBm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8HfkuJPUqsn3Awuenatf/IEQPmpg5V796mo9RsYRsOq3kR9w4MyoS01Z8lwQy+ai4N8WpfQ2pp/Mx7CsYWs2diHWsioa7NgPx9+c/tDxpPT5NhVPSfvunHO5u5ODPynRMuvS917X/+fLs+0EKDVKLJfoAtw/fMPKLhQFBSwnrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220187.atnat0029.highway.webapn.at [89.144.220.187])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4bgpJv3PWyzRpLG;
	Mon, 14 Jul 2025 18:52:31 +0200 (CEST)
Message-ID: <878b4335-873c-4bc5-a7c1-581d3a71901e@kdbg.org>
Date: Mon, 14 Jul 2025 18:52:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gitk: Add support of SHA256 repo
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: Denton Liu <liu.denton@gmail.com>, Eric Huber <echuber2@illinois.edu>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Avi Halachmi <avihpit@yahoo.com>, Christoph Sommer <sommer@cms-labs.org>,
 Paul Mackerras <paulus@ozlabs.org>, Rostislav Krasny <rosti.bsd@gmail.com>,
 git@vger.kernel.org
References: <20250617055957.9794-1-tiwai@suse.de>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250617055957.9794-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 17.06.25 um 07:59 schrieb Takashi Iwai:
> This patch adds a basic support of SHA256 Git repository to Gitk, so
> that Gitk can show and operate on both SHA1 and SHA256 repos
> gracefully.  Since SHA256 has a longer ID length (64 char) than SHA1
> (40 char), many field widths are adjusted to fit with it.
> 
> A caveat is that the configuration of auto selection length is shared
> between SHA1 and SHA256 repos.  That is, once when this value is saved
> and read, it's applied to both repo types, which may result in shorter
> selection than the full SHA256 ID.  We may introduce another
> individual config for sha256 (actually I did write in the first
> version), but for simplicity, the common config is used as of writing
> this.
> 
> Many lines still refer "sha1" although they may point to both SHA1 and
> SHA256.  They are left untouched for making the changes simpler.
> 
> This patch is based on the early work by Rostislav Krasny:
>   https://patchwork.kernel.org/project/git/patch/pull.979.git.1623687519832.gitgitgadget@gmail.com
> I refreshed, revised and extended to the latest state.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> v1: https://lore.kernel.org/20250320154136.23262-1-tiwai@suse.de
> v1->v2:
> - Fix other procs using fixed 40 length
> - Don't use tabs
> - Drop autosellensha256 config
> - Some code simplification
> - Fix patch description

Thank you for the update. I'll queue this patch, but...

> @@ -12491,6 +12513,17 @@ if {$tclencoding == {}} {
>      puts stderr "Warning: encoding $gitencoding is not supported by Tcl/Tk"
>  }
>  
> +# Use object format as hash algorightm (either "sha1" or "sha256")
> +set hashalgorithm [exec git rev-parse --show-object-format]
> +if {$hashalgorithm eq "sha1"} {
> +    set hashlength 40
> +} elseif {$hashalgorithm eq "sha256"} {
> +    set hashlength 64
> +} else {
> +    puts stderr "Unknown hash algorithm: $hashalgorithm"
> +    exit 1
> +}
> +
>  set gui_encoding [encoding system]
>  catch {
>      set enc [exec git config --get gui.encoding]

... I'll move the setup of $hashlength after the gui_encoding setup that
is visible in the context, so that the new code is not in the middle of
the encoding section.

-- Hannes

