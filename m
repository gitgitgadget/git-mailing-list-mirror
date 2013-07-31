From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 8/9] checkout-index: Fix negations of even numbers of -n
Date: Wed, 31 Jul 2013 13:16:39 -0400
Message-ID: <CAPig+cTQV=2OFg_4OSFzkYWE8Uxz0ErWgXKOoV6mUWEMT65F4w@mail.gmail.com>
References: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
	<1375288117-1576-9-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 19:16:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4a0z-0004yU-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 19:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757109Ab3GaRQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 13:16:41 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:52851 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855Ab3GaRQl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 13:16:41 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so798426lbf.4
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=X1uPYh5VGMh7Tno8JYC3NvbGoLjnuRU6uxz1uuuqBxE=;
        b=t5c6atLi4rMAg77OwRC8/2A1hu+OpAPUJbVsoaOlIiFgfHO8lNLHGCdFfHvU1aP7Vj
         bTN4qpJPIddrrOiWLSoCMjdC1Mhkwd4/kKvsfIRGbv1n4DBSPa4hXc5hb5t9nDiCtXw4
         vI0qokRSXpzePYKttl+XEpLyn6lyyvNZew0ZjqWS2TTCeo7gWIhzKoVZE9iYYDD6KvFM
         rCYtYbJyUVhSbO25cVHVbdRbZlTnmDmsc1kjBdAMDhojx2SQJsH6PmaNDtainikDLVf3
         bJY1YQSxyGZ2kDk0AtUEGe2AhIKv63ljjKytKQeZYxPy9BFo+MOzGqDxrb6VDhGL3qAS
         N/MA==
X-Received: by 10.152.10.2 with SMTP id e2mr14962939lab.61.1375290999475; Wed,
 31 Jul 2013 10:16:39 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Wed, 31 Jul 2013 10:16:39 -0700 (PDT)
In-Reply-To: <1375288117-1576-9-git-send-email-stefanbeller@googlemail.com>
X-Google-Sender-Auth: Eg3IG6SSF0ISLjh0J3Q3dZWDvu4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231437>

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

s/multiple --no-create multiple times/--no-create multiple times/

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
