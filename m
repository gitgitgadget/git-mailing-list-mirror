From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] "git --literal-pathspecs blame" broken in master
Date: Fri, 25 Oct 2013 11:11:21 +0700
Message-ID: <CACsJy8AYS8VLuuZ_4rVvrG8SV_aq8dtNa0TqfcjEmow05RSP_A@mail.gmail.com>
References: <20131025034947.GA4959@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 06:11:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZYkf-0001RC-4g
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 06:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292Ab3JYELx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 00:11:53 -0400
Received: from mail-qe0-f45.google.com ([209.85.128.45]:41858 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab3JYELw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 00:11:52 -0400
Received: by mail-qe0-f45.google.com with SMTP id 8so2050828qea.4
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Sno75WwPeRDgPrgLuGPoUJ+d61RUiUTUNJWWfkNElYI=;
        b=gnMvEpqV8XEUXd/0JUQJBq7rKvJxVJ8FwKelq51jH+8xG4MXm0Qulhh8cRKEaoCxRX
         qJAinBdhoMbNn+XgUI5uDYdkdKhr90AT67tqmYRMVgd5U8zbwFMI80Jzu0/pyXldmQis
         eTIHiO8sLXiiqQwL6RJu1+GGXim89PpRMFaNL8LVmMfFrH/JVcCNNU35vvVnd25vdR74
         EEfMwq0CTt23GLRboXodbhTVvobXSNSuLPqrwieKZ63L5j1E3cThwMlHdR4Qi3sQSS8F
         np5m8Ln+Fkw7o1kVgLM4ZfmGb3tqi3DvlsxAolsIKcMXp4bRqmmTpu+gv4OxNETH3kzI
         0Tuw==
X-Received: by 10.49.96.225 with SMTP id dv1mr7945560qeb.89.1382674312097;
 Thu, 24 Oct 2013 21:11:52 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Thu, 24 Oct 2013 21:11:21 -0700 (PDT)
In-Reply-To: <20131025034947.GA4959@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236653>

On Fri, Oct 25, 2013 at 10:49 AM, Jeff King <peff@peff.net> wrote:
>   $ git --literal-pathspecs blame ':(foo)bar'
>   fatal: :(foo)bar: pathspec magic not supported by this command: 'literal'
>
> The first one remains good, but the second one is still broken. I
> haven't dug further yet, but I thought it might be a bit more obvious to
> you.

I checked it too strict. Something like this should fix it. I'll post
a patch with tests later

diff --git a/pathspec.c b/pathspec.c
index ad1a9f5..69e4fdb 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -405,7 +405,7 @@ void parse_pathspec(struct pathspec *pathspec,
                item[i].magic = prefix_pathspec(item + i, &short_magic,
                                                argv + i, flags,
                                                prefix, prefixlen, entry);
-               if (item[i].magic & magic_mask)
+               if (item[i].magic & (magic_mask & ~PATHSPEC_LITERAL))
                        unsupported_magic(entry,
                                          item[i].magic & magic_mask,
                                          short_magic);

-- 
Duy
