From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] xdiff: optimise for no whitespace difference when ignoring
 whitespace.
Date: Mon, 05 Jul 2010 10:34:57 +0200
Message-ID: <4C319931.4020603@drmicha.warpmail.net>
References: <1278310017-24299-1-git-send-email-dgreid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dylan Reid <dgreid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 10:36:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVh9t-0000Vn-7P
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 10:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab0GEIfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 04:35:54 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33725 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751819Ab0GEIfx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 04:35:53 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 86AE91155E6;
	Mon,  5 Jul 2010 04:35:49 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 05 Jul 2010 04:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=o5JQsSWlFKv1taXJ8eWmVTtNKTM=; b=I74XrQeEbCE8WjYaBeO5ThL/Jq2iTMrpPFiHr/Velh3v4aO2AQEawy6WoQIetMRkRGUqZ0VJcGf0aeeS+Fp6OH9Uu8pmO3BBXPO8nWWFwdvcLQs/QhDPKLuzfo1L7nMI6fMdxrysGsyRuk7ShsdiKVBe4OXIuSB+Pj57VQL7fmc=
X-Sasl-enc: ZkAzFdNU8QVtgi5ABBkmOZMYXRJGhI5T5O7gfLAA2Etr 1278318949
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E883D6C780;
	Mon,  5 Jul 2010 04:35:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <1278310017-24299-1-git-send-email-dgreid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150250>

Dylan Reid venit, vidit, dixit 05.07.2010 08:06:
> Invert the order of the memcmp and flag check are done in xdl_recmatch,

I was wondering whether you describe old (before patch) or new (after
patch) here. Maybe one of the following is clearer:

"Invert the order of the memcmp and flag check which are done in
xdl_recmatch,"

"Invert the order of the memcmp and flag check in xdl_recmatch,"

> as it makes the common case (there is no whitespace difference) faster.
> It costs the case where lines are the same length and contain
> whitespace differences, but the common case is more than 20% faster.
> 
> Signed-off-by: Dylan Reid <dgreid@gmail.com>
> ---
>  xdiff/xutils.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index bc12f29..dc97a21 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -190,8 +190,10 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
>  {
>  	int i1, i2;
>  
> -	if (!(flags & XDF_WHITESPACE_FLAGS))
> -		return s1 == s2 && !memcmp(l1, l2, s1);
> +	if (s1 == s2 && !memcmp(l1, l2, s1))
> +		return 1;
> +	else if (!(flags & XDF_WHITESPACE_FLAGS))

You can do without the "else" here.

> +		return 0;
>  
>  	i1 = 0;
>  	i2 = 0;

BTW: How did you find this? Are you profiling parts of git?

Michael
