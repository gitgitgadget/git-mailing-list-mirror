From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 22/23] worktree: add: auto-vivify new branch when <branch> is omitted
Date: Tue, 07 Jul 2015 09:10:27 -0700
Message-ID: <xmqqmvz83q4s.fsf@gitster.dls.corp.google.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
	<1436203860-846-23-git-send-email-sunshine@sunshineco.com>
	<xmqqpp45ytzh.fsf@gitster.dls.corp.google.com>
	<20150707013301.GA26523@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 18:10:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVS7-0003U9-Im
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239AbbGGQKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:10:31 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34857 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320AbbGGQKa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:10:30 -0400
Received: by igcqs7 with SMTP id qs7so36188579igc.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4oPmME8KGdw7tuRNnIS2I5aZiKmvuI9uukchu9dBPQM=;
        b=xmzD6FL391ho6naF1LH2FUhynR8RsxkM7r3dYSWwiNKAvGYEcQ+hUN6VvfjCxgnOk4
         GjY0wNfbvp5oBDYdNhm6MYw022xAtg3i8lrD15qUfUZtF1bDzFgF058BdtNsA45NU8Ym
         ESMNYu+CJOaSXQRTqwnE72o4y/iw3Vsr8WFC+x9AkwDxnzbOIk22Q/1nL5LGegYzf0hw
         mAzcNnVAyyU9QU5kk9YawUeoAQwFOLlln9xbObnquvY7mUtoqGr8rPYxpJMVfd30RnMN
         bXfhz/bE7H0en7C47QZNFiVyvi6Q2t8Q0baVrS11KmisH93DIcV1tfmj4QZ8wrEfk9jD
         BPdw==
X-Received: by 10.50.221.107 with SMTP id qd11mr8223253igc.13.1436285429801;
        Tue, 07 Jul 2015 09:10:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id ot6sm12123983igb.11.2015.07.07.09.10.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 09:10:29 -0700 (PDT)
In-Reply-To: <20150707013301.GA26523@flurp.local> (Eric Sunshine's message of
	"Mon, 6 Jul 2015 21:33:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273583>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Which may be something we would want to have a test for, though.
>
> Good idea. How about the following as a squash-in?

Sounds sensible.

At this point we do not have "worktree list", but if we gained that,
we may want to add this as one more postcondition after the failed
"worktree add":

       git worktree list >actual &&
       ! grep precious actual

but that should happen in the series that adds "worktree list" ;-)

> --- 8< ---
> From: Eric Sunshine <sunshine@sunshineco.com>
> Subject: [PATCH] fixup! worktree: add: auto-vivify new branch when <branch> is omitted
>
> ---
>  t/t2025-worktree-add.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 8fe242f..ead8aa2 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -150,4 +150,13 @@ test_expect_success '"add" with <branch> omitted' '
>  	test_cmp_rev HEAD bat
>  '
>  
> +test_expect_success '"add" auto-vivify does not clobber existing branch' '
> +	test_commit c1 &&
> +	test_commit c2 &&
> +	git branch precious HEAD~1 &&
> +	test_must_fail git worktree add precious &&
> +	test_cmp_rev HEAD~1 precious &&
> +	test_path_is_missing precious
> +'
> +
>  test_done
