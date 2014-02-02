From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 3/4] setup: Add 'abspath_part_inside_repo' function
Date: Sun, 2 Feb 2014 09:19:04 +0700
Message-ID: <CACsJy8A8hardH7EaopY2Xu5Ob50mew3pJdqAr6fJsqyyhLQYMg@mail.gmail.com>
References: <20140131202142.GA9731@mule> <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391306351-13237-4-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, richih@debian.org,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 02 03:20:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9mfE-0003EC-LL
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 03:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbaBBCTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Feb 2014 21:19:36 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:38586 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbaBBCTf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Feb 2014 21:19:35 -0500
Received: by mail-qc0-f170.google.com with SMTP id e9so9499800qcy.1
        for <git@vger.kernel.org>; Sat, 01 Feb 2014 18:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mOs0JWqB8faY1/Oq1q5HzrcU8tGD98A/4Peb2V41BFI=;
        b=W39S0oUTZtkG6Ij+NP5RJaSpc4pzjz85djjva9vFKAnFNWirqmQp6JEik6ig3EVBpQ
         F1MpweShO4kG2TJlHAO4if1ZBNw406A6NusCjt8MaaOtdN8jXjY95/1S1Yp6JdP7e6RH
         JgRaTIvAdjj6q4oI+sVCqK17A39m8PP42fcESI8fsuQGAo+YpvjZj6WG48XL+n9SQe6V
         65QBYJCnRvZokPmd6tDpiSh7uRtOwBbtoiteugwKxyuH98cx/YEG8rxoVBuiZqRULetY
         YuQrM8w/gwbjF87L7tqUdJ0JXyjIq3v9qa7aEFxOFz9gMIOwgontDcKgrU2wjr9OVar8
         N68Q==
X-Received: by 10.140.40.5 with SMTP id w5mr42211047qgw.65.1391307574990; Sat,
 01 Feb 2014 18:19:34 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sat, 1 Feb 2014 18:19:04 -0800 (PST)
In-Reply-To: <1391306351-13237-4-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241351>

On Sun, Feb 2, 2014 at 8:59 AM, Martin Erik Werner
<martinerikwerner@gmail.com> wrote:
> +       /* check if work tree is already the prefix */
> +       if (strncmp(path, work_tree, wtlen) == 0) {
> +               if (path[wtlen] == '/')
> +                       memmove(path, path + wtlen + 1, len - wtlen);
> +               else
> +                       /* work tree is the root, or the whole path */
> +                       memmove(path, path + wtlen, len - wtlen + 1);
> +               return 0;
> +       }

No the 4th time is not the charm yet :) if path is "/abc/defghi" and
work_tree is "/abc/def" you don't want to return "ghi" as the prefix
here.

> +       path0 = path;
> +       path += offset_1st_component(path);
> +
> +       /* check each level */
> +       while (*path != '\0') {
> +               path++;

To me it looks like we could write

for (; *path; path++) {

or even

for (path += offset_1st_component(path); *path; path++) {

but it's personal taste..

> +               if (*path == '/') {
> +                       *path = '\0';
> +                       if (strcmp(real_path(path0), work_tree) == 0) {
> +                               memmove(path0, path + 1, len - (path - path0));
> +                               return 0;
> +                       }
> +                       *path = '/';
> +               }
> +       }
> +
> +       /* check whole path */
> +       if (strcmp(real_path(path0), work_tree) == 0) {
> +               *path0 = '\0';
> +               return 0;
> +       }

I think this is already handled by the "check if work tree is already
the prefix" block.

> +
> +       return -1;
> +}
> +
> +/*
>   * Normalize "path", prepending the "prefix" for relative paths. If
>   * remaining_prefix is not NULL, return the actual prefix still
>   * remains in the path. For example, prefix = sub1/sub2/ and path is
> --
> 1.8.5.2
>



-- 
Duy
