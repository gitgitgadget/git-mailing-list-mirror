From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git 1.7.6: Sparse checkouts do not work with directory exclusions
Date: Tue, 20 Sep 2011 16:38:16 +0200
Message-ID: <4E78A558.6090903@drmicha.warpmail.net>
References: <4E77BC36.7060005@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 16:38:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R61Sq-0001c6-CR
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 16:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905Ab1ITOiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 10:38:19 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50643 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751784Ab1ITOiT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 10:38:19 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3743F3EFA9;
	Tue, 20 Sep 2011 10:38:18 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 20 Sep 2011 10:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=0iirovRyiRMEjiVO7uZSDw
	9FEMk=; b=sreZXHJ0qESkYAlXcP1LBEgCyratlZyE0ltXYENV1S4D1Vcq7bs53M
	aPR9wm/DkKVsryxQJsvSrHwAyIGuDHGFLr9F5CrIukASIILTfGtm8R/6zYPpJyRR
	ofAqf5s58M8uYDWWnIAadbDqudXJ8zzuqPmKKKs83TF9aW4mJWXoI=
X-Sasl-enc: baMqeeQM15kK5kAIARCXR2catQwxewJgjskb/Tq5idSZ 1316529497
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 94E389211BD;
	Tue, 20 Sep 2011 10:38:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <4E77BC36.7060005@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181767>

Joshua Jensen venit, vidit, dixit 20.09.2011 00:03:
> Sometime after Git 1.7.3.2, sparse checkouts stopped working for me.  My 
> sparse-checkout file looks something like:
> 
> *
> !DirA/
> !DirB/
> DirC/
> 
> I have restored some lines of code that were removed in November 2010.  
> This resolves the sparse checkout issue for me, but my guess is the 
> solution is not implemented properly.
> 
> Can anyone confirm the issue and describe why those lines were removed?
> 
> Thanks.
> 
> Josh
> 
> ---
>   dir.c |    5 ++++-
>   1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/dir.c b/dir.c
> index 6e4494e..3f057b6 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -507,7 +507,10 @@ int excluded_from_list(const char *pathname,
>               int to_exclude = x->to_exclude;
> 
>               if (x->flags & EXC_FLAG_MUSTBEDIR) {
> -                if (*dtype == DT_UNKNOWN)
> +                if (!prefixcmp(pathname, exclude) &&
> +                    pathname[x->patternlen] == '/')
> +                    return to_exclude;
> +                else if (*dtype == DT_UNKNOWN)
>                       *dtype = get_dtype(NULL, pathname, pathlen);
>                   if (*dtype != DT_DIR)
>                       continue;

That code was in git only between

c84de70 (excluded_1(): support exclude files in index, 2009-08-20)

and

9e08273 (Revert "excluded_1(): support exclude files in index", 2010-11-27)

i.e. after v1.6.4 and before v1.7.3.2

Ccing Duy who will know more.

Michael
