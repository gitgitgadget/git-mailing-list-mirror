From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] revert: Free memory after get_message call
Date: Thu, 11 Aug 2011 14:24:03 -0500
Message-ID: <20110811192403.GF2277@elie.gateway.2wire.net>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 21:24:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrare-0002Mg-KM
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 21:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab1HKTYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 15:24:08 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54540 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab1HKTYH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 15:24:07 -0400
Received: by yxj19 with SMTP id 19so1534650yxj.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 12:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xGk4L4EnQloPlc8z+/tyxQKR7xoxNiCuK6wBHQt6Ak4=;
        b=LACg4Fgo0keS4fx7N4R14fJ7Hy4tTVxBPxVs+LkN5vESeAaJgQxfzShz+c2FkDBHEw
         +Llk/7b75Kq8qEkftGfwn966fXs1/Gskqn59zHKeuFf8xccMH4Z1Wj0ucEam27PvrSG2
         hEZN/Im4Qhgu0eT2+jCrwiUKmPh2/05TPLhGU=
Received: by 10.236.115.226 with SMTP id e62mr53711yhh.222.1313090646584;
        Thu, 11 Aug 2011 12:24:06 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.sbcglobal.net [69.209.69.68])
        by mx.google.com with ESMTPS id f48sm99594yhh.42.2011.08.11.12.24.05
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 12:24:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313088705-32222-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179137>

Ramkumar Ramachandra wrote:

> The format_todo function leaks memory because it forgets to call
> free_message after get_message.  Fix this.
>
> Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

That's "Reported-by", I think. :)

Is this a big leak or a small one?  Is it one-time or in a loop?

> ---
>  builtin/revert.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index a548a14..1a4187a 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -688,6 +688,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
>  			return error(_("Cannot get commit message for %s"), sha1_abbrev);
>  		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
>  	}
> +	free_message(&msg);
>  	return 0;
>  }

I don't see how this could work.  Since there an xmalloc() in each
loop iteration, I would have expected the free() to be in the loop
body, too.
