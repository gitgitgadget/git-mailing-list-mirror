Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E021101EE
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984069; cv=none; b=qzY/hX72HndX2lVYklTZW2g2MzahcHwzJ5BH5flPBQzbDnUYHsufwsCEPlRo06JAi9ghWMBkS2fpwxCzhWreH1iS+3VGrC5u7M4xTuLPAZzzb014MF6KHNXwPh1v5Y9bWbFvJfAeL8KsWp4YBtaQezTPhM1xxE7+NXbwpvQpvQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984069; c=relaxed/simple;
	bh=ws7UlaTmiNl2cpr5Vc3lzS9J8P5Y5TnIJF64Q5HjZKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYkfGT9QSJqowlscFWhcVNO7HM+ZbwE7NSRy+ZZROKjMtO81lo4a2K0hJJmleCQ5rQttDKiKqlMxoT8rGlnTq2FUdXTZnTISbKecCrVPCJQPyIBrwi3veB9MZSNpG4uhYV5nl7TWM7kcmpr0LLuW2vj6kfFx/kRYXQh9izrO2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4btGkl2zP6zRpKk;
	Thu, 31 Jul 2025 19:47:43 +0200 (CEST)
Message-ID: <c5f382d0-7a65-410a-bfee-ea3829a01087@kdbg.org>
Date: Thu, 31 Jul 2025 19:47:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] git-gui: ensure own version of git-gui--askpass is
 used
Content-Language: en-US
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: johannes.schindelin@gmx.de, mlevedahl@gmail.com, ps@pks.im,
 gitster@pobox.com, git@vger.kernel.org
References: <20250730164052.15371-1-carenas@gmail.com>
 <20250731080628.27917-1-carenas@gmail.com>
 <20250731080628.27917-6-carenas@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250731080628.27917-6-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 31.07.25 um 10:06 schrieb Carlo Marcelo Arenas Belón:
> When finding a location for the askpass helper, git will be asked
> for its exec path, but if that git is not the same that called
> git-gui then we might mistakenly point to its helper instead.
> 
> Assume that git-gui and the helper are colocated to derive its
> path instead.
> 
> This is specially useful in macOS where a broken version of that
> helper is provided by the system git.
> 
> Suggested-by: Mark Levedahl <mlevedahl@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  git-gui.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 8bb121d..78324db 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1114,7 +1114,9 @@ citool {
>  
>  # Suggest our implementation of askpass, if none is set
>  if {![info exists env(SSH_ASKPASS)]} {
> -	set env(SSH_ASKPASS) [file join [git --exec-path] git-gui--askpass]
> +	set env(SSH_ASKPASS) \
> +		[file join [file dirname [file normalize $::argv0]] \
> +			git-gui--askpass]
>  }
>  
>  ######################################################################

FYI, in my integration branch, this area looks like so without this change:

# Suggest our implementation of askpass, if none is set
if {![info exists env(SSH_ASKPASS)]} {
	set env(SSH_ASKPASS) [file join [git --exec-path] git-gui--askpass]
}
if {![info exists env(GIT_ASKPASS)]} {
	set env(GIT_ASKPASS) [file join [git --exec-path] git-gui--askpass]
}
if {![info exists env(GIT_ASK_YESNO)]} {
	set env(GIT_ASK_YESNO) [file join [git --exec-path] git-gui--askyesno]
}

To help these other cases, I'll squash the following into this
commit:

diff --git a/git-gui.sh b/git-gui.sh
index 78324db2b587..f28a23f844cf 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1113,11 +1113,11 @@ citool {
 ## execution environment
 
 # Suggest our implementation of askpass, if none is set
+set argv0dir [file dirname [file normalize $::argv0]]
 if {![info exists env(SSH_ASKPASS)]} {
-	set env(SSH_ASKPASS) \
-		[file join [file dirname [file normalize $::argv0]] \
-			git-gui--askpass]
+	set env(SSH_ASKPASS) [file join $argv0dir git-gui--askpass]
 }
+unset argv0dir
 
 ######################################################################
 ##


