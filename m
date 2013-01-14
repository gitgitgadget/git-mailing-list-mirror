From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/14] imap-send.c: remove msg_data::flags, which was
 always zero
Date: Sun, 13 Jan 2013 21:57:21 -0800
Message-ID: <20130114055721.GD3125@elie.Belkin>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
 <1358141566-26081-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:57:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tud3M-0003TP-85
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab3ANF51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:57:27 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:62564 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab3ANF51 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 00:57:27 -0500
Received: by mail-pb0-f45.google.com with SMTP id mc8so1962555pbc.4
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 21:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Z25mFVS3bvqBrwwmQU/RojtAqZFaTIsHjhIKTT7JDIE=;
        b=rLYfQoP7WhaDS3rCex1Acxc3Hd/TcEIr315RWju8TAEd5XLvTB39uhB/JCql2goNft
         u57//T9BqPnv2rLNMJ1u9Z2eKTincrb1HPrf3vmXg1LE8MbSYoAfWhJ3dYWJK4913a7u
         XGqiRoOnOUb3765JuCxYwvUV6Q9ZLavYZkyilavctk0YRrFqtvzzqwynut/hgPJ7nz4X
         nFrxW66eZ7M8clY9whCRNPiiqBkuEGJWJwI9bBLZcs2wJhOBXuqNuAY0I4jkQyMj4GUr
         Rnech1u7BO4dqQg42eRXBWkC/U9yOX75N/R2msXQhkaTHGY+aMCK6SET3W/rClwz1/Jl
         p1Rg==
X-Received: by 10.66.81.198 with SMTP id c6mr229464436pay.50.1358143046425;
        Sun, 13 Jan 2013 21:57:26 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id w5sm8107933pax.28.2013.01.13.21.57.24
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 21:57:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358141566-26081-2-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213448>

Hi,

Michael Haggerty wrote:

> This removes the need for function imap_make_flags(), so delete it,
> too.
[...]
> --- a/imap-send.c
> +++ b/imap-send.c
[...]
>  	box = gctx->name;
>  	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
>  	cb.create = 0;
> -	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" %s", prefix, box, flagstr);
> +	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\"", prefix, box);

Before this change, the command is

	"APPEND" SP mailbox SP "{" msglen "}" CRLF

.  After this change, it leaves out the space before the brace.  If I
understand RFC3501 correctly, the space is required.  Intentional?

With the below squashed in,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/imap-send.c w/imap-send.c
index 451d5027..f1c8f5a5 100644
--- i/imap-send.c
+++ w/imap-send.c
@@ -1296,7 +1296,7 @@ static int imap_store_msg(struct store *gctx, struct msg_data *msg)
 	box = gctx->name;
 	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
 	cb.create = 0;
-	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\"", prefix, box);
+	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" ", prefix, box);
 	imap->caps = imap->rcaps;
 	if (ret != DRV_OK)
 		return ret;
