From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv3 2/7] diff_opt: track whether flags have been set explicitly
Date: Fri, 10 May 2013 11:31:29 -0400
Message-ID: <CAPig+cSAtXfeBYkw8Ob4i_ozETVwndONcQxH42ryU0ihKPTDjw@mail.gmail.com>
References: <cover.1368197380.git.git@drmicha.warpmail.net>
	<7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
	<88fb8906050411d0fe8b56cea160a4bfa1abb699.1368197380.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 10 17:31:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UapIG-0002wY-62
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757576Ab3EJPbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:31:32 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:53737 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab3EJPbb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 11:31:31 -0400
Received: by mail-la0-f44.google.com with SMTP id ed20so4127461lab.17
        for <git@vger.kernel.org>; Fri, 10 May 2013 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=GP+ACl/bjw5/2AInGVAjaRrpp1FCp4K4rjXJFaTTIuI=;
        b=0fEmXSdBcbw1Ksfe5tsWeWEFmKyzuAaug4UDK68O8bFsFZ0fPx8iH/KkzdE7ieDUMK
         VYsNFFoNGIe6rYU5wfu/3+ZiTPkQyKYaisy0rCMcpeTbSeOZUcjl48wNiJXz5dBhbCB/
         /OXJRUcM8GHg/XzpWdyMS5eoMYFs+VzdtNL+o+K3xrII8NvL3DP+cIh5WHiCZS5mwMHn
         Fx3X9LRZLBP1lzDu9KN61Cd1OeVFKiVvpy4ZQwsLHeD22vyVTCGAWEigqHnAtnYwXby7
         CZ6cDK8TI1oNqcg2ocBVE5zPUP82ql6ZtbdqR8rOzIAfABLt2pUUXEvsIpR41812AGkG
         VQEQ==
X-Received: by 10.112.137.9 with SMTP id qe9mr7820277lbb.64.1368199889856;
 Fri, 10 May 2013 08:31:29 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Fri, 10 May 2013 08:31:29 -0700 (PDT)
In-Reply-To: <88fb8906050411d0fe8b56cea160a4bfa1abb699.1368197380.git.git@drmicha.warpmail.net>
X-Google-Sender-Auth: UA-OmNz5j5sZrjD-3sCbkJr1eqs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223872>

On Fri, May 10, 2013 at 11:10 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> From: Junio C Hamano <gitster@pobox.com>
>
> The diff_opt infrastructure sets flags based on defaults and command
> line options. Currently, it is impossible to detect whether a flag has
> been set as a default or on explicit request.
>
> Amend the structure so that this detection is possible:
>
>  * There is an extra "opt->touched_flags" that keeps track of all
>    the fields that have been touched by DIFF_OPT_SET and
>    DIFF_OPT_CLR;
>
>  * You may continue setting the default values to the flags, like
>    commands in the "log" family do in cmd_log_init_defaults(), but
>    after you finished setting the defaults, you clear the
>    touched_flags field;
>
>  * And then you let the usual callchain call diff_opt_parse(),
>    allowing the opt->flags be set or unset, while keeping track of
>    which bits the user touched;
>
>  * There is an optional callback "opt->set_default" that is called
>    at the very beginning to lets you inspect touched_flags and

s/lets/let/

>    update opt->flags appropriately, before the remainder of the
>    diffcore machinery is set up, taking the opt->flags value into
>    account.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
