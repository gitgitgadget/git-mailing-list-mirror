Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95A43ADE
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720903814; cv=none; b=D3wOSwR/SaZAllfulZejIu2tHvaMs68PRgYW39gonxsgEztW05u1yaghErF9s0YQMxyqwJsTdAYpD1asgMZrvn9yZPj4bWXplStTUhi1N+/yHmhWBSp8FpOZX7dnKax8t13AQIuyTfNTnDbMVQTORGvWnXeDrB5oicaJDQE+lkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720903814; c=relaxed/simple;
	bh=0fOl9FMjF0+060EZtYz98RvxDFIb+5lUtvcGBHRyRV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNL0h3tmSOtCyjieVSLob5qYk68mYeWgRbxXgcOrgtzz75ixb12lzDrmlkwR2B6dNfSOBD3RNo64PeRDiwHM+uHgkeW0UOX3XqxUvIIrLjh1l8xWrRcin5MoXS8XWgqcwBgg5y2tPE5M/+ONr7QLKmThGLQ1Wn7VaPSKbrF0NRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144221249.atnat0030.highway.webapn.at [89.144.221.249])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4WM0vt6spHzRpKn;
	Sat, 13 Jul 2024 22:50:02 +0200 (CEST)
Message-ID: <7789e98f-df21-4390-943c-1c96262bd0d6@kdbg.org>
Date: Sat, 13 Jul 2024 22:50:01 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-gui: do not exit upon prepare-commit-msg hook failure
Content-Language: en-US
To: Anthony Loiseau <anthony@loiseau.fr>
Cc: Junio C Hamano <gitster@pobox.com>,
 Pat Thoyts <patthoyts@users.sourceforge.net>,
 Joshua Williams <joshua.williams@qlogic.com>, git@vger.kernel.org
References: <20240711132542.9792-1-anthony@loiseau.fr>
 <20240711132542.9792-2-anthony@loiseau.fr>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20240711132542.9792-2-anthony@loiseau.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[j6t: removed Shawn from the Cc list]

Am 11.07.24 um 15:25 schrieb Anthony Loiseau:
> prepare-commit-msg hook is fired as soon git-gui is started
> and upon F5 in order to pre-fill commit message area.
> 
> Having it fatal, forcibly exiting app when this hook fails
> rendered git-gui unusable in this case. Fix this by not
> treating this hook as fatal, and not exiting app when failure
> popup is dismissed.

It is understandable that a Git GUI that cannot be started looks like a
problem that needs solving. However, I am not happy with the proposed
solution.

The first reason is that even if Git GUI can now run, the error message
still reappears every time when Rescan (F5) is used and must be
dismissed each time. (The version of Git GUI that I use does a rescan on
window activation and now runs into rescan loop after the dismission; I
can't even exit Git GUI anymore.)

> This way, user can use git-gui when he/she dismisses failure popup
> of a failed prepare-commit-msg hook.
> 
> Note that this commit does not deny user from commiting when
> prepare-commit-msg failed. Message is simply not pre-filled.

This is the second reason. As a first step, an attempt should be made to
fill the edit box with the unprocessed commit message.

I am unsure what next steps should be, though.

- Should we not allow to make a commit?
- Should we allow to edit the message and then permit a commit?

I can't tell, because I do not know for what purposes people use the
prepare-commit-msg hook.

Without these two points addressed, I consider it better that Git GUI
does not even start or exits.

> 
> Signed-off-by: Anthony Loiseau <anthony@loiseau.fr>
> ---
>  git-gui/git-gui.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 8fe7538e72..ab6caaf2ae 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -1643,9 +1643,8 @@ proc prepare_commit_msg_hook_wait {fd_ph} {
>  	if {[eof $fd_ph]} {
>  		if {[catch {close $fd_ph}]} {
>  			ui_status [mc "Commit declined by prepare-commit-msg hook."]
> -			hook_failed_popup prepare-commit-msg $pch_error
> +			hook_failed_popup prepare-commit-msg $pch_error 0
>  			catch {file delete [gitdir PREPARE_COMMIT_MSG]}
> -			exit 1
>  		} else {
>  			load_message PREPARE_COMMIT_MSG
>  		}

Below this context is the same catch {file delete ...}. Since it is now
reached, the instance in the if-branch should be removed.

-- Hannes

