From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] status: don't say 'HEAD detached at HEAD'
Date: Thu, 1 Oct 2015 13:13:19 +0200
Message-ID: <560D154F.9000809@drmicha.warpmail.net>
References: <1443366822-1753-1-git-send-email-Matthieu.Moy@imag.fr>
 <1443366822-1753-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 01 13:13:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhbnx-0005Ng-F7
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 13:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbbJALNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 07:13:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33760 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755560AbbJALNV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Oct 2015 07:13:21 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 4913120189
	for <git@vger.kernel.org>; Thu,  1 Oct 2015 07:13:21 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 01 Oct 2015 07:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=D2JOM7Aojat4aAffPgiayNspegU=; b=L5XUXG
	OiJlAaF2TlDUeBM/ytLjpJCJU3fBRFJTZCQCUKGhdO9QXIerMiqFI4Q1Gz9qDVEo
	JaKx7XMAYbUdpsj3xwb7OPy5NwawUny9jRH42aIvOn1TbU20HRF2O4FdMji/7FGL
	RKXh4IllsYg+Kx6DqnThlFgzxUud58Kwp1XGw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=D2JOM7Aojat4aAf
	fPgiayNspegU=; b=cxQH/yp9/ovydVkeMP2/VRFRkmJzSXtnehTzRZPwkSAlFXA
	AdT8uMUtksv5hHFy6TXhbesNgdXTNmc3JpCfjOEe3lGK9uqda5cb6gGrMF96lUNP
	4gfTjAxIvspjLG04R37XdBNJzLSS3y/oFwg790B1JMy+zW61pWH4jBay3lNc=
X-Sasl-enc: X5kywPT6to043t2T+iXdbGgTOsNDw7pZWt8Lmkh7/+/+ 1443698001
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A75AB68013E;
	Thu,  1 Oct 2015 07:13:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <1443366822-1753-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278891>

Matthieu Moy venit, vidit, dixit 27.09.2015 17:13:
> After using "git checkout --detach", the reflog is left with an entry
> like
> 
>   checkout: moving from ... to HEAD
> 
> This message is parsed to generate the 'HEAD detached at' message in
> 'git branch' and 'git status', which leads to the not-so-useful message
> 'HEAD detached at HEAD'.
> 
> Instead, when parsing such reflog entry, resolve HEAD to the
> corresponding commit in the reflog, so that the message becomes 'HEAD
> detached at $sha1'.
> ---
> Another possible fix is to avoid creating such reflog entry. But
> anyway, this patch remains a good thing to do and it does fix the
> issue.
> 
> I won't have time to work on fixing the reflog soon, but it may be a
> nice microproject.
> 
>  t/t3203-branch-output.sh | 2 +-
>  wt-status.c              | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index bf24dbf..16efe7a 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -106,7 +106,7 @@ EOF
>  	test_i18ncmp expect actual
>  '
>  
> -test_expect_failure 'git branch shows detached HEAD properly after checkout --detach' '
> +test_expect_success 'git branch shows detached HEAD properly after checkout --detach' '
>  	git checkout master &&
>  	cat >expect <<EOF &&
>  * (HEAD detached at $(git rev-parse --short HEAD^0))
> diff --git a/wt-status.c b/wt-status.c
> index c327fe8..3e3b8c0 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1319,6 +1319,12 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
>  	hashcpy(cb->nsha1, nsha1);
>  	for (end = target; *end && *end != '\n'; end++)
>  		;
> +	if (!memcmp(target, "HEAD", end - target)) {
> +		/* HEAD is relative. Resolve it to the right reflog entry. */
> +		strbuf_addstr(&cb->buf,
> +			      find_unique_abbrev(nsha1, DEFAULT_ABBREV));
> +		return 1;
> +	}
>  	strbuf_add(&cb->buf, target, end - target);
>  	return 1;
>  }
> 

Reviewed and compile tested, thanks.

Junio will also want your s-o-by, though ;)

(Typically we don't introduce a failing test separately like 1/2 any
more and do it in 1 patch, but I don't care either way.)

Michael
