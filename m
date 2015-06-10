From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 15/19] pull: teach git pull about --rebase
Date: Wed, 10 Jun 2015 23:35:18 +0800
Message-ID: <CACRoPnSgVPVDTC=nY6FQHoVRPF1HZhRYXaKoQ1oJrJCoG1W8xg@mail.gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-16-git-send-email-pyokagan@gmail.com>
	<xmqqk2vcuy10.fsf@gitster.dls.corp.google.com>
	<CACRoPnR5shi800KZ_Do5V469ZgZYAzUZKy9mNYNNRPF6HFqs_w@mail.gmail.com>
	<xmqqmw07oc72.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:35:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2i2N-0003eE-7Z
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbbFJPf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:35:26 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:34741 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964806AbbFJPfU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:35:20 -0400
Received: by laew7 with SMTP id w7so35808317lae.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jS2RNcuAHBuYV/Ue/4TdohgX/HWZGwLgyQZaNsc9ZGM=;
        b=l6F8dr6lH71QYAesP3bAvXpb5TyeC58VCHKzbSuJ/emy+qkJMyshfYenngq4ErHNfa
         CRW5IAMZ0O0KUH8S2V+3XjJiuxJuMmfuMWhbobvWrEua37kG+w7+m76Y3etmwO97YjxT
         VQ+5j0WeIRerXjnM1JaDNUXNOXTM8M9IvmZwSUN4ut7D3fJU9vyMtpoSK9tW2HpoXTIr
         2DQ6zfTVNFcmdYVr1xFr0H342YmEjnH+aRpH9W1R8+s1CS1bq4Y0LLB6PhmVx8B8L0rP
         1QNuVMEvIV1VpmFLXVxYAgqoSvGa2D6VNqqpAdTGRPp/Jy33x3E2Bt62gbL1sOLzrWcZ
         s4cQ==
X-Received: by 10.112.182.4 with SMTP id ea4mr4805532lbc.35.1433950518367;
 Wed, 10 Jun 2015 08:35:18 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 10 Jun 2015 08:35:18 -0700 (PDT)
In-Reply-To: <xmqqmw07oc72.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271307>

On Wed, Jun 10, 2015 at 10:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>>> Hmph, it is somewhat surprising that we do not have such a helper
>>> already. Wouldn't we need this logic to implement $branch@{upstream}
>>> syntax?
>>
>> Right, the @{upstream} syntax is implemented by branch_get_upstream()
>> in remote.c. It, however, does not check to see if the branch's remote
>> matches what is provided on the command-line, so we still have to
>> implement this check ourselves, which means this helper function is
>> still required.
>>
>> I guess we could still use branch_get_upstream() in this function though.
>
> It is entirely expected that existing function may not do exactly
> what the new caller you introduce might want to do, or may do more
> than what it wants.  That is where refactoring of existing code
> comes in.
>
> It somewhat feels strange that you have to write more than "shim"
> code to glue existing helpers and API functions together to
> re-implement what a scripted Porcelain is already doing, though.
> It can't be that git-pull.sh implements this logic as shell script,
> and it must be asking existing code in Git to do what the callers
> you added for this function would want to do, right?

Not git-pull.sh, but get_remote_merge_branch() git-parse-remote.sh.
The shell code that get_upstream_branch() in this patch implements is:

    0|1)
        origin="$1"
        default=$(get_default_remote)
        test -z "$origin" && origin=$default
        curr_branch=$(git symbolic-ref -q HEAD) &&
        [ "$origin" = "$default" ] &&

^ This here is where it checks to see if the branch's configured
remote matches the remote provided on the command line.

        echo $(git for-each-ref --format='%(upstream)' $curr_branch)
        ;;

^ While here it calls git to get the upstream branch, which is
implemented by branch_get_upstream() on the C side.

So yes, we can use branch_get_upstream(), but we still need to
implement some code on top.

Just to add on, the shell code that get_tracking_branch() in this
patch implements is:

    *)
        repo=$1
        shift
        ref=$1
        # FIXME: It should return the tracking branch
        #        Currently only works with the default mapping
        case "$ref" in
        +*)
        ref=$(expr "z$ref" : 'z+\(.*\)')
        ;;
        esac
        expr "z$ref" : 'z.*:' >/dev/null || ref="${ref}:"
        remote=$(expr "z$ref" : 'z\([^:]*\):')
        case "$remote" in
        '' | HEAD ) remote=HEAD ;;
        heads/*) remote=${remote#heads/} ;;
        refs/heads/*) remote=${remote#refs/heads/} ;;
        refs/* | tags/* | remotes/* ) remote=
        esac
        [ -n "$remote" ] && case "$repo" in
        .)
            echo "refs/heads/$remote"
            ;;
        *)
            echo "refs/remotes/$repo/$remote"
            ;;
        esac

so it's more or less a direct translation of the shell script, and we
can be sure it will have the same behavior. I'm definitely in favor of
switching this to use remote_find_tracking(), the question is whether
we want to do it in this patch or in a future patch on top.

Thanks,
Paul
