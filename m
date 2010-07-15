From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/8] Add infrastructure to write revisions in
 fast-export format
Date: Thu, 15 Jul 2010 14:28:39 -0500
Message-ID: <20100715192839.GD2774@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <1279210984-31604-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 21:29:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZU7o-0003jf-3v
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 21:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934473Ab0GOT3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 15:29:33 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53018 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934378Ab0GOT3d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 15:29:33 -0400
Received: by ewy23 with SMTP id 23so364297ewy.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+5F0UjxDokN5Z4qbBHs2zCbZfknn9HnNWo3qTwGKCzE=;
        b=x3mJAbCDAwacqJv0j7qolCIAQvpaOyheOJEkr9yTkc6MfPI5nDyK7Vt2O43BPOXIdO
         23yZCkZwyGA/WPdxBMiKLs7MCWBv3JuvdO2Gjtd73Qi9Kv7xiUeso7wmzap407GJuQDo
         ZETu11jQYyfhnQTY9Bx3at5CxwBwV810vHA8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZV2ecK1FaRx6RZ18pBnyj4pgp0si2m76HL4pH/EeJoS0y3kq/KlWwKcFRt9razwRhl
         d+opEnzRwYTAtqr/axoXuDSR7avUFDJXm7hbEOc97rjhg1Zz6AkL9pYfpKq3Z6YWVx2h
         428MNCm0A4DvRpxCU6l5S7mtld5ZmlF6F1oW4=
Received: by 10.213.16.143 with SMTP id o15mr3454722eba.0.1279222171476;
        Thu, 15 Jul 2010 12:29:31 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id x54sm10661996eeh.23.2010.07.15.12.29.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 12:29:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279210984-31604-8-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151116>

Ramkumar Ramachandra wrote:

> diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
> new file mode 100644
> index 0000000..7552803
> --- /dev/null
> +++ b/vcs-svn/fast_export.c
> @@ -0,0 +1,75 @@
[...]
> +void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
> +                        uint32_t mark)
> +{
> +	/* Mode must be 100644, 100755, 120000, or 160000. */
> +	printf("M %06o :%d ", mode, mark);

David tweaked the API nicely upstream to enforce this constraint.  So
nice things will come with the next pull from him.

> diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
> new file mode 100644
> index 0000000..47e8f56
> --- /dev/null
> +++ b/vcs-svn/fast_export.h
> @@ -0,0 +1,14 @@
> +#ifndef FAST_EXPORT_H_
> +#define FAST_EXPORT_H_
> +
> +#include <stdint.h>
> +#include <time.h>

The usual convention within git is to rely on .c files to include
git-compat-util.h (indirectly through cache.h or directly).

> +/* Memory pools for commit, dir and dirent */
> +obj_pool_gen(commit, struct repo_commit, 4096);
> +obj_pool_gen(dir, struct repo_dir, 4096);
> +obj_pool_gen(dirent, struct repo_dirent, 4096);

Are the semicolons necessary?  (A nitpick, I know).

That said, this part is looking pretty good.
