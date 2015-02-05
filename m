From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 1/2] Makefile: Use the same source directory for "ln -s" as for "ln" / "cp"
Date: Thu, 5 Feb 2015 09:48:41 -0800
Message-ID: <D060A1E5-DAF3-49D5-B0B3-F831BCDFD41F@gmail.com>
References: <CAHGBnuOGv4Zn7dz6voEMn=PtMfm=0TQumt9PxV9nYgXyB0Xj=g@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 18:49:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJQY2-0002X2-EC
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 18:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbbBERs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 12:48:58 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:41006 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbbBERsp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 12:48:45 -0500
Received: by pdiy13 with SMTP id y13so9092917pdi.8
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 09:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=o9s3WGDwYtrm8QXysbwaCzJCocWka2Ez0DFE3K1ZDog=;
        b=LvpsewqGbYhDmBV9nStlb6FR/NMmLsc38Z/On6EX1YTeGbJUhdyssubwp9GvGNR9td
         HjbRlLaYg1RGJfviO2RXkEMX0Sv3ddJkCUItvaVrpko6nKk8HdMFmtv17Kb/sMOUv1FA
         iKssDBJ90a/YymL/Yf9ljp7E5sa2w73JbTNpPXeZ0hDtaAejo2FwblknTEz0ipqWBhYS
         MXqvxt+y8V3PvYlLy/nLhnoDsbiB/lsMZTOQnnlQvvkUqoeEkiolzk8ScsIhK5n08Vri
         9ZncaSWmMT0JkbzThrSeqPqfmfYTvXmuzMrXevY+SRZ/aI8txCde50qf+fHqBaFfSPCA
         wwzw==
X-Received: by 10.66.62.229 with SMTP id b5mr7797773pas.30.1423158524800;
        Thu, 05 Feb 2015 09:48:44 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id dh1sm5682312pbc.24.2015.02.05.09.48.43
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Feb 2015 09:48:44 -0800 (PST)
In-Reply-To: <CAHGBnuOGv4Zn7dz6voEMn=PtMfm=0TQumt9PxV9nYgXyB0Xj=g@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263380>

On Feb 5, 2015, at 07:51, Sebastian Schuberth wrote:
> For consistency, we should use the same source for symbolic links as  
> for
> hard links and copies.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
> Makefile | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c44eb3a..21f23cb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2265,14 +2265,14 @@ endif
>         $(RM) "$$bindir/$$p" && \
>         test -z "$(NO_INSTALL_HARDLINKS)" && \
>         ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
> -        ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
> +        ln -s "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \

This is wrong.

Currently with symlinks you will get installed into bindir something  
like this:

   git
   git-tag -> git
   git-show -> git

etc.

With your change you would have

   git
   git-tag -> /usr/local/libexec/git-core/git
   git-show -> /usr/local/libexec/git-core/git

And I don't think we want that.  While those absolute path symlinks  
are technically correct, what we have now is much simpler.  While  
there are a number of build-time paths hard-coded into the  
executables, the binaries work for the most part if you relocate them  
as a whole.  Your change totally breaks that.

-Kyle
