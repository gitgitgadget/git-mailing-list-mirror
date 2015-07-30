From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] refs: support negative transfer.hideRefs
Date: Thu, 30 Jul 2015 16:17:35 -0400
Message-ID: <CAPig+cTJuCWwhzrAt47yCEMv4yrTX-C1e9L_yBwyqJ-YbGfcuA@mail.gmail.com>
References: <20150728195747.GA13596@peff.net>
	<20150728195934.GB13795@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 30 22:17:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKuGq-0002ST-Ot
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 22:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbbG3URg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 16:17:36 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35306 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbG3URf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 16:17:35 -0400
Received: by ykdu72 with SMTP id u72so43278482ykd.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ivdxDBstDN+CcWvGssY0LakGm/QtRIkCPAp8rWySM9E=;
        b=Xy2OfH+yt3ZvP4ebNjshjLgQUfTdhCyfNiVbT6Ya5f7xUHB3psBVaEeYMF+VTDe0Xk
         /Xc5cHFqLn3b/2VfoEsop7S42V1070YiMNRE8XfMHlGVkI2DZYkcc3NaBVJYD+oSSgH4
         rgkymbzQUILjnxLNq5yLyXD5Y3UNMUvlOQV6hrjrlNaaqXZzhAjTW/Lfzm0wxh+uu0UH
         6SU3/F2xg7yhG1C6o19QIuLZZohfdAvXp8CD9GdQk6lvvKTqVoam7+faQL3eaSJm7rsG
         AUVKWiXhSldCv88SJmwyP3YGCIUeEOlbsarpWomMQyw2rmx7cWXHssyUrvoQKo0n4ZC5
         TRyQ==
X-Received: by 10.13.202.204 with SMTP id m195mr52677114ywd.48.1438287455187;
 Thu, 30 Jul 2015 13:17:35 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 30 Jul 2015 13:17:35 -0700 (PDT)
In-Reply-To: <20150728195934.GB13795@peff.net>
X-Google-Sender-Auth: 2Ia17WQVEaJpdGDEhOf1pLf7rb0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275026>

On Tue, Jul 28, 2015 at 3:59 PM, Jeff King <peff@peff.net> wrote:
> If you hide a hierarchy of refs using the transfer.hideRefs
> config, there is no way to later override that config to
> "unhide" it. This patch implements a "negative" hide which
> causes matches to immediately be marked as unhidden, even if
> another match would hide it. We take care to apply the
> matches in reverse-order from how they are fed to us by the
> config machinery, as that lets our usual "last one wins"
> config precedence work (and entries in .git/config, for
> example, will override /etc/gitconfig).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> +test_expect_success 'set up some extra tags for ref hiding' '
> +       git tag magic/one &&
> +       git tag magic/two
> +'
> +
>  for configsection in transfer uploadpack
>  do
>         test_expect_success "Hide some refs with $configsection.hiderefs" '
> @@ -138,6 +143,16 @@ do
>                 sed -e "/       refs\/tags\//d" >expect &&
>                 test_cmp expect actual
>         '
> +
> +       test_expect_success "Override hiding of $configsection.hiderefs" '
> +               test_when_finished "test_unconfig $configsection.hiderefs" &&
> +               git config --add $configsection.hiderefs refs/tags &&
> +               git config --add $configsection.hiderefs "!refs/tags/magic" &&
> +               git config --add $configsection.hiderefs refs/tags/magic/one &&
> +               git ls-remote . >actual &&
> +               verbose grep refs/tags/magic/two actual

For completeness, do you also want to add

    !grep refs/tags/magic/one actual

to confirm that the third hideRefs did indeed override the second one?

> +       '
> +
>  done
>
>  test_done
> --
> 2.5.0.rc3.557.g17a1555
