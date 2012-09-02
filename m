From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 9/9] Add git-check-ignores
Date: Sun, 2 Sep 2012 17:41:21 +0700
Message-ID: <CACsJy8CLzTddPOCzGhNkOGYjTvEtgWFoD+6DLhAew4Rf1aw5WA@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org> <1346544731-938-10-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 12:43:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T87dq-0003Up-Uz
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 12:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055Ab2IBKmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 06:42:24 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61220 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051Ab2IBKlx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 06:41:53 -0400
Received: by ieje11 with SMTP id e11so2759260iej.19
        for <git@vger.kernel.org>; Sun, 02 Sep 2012 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7VjrixRd5NwS3SdpiRd0AczRJGPqZ3znKYnUFf3vqL8=;
        b=dQ2rU/ElHSxZJyBwuG6saq31PDrbJGR6M9UW9XuDki2Vl9H2IbAYUkJzBzKyRLxPFB
         CPZYw6ljWrIVpL8uh95fki5RQ6j2sWjikYS2vnyCdPtjzgC7cCGMX0TzwTLLaiknAGbW
         Yjbio5Kbf6LWaaHeR/vAPvsx3Ac5Gwf/CJJXSaw+vjVxS6HXcfJ1PIPEewJswTILl9TN
         rv2ylH+euaWkhH/yjyUUfRsdkV1TK0zapgaARy6VHpS1+OQDQB9XeRZ2EJXrHylZPHz0
         J2LCJjYlsnzE9nEm5P9vnySTBT09+5/Cu7Oy92AhP7GeY82n7wXRf+xglRx8Q4HRS+W/
         P4Rg==
Received: by 10.50.214.1 with SMTP id nw1mr7879242igc.2.1346582512223; Sun, 02
 Sep 2012 03:41:52 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Sun, 2 Sep 2012 03:41:21 -0700 (PDT)
In-Reply-To: <1346544731-938-10-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204665>

On Sun, Sep 2, 2012 at 7:12 AM, Adam Spiers <git@adamspiers.org> wrote:
> This works in a similar manner to git-check-attr.  Some code
> was reused from add.c by refactoring out into pathspec.c.

Thanks, comments from a quick glance. First of all, can we make it
work (or share code) with .gitattributes? We may need to debug
.gitattributes as well as .gitignore. A common command would be nice.

> +SYNOPSIS
> +--------
> +[verse]
> +'git check-ignore' pathname...
> +'git check-ignore' --stdin [-z] < <list-of-paths>

Also --quiet option, where check-ignore returns 0 if the given path is
ignored, 1 otherwise?

> +OUTPUT
> +------
> +
> +The output is a series of lines of the form:
> +
> +<path> COLON SP <type> SP <pattern> SP <source> SP <position> LF
> +
> +<path> is the path of a file being queried, <type> is either
> +'excluded' or 'included' (for patterns prefixed with '!'), <pattern>
> +is the matching pattern, <source> is the pattern's source file (either
> +as an absolute path or relative to the repository root), and
> +<position> is the position of the pattern within that source.

I think we should have a few levels of verbosity.

 - The --quiet I already mention above.
 - If many paths are given, then perhaps we could print ignored paths
(no extra info).
 - Going to the next level, we could print path and the the location
of the final exclude/include rule (file and line number).
 - For debugging, given one path, we print all the rules that are
applied to it, which may help understand how/why it goes wrong.

> @@ -338,6 +338,7 @@ static void handle_internal_command(int argc, const char **argv)
>                 { "bundle", cmd_bundle, RUN_SETUP_GENTLY },
>                 { "cat-file", cmd_cat_file, RUN_SETUP },
>                 { "check-attr", cmd_check_attr, RUN_SETUP },
> +               { "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
>                 { "check-ref-format", cmd_check_ref_format },
>                 { "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
>                 { "checkout-index", cmd_checkout_index,

I don't think we really need NEED_WORK_TREE here. .gitignore can be
read from index only.
-- 
Duy
