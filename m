From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git add <single file> and git add <list of files> behave differentely
 for ignored files
Date: Thu, 04 Dec 2014 16:02:21 +0100
Message-ID: <5480777D.6000205@drmicha.warpmail.net>
References: <CAMDzUtzQJoEi17OfX8FPOV6SDJ_ytJSH-YTKx2DtUON35-EVSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Guilherme <guibufolo@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 16:02:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwXvH-0006PY-Gl
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 16:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030AbaLDPCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 10:02:23 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34951 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753832AbaLDPCX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 10:02:23 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 6B7CF20947
	for <git@vger.kernel.org>; Thu,  4 Dec 2014 10:02:22 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 04 Dec 2014 10:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=afRlIZDdQQU6KK/LtZAzFe
	zEwek=; b=C8JiCoSckPH5ogBfAH1l5iSwWxc5cVqTCM6F86UKyPuia+FE5H9EiQ
	FkRjZdP486nl6ICdy6RNPHxRu5nJKtO44pxNR/puYfzYge52qKp0cHVqVrlDtERg
	B1gOwhcVfLYcv2F2tEtQ9TF9IR5+rgQPwbP4qofc+fGyYyKwyfbsE=
X-Sasl-enc: PkygyslhreIgjuwMhu69i+CFg6jE+eWQ/NBLmSalRYjq 1417705342
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E8E31C0027F;
	Thu,  4 Dec 2014 10:02:21 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAMDzUtzQJoEi17OfX8FPOV6SDJ_ytJSH-YTKx2DtUON35-EVSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260759>

Guilherme schrieb am 04.12.2014 um 10:06:
> Hello,
> 
> I reported this issue on the git-user mailing list and they redirected me here.
> 
> The problem I have observed is that with a ignored path `git add
> <single file>` behaves differently then `git add <list of files>`.
> 
> I my git/info/excludes file i have
> 
> /COM/config
> !COM/config/Project.gny
> 
> The file COM/config/Project.gny has already been added to the
> repository via `git add -f`.
> 
> When doing
> 
>     git add -- COM/config/Projec.gny
> 
> git will not complain but when doing
> 
>     git add -- COM/config/Project.gny otherfiles.c
> 
> it will report:
> 
>     The following paths are ignored by one of your .gitignore files:
>     COM/config
>     Use -f if you really want to add them.
>     fatal: no files added

This is because git add assumes you specified on of the files in error,
and thus refuses to add the other one, too.

I found that behaviour surprising. There's already a patch which, in the
2nd case, would make "git add" only warn you about the ignored file but
add the other one anyways. It will probably make its way into the next
release.

For the case of a single file (or rather: ignored files only) I'm
wondering whether we should issue a warning, too.

> This odd behaviour is also present in `git check-ignore`.
> 
> Before adding the file `git check-ignore` correctly reports the file
> as ignored. After having added it via `git add -f` it won't report it
> as ignored anymore.

This is different: Once a file is "added", it is not ignored any more -
you explicitely told git to track that file (rather than ignoring it).
So, the output of git check-ignore is correct.

> Even if not a bug this behaviour is inconsistent and might want to be
> addressed as it makes scripting a little bit harder.
> 
> Thank you.
> 

I guess you want "git check-ignore --no-index". That man page may be a
bit misleading - the description sounds as if only the patterns would
matter.

Michael
