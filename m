From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv5 3/3] submodule: Reimplement `module_clone` shell
 function in C
Date: Thu, 3 Sep 2015 19:17:50 -0400
Message-ID: <CAPig+cTjXxo+iD7wkwrmHNQVDDYnqqHPEpVHNdVKCrYohb6adw@mail.gmail.com>
References: <1441230146-26921-1-git-send-email-sbeller@google.com>
	<1441230146-26921-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 01:18:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXdlU-0003zK-0p
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 01:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757110AbbICXRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 19:17:52 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34683 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbICXRv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 19:17:51 -0400
Received: by ykdg206 with SMTP id g206so5077066ykd.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 16:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oETXB+c/sXxCbEzAi4mF8YJXswRT7UaI9UT1C02nMLE=;
        b=rPo78T8QUpgdnQhOrUc/mSUW9ZcaUEBp55kKwADxkuhcaytypG6c4H7AKc9mEhoFtt
         YplnviO2g7hqS3Im0LLFIAvo2yG19dgr/KYypRejW9vZ41dfKberL7rfgIpmTzutvNnx
         Y8lUAmWeNcG/oKePz+Hsr2YAAmWgLO8IpxxCIL2ACeHqPJknM7dxYz7bB+qV0Eyi8AnV
         ZkgEiMZnjrmX2lKjDtAFMXqGyDx20cg754VjOY9QldWeyggebIfLsmIMI20fc1uewCsd
         gm/Y4ETr/gNx9izFafeqcXkUFGE7nElmsAIzLfRpksPC2seyQEOD/jgzykT5Iro0mZJo
         cvYA==
X-Received: by 10.13.201.130 with SMTP id l124mr575101ywd.39.1441322271036;
 Thu, 03 Sep 2015 16:17:51 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Thu, 3 Sep 2015 16:17:50 -0700 (PDT)
In-Reply-To: <1441230146-26921-4-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 2dNvzRP85cwumB_wNqdWClOpJN4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277281>

On Wed, Sep 2, 2015 at 5:42 PM, Stefan Beller <sbeller@google.com> wrote:
> This reimplements the helper function `module_clone` in shell
> in C as `clone`. This functionality is needed for converting
> `git submodule update` later on, which we want to add threading
> to.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> +static int module_clone(int argc, const char **argv, const char *prefix)
> +{
> +       /* Write a .git file in the submodule to redirect to the superproject. */
> +       if (safe_create_leading_directories_const(path) < 0)
> +               die(_("could not create directory '%s'"), path);
> +
> +       if (path && *path)
> +               strbuf_addf(&sb, "%s/.git", path);
> +       else
> +               strbuf_addf(&sb, ".git");

Minor: strbuf_addstr(...);

> +       if (safe_create_leading_directories_const(sb.buf) < 0)
> +               die(_("could not create leading directories of '%s'"), sb.buf);
> +       submodule_dot_git = fopen(sb.buf, "w");
> +       if (!submodule_dot_git)
> +               die_errno(_("cannot open file '%s'"), sb.buf);
> +}
