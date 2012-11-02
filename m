From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v4 09/14] remote-testgit: report success after an import
Date: Fri, 02 Nov 2012 14:58:43 +0100
Message-ID: <5093D193.3030108@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com> <1351821738-17526-10-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 14:59:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUHm4-0004l0-HX
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 14:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757895Ab2KBN6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 09:58:51 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59616 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab2KBN6u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 09:58:50 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1394621bkc.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=AHhV8UJdP/PWWGiXPzzU1iKL5fDIc9vIXfwQ/b7K2sM=;
        b=gPBtfG2Yox1D2JOM7UubjloBI7hmqHfdJ4VdLu77p4ktsFCnR59+zNUJwfExf4F0ZV
         7jPeQ42v54xKID/eknhhbr196sTx6+3TVY9h1YVLF9Ep4mPE3QgVAI+xYa86BGrJgOsX
         bffFs63irgCr/zq9VxZfBJrFQ+GWCG8tp4VCiZgD9V9daHT/m/YZ3RWWBYOeEsgfAKoh
         sFHTEeHW/OABJhJvUKyAO6mCMKkKtstU4RC2XOXEViaYshZF7FtoYDvdW72qsBTjFsJl
         HOG/VBFDWjPBd5KLvk9qm8nIeYTBMkRZebvGNBO4tFSM0rsnyJWykCkM9EcwS69Al2J5
         U8zg==
Received: by 10.205.136.2 with SMTP id ii2mr410299bkc.114.1351864729566;
        Fri, 02 Nov 2012 06:58:49 -0700 (PDT)
Received: from [192.168.178.21] (host247-100-dynamic.8-87-r.retail.telecomitalia.it. [87.8.100.247])
        by mx.google.com with ESMTPS id j24sm6691737bkv.0.2012.11.02.06.58.46
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Nov 2012 06:58:48 -0700 (PDT)
In-Reply-To: <1351821738-17526-10-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208934>

On 11/02/2012 03:02 AM, Felipe Contreras wrote:
> Doesn't make a difference for the tests, but it does for the ones
> seeking reference.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-remote-testgit | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/git-remote-testgit b/git-remote-testgit
> index 6c348b0..4e8b356 100755
> --- a/git-remote-testgit
> +++ b/git-remote-testgit
> @@ -59,7 +59,18 @@ while read line; do
>              sed -e "s#refs/heads/#${prefix}/heads/#g"
>          ;;
>      export)
> +        declare -A before after
> +
If you convert this script to be a valid POSIX shell script (as I've
suggested in my reply to [PATCH v4 04/14]), you'll need to get rid of
this bashism (and those below) as well.

> +        eval $(git for-each-ref --format='before[%(refname)]=%(objectname)')
> +
>          git fast-import --{import,export}-marks="$testgitmarks" --quiet
> +
> +        eval $(git for-each-ref --format='after[%(refname)]=%(objectname)')
> +
> +        for ref in "${!after[@]}"; do
> +            test "${before[$ref]}" ==  "${after[$ref]}" && continue
> +            echo "ok $ref"
> +        done
>          echo
>          ;;
>      '')

Regards,
  Stefano
