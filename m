From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] prune-packed: fix a possible buffer overflow
Date: Thu, 19 Dec 2013 07:37:40 +0700
Message-ID: <CACsJy8CxOAY7MSGx45W60i0ETj4mrgh4rVbVBKrBrLck4bahEg@mail.gmail.com>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
 <1387287838-25779-2-git-send-email-mhagger@alum.mit.edu> <CACsJy8DVc4soBrS1RbTLv93b5rere3htyL1DjRw=UcT4zVN9FA@mail.gmail.com>
 <xmqqd2kvmi85.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 01:38:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtRd2-0005uD-2P
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 01:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034Ab3LSAiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 19:38:12 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:36836 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab3LSAiL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 19:38:11 -0500
Received: by mail-qc0-f179.google.com with SMTP id i8so369215qcq.24
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 16:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=evuhM2dqdyCrmqJb8ITszvQRHCa5VqO3Fs/UQd8QojQ=;
        b=Bk3vpBEuzL/SyWOLzTYc/O2/dPkMAnrk7ZJV4TbV87WRJx89+Ah7KjX/T+U+cA2DtN
         o+v9qKBNakY1k8Bo+4d7LZ64pSesQi6gY3fP1V6OSTYyhAIdgYj0LWRkOnak73q3YqBT
         o2OStl57/TGmIVqd8luFif6H74txg6ygJo3yUVfqikRUZRROB9xVwyWHbeEMhW2AsPug
         Wa/kYQ5qHUAPwdol4y3o2rfkhuvSD8G4ArJXLlgUHsEe3lW0cn6avLV9CC6G49CVyDPC
         sLiAQN/1txJ2IkDkSzpIpPc9mQOfj8+wulo7zMD6DB4kFH+dzD3RrJ7WIJt2o/vfnYye
         e75w==
X-Received: by 10.49.15.227 with SMTP id a3mr59273806qed.66.1387413490406;
 Wed, 18 Dec 2013 16:38:10 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Wed, 18 Dec 2013 16:37:40 -0800 (PST)
In-Reply-To: <xmqqd2kvmi85.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239507>

On Wed, Dec 18, 2013 at 1:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Why don't we take this opportunity to replace that array with a
>> strbuf? The conversion looks simple with this function.
>
> Indeed.  Something like this, perhaps?

Yes, looking good.

>  void prune_packed_objects(int opts)
>  {
>         int i;
> -       static char pathname[PATH_MAX];
>         const char *dir = get_object_directory();
> -       int len = strlen(dir);
> +       struct strbuf pathname = STRBUF_INIT;
> +       int top_len;
>
> +       strbuf_addstr(&pathname, dir);
>         if (opts & PRUNE_PACKED_VERBOSE)
>                 progress = start_progress_delay("Removing duplicate objects",
>                         256, 95, 2);
>
> -       if (len > PATH_MAX - 42)
> -               die("impossible object directory");
> -       memcpy(pathname, dir, len);
> -       if (len && pathname[len-1] != '/')
> -               pathname[len++] = '/';
> +       if (pathname.len && pathname.buf[pathname.len - 1] != '/')
> +               strbuf_addch(&pathname, '/');

I see this pattern (add a trailing slash) in a few places too. Maybe
we could make a wrapper for it.
-- 
Duy
