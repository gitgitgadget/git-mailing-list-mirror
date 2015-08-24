From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] write_file(): introduce an explicit WRITE_FILE_GENTLY request
Date: Mon, 24 Aug 2015 11:41:27 -0700
Message-ID: <xmqqh9no4jhk.fsf@gitster.dls.corp.google.com>
References: <20150824065033.GA4124@sigill.intra.peff.net>
	<1440436186-7894-1-git-send-email-gitster@pobox.com>
	<1440436186-7894-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 20:41:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTwgY-00058s-I1
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 20:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbbHXSla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 14:41:30 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33548 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbbHXSl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 14:41:29 -0400
Received: by pdrh1 with SMTP id h1so57426817pdr.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+il4hsb0iNY5MEdHwwl1x4zKPQnwGaZAf9sGwfFQFcY=;
        b=v8y1C719rLOtXPnsdDxrb6alap7mCH8FJho/SaIHeIjTyxMitSTE+x7bkzipao3PQL
         CdWCCTDWExGin9aBIJivYQGyDUZlA1iRQr7TnXL1T8dViojaX4ncQyJ3sBC9PobbaGJ0
         d5Qg2YFGUE12m4pDknHVc6KparwmOCY3CnCicHb7ecipYAtHQ2zRawlkvIVHeTLk7uK5
         fcp/5ytnHUSO96EGaXCBwV7kxUc5aojBbTirGhqxWMLUTSpXUJK/F9RHWPEPZgZ1FHoA
         tsfDk8VJnaN0D70w+ukKhJHL0ZzTYYgr/tnRx0AZTUiVNB3zXmsZXRVZvnxVfTBdEUHb
         6CfA==
X-Received: by 10.70.100.165 with SMTP id ez5mr47722956pdb.106.1440441688913;
        Mon, 24 Aug 2015 11:41:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id pm5sm414618pdb.53.2015.08.24.11.41.28
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 11:41:28 -0700 (PDT)
In-Reply-To: <1440436186-7894-4-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Mon, 24 Aug 2015 10:09:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276476>

Junio C Hamano <gitster@pobox.com> writes:

> All callers except for two ask this function to die upon error by
> passing fatal=1; turn the parameter to a more generic "unsigned flag"
> bag of bits, introduce an explicit WRITE_FILE_GENTLY bit and change
> these two callers to pass that bit.

There is a huge iffyness around one of these two oddball callers.

> diff --git a/setup.c b/setup.c
> index 5f9f07d..718f4e1 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -404,7 +404,7 @@ static void update_linked_gitdir(const char *gitfile, const char *gitdir)
>  
>  	strbuf_addf(&path, "%s/gitfile", gitdir);
>  	if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NULL))
> -		write_file(path.buf, 0, "%s\n", gitfile);
> +		write_file(path.buf, WRITE_FILE_GENTLY, "%s\n", gitfile);
>  	strbuf_release(&path);
>  }

This comes from 23af91d1 (prune: strategies for linked checkouts,
2014-11-30).  I cannot tell what the justification is to treat a
failure to write a gitfile as a non-error event.  Just a sloppy
coding that lets the program go through to its finish, ignoring the
harm done by possibly corrupting user repository silently?

> diff --git a/transport.c b/transport.c
> index 40692f8..e1821a4 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -291,7 +291,7 @@ static int write_one_ref(const char *name, const struct object_id *oid,
>  
>  	strbuf_addstr(buf, name);
>  	if (safe_create_leading_directories(buf->buf) ||
> -	    write_file(buf->buf, 0, "%s\n", oid_to_hex(oid)))
> +	    write_file(buf->buf, WRITE_FILE_GENTLY, "%s\n", oid_to_hex(oid)))
>  		return error("problems writing temporary file %s: %s",
>  			     buf->buf, strerror(errno));
>  	strbuf_setlen(buf, len);

This one is OK, in that it is merely to give a better error
diagnosis than just "oh, I cannot write so I die".
