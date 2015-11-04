From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/4] t5509: add basic tests for hideRefs
Date: Wed, 4 Nov 2015 14:36:54 -0500
Message-ID: <CAPig+cQWbisskb4aQ48Oo=8_SYKZWwMK8jn_P_zsivY-xuk43g@mail.gmail.com>
References: <1446537497-13921-1-git-send-email-lfleischer@lfos.de>
	<1446537497-13921-5-git-send-email-lfleischer@lfos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:37:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu3s0-0005TW-Mw
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 20:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354AbbKDThO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 14:37:14 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36277 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315AbbKDTgz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 14:36:55 -0500
Received: by ykba4 with SMTP id a4so91142569ykb.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qd8ojafJej28RKSB/ReiW0x5W/zCZmlepXkRNRH2Luk=;
        b=QkNVxvL8CoeHAus8i5mLWNvozZqq6famyWEoZyI+ZZ5mgALcxIrxCrCALUGokdB8Eo
         t9TNKwfjHTAvMRa0sp6lCh99Cin6RDzBMtj69dZa0ebgOKM4L/KfKNvVCYk1Vv7oF3f5
         Hu6jSxm/pkzsSXhRqOjxCQsrs4ItRH0W+3MblSVw5oekmIjaD/oomrCS85B+FiPM4wZm
         OUc5e8Tb5HtKMhpnc8aqHKN4td1WncfYwrBivWMGkjSv0OIZmEGVTkqmAsrtnyMl6hJd
         v11i6uUfp27ZzdBkXPk5tBxH/M6GuvkIgQ06tCCvyaG8ydZSLRSael088rlIrMGWCgzC
         uwig==
X-Received: by 10.31.56.75 with SMTP id f72mr3572290vka.115.1446665814431;
 Wed, 04 Nov 2015 11:36:54 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Wed, 4 Nov 2015 11:36:54 -0800 (PST)
In-Reply-To: <1446537497-13921-5-git-send-email-lfleischer@lfos.de>
X-Google-Sender-Auth: gsuWTpnIXk6oWSTquyEPn7SnQQ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280867>

On Tuesday, November 3, 2015, Lukas Fleischer <lfleischer@lfos.de> wrote:
> Test whether regular and full hideRefs patterns work as expected when
> namespaces are used.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
> ---
> diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
> @@ -82,4 +82,45 @@ test_expect_success 'mirroring a repository using a ref namespace' '
> +test_expect_success 'hide namespaced refs with transfer.hideRefs' '
> +       GIT_NAMESPACE=namespace \
> +               git -C pushee -c transfer.hideRefs=refs/tags \
> +               ls-remote "ext::git %s ." >actual &&
> +       printf "$commit1\trefs/heads/master\n" >expected &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'check that transfer.hideRefs does not match unstripped refs' '
> +       GIT_NAMESPACE=namespace \
> +               git -C pushee -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
> +               ls-remote "ext::git %s ." >actual &&
> +       printf "$commit1\trefs/heads/master\n" >expected &&
> +       printf "$commit0\trefs/tags/0\n" >>expected &&
> +       printf "$commit1\trefs/tags/1\n" >>expected &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'hide full refs with transfer.hideRefs' '
> +       GIT_NAMESPACE=namespace \
> +               git -C pushee -c transfer.hideRefs="^refs/namespaces/namespace/refs/tags" \
> +               ls-remote "ext::git %s ." >actual &&
> +       printf "$commit1\trefs/heads/master\n" >expected &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'try to update a hidden ref' '
> +       test_config -C pushee transfer.hideRefs refs/heads/master &&
> +       test_must_fail git -C original push pushee-namespaced master

In above tests, you use -c to set the configuration temporarily for
the git invocation, but not in this and following tests. Is that
because the -c isn't visible to sub-commands which git-push invokes?
(Genuine question; I want to make sure I understand the reasoning.)

> +'
> +
> +test_expect_success 'try to update a ref that is not hidden' '
> +       test_config -C pushee transfer.hideRefs refs/namespaces/namespace/refs/heads/master &&
> +       git -C original push pushee-namespaced master
> +'
> +
> +test_expect_success 'try to update a hidden full ref' '
> +       test_config -C pushee transfer.hideRefs "^refs/namespaces/namespace/refs/heads/master" &&
> +       test_must_fail git -C original push pushee-namespaced master
> +'
> +
>  test_done
> --
> 2.6.2
>
