From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/5] implement submodule config cache for lookup of
 submodule names
Date: Sun, 8 Jun 2014 05:04:44 -0400
Message-ID: <CAPig+cTmXu09QLca4W=VpUS82m0uDSQLch7Gb06U_XeUZ83FrQ@mail.gmail.com>
References: <20140605060425.GA23874@sandbox-ub>
	<20140605060750.GC23874@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Jun 08 11:04:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtZ22-0008W7-HS
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jun 2014 11:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbaFHJEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2014 05:04:46 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:59586 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbaFHJEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2014 05:04:45 -0400
Received: by mail-yh0-f54.google.com with SMTP id i57so77179yha.27
        for <git@vger.kernel.org>; Sun, 08 Jun 2014 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=M/xK47UEPtUJ6XeFV9gPRPI4MLmwAHulZPSRywQb0gQ=;
        b=hUyBdhahWfUNSOtAae/TSwuvcRZxZ59HY5eW6TXYJ42x75H+Si2Zy+PCxFTxze5Q5s
         dG1JtWK2+quqWP8S3VdDBHBgLOG+n5dfJjhjMZg/DgVIM9WJM4Q41hldXrPwahFjOgfW
         TTdY+7sGxuAU9+kQ5dGeZfzirqLfl9M4QQUA4PQs5yi9KJt10gV812PWtOPSCrNolClg
         YCIgbhOdF3YFAX2cd+2AJ19wcYa6VdPKBzoGogRQEL+Skj41j7EKqP8m4sVdTAMfpegE
         pyMcIgUK+Gtl/5N4wCvZokI1ng1bZmvnRdA3qROpUd+LVRQOXblwRG9K929q0hjcgJu8
         +9JQ==
X-Received: by 10.236.223.36 with SMTP id u34mr4386235yhp.79.1402218284868;
 Sun, 08 Jun 2014 02:04:44 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Sun, 8 Jun 2014 02:04:44 -0700 (PDT)
In-Reply-To: <20140605060750.GC23874@sandbox-ub>
X-Google-Sender-Auth: zxJs33xs0QDpftockJuQUIB2ucw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251051>

On Thu, Jun 5, 2014 at 2:07 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> This submodule configuration cache allows us to lazily read .gitmodules
> configurations by commit into a runtime cache which can then be used to
> easily lookup values from it. Currently only the values for path or name
> are stored but it can be extended for any value needed.
>
> [...]
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> diff --git a/t/t7410-submodule-config.sh b/t/t7410-submodule-config.sh
> new file mode 100755
> index 0000000..ea453c5
> --- /dev/null
> +++ b/t/t7410-submodule-config.sh
> @@ -0,0 +1,73 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2014 Heiko Voigt
> +#
> +
> +test_description='Test submodules config cache infrastructure
> +
> +This test verifies that parsing .gitmodules configuration directly
> +from the database works.
> +'
> +
> +TEST_NO_CREATE_REPO=1
> +. ./test-lib.sh
> +
> +test_expect_success 'submodule config cache setup' '
> +       mkdir submodule &&
> +       (cd submodule &&
> +               git init

Broken &&-chain.

> +               echo a >a &&
> +               git add . &&
> +               git commit -ma
> +       ) &&
> +       mkdir super &&
> +       (cd super &&
> +               git init &&
> +               git submodule add ../submodule &&
> +               git submodule add ../submodule a &&
> +               git commit -m "add as submodule and as a" &&
> +               git mv a b &&
> +               git commit -m "move a to b"
> +       )
> +'
> +
> +cat >super/expect <<EOF
> +Submodule name: 'a' for path 'a'
> +Submodule name: 'a' for path 'b'
> +Submodule name: 'submodule' for path 'submodule'
> +Submodule name: 'submodule' for path 'submodule'
> +EOF
> +
> +test_expect_success 'test parsing of submodule config' '
> +       (cd super &&
> +               test-submodule-config \
> +                       HEAD^ a \
> +                       HEAD b \
> +                       HEAD^ submodule \
> +                       HEAD submodule \
> +                               >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +cat >super/expect_error <<EOF
> +Submodule name: 'a' for path 'b'
> +Submodule name: 'submodule' for path 'submodule'
> +EOF
> +
> +test_expect_success 'error in one submodule config lets continue' '
> +       (cd super &&
> +               cp .gitmodules .gitmodules.bak &&
> +               echo "  value = \"" >>.gitmodules &&
> +               git add .gitmodules &&
> +               mv .gitmodules.bak .gitmodules &&
> +               git commit -m "add error" &&
> +               test-submodule-config \
> +                       HEAD b \
> +                       HEAD submodule \
> +                               >actual &&
> +               test_cmp expect_error actual
> +       )
> +'
> +
> +test_done
