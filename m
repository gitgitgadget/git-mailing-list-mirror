From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 8/9] checkout-index: Fix negations of even numbers of -n
Date: Wed, 31 Jul 2013 13:21:48 -0400
Message-ID: <CAPig+cTfDnQEt72ON1g+T9UpHt9drJ8OmbuszPt4uU49Gj2Bow@mail.gmail.com>
References: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
	<1375288117-1576-9-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 19:21:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4a5z-0008FT-D2
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 19:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760609Ab3GaRVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 13:21:51 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:54952 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760452Ab3GaRVt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 13:21:49 -0400
Received: by mail-la0-f44.google.com with SMTP id fo12so717628lab.31
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=vGsVB3AwbOLtuQ0rrrXOIeNMvHnAF/KmBHCbk/as8Ao=;
        b=lVLmV4h1WwHtHUd0/SvFduRIgclo3ZP9yGfUZUpA0ieVWSC/HsNtRvMvR+w+snyfxF
         Yw5L/FM/Rf6m305G12G5Ww1nwknoFyVuBMaSJrGoizG7ZqErRC4snOVoOz346bPAF5Q7
         DedFNlL8JbHySSYQ70vyN3+Po8W5Fx9Oyj7+N2dyBJEoJxDdPCJLIzIG5ACooLTHjGka
         FfXuEQdUZQxcslyLxmMvlJbv4Wi+S1qNcej8sAHQeYq3Z7hxYp5WQTO6hp+Fk+uM4NtZ
         9T8F+MdxJdXwG2I/UxVD20h9d/xbePIpctQ+8uPqc5by+pddX1D8oNoJS+JFsblLqenf
         n1UQ==
X-Received: by 10.152.1.169 with SMTP id 9mr6277566lan.90.1375291308117; Wed,
 31 Jul 2013 10:21:48 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Wed, 31 Jul 2013 10:21:48 -0700 (PDT)
In-Reply-To: <1375288117-1576-9-git-send-email-stefanbeller@googlemail.com>
X-Google-Sender-Auth: s2sXJvwzJRDaoqCM6u7ic_PoR5w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231438>

On Wed, Jul 31, 2013 at 12:28 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> The --no-create was parsed with OPT_BOOLEAN, which has a counting up
> logic implemented. Since b04ba2bb (parse-options: deprecate OPT_BOOLEAN,
> 2011-09-27) the OPT_BOOLEAN is deprecated and is only a define:
>         /* Deprecated synonym */
>         #define OPTION_BOOLEAN OPTION_COUNTUP
>
> However the variable not_new, which can be counted up by giving multiple
> --no-create multiple times, is used to set a bit in the struct checkout
> bitfield (defined in cache.h:969, declared at builtin/checkout-index.c:19):
>
>         state.not_new = not_new;
>
> When assigning a value other than 0 or 1 to a bit, all leading digits but
> the last are ignored and only the last bit is used for setting the bit
> variable.
>
> Hence the following:
>         # in git.git:
>         $ git status
>         # working directory clean
>         rm COPYING
>         $ git status
>         # deleted:    COPYING
>         $ git checkout-index -a -n

Missing "$ git status" at this point in example.

>         # deleted:    COPYING
>         # which is expected as we're telling git to not restore or create
>         # files, however:
>         $ git checkout-index -a -n -n
>         $ git status
>         # working directory clean, COPYING is restored again!
>         # That's the bug, we're fixing here.
>
> By restraining the variable not_new to a value being definitely 0 or 1
> by the macro OPT_BOOL the bug is fixed.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
