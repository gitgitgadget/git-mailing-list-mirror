From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule update: continue when an update fails
Date: Thu, 21 Apr 2011 11:28:00 -0700
Message-ID: <7vpqofxxvz.fsf@alter.siamese.dyndns.org>
References: <20110421085321.GA14057@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:28:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCybw-0006aE-Mg
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 20:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab1DUS2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 14:28:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab1DUS2J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 14:28:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D29EE4DCD;
	Thu, 21 Apr 2011 14:30:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iI/o3ehGck5jVcdmS89oMauDGtA=; b=IhaPGV
	CBwdgbqeObDomC/bimaw1pdaPjHydgIR+B6eQxHMs09PIEbW8ipW9tr5ae8VgT2t
	efUploikkDKV/zx1Hr0O8td8Yf2v2xz5vR8I1C2nxGCcsb1ujl+dgNZJneEG3NzE
	NDgWj++CKw07Ej3+xBgFjhLvXdS2rNIDVZbW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O0Ty4ymdmvDvHGzFMCLvgOOLr2tQp557
	xQvzZCbzOh9WHos+oCaODWSaI7/qH+JcNL+ynLSWo2g20SNjt1fTcRiXTH5pW+E5
	yb+10MmSX+nmPqUtrrgB+aCUwHRnRbmvAWch5MLwyxtdqooya2kabfjugM4g70jB
	XUXLO1rtmzI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B08C04DCC;
	Thu, 21 Apr 2011 14:30:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D4274DCB; Thu, 21 Apr 2011
 14:30:02 -0400 (EDT)
In-Reply-To: <20110421085321.GA14057@paksenarrion.iveqy.com> (Fredrik
 Gustafsson's message of "Thu, 21 Apr 2011 10:53:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60F58B62-6C45-11E0-B98F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171911>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> when running git submodule update the scripts stop after failing to
> fetch an submodule. This is errornous because this implies that if a
> submodule 'a' isn't availiable then submodule 'x' shouldn't be loaded.
> This implies a relationship that isn't definied within git.

I do not quite understand this. The relationship between 'a' and 'x' are
clearly defined within your superproject in that they are both submodules
of it.

It is indeed asymmetric in that if we fail 'a' we do not even attempt 'x',
while if we succeed a' and then fail 'x', we do not roll-back 'a', i.e. we
do not try to be atomic.

One could argue that if we do not bother to be atomic, it would be better
to try doing the remainder than stopping at the first failure.  Is that
what you wanted to say?

I suspect that it depends on the nature of the "failure" and the state the
failure leaves the particular submodule in.  For example, if the failure
leaves the failed submodule intact (i.e. idempotent and/or no-op), and if
it fails quickly enough, then it makes perfect sense to keep going and
finish all that can succeed.  On the other hand, if it leaves a huge mess
the user needs to go in and manually fix (think: conflict resolution),
some users may prefer to do so one at a time, instead of having to deal
with many independent huge messes that will be left by this change.

> There's three different ways to solve this (because the script is runned
> as a childprocess of the git-submodule.sh script):
>
> 1. use a global variable (via the export command) to share data between
>  processes.

It is unclear what you mean by "share data"?  Data on what?

> 2. Print outdata from the childprocess to stdout and read it via a pipe
>  in the parent process.

The same.  The reason why you need the communication is not explained
well. What are you trying to pass from the child to the parent? Why does
the parent need to know it?

> 3. Do all error handling in the child process

Ahh, so the "share data" was about "the outcome of the processing for one
submodule, if it succeeded, or if it failed and if so how".

> I've choosen alternative 3 as it seams to have the smallest impact.

All of the above, if expressed clearly (in other words, when rewritten so
that I do not have to say "I don't understand this"), should be in the
commit log message.

> From 7ba07dcfdd99c14522946e923ec63bd0bcd60021 Mon Sep 17 00:00:00 2001
> From: Fredrik Gustafsson <iveqy@iveqy.com>
> Date: Mon, 18 Apr 2011 23:08:59 +0200
> Subject: [PATCH] submodule update: continue when an update fails
>
> git submodule update dies when a remote reference isn't a tree. Instead

"When a remote reference isn't a tree"?  I am not sure what you mean.
What remote reference?

> of dying, print an error message and continue update the next submodule
> (and die when all modules are done if there was any errors).

More importantly, for the purpose of your change, it does not matter how a
command run for one submodule fails.  Perhaps restate the above like this?

    "git submodule update" stops at the first submodule it cannot update.
    Instead, report the error, continue to update other submodules, and
    exit with failure status at the end.

> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
> ---
>  git-submodule.sh |   30 +++++++++++++++++++++++-------
>  1 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index b010a67..06ff7f2 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -441,7 +441,8 @@ cmd_update()
>  	fi
>  
>  	cloned_modules=
> -	module_list "$@" |
> +	err=
> +	module_list "$@" | {
>  	while read mode sha1 stage path
>  	do

Shouldn't this be

	module_list "$@" | {
        err=
        while read ...
	do

as the $err is only relevant to the child process that is on the
downstream of this pipe?
