From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 06/10] setup: refactor repo format reading and verification
Date: Thu, 3 Mar 2016 20:19:22 +0700
Message-ID: <CACsJy8B6j2AB5CCBVVz7f1JShq0XVicJfzZvjRO54ksde0RMfQ@mail.gmail.com>
References: <20160301143546.GA30806@sigill.intra.peff.net> <20160301144206.GF12887@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 14:20:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abTAd-0005YD-Nq
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 14:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbcCCNTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 08:19:55 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33592 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbcCCNTy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 08:19:54 -0500
Received: by mail-lb0-f174.google.com with SMTP id k15so23017012lbg.0
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 05:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UZ1st+0yesz3oV9q2IuGWuIW7YM1+5sp9LCt4jNynsQ=;
        b=i3yQMiNlR0adOK+RC/L1Ve+cjVx07jqxZlGziLgyP/cbLWgwppq7ePOg+574mSObMe
         Gw8wrM5MF3rQJA6C6cmzdw9AHFyKYqPuPKAog5FMVF2pmuCQPYZijBkFhoguUEFI7+wI
         8a7osTxujkYeYHEUTyC12uFFUtvLoKtYEqpgHEScWSk2qBBXx41b4e8w4KzqOEaxeYpY
         q3/0M4gcKV/EpHpzOXHnHvBvXMv57Aui6vUIHWGyBKrv7A8kAuJqPksNKziBVv22YUFr
         nWNXoIMJNEhmb1v5sKpLUsU1zhLFGyMmVpHkXp2tslCJTHLwt4NHHIHgJKdmhcLzFRXX
         Qo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UZ1st+0yesz3oV9q2IuGWuIW7YM1+5sp9LCt4jNynsQ=;
        b=V8s4Igm9lAd4oCLfC1kjkL47LXaJkoairWLNiXESsIS3xpfxnWr5IAXev5/RQfgG5V
         RtRM0XzsmBOhOOfVFs1HW2JjVBA4J0YxqHYDsXphCJC6drJlt8gVjWKD5es7gm0JpPjv
         wURm1fOxrHbXUV/flsPV3n50xUG/jL6/iL7O/6zTAYali7Z5VXXPZHWUJ+9YK1tUcX99
         AGWmgecidJYnPv1q5SYe21+FOu3P9PjWIEhv3oj20CHHbu575br3DgHKKTf7/wtr70x6
         RYMKKkGqr7BxAQkkQm0J5MSfbhnylpufaeP1ok05tcCtbfV6hNCEZYy5IAc+odXwHpxt
         tq5g==
X-Gm-Message-State: AD7BkJKOSFmbUkayce8ez0jx6FbLTom7BOaDkOJnjiSKh8iznba3tka8KZRbhGeQ7fLCtaV0oOi1HxtYui61LQ==
X-Received: by 10.112.171.163 with SMTP id av3mr993087lbc.145.1457011192398;
 Thu, 03 Mar 2016 05:19:52 -0800 (PST)
Received: by 10.112.34.162 with HTTP; Thu, 3 Mar 2016 05:19:22 -0800 (PST)
In-Reply-To: <20160301144206.GF12887@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288177>

On Tue, Mar 1, 2016 at 9:42 PM, Jeff King <peff@peff.net> wrote:
> -               for (i = 0; i < unknown_extensions.nr; i++)
> -                       warning("unknown repository extension: %s",
> -                               unknown_extensions.items[i].string);
> -               *nongit_ok = -1;
> -               ret = -1;
> +int verify_repository_format(const struct repository_format *format,
> +                            struct strbuf *err)
> +{
> +       if (GIT_REPO_VERSION_READ < format->version) {
> +               strbuf_addf(err, "Expected git repo version <= %d, found %d",
> +                           GIT_REPO_VERSION_READ, format->version);
> +               return -1;

Since you have given lots of thoughts about this code, perhaps just a
little bit more, double check if these strings should be translatable
or not and mark _() if so?

>         }
>
> -       strbuf_release(&sb);
> -       return ret;
> +       if (format->version >= 1 && format->unknown_extensions.nr) {
> +               int i;
> +
> +               for (i = 0; i < format->unknown_extensions.nr; i++)
> +                       strbuf_addf(err, "unknown repository extension: %s",
> +                                   format->unknown_extensions.items[i].string);

Ditto.
-- 
Duy
