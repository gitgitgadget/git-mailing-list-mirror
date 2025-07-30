Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149F78F4E
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753902565; cv=none; b=j0B1iFt/uvXwPWIdFzN1N1q9sn4F0Qt55wTRv0vcZL9tieMGoyRFHk+SQ0iJrUNz8vHm4xLo66G3UKsiXQNinBGMfH9Oce+Q5XXe+uHJLYFhUTvqempLQxxORnQRVqLc7AD0PzCcuefCExq8jxaJ76288Pk62hMVAtDEqzeCY00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753902565; c=relaxed/simple;
	bh=Xg7iI9MpB04vcbEZ7VH/FemEI2UE9+n3kGOGrS4sdWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XULDRZjQc0estvmUZYdLXJYGeQKWdPqVcBEKPHTNDeombzj+uxxOZdK2Epl9iFUEhi4JJ3ZWwSdMT8ihQhnA8s+1Rkfa2GPU0FPGsRM7QRwpkGDmRVPV0zCzlwgRL+1DtBt1dDtstPFTypj/1LRjw5Z9YSQCxITgOa0qTfvabTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4bshbH0NSwzRnmF;
	Wed, 30 Jul 2025 21:09:15 +0200 (CEST)
Message-ID: <74891c16-8850-4148-ba15-d5b3e5571bcb@kdbg.org>
Date: Wed, 30 Jul 2025 21:09:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] git-gui: workaround deprecation of Tcl/TK 8.5 in
 macOS
Content-Language: en-US
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250730164052.15371-1-carenas@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250730164052.15371-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 30.07.25 um 18:40 schrieb Carlo Marcelo Arenas Belón:
> This series, add improvements to allow running `git-gui` in macOS, which is
> stuck in an ancient version of Tcl/TK that is no longer supported by git.
> 
> Patches 1 and 2 are minor fixes that could also apply to maint, but the main
> change is in Patch 3, which removes the long obsoleted "Git Gui" app that was
> tied to the system provided Tcl/TK framework and that has been broken for a
> while.

This sounds like the lifted requirement of Tcl 8.6 isn't the cause why
this part is broken. But the commit message of patch 3 says it is. Which
one is it?

> 
> Patches 4 and 5 are needed to avoid the system framework and facilitate using
> a third party provided package of Tcl/TK 8.6 instead, but the last patch also
> protects against a conflict with the Xcode provided git that for some reason
> includes a copy pf `git-gui--askpass` even if `git-gui` is missing.

Patch 5, I fear, needs a different approach as it breaks RUNTIME_PREFIX
builds. I say that after having looked at the patch; I haven't test it.

Any help would be appreciated on the Meson parts and whether the updated
git-gui--askpass build still works. I don't use either of them.

> 
> Carlo Marcelo Arenas Belón (5):
>   git-gui: remove uname_O in Makefile
>   git-gui: fix dependency of GITGUI_MAIN on generator
>   git-gui: retire Git Gui.app
>   git-gui: honor TCLTK_PATH in git-gui--askpass
>   git-gui: ensure own version of git-gui--askpass is used
> 
>  .gitignore                              |   2 +-
>  GIT-GUI-BUILD-OPTIONS.in                |   1 -
>  Makefile                                |  63 +++----------------
>  generate-git-gui.sh                     |   1 +
>  generate-macos-app.sh                   |  30 ---------
>  generate-macos-wrapper.sh               |  35 -----------
>  generate-script.sh                      |  22 +++++++
>  git-gui--askpass => git-gui--askpass.sh |   0
>  git-gui.sh                              |  10 ++-
>  lib/about.tcl                           |   4 +-
>  macosx/AppMain.tcl                      |  29 ---------
>  macosx/Info.plist                       |  30 ---------
>  macosx/git-gui.icns                     | Bin 28866 -> 0 bytes
>  meson.build                             |  79 +++++-------------------
>  14 files changed, 56 insertions(+), 250 deletions(-)
>  delete mode 100755 generate-macos-app.sh
>  delete mode 100755 generate-macos-wrapper.sh
>  create mode 100755 generate-script.sh
>  rename git-gui--askpass => git-gui--askpass.sh (100%)
>  delete mode 100644 macosx/AppMain.tcl
>  delete mode 100644 macosx/Info.plist
>  delete mode 100644 macosx/git-gui.icns
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>

-- Hannes

