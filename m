From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] submodule::module_clone(): silence die() message
 from module_name()
Date: Mon, 10 Oct 2011 21:34:00 +0200
Message-ID: <4E9348A8.5000500@web.de>
References: <1317978295-4796-1-git-send-email-rctay89@gmail.com> <1317978295-4796-2-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 21:34:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDLc2-0001VW-Fo
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 21:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583Ab1JJTeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 15:34:04 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:57440 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706Ab1JJTeD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 15:34:03 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6587619FB3E0F;
	Mon, 10 Oct 2011 21:34:01 +0200 (CEST)
Received: from [79.247.240.43] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1RDLbt-0002IC-00; Mon, 10 Oct 2011 21:34:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <1317978295-4796-2-git-send-email-rctay89@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/+A0sz9U0EH+lM4iR7bv9kWwevAgkgsBmBw0iY
	52K3RSBnppE+K0O1jvDPIAnREVxWUnF33E7K8CQqGcYoknyg5Y
	6kGbkg9bP5XoAYAiAVmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183251>

BTW: this patch applies to next

Am 07.10.2011 11:04, schrieb Tay Ray Chuan:
> The die() message that may occur in module_name() is not really relevant
> to the user when called from module_clone(); the latter handles the
> "failure" (no submodule mapping) anyway.

Makes tons of sense, especially as adding a new submodule currently always
spews out the "No submodule mapping found in .gitmodules for path 'sub'"
message right before that mapping is added there. Thanks for noticing that
and ACK on that change from my side.

> Leave other callers of module_name() unchanged, as the die() message
> shown is either relevant for user consumption (such as those that exit()
> when the call fails), or will not occur at all (when called with paths
> returned by module_list()).

Hmm, while I agree on the first reasoning I'm not sure about the second.
module_list() asks the index for the submodule paths while module_name()
gets it's input from .gitmodules, so they can (and sometimes will)
disagree. When cmd_foreach() passes an empty "name" variable to the
spawned command that might still work (and even make sense), but using the
empty name in cmd_sync() to access the config is looking like an error to
me. It might make sense to add an "|| exit" at least to the callsite in
cmd_sync(). Or am I missing something here?

> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  git-submodule.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ebea35b..3adab93 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -130,7 +130,7 @@ module_clone()
>  
>  	gitdir=
>  	gitdir_base=
> -	name=$(module_name "$path")
> +	name=$(module_name "$path" 2>/dev/null)
>  	base_path=$(dirname "$path")
>  
>  	gitdir=$(git rev-parse --git-dir)
