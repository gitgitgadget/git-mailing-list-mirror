From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 05/12] cherry-pick: remember rerere-autoupdate
Date: Thu, 24 Apr 2014 04:21:32 -0400
Message-ID: <CAPig+cSYsfsg8+2FruQqwVanDHmfQKgCi1NkXhpduJhVD1o6PQ@mail.gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
	<1398307491-21314-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 10:21:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdEub-0001D3-UI
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 10:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbaDXIVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 04:21:36 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:37449 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbaDXIVe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 04:21:34 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so1939091wgh.16
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cI30s083A2EA9I+bDzVoQ2P1L7Oe845HnWR4TVIq7Kk=;
        b=NBs77IcrP16NzD1b6+k+y+HvhlcKV+vwazGJJnXzh6oVtRFszkXUzKBGSbnR2PUbid
         EIeW6ZK/0mYXI4YGpDn0b4E6Fm2Ska8OVrlTi8JTNx6wgzLbbI+iR+5YaBYBaWrgvpn8
         CNRYdCI8biosDAUpjv5vW+x9f7wyaNXF+URL0qfSgWNiC3O1KP+uzociWXHpupyB2PHE
         K+piAYz2LdOAX+lGhm5lpOsQHXPIbL2KjzwMd+GbAyjy4CpaKnPjtlnAhq6NMltAP0Bi
         YSxD7do9dMjsdmZevwR/+A2R600D7kXRIXEsc82i3WyokmIjIxEjykLy/Pdru67+XuCR
         fmTA==
X-Received: by 10.180.7.133 with SMTP id j5mr1575306wia.55.1398327692827; Thu,
 24 Apr 2014 01:21:32 -0700 (PDT)
Received: by 10.217.46.68 with HTTP; Thu, 24 Apr 2014 01:21:32 -0700 (PDT)
In-Reply-To: <1398307491-21314-6-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: qZ3MJ3AAwOZ_vGQOKXvkNHEMsYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246946>

On Wed, Apr 23, 2014 at 10:44 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
> index e6a6481..274b2cc 100755
> --- a/t/t3504-cherry-pick-rerere.sh
> +++ b/t/t3504-cherry-pick-rerere.sh
> @@ -42,4 +42,43 @@ test_expect_success 'cherry-pick conflict without rerere' '
>         test_must_fail test_cmp expect foo
>  '
>
> +test_expect_success 'cherry-pick --rerere-autoupdate' '
> +       test_when_finished "rm -rf rerere" &&
> +       (
> +       git init rerere &&
> +       cd rerere &&
> +       test_config rerere.enabled true &&
> +       echo one > content-a && git add content-a &&
> +       echo one > content-b && git add content-b &&
> +       git commit -m one &&
> +       git checkout -b conflict master &&
> +       echo conflict-a > content-a &&
> +       git commit -a -m conflict-a &&
> +       echo conflict-b > content-b &&
> +       git commit -a -m conflict-b &&
> +       git checkout master &&
> +       echo two > content-a &&
> +       echo two > content-b &&
> +       git commit -a -m two &&
> +       git checkout -b test &&
> +       test_must_fail git cherry-pick master..conflict &&
> +       echo resolved-a > content-a &&
> +       git add content-a &&
> +       test_must_fail git cherry-pick --continue &&
> +       echo resolved-b > content-b &&
> +       git add content-b &&
> +       git cherry-pick --continue &&
> +       git reset --hard master

Broken &&-chain.

> +       git log --oneline --all --decorate --graph &&
> +       test_must_fail git cherry-pick --rerere-autoupdate master..conflict &&
> +       git log --oneline --all --decorate --graph &&
> +       echo resolved-a > expected &&
> +       test_cmp expected content-a

Ditto.

> +       test_must_fail git cherry-pick --continue &&
> +       echo resolved-b > expected &&
> +       test_cmp expected content-b &&
> +       git cherry-pick --continue
> +       )
> +'
> +
>  test_done
> --
> 1.9.2+fc1.2.gfbaae8c
