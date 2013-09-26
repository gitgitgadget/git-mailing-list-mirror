From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] repack: Add --version parameter
Date: Thu, 26 Sep 2013 18:42:10 +0700
Message-ID: <CACsJy8BjTQhA6rDWk6FboxU-b6d93Jn+ZNvQ0DJYXehgrpSmwg@mail.gmail.com>
References: <1380162409-18224-10-git-send-email-pclouds@gmail.com> <1380184349-26380-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 13:42:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP9y1-0006oA-SL
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 13:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696Ab3IZLml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 07:42:41 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:49500 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353Ab3IZLmk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 07:42:40 -0400
Received: by mail-oa0-f46.google.com with SMTP id k14so514483oag.33
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=t7LnNEE6LQqybqPl9rMVKRntpdrFH8X5q4kAiwV3Nd4=;
        b=Gj4iF6c8rMOI+ZtPiUmn6rXS9/qEzfDsJdwNihepu4bJOiu80OhHOsV7ZY6rh4qtjU
         5ipQLWaKRk0v3eXbzzCZEFCzNOMv+h9k/C+JtVq0sBGMKgEF1odwlXqWkPDovx9Jv/Ue
         GEuVqL9gV0HsBoMDZE86ZBQve9uXlmcnOOPlLk0l6A2cQic4MM528VjszZ/CAs6SUxNq
         5X8UxdILJpN60zE5u+SfqlaFRJ9e2ASZVXXugqMOU3gzPSMdiLD1xOBVk3xkY0zq8hXh
         H8qHSBoLyVzo2IT9jIgJ/1OeKNFvZP6p4Gsn6rL6uoRinHWs3RJLSN9PgyAdF9qyNpIo
         64Qg==
X-Received: by 10.60.141.225 with SMTP id rr1mr301968oeb.55.1380195760312;
 Thu, 26 Sep 2013 04:42:40 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Thu, 26 Sep 2013 04:42:10 -0700 (PDT)
In-Reply-To: <1380184349-26380-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235417>

On Thu, Sep 26, 2013 at 3:32 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> This is just a direct translation of
> http://article.gmane.org/gmane.comp.version-control.git/235396
> So I don't consider this is ready for inclusion.
>
> Some notes:
> We need to have more error checking, repack shall be 0, 2 or 4 but nothing
> else. If 0 is given, no argument is passed to pack-objects, in case of
> 2 or 4 --version=<n> is passed.

It's not that bad. If you don't catch it, pack-objects will.

>
> Do we really want to call it "--version"? This parameter sounds so much
> like questioning for the program version, similar to
>         git --version
>         1.8.4
> So I'd rather use "--repack-version".

Hmm.. I think it's "git repack --pack-version"? Or if you meant "git
pack-objects --version", I drop the "pack-" out because there's
already "pack" in "pack-objects". But I'm OK renaming --version to
--pack-version too. Maybe later.

> @@ -22,6 +23,9 @@ static int repack_config(const char *var, const char *value, void *cb)
>                 delta_base_offset = git_config_bool(var, value);
>                 return 0;
>         }
> +       if (!strcmp(var, "core.preferredPackVersion")) {
> +               pack_version = git_config_int(var, value);
> +       }
>         return git_default_config(var, value, cb);

In np/pack-v4 series (not the one on 'pu' yet) git_default_config will
do this and save the value in core_default_pack_format. So you don't
need to set it here.

> @@ -220,6 +226,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>                 argv_array_push(&cmd_args,  "--quiet");
>         if (delta_base_offset)
>                 argv_array_push(&cmd_args,  "--delta-base-offset");
> +       if (pack_version)
> +               argv_array_pushf(&cmd_args, "--version=%u", pack_version);

but then you may need "if (!pack_version) pack_version =
core_defaul_pack_format;" before this "if".

>
>         argv_array_push(&cmd_args, packtmp);
-- 
Duy
