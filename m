From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Make !pattern in .gitattributes non-fatal
Date: Sat, 2 Mar 2013 10:50:14 +0700
Message-ID: <CACsJy8CO1i1_QpMbLvfys=wsLDPTK69_9JanQYq2D3-fboK_WA@mail.gmail.com>
References: <a1679159dbe67c34675bbe016e131260310db189.1362168366.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Mar 02 04:51:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBdTc-0007Yr-PV
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 04:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab3CBDuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 22:50:46 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:47193 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab3CBDup (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 22:50:45 -0500
Received: by mail-oa0-f52.google.com with SMTP id k14so6659755oag.25
        for <git@vger.kernel.org>; Fri, 01 Mar 2013 19:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=nyuUNMgqhxDiK0+DFFi9Ugrqcx82K3Fncp8fGZtc1no=;
        b=sBxT67hbP+3esdulEXIHccSwlfwJCgQA4FZqMFEs+ZJrSg+c1lTi/HB5st+PWUmgu4
         xyboHe2ANjv4t8407OIcLSWrw/BvzFRatkbB64cUdY/JeVjdpSSP8OQO8NNpBnqW4cff
         v7M776TzXEyNN8hIvwYAG2DvIfao2+Po2/s2Ea//4HGpnX1sn8AHgALmtveEKR5p2wBS
         7KQKGhglww4JxXbNFd9/6tFED/813S3q5fO7c+HqtSu05oDx1/mCPuAjoypbus4mpduD
         QuohhwqJUAj6uF2aOUox2u0hHBfq9zQfMIKJ0h95DGjk3GogFgYISC1Mbb9ED68KdFWb
         0+eg==
X-Received: by 10.182.235.49 with SMTP id uj17mr10386625obc.18.1362196244983;
 Fri, 01 Mar 2013 19:50:44 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Fri, 1 Mar 2013 19:50:14 -0800 (PST)
In-Reply-To: <a1679159dbe67c34675bbe016e131260310db189.1362168366.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217319>

On Sat, Mar 2, 2013 at 3:06 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> Before 82dce99 (attr: more matching optimizations from .gitignore,
> 2012-10-15), .gitattributes did not have any special treatment of a
> leading '!'.  The docs, however, always said
>
>   The rules how the pattern matches paths are the same as in
>   `.gitignore` files; see linkgit:gitignore[5].
>
> By those rules, leading '!' means pattern negation.  So 82dce99
> correctly determined that this kind of line makes no sense and should
> be disallowed.
>
> However, users who actually had a rule for files starting with a '!'
> are in a bad position: before 82dce99 '!' matched that literal
> character, so it is conceivable that users have .gitattributes with
> such lines in them.  After 82dce99 the unescaped version was
> disallowed in such a way that git outright refuses to run(!) most
> commands in the presence of such a .gitattributes.  It therefore
> becomes very hard to fix, let alone work with, such repositories.
>
> Let's at least allow the users to fix their repos: change the fatal
> error into a warning.

I agree we should not break existing .gitattributes. So yes, die()ing
here sounds bad. But..

> @@ -255,9 +255,11 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
>                                       &res->u.pat.patternlen,
>                                       &res->u.pat.flags,
>                                       &res->u.pat.nowildcardlen);
> -               if (res->u.pat.flags & EXC_FLAG_NEGATIVE)
> -                       die(_("Negative patterns are forbidden in git attributes\n"
> -                             "Use '\\!' for literal leading exclamation."));
> +               if (res->u.pat.flags & EXC_FLAG_NEGATIVE) {
> +                       warning(_("Negative patterns are ignored in git attributes\n"
> +                                 "Use '\\!' for literal leading exclamation."));
> +                       return NULL;
> +               }

This "return NULL;" means we ignore "!blah" pattern, which is a
regression, isn't it? Should we treat '!' as literal here?
-- 
Duy
