From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 7/8] reflog_expire(): never update a reference to null_sha1
Date: Mon, 9 Feb 2015 15:55:17 -0500
Message-ID: <CAPig+cTksvo2A9nazpeg=BThOSPv7DsJ6hz51h=U_yvSNBGn5A@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 21:55:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKvMZ-0002ne-A4
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 21:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759318AbbBIUzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 15:55:19 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:65461 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbbBIUzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 15:55:17 -0500
Received: by mail-yh0-f53.google.com with SMTP id v1so13078604yhn.12
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 12:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6K3u6LWQcpiiVCrMYqzGdAAOgOiLUEtDRCoxUNwdme4=;
        b=A7fCD1So99nv9hzJy72nMHa0u3lVdS4i99GkpGHu53TWynXpXHFsNlg9NvvA5oQ8N8
         QT8MuWDVBvyt3Qs+081uZtt6GOO87zWxmKwVX+9e81lz2UGsaOu6zvuEx6aPrcOiSc5o
         nxUY9cA3odzPNMoeuxAIKpXO39amzJIlZj1GIWw5OVHkZUmt8Ir0dwG7/xv2UafeXX/J
         FGsH3t98Xrq+F0poiq9TiHporKaREVPyk8Y2OE+lhkI2BElTWTABXFNWpNL7/WrPNUPI
         GIPCV9AVpUjp4zgMiF38+K9omGF9zRewc8cOVfozP1dAu3yJ9uyE/Mwz5ML0DYwiBm6d
         EJnQ==
X-Received: by 10.170.188.10 with SMTP id f10mr8238221yke.22.1423515317167;
 Mon, 09 Feb 2015 12:55:17 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 9 Feb 2015 12:55:17 -0800 (PST)
In-Reply-To: <1423473164-6011-8-git-send-email-mhagger@alum.mit.edu>
X-Google-Sender-Auth: 2gaoKPbqBo-Sc74blBRjF1D55xU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263596>

On Mon, Feb 9, 2015 at 4:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Currently, if --updateref is specified and the very last reflog entry
> is expired or deleted, the reference's value is set to 0{40}. This is
> an invalid state of the repository, and breaks, for example, "git
> fsck" and "git for-each-ref".
>
> The only place we use --updateref in our own code is when dropping
> stash entries. In that code, the very next step is to check if the
> reflog has been made empty, and if so, delete the "refs/stash"
> reference entirely. Thus that code path ultimately leaves the
> repository in a valid state.
>
> But we don't want the repository in an invalid state even temporarily,
> and we don't want leave an invalid state if other callers of "git

s/want/want to/

> reflog expire|delete --updateref" don't think to do the extra cleanup
> step.
>
> So, if "git reflog expire|delete" leaves no more entries in the
> reflog, just leave the reference un-updated.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
