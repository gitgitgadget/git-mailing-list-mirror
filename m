From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/6] t6300: introduce test_date() helper
Date: Tue, 1 Sep 2015 18:26:15 -0400
Message-ID: <CAPig+cRyiuPhcQ4tm=cxEPk0zHa6=2Wh-nHdnPJLFTDaO9vVTQ@mail.gmail.com>
References: <20150901083731.GE30659@serenity.lan>
	<cover.1441144343.git.john@keeping.me.uk>
	<8e869f362971a44bb1f40ca5fed98b658efaa0dd.1441144343.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:26:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWu0T-00006b-HM
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbbIAW0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:26:17 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35522 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbbIAW0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:26:16 -0400
Received: by ykax124 with SMTP id x124so5449003yka.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rVcVzSJ/tkKEwZT27aqAkalepZB3L85lHnAirzma2vE=;
        b=W7jF39eXG6xFt1qtGl15/mAJJlyWp7vTG/VwQpQq2HPyw/N6BZQsTgxbvr19bbQt5P
         ZSt59p12R2WV98FPSoMW8+Omnj2GGXwUGx2RMwWhIk3+ortWGlOzoKbsBoK4y9gIDQp+
         t8rLAtLrxz9ZW7+L2f2uTZPuI8f8oy9s9GIBAShhoWq5C0ckc8Wd9xceSlCvFn2T6kbV
         efUjW3B4Z+GiiMKOLQ+y6ouhxRUCcvrX7K8+DZr/UefkXd/Fsilh3H+wCyehD+MXLPlc
         5XBYK7tqBOMBqsnCA1f9d8wZ3iHlPNPlKczRA1KYlIOzRyqImoPaHyGBOcwuPx5QOxU4
         XnuQ==
X-Received: by 10.170.216.136 with SMTP id i130mr786637ykf.71.1441146375259;
 Tue, 01 Sep 2015 15:26:15 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Tue, 1 Sep 2015 15:26:15 -0700 (PDT)
In-Reply-To: <8e869f362971a44bb1f40ca5fed98b658efaa0dd.1441144343.git.john@keeping.me.uk>
X-Google-Sender-Auth: Q-dWTf5yolUnuUqtVqlbsUgdzGw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277059>

On Tue, Sep 1, 2015 at 5:55 PM, John Keeping <john@keeping.me.uk> wrote:
> This moves the setup of the "expected" file inside the test case.  The
> helper function has the advantage that we can use SQ in the file content
> without needing to escape the quotes.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 7c9bec7..5fdb964 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -146,85 +146,54 @@ test_expect_success 'Check invalid format specifiers are errors' '
>         test_must_fail git for-each-ref --format="%(authordate:INVALID)" refs/heads
>  '
>
> -cat >expected <<\EOF
> -'refs/heads/master' 'Mon Jul 3 17:18:43 2006 +0200' 'Mon Jul 3 17:18:44 2006 +0200'
> -'refs/tags/testtag' 'Mon Jul 3 17:18:45 2006 +0200'
> -EOF
> +test_date () {
> +       f=$1

f=$1 &&

> +       committer_date=$2 &&
> +       author_date=$3 &&
> +       tagger_date=$4 &&
> +       cat >expected <<-EOF &&
> +       'refs/heads/master' '$committer_date' '$author_date'
> +       'refs/tags/testtag' '$tagger_date'
> +       EOF
> +       (
> +               git for-each-ref --shell --format="%(refname) %(committerdate${f:+:$f}) %(authordate${f:+:$f})" refs/heads &&
> +               git for-each-ref --shell --format="%(refname) %(taggerdate${f:+:$f})" refs/tags
> +       ) >actual &&
> +       test_cmp expected actual
> +}
