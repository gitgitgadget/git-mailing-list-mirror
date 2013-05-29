From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] wildmatch: properly fold case everywhere
Date: Wed, 29 May 2013 20:22:11 +0700
Message-ID: <CACsJy8CY_T44ymUnLWv4FpF3zpL3WKSysJ1wBhfxGHNPJ6kSmg@mail.gmail.com>
References: <1369744361-44918-1-git-send-email-n.oxyde@gmail.com> <1369749497-55610-1-git-send-email-n.oxyde@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Anthony Ramine <n.oxyde@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:22:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgL2-0008Ng-RL
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965889Ab3E2NWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:22:44 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:46057 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab3E2NWn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:22:43 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so11686441oag.11
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4SKKmpc7zjo5LIA248Wv3nQW4/WT7xOkO2vddKGoELE=;
        b=kQZPbekNvYnE4l0tLh4YjNP8VuBOh5VLTFsjBonKWM2SBRogavmUUzUVvvw6h7fe8p
         60YPYKtreUUDsKXlLsTPcQZwAcfKb1xrRXJeBhYZkl2iTgXGCdhRDojd/nt/3LSewlrJ
         y5t+PVwvk+arpLDO/E/pyFhM/EXIvu/LXpt4y7DD0QGf24B7eP8tGayzpHS7on4eGI16
         n0jqG2x58PUX0OH7543PiEG4V/lw0QSvvMrm0/NE6UXmRicmagcH7BZBo/3sjR+CY/VF
         hWGi075WS7YCFP6aRYGOCeR1w4Ww111wlbm/9acUNepub8SF4uXbhtlv+ZLmvY0Jy8a+
         /4ag==
X-Received: by 10.60.99.10 with SMTP id em10mr1539827oeb.58.1369833761616;
 Wed, 29 May 2013 06:22:41 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Wed, 29 May 2013 06:22:11 -0700 (PDT)
In-Reply-To: <1369749497-55610-1-git-send-email-n.oxyde@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225813>

On Tue, May 28, 2013 at 8:58 PM, Anthony Ramine <n.oxyde@gmail.com> wrote:
> Case folding is not done correctly when matching against the [:upper:]
> character class and uppercased character ranges (e.g. A-Z).
> Specifically, an uppercase letter fails to match against any of them
> when case folding is requested because plain characters in the pattern
> and the whole string and preemptively lowercased to handle the base case
> fast.

I did a little test with glibc fnmatch and also checked the source
code. I don't think 'a' matches [:upper:]. So I'm not sure if that's a
correct behavior or a bug in glibc. The spec is not clear (I think) on
this. I guess we should just assume that 'a' should match '[:upper:]'?

> @@ -196,6 +196,11 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>                                         }
>                                         if (t_ch <= p_ch && t_ch >= prev_ch)
>                                                 matched = 1;
> +                                       else if ((flags & WM_CASEFOLD) && ISLOWER(t_ch)) {
> +                                               uchar t_ch_upper = toupper(t_ch);
> +                                               if (t_ch_upper <= p_ch && t_ch_upper >= prev_ch)
> +                                                       matched = 1;
> +                                       }

Or we could stick with to tolower. Something like this

if ((t_ch <= p_ch && t_ch >= prev_ch) ||
   ((flags & WM_CASEFOLD) &&
      t_ch <= tolower(p_ch) && t_ch >= tolower(prev_ch)))
   match = 1;

I think it's easier to read if we either downcase all, or upcase all, not both.

>                                         p_ch = 0; /* This makes "prev_ch" get set to 0. */
>                                 } else if (p_ch == '[' && p[1] == ':') {
>                                         const uchar *s;
> @@ -245,6 +250,8 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>                                         } else if (CC_EQ(s,i, "upper")) {
>                                                 if (ISUPPER(t_ch))
>                                                         matched = 1;
> +                                               else if ((flags & WM_CASEFOLD) && ISLOWER(t_ch))
> +                                                       matched = 1;
>                                         } else if (CC_EQ(s,i, "xdigit")) {
>                                                 if (ISXDIGIT(t_ch))
>                                                         matched = 1;

If WM_CASEFOLD is set, maybe isalpha(t_ch) is enough then?
--
Duy
