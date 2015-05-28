From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] config.c: rewrite ENODEV into EISDIR when mmap fails
Date: Thu, 28 May 2015 10:11:55 -0700
Message-ID: <xmqq7frsiq3o.fsf@gitster.dls.corp.google.com>
References: <20150528075142.GB3688@peff.net> <20150528080300.GD23395@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 28 19:12:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy1Le-0006Nc-7y
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 19:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbbE1RL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 13:11:58 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34747 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbbE1RL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 13:11:57 -0400
Received: by ieczm2 with SMTP id zm2so43561937iec.1
        for <git@vger.kernel.org>; Thu, 28 May 2015 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=BDkSNHpk0pqz8H+Y5vnUBBuIBnHLvZ7XTEVQIa/0HrU=;
        b=ce+O5nvgs2m7R8EK7ZGEb9cU5+vg2+q3c0xZcI2u3MCpmNYI0NopwHZeNVTXh8ISOd
         /fsmVzFxpGYQctisEI07xHzDJH5NZXect1ey39iE7qqDyzMhVAfBqf0n3rIzeM5tullW
         rz7dRUKNT5Uz4Qa/CP8BkQfiLgqN84XgBR8tOTuEeGcmUrn01K/1mEjZxT5P/C63u/nW
         mca97v8w6hCprVITiHZiHQCGF51QeqjwdnnAiZW3UAehttHIgcHIrmp05ggVvBt1ijIA
         nfEywyx2Nm1r+Gkzdbg9TWTMYf0y7IcTNuXKugWCGPEjFSuhJFZGsUj6adi0s7pn7w+Z
         Hezg==
X-Received: by 10.50.61.130 with SMTP id p2mr968482igr.9.1432833116479;
        Thu, 28 May 2015 10:11:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id 191sm2181792iof.18.2015.05.28.10.11.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 10:11:55 -0700 (PDT)
In-Reply-To: <20150528080300.GD23395@peff.net> (Jeff King's message of "Thu,
	28 May 2015 04:03:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270162>

Jeff King <peff@peff.net> writes:

> If we try to mmap a directory, we'll get ENODEV. This
> translates to "no such device" for the user, which is not
> very helpful. Since we've just fstat()'d the file, we can
> easily check whether the problem was a directory to give a
> better message.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> It feels a bit wrong to put this magic conversion here, and not in
> xmmap. But of course xmmap does not have the stat information.
> ...
> diff --git a/config.c b/config.c
> index e7dc155..29fa012 100644
> --- a/config.c
> +++ b/config.c
> @@ -2056,6 +2056,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
>  		contents = xmmap_gently(NULL, contents_sz, PROT_READ,
>  					MAP_PRIVATE, in_fd, 0);
>  		if (contents == MAP_FAILED) {
> +			if (errno == ENODEV && S_ISDIR(st.st_mode))
> +				errno = EISDIR;
>  			error("unable to mmap '%s': %s",
>  			      config_filename, strerror(errno));
>  			ret = CONFIG_INVALID_FILE;

I think this patch places the "magic" at the right place, but I
would have preferred to see something more like this:

	if (contents == MAP_FAILED) {
        	if (errno == ENODEV && S_ISDIR(st.st_mode))
			error("unable to mmap a directory '%s',
                        	config_filename);
		else
                	error("unable to mmap '%s': %s",
                        	config_filename, strerror(errno));
		ret = CONFIG_INVALID_FILE;

But that is a very minor preference.  I am OK with relying on our
knowledge that strerror(EISDIR) would give something that says "the
thing is a directory which is not appropriate for the operation", as
nobody after that strerror() refers to 'errno' in this codepath.

Thanks.  The patches were a pleasant read.
