From: "Dan McGee" <dan@archlinux.org>
Subject: Re: [PATCH] send-pack: respect '+' on wildcard refspecs
Date: Fri, 19 Oct 2007 07:10:42 -0500
Message-ID: <449c10960710190510y3af3ffa2ydb9ae4a01b5d480c@mail.gmail.com>
References: <20071019090400.GA8944@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 14:10:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiqgr-00082s-FM
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 14:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbXJSMKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 08:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbXJSMKq
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 08:10:46 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:24700 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbXJSMKp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 08:10:45 -0400
Received: by nz-out-0506.google.com with SMTP id s18so28764nze
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=pd5aSe3vGBvZp06s0LdU6zHSqFwF26A8HFL++kFRd0Y=;
        b=ZXwmByTuD0dkMdFYzj1NmEEtru1si8EDp/1O5DPWVOMdQUzGq3N2Q4g2q9BAeizq/VjiZVL9tGFenw6o3GNKxhOVpZBr+x3d7ipPjkJGKMqI05ruc8FSGgV7FepIKTNKymYEIo6D431cS0T2CyL5UveENNh0FiSX1G6FyMaDkTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=rOOFAWvkgZ4nc4QhleRBlLKKGYy2DZTNK3owdWdNOx6ZnErmrOKGWbH7VvFSJ6dK3vffsfHqtkjHm0vQhAmsUAmVqnluFrfXFHnMcONRqM4K70J9kB1o0fiiEEFwT0ur+KvXp58dh/Q/o/JZ6xkULoD/Q1q5ktvSv9oYLqGFSxw=
Received: by 10.114.73.1 with SMTP id v1mr2009657waa.1192795843049;
        Fri, 19 Oct 2007 05:10:43 -0700 (PDT)
Received: by 10.114.67.15 with HTTP; Fri, 19 Oct 2007 05:10:42 -0700 (PDT)
In-Reply-To: <20071019090400.GA8944@coredump.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: bef09397f471f714
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61694>

On 10/19/07, Jeff King <peff@peff.net> wrote:
> When matching source and destination refs, we were failing
> to pull the 'force' parameter from wildcard respects (but
> not explicit ones) and attach it to the ref struct.
>
> This adds a test for explicit and wildcard refspecs; the
> latter fails without this patch.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote.c             |    2 ++
>  t/t5400-send-pack.sh |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 0 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index b20e2be..170015a 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -762,6 +762,8 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
>                         hashcpy(dst_peer->new_sha1, src->new_sha1);
>                 }
>                 dst_peer->peer_ref = src;
> +               if (pat)
> +                       dst_peer->force = pat->force;
>         free_name:
>                 free(dst_name);
>         }
> diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
> index 57c6397..2d0c07f 100755
> --- a/t/t5400-send-pack.sh
> +++ b/t/t5400-send-pack.sh
> @@ -123,4 +123,52 @@ test_expect_success \
>         git-branch -a >branches && ! grep -q origin/master branches
>  '
>
> +rewound_push_setup() {
> +       rm -rf parent child &&
> +       mkdir parent && cd parent &&
> +       git-init && echo one >file && git-add file && git-commit -m one &&
> +       echo two >file && git-commit -a -m two &&
> +       cd .. &&
> +       git-clone parent child && cd child && git-reset --hard HEAD^
> +}
> +
> +rewound_push_succeeded() {
> +       cmp ../parent/.git/refs/heads/master .git/refs/heads/master
> +}
> +
> +rewound_push_failed() {
> +       if rewound_push_succeeded
> +       then
> +               false
> +       else
> +               true
> +       fi
> +}
> +
> +test_expect_success \
> +       'pushing explicit refspecs respects forcing' '
> +       rewound_push_setup &&
> +       if git-send-pack ../parent/.git refs/heads/master:refs/heads/master
> +       then
> +               false
> +       else
> +               true
> +       fi && rewound_push_failed &&
> +       git-send-pack ../parent/.git +refs/heads/master:refs/heads/master &&
> +       rewound_push_succeeded
> +'
> +
> +test_expect_success \
> +       'pushing wildcard refspecs respects forcing' '
> +       rewound_push_setup &&
> +       if git-send-pack ../parent/.git refs/heads/*:refs/heads/*
> +       then
> +               false
> +       else
> +               true
> +       fi && rewound_push_failed &&
> +       git-send-pack ../parent/.git +refs/heads/*:refs/heads/* &&
> +       rewound_push_succeeded
> +'
> +
>  test_done
> --
> 1.5.3.4.1254.gc1ca9-dirty
>

Hmm. For some reason this passes with your test case, but not with my
original bash test script[1]. Did you try it with this?

-Dan

[1] http://www.toofishes.net/uploads/
